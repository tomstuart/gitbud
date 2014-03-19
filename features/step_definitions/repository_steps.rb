When(/^I enter the Git URL of a public repository$/) do
  visit '/'
  fill_in 'Repository URL', with: 'git://github.com/git/git.git'
  click_on 'View repository'
end

Then(/^I see a list of its branches$/) do
  branch_names = all('.branches > *').map(&:text)
  expect(branch_names).to contain_exactly 'maint', 'master', 'next', 'pu', 'todo'
end
