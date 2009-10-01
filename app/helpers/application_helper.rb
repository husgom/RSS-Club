# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def image_submit_tag(source, options = {})
    # For testing I need a button with an id
    options[:id] ||= "submit"
    super source, options
  end
end
