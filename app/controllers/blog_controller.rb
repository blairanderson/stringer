class BlogController < PublicController

  # This will be used for rendering the blog. possibly with the way rails renders a partial template.
  # if file missing, raise routing error
  # if index, render index file.
  # if blog post, render post.
  # should always render into the layout.
  def show
    file = "public/blog/#{params[:path]}"
    file += ".#{params[:format]}" if params[:format]
    root_file = "#{Rails.root}/#{file}"

    path = params[:id] || ""
    path += "/index.html" if path.match(/\S+\.\S+$/).nil?
    path = "/blog" + path

    exists = File.exist?(path) || File.exist?(file)

    binding.pry

    render "/#{self.controller_name}/#{params[:title]}/index.html"
  end

  private
  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

end
