require 'rack/content_type'
require 'rack/lint'
require 'rack/response'

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
