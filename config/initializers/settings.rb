Settings = YAML::load_file(File.join(RAILS_ROOT, "config", "settings.yml"))
ActionView::Base.default_form_builder = CustomFormBuilder