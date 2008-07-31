require "fileutils"
require "yaml"
require "digest/sha1"

namespace :app do
  desc 'Creates a database.yml and settings.yml.'
  task :init do
    puts ">> Creating database.yml.."
    FileUtils.cp(File.join(Rails.root, 'config', 'database.sample.yml'), File.join(Rails.root, 'config', 'database.yml'))
    
    puts ">> Creating settings.yml.."
    
    create_settings_dot_yml
    create_user_fixture
    
    puts ">> Migrating the database.."
    Rake::Task["db:migrate"].invoke
  end
  
  def create_settings_dot_yml
    settings = {}
    
    settings["cookie_key"] = get_cookie_key
    settings["cookie_secret"] = generate_secret
    settings["system_message"] = ""
    @password_salt = generate_password_salt
    settings["password_salt"] = @password_salt
    
    yamlize_and_save(settings, File.join(Rails.root, 'config', 'settings.yml'))
  end
  
  def create_user_fixture
    data = {
      "august" => {
        "username" => "august",
        "full_name" => "August Lilleaas",
        "email" => "augustlilleaas@gmail.com"
      }
    }
    
    data["august"]["password_hash"] = generate_password_hash
    yamlize_and_save(data, File.join(Rails.root, 'test', 'fixtures', 'users.yml'))
  end
  
  def get_cookie_key
    ENV['SESSION_COOKIE_NAME'] || begin
        puts "  Using _myapp_session as session cookie name. You probably want to change that. You can also set it with the SESSION_COOKIE_NAME environment variable (rake app:init SESSION_COOKIE_NAME='_myapp_session')"
      '_myapp_session'
    end
  end
  
  def generate_password_salt
    generate_secret.insert(rand(39), "%s")
  end
  
  def generate_secret
    %x{rake secret}.split("\n")[1]
  end
  
  def generate_password_hash
    Digest::SHA1.hexdigest(@password_salt % "12345")
  end
  
  def yamlize_and_save(data_hash, target)
    File.delete(target) if File.file?(target)
    File.open(target, "w+") {|f| f.puts YAML.dump(data_hash) }
  end
end