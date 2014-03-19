When(/^I enter the Git URL of a public repository$/) do
  visit '/'
  fill_in 'Repository URL', with: 'git://github.com/git/git.git'
  click_on 'View repository'
end
