module ApplicationHelper
  
  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "MyDay"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end


  def date_select_items
    days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    s = ""
    s += "<li>" + link_to("Today", today_path) + "</li>" unless session[:path] == 'Today'
    s += "<li>" + link_to("Tomorrow", tomorrow_path) + "</li>" unless session[:path] == 'Tomorrow'

    # add next 4 days by DOW name
    4.times do |i|
      d = Date.today + i + 2
      s += "<li><a href='/todos?d=" + d.to_s + "'>" + days[d.wday] + "</a></li>" unless session[:path] == d.strftime("%m/%d/%Y")
    end

    s += "<li class='divider'></li>" unless session[:path] == 'Someday'
    s += "<li>" + link_to("Someday", someday_path) + "</li>" unless session[:path] == 'Someday'
    return s
  end


  def convert_MMDDYYYY_to_YYYYMMDD(o)
    b = o.split('/')
    s = b[2] + '-' + b[0] + '-' + b[1]
    d = s.to_date
    return d
  end


end
