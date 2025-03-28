module ApplicationHelper
  def navbar_active?(section, params)
    active = case section
    when :home
      params["action"] == "home"
    when :habits
      params["controller"] == "habits" && params["action"] != "home"
    when :unlocks
      params["controller"] == "goals"
    when :settings
      params["action"] == "settings"
    end
    active ? "active" : ""
  end
end
