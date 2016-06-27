module ApplicationHelper

	def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end

  def link_to_add_fields(name, f, association)
	  new_object = f.object.class.reflect_on_association(association).klass.new
	  fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
	    render(association.to_s.singularize + "_fields", :f => builder)
	  end
	  link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
	end

	def link_to_function(name, function, html_options={})
	  message = "link_to_function is deprecated and will be removed from Rails 4.1. We recommend using Unobtrusive JavaScript instead. " +
	    "See http://guides.rubyonrails.org/working_with_javascript_in_rails.html#unobtrusive-javascript"
	  ActiveSupport::Deprecation.warn message

	  onclick = "#{"#{html_options[:onclick]}; " if html_options[:onclick]}#{function}; return false;"
	  href = html_options[:href] || '#'

	  content_tag(:a, name, html_options.merge(:href => href, :onclick => onclick))
	end

	def flash_class(level)
		case level.to_sym
			when :notice then "alert alert-success"
			when :info then "alert alert-info"
			when :alert then "alert alert-danger"
			when :warning then "alert alert-warning"
		end
	end

	def link_to_reloggin
		unless session[:relogin_id].blank?
      content_tag :li do
      	link_to "Back login by admin", back_login_by_admin_path, class: 'btn-info btn'
      end
    end
	end
end
