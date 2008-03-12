class CustomFormBuilder< ActionView::Helpers::FormBuilder
  DEFAULT_OPTIONS = {}
  helpers = field_helpers + 
    %w(date_select datetime_select time_select) + 
    %w(collection_select select country_select time_zone_select) - 
    %w(hidden_field label fields_for)

  helpers.each do |name| 
    define_method(name) do |field, *args| 
      options = args.extract_options!
      label_text = options.delete(:label_text)
      
      if label_text == false
        super(field, options)
      else
        @template.content_tag(:p, label((label_text || field)) + "<br/>" + super(field, options)) 
      end
    end 
  end
end