module ApplicationHelper

  def flash_level(level)
    if level == "notice"
      'alert alert-success'
    else 
      'alert alert-danger'
    end
  end
end
