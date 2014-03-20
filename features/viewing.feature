Feature: Viewing remote repositories
  As a GitBud user
  I want to see information about a remote repository with a particular URL
  So that I can check it’s the one I expect

  Scenario: View a public repository with a Git URL
    When I enter the Git URL of a public repository
    Then I see a list of its branches

  Scenario: View a public repository with an HTTPS URL
    When I enter the HTTPS URL of a public repository
    Then I see a list of its branches
