###
# Blog settings
###

Time.zone = "Tokyo"

activate :blog do |blog|
  # This will add a prefix to all links, template references and source paths
  # blog.prefix = "article"

  blog.permalink = "{year}/{month}/{title}.html"
  # Matcher for blog source files
  blog.sources = "article/{year}-{month}-{day}-{title}.html"
  # blog.taglink = "tags/{tag}.html"
  blog.layout = "layout/layout"
  # blog.summary_separator = /(READMORE)/
  # blog.summary_length = 250
  # blog.year_link = "{year}.html"
  # blog.month_link = "{year}/{month}.html"
  # blog.day_link = "{year}/{month}/{day}.html"
  blog.default_extension = ".md"

  # blog.tag_template = "tag.html"
  # blog.calendar_template = "calendar.html"

  # Enable pagination
  blog.paginate = true
  blog.per_page = 4
  blog.page_link = "page/{num}"
end

page "/feed.xml", layout: false

activate :directory_indexes

###
# Compass
###

compass_config do |config|
  config.output_style = :expanded
  config.line_comments = false
end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", layout: false
#
# With alternative layout
# page "/path/to/file.html", layout: :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
activate :automatic_image_sizes

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

# Slim Options
require 'slim'
set :slim, { :pretty => true, :sort_attrs => false, :format => :html5 }

# Directory Settings
set :css_dir, 'css'
set :js_dir, 'js'
set :images_dir, 'img'
set :fonts_dir, 'font'
set :layouts_dir, 'layout'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  activate :relative_assets
  set :relative_links, true

  # Or use a different image path
  # set :http_prefix, "/Content/images/"

  # Autoprefixer
  activate :autoprefixer, browsers: ['last 2 versions', 'ie 9']
end

# Deploy
activate :deploy do |deploy|
  deploy.build_before = true
  deploy.method = :git
  deploy.branch = 'gh-pages'
end