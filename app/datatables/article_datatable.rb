class ArticleDatatable < AjaxDatatablesRails::Base
  def_delegators :@view, :prepare_html_for_action,:format_date

  def view_columns
    @view_columns ||= {
      title: { source: "Article.title", cond: :like},
      description: { source: "Article.description", cond: :like},
      created_at: { source: "Article.created_at", cond: :like},
      updated_at: { source: "Article.updated_at", cond: :like},
      action: { source: ""}
    }
  end

  def data
    records.map do |record|
      {
        title: record.title,
        description: record.description,
        created_at: format_date(record.created_at),
        updated_at: format_date(record.updated_at),
        action: prepare_html_for_action(record, "action").html_safe
      }
    end
  end

  def prepare_html_for_action(record, status)
    @view.render :partial =>  '/datatables/articles/action', :locals => {:record => record, :status => status}
  end  

  private

  def get_raw_records
    Article.order('created_at DESC').all
  end
end
