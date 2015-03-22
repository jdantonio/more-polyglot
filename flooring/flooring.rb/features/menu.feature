Feature: Flooring Program Menu

  Scenario: Main menu
    When I run `bundle exec ../bin/flooring`
    Then the output should contain "FALSE"
