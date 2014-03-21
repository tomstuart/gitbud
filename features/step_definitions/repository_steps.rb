require 'rugged'
require 'tmpdir'

Given(/^a public repository hosted by GitBud$/) do
  repository = Rugged::Repository.init_at(File.expand_path('../../../repositories/hello_world.git', __FILE__), :bare)
  blob = "puts 'Hello, world!'\n"
  oid = repository.write(blob, :blob)
  index = Rugged::Index.new
  index.add(path: 'hello_world.rb', oid: oid)
  tree = index.write_tree(repository)
  commit = Rugged::Commit.create(repository, message: 'Initial commit', parents: [], tree: tree, update_ref: 'HEAD')
end

When(/^I enter the (.*) URL of a public repository$/) do |transport|
  url =
    case transport
    when 'Git'
      'git://github.com/git/git.git'
    when 'HTTPS'
      'https://github.com/git/git.git'
    end

  visit '/'
  fill_in 'Repository URL', with: url
  click_on 'View repository'
end

When(/^I clone the repository URL on the command line$/) do
  @directory = Dir.mktmpdir
  pid = Process.fork { Rack::Handler.default.run(Capybara.app, Host: 'localhost', Port: 8888) }

  sleep 1 # wait for WEBrick to boot

  Dir.chdir(@directory) do
    system 'git', 'clone', 'http://localhost:8888/repositories/hello_world.git'
  end

  Process.kill 'SIGTERM', pid
end

Then(/^I see a list of its branches$/) do
  branch_names = all('.branches > *').map(&:text)
  expect(branch_names).to contain_exactly 'maint', 'master', 'next', 'pu', 'todo'
end
