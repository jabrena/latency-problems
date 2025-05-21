Feature: Greek Gods Wikipedia Information
  As a user
  I want to find out which Greek god has the most literature on Wikipedia
  So that I can learn more about them

  Background:
    Given the following REST APIs:
      | API Name      | URL                                                              |
      | Greek Gods    | https://my-json-server.typicode.com/jabrena/latency-problems/greek |
      | Wikipedia     | https://en.wikipedia.org/wiki/{greekGod}                         |
    And I have a way to measure the amount of literature for a god on Wikipedia

  Scenario: Successfully retrieve the list of Greek gods
    When I request the list of Greek gods
    Then I should receive a list containing Greek gods

  Scenario: Identify the Greek god with the most literature on Wikipedia
    Given I have the list of Greek gods
    When I retrieve the Wikipedia page for each god
    And I determine the amount of literature for each god
    Then I should be able to identify the god with the most literature
