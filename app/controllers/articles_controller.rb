class ArticlesController < ApplicationController
  # before_action :authenticate
  
	def index
    
	end	

	def new
    @article = Article.new
    @header = 'New Article'
    respond_to do |format|
      format.js
    end
  end

  def create
    @role = Role.new(role_params)
    respond_to do |format|
      @role.save
      format.js { render :file => "roles/create.js.erb", locals: {:message => "New Role Created Successfully"}}
    end
  end

	def show_roles
    respond_to do |format|
      format.html
      format.js { render json: RoleDatatable.new(view_context)}
    end
  end

  def edit
    @role = Role.find(params[:id])
    @header = 'Edit Role'
    respond_to do |format|
      format.js { render :file => "roles/new.js.erb" }
    end
  end

  def update
  	@role = Role.find(params[:id])
  	respond_to do |format|
			@role.update(role_params)
			format.js { render :file => "roles/create.js.erb",locals: {:message => "Role Updated Successfully" }}
    end		
  end	

  def assign_sites
    @role = Role.find(params[:role_id])
    @header = "Assign sites to #{@role.name}"
    respond_to do |format|
      format.js
    end
  end

  def update_assign_sites
    role = Role.find(params[:id])
    @message = "Please select atleast one site"

    RolesSite.where(:role_id => params[:id]).delete_all
    if params[:ref].present? && params[:ref].size > 0
      @message = "Sites assign to #{role.name} Successfully !!"

      params[:ref].each do |id|
        role_site = RolesSite.new
        role_site.role_id = params[:id]
        role_site.site_id = id
        role_site.save
      end  
    end  
  end

  private

  def role_params
    params.require(:role).permit(:name, :description, :slug)
  end
end
