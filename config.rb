
require 'slim'
require 'redcarpet'
require "middleman-smusher"

# set :slim, :pretty => true
set :markdown, :layout_engine => :slim
set :markdown_engine, :redcarpet


activate :directory_indexes 
activate :livereload


# generate dynamic pages for each project. the variable @project will carry the yaml data structure
data.projects.each do |p|
  proxy "/project/#{p.url}.html", "project.html", :ignore => true do
    @project = p
  end
end

# Build-specific configuration
configure :build do  
  activate :minify_css
  activate :minify_javascript
  activate :cache_buster
  activate :smusher # compressing images
end

helpers do
  def get_local_env_path
    env_file = File.join(File.dirname(__FILE__) , '', 'local_env.yml')
    env_file
  end

  def set_env_vars file_path
    YAML.load(File.open(file_path)).each do |key, value|
      ENV[key.to_s] = value
    end if File.exists?(file_path)
  end
end

# sensible settings are stored in a .gitignored file called local_env.yml
# and read as ENV variables below
# http://railsapps.github.io/rails-environment-variables.html
set_env_vars(get_local_env_path)

# Activate deploy extension
activate :deploy do |deploy|
  deploy.method = :rsync
  deploy.host =  ENV["HOST"]
  deploy.user =  ENV["USER"]
  deploy.path =  ENV["STAGING_PATH"]
end




