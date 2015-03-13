module ApplicationHelper
  def csrf_inject
    csrf_form = <<-ERB
      <input type="hidden" name="authenticity_token" value="#{form_authenticity_token}" />
    ERB
    csrf_form.html_safe
  end

  def method_n(name)
    name ||= "POST"
    html = <<-HTML
      <input type="hidden" name="_method" value="#{name}" />
    HTML
    html.html_safe
  end

  def helpz(obj, method, singular)
    method_name = "#{method ? method + "_" : ""}"
    resource_name = obj.class.name.downcase
    resource_name = resource_name.pluralize unless singular
    method_name += resource_name
    Rails.application.routes.url_helpers.send :"#{method_name}_url", obj.id
  end

  def owns?(obj)
    current_user.id == obj.try(:user).try(:id)
  end

  def render_heirarchy(heirarchy)
    return unless heirarchy
    html_string = ""
    heirarchy.each do |elem|
      html_string += link_to elem.name, helpz(elem, nil, true)
      html_string += " > "
    end
    html_string.html_safe
  end
end
