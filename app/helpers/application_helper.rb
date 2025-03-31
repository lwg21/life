module ApplicationHelper
  # Render SVG icon partials inline + memoization
  def icon(name)
    @icons ||= {}
    @icons[name] ||= render "shared/icons/#{name}"
  end

  def navbar_active?(section, params)
    active = case section
    when :habits
      params["controller"] == "habits"
    when :unlocks
      params["controller"] == "goals"
    when :settings
      params["action"] == "settings"
    end
    active ? "active" : ""
  end
end
