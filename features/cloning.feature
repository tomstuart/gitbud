Feature: Cloning Git repositories
  As someone on the internet
  I want to clone a repository hosted by GitBud
  So that I can work on it locally

  Scenario: Clone a public repository
    Given a public repository hosted by GitBud
    When I clone the repository URL on the command line
    Then I have a local copy
