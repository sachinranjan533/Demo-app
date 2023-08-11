module ApplicationHelper

  def format_date(date)
    date.strftime("%d/%m/%Y") if date
  end

  def active_menu_class?(path)
    return 'menu_active' if request.path == path
    ''
  end
  
end
