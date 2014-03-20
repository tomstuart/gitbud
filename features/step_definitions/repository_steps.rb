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

Then(/^I see a list of its branches$/) do
  branch_names = all('.branches > *').map(&:text)
  expect(branch_names).to contain_exactly 'maint', 'master', 'next', 'pu', 'todo'
end
