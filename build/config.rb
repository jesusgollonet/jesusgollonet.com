
require 'slim'
require 'redcarpet'
require "middleman-smusher"
require File.join(File.dirname(__FILE__), "", "helpers/env_helper")

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

EnvHelper.set_env_vars

# Activate deploy extension
activate :deploy do |deploy|
  deploy.method = :rsync
  deploy.host =  ENV["HOST"]
  deploy.user =  ENV["USER"]
  deploy.path =  ENV["LIVE_PATH"]
end




