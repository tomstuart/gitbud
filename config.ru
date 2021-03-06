require 'grack'
require 'rack/content_type'
require 'rack/lint'
require 'rack/request'
require 'rack/response'
require 'rack/utils'
require 'rugged'
require 'tmpdir'

use Rack::ContentType, 'text/html'
use Rack::Lint

map '/' do
  run -> env {
    Rack::Response.new do |response|
      response.write <<-END
        <form action="view">
          <label>Repository URL <input name="url"></label>
          <input type="submit" value="View repository">
        </form>
      END
    end
  }
end

map '/view' do
  run -> env {
    request = Rack::Request.new(env)
    url = request.params['url']

    branch_names = nil

    Dir.mktmpdir do |directory|
      repository = Rugged::Repository.init_at(directory)

      Rugged::Remote.new(repository, url).connect(:fetch) do |remote|
        branch_names = remote.ls.
          map { |reference| reference[:name] }.
          select { |name| name.start_with?('refs/heads/') }.
          map { |name| name.slice(%r{(?<=\Arefs/heads/).*\z}) }
      end
    end

    Rack::Response.new do |response|
      response.write '<ul class="branches">'
      branch_names.each do |branch_name|
        response.write "<li>#{Rack::Utils.escape_html(branch_name)}</li>"
      end
      response.write '</ul>'
    end
  }
end

map '/repositories' do
  run Grack::App.new(project_root: File.expand_path('../repositories', __FILE__), adapter: Grack::GitAdapter)
end
