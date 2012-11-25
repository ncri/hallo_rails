require "hallo_rails/version"

class Railtie < Rails::Railtie
  initializer "hallo_rails.view_helpers" do
    ActionView::Base.send :include, HalloRails::ViewHelpers
  end
end


module HalloRails

  module Rails
    class Engine < ::Rails::Engine
    end
  end

  module ViewHelpers

    def editable object, method, options = {}
      object_name = object.class.to_s.underscore
      options.reverse_merge! tag: :div,
                             content: object.send(method).try(:html_safe),
                             update_url: "/#{object_name.pluralize}/#{object.to_param}",
                             blank_text: "<i>Click to Edit</i>".html_safe

      options[:content] = sanitize(options[:content]) if options[:sanitize]

      is_editable = !options.has_key?(:editable) || options[:editable]
      content_tag_data = if is_editable
        {update_url: options[:update_url],
        model: object_name,
        method: method.to_s,
        editable_options: options[:hallo_options],
        editable_plugins: options[:plugins] }.merge(options[:params] || {})
      end

      content_tag( :div, class: 'editable_wrapper', style: options[:inline] ? 'display:inline-block' : nil ) do
        content_tag options[:tag], options[:content].present? ? options[:content] : options[:blank_text],
                      class: "#{'editable' if is_editable}",
                      id: "#{object_name}_#{method.to_s}",
                      data: content_tag_data
      end
    end


    def form_editable object, method, options = {}
      object_name = object.class.to_s.underscore
      options.reverse_merge! tag: :div,
                             content: object.send(method).try(:html_safe),
                             blank_text: "<i>Click to Edit</i>".html_safe
      options[:content] = sanitize(options[:content]) if options[:sanitize]
      content_tag( :div, class: 'editable_wrapper', style: options[:inline] ? 'display:inline-block' : nil) do
        content_tag( options[:tag], options[:content].present? ? options[:content] : options[:blank_text],
                                      class: 'form_editable',
                                      data: { model: object_name,
                                              method: method.to_s,
                                             editable_options: options[:hallo_options],
                                             editable_plugins: options[:plugins] }.merge(options[:params] || {})) +
        text_area_tag( "#{object_name}[#{method}]", options[:content], style: "display:none" )
      end
    end

  end

end
