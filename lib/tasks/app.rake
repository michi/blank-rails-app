require "fileutils"
require "yaml"

namespace :app do
  desc 'Creates a database.yml and settings.yml.'
  task :init do
    puts ">> Creating database.yml.."
    FileUtils.cp(File.join(Rails.root, 'config', 'database.sample.yml'), File.join(Rails.root, 'config', 'database.yml'))
    
    puts ">> Creating settings.yml.."
    
    settings = {}
    
    settings["cookie_key"] = ENV['SESSION_COOKIE_NAME'] || begin
        puts "  Using _myapp_session as session cookie name. You probably want to change that. You can also set it with the SESSION_COOKIE_NAME environment variable (rake app:init SESSION_COOKIE_NAME='_myapp_session')"
      '_myapp_session'
    end    
    settings["cookie_secret"] = %x{rake secret}.split("\n")[1]
    settings["system_message"] = ""
    settings["password_salt"] = "12345%12345"
    
    settings_path = File.join(Rails.root, 'config', 'settings.yml')
    File.delete(settings_path) if File.file?(settings_path)
    File.open(settings_path, 'w+') {|f| f.puts YAML.dump(settings) }
  end
end