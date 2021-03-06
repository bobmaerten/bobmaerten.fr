###
# Blog settings
###
activate :livereload

set :markdown_engine, :redcarpet
set :markdown, :fenced_code_blocks => true, :smartypants => true

Time.zone = "Paris"
activate :blog do |blog|
  blog.prefix = "blog"
  blog.permalink = ":year/:title.html"
  blog.sources = ":year-:month-:day-:title.html"
  blog.taglink = "tags/:tag.html"
  # blog.layout = "layout"
  blog.summary_separator = /READMORE/
  # blog.summary_length = 250
  # blog.year_link = ":year.html"
  # blog.month_link = ":year/:month.html"
  # blog.day_link = ":year/:month/:day.html"
  blog.default_extension = ".markdown"
  blog.new_article_template = "blog_article.tmpl"
  blog.tag_template = "tag.html"
  blog.calendar_template = "calendar.html"

  blog.paginate = true
  blog.per_page = 5
  blog.page_link = "page/:num"
end

activate :directory_indexes

activate :deploy do |deploy|
  deploy.method = :git
  deploy.remote   = "origin" # remote name or git url, default: origin
  deploy.branch   = "master" # default: gh-pages
  # deploy.host   = "arrakis"
  # deploy.path   = "/home/deploy/bobmaerten.fr"
  # Optional Settings
  # deploy.user  = "deploy" # no default
  # deploy.port  = 5309 # ssh port, default: 22
  deploy.build_before = true
  deploy.clean = true # remove orphaned files on remote host, default: false
end

page "blog/*", :layout => :post
page "blog/index.html", :proxy => '/index.html'
page "patisserie/*", :layout => :article
page "/atom.xml", :layout => false
page "/sitemap.xml", :layout => false

###
# Compass
###

# Susy grids in Compass
# First: gem install susy
# require 'susy'

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy (fake) files
# page "/this-page-has-no-template.html", :proxy => "/template-file.html" do
#   @which_fake_page = "Rendering a fake page with a variable"
# end

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Code syntax
activate :syntax


###
# Helpers
###

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

set :css_dir, 'css'

set :js_dir, 'js'

set :images_dir, 'img'

# Build-specific configuration
configure :build do
  activate :favicon_maker, :icons => {
    "favicon_base.png" => [
      { icon: "apple-touch-icon-152x152-precomposed.png" },
      { icon: "apple-touch-icon-144x144-precomposed.png" },
      { icon: "apple-touch-icon-114x114-precomposed.png" },
      { icon: "apple-touch-icon-72x72-precomposed.png" },
      { icon: "mstile-144x144", format: :png },
      { icon: "favicon.png", size: "16x16" },
      { icon: "favicon.ico", size: "64x64,32x32,24x24,16x16" },
    ]
  }
  # activate :asset_host, host: 'http://bobmaerten.fr/'
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Enable cache buster
  # activate :cache_buster

  # Use relative URLs
  # activate :relative_assets

  # Compress PNGs after build
  # First: gem install middleman-smusher
  # require "middleman-smusher"
  # activate :smusher

  # Or use a different image path
  # set :http_path, "/Content/images/"
end
