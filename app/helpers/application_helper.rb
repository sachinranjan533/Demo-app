module ApplicationHelper
  def format_date(date)
    date.strftime("%d/%m/%Y") if date
  end
end
