module ApplicationHelper
  
  def js_template(path)
    hb = Rails.root.join('app/assets/javascripts/templates', "#{path}.hbs").read.html_safe
    content_tag(:script, hb, :type => "text/x-handlebars-template", :id => path) +
    javascript_tag("""
      window.template = window.template || {}
      window.template['#{path}'] = Handlebars.compile($('##{path}').html())
    """)
  end

end
