require 'rack/lint'

use Rack::Lint

run -> env {
  [200, {}, []]
}
