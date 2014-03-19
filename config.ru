require 'rack/content_type'
require 'rack/lint'

use Rack::ContentType, 'text/html'
use Rack::Lint

run -> env {
  [200, {}, []]
}
