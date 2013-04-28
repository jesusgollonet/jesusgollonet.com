
require 'slim'
require 'redcarpet'
require "middleman-smusher"

# set :slim, :pretty => true
set :markdown, :layout_engine => :slim
set :markdown_engine, :redcarpet


activate :directory_indexes 


# generate dynamic pages for each project. the variable @project will carry the yaml data structure
data.projects.each do |p|
  proxy "/projects/#{p.url}.html", "project.html", :ignore => true do
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