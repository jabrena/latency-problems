# Problem 6

```gherkin
Feature: Consume a REST Greek God Service

Scenario: Consume the API in a Happy path case
    Given a REST API about Greek gods
    When  the client sends the request
    And   execute a Retry Policy
    Then  return all gods starting with `a`

Scenario: Force an internal Retry behaviour
    Given a REST API about Greek gods
    When  the client sends the request
    And   execute a Retry Policy
    Then  return all gods starting with `a`

Scenario: Consume the API with a bad response
    Given a REST API about Greek gods
    When  the client sends the request
    And   execute a Retry Policy
    Then  return all gods starting with `a`

Scenario: Consume the API with a corrupted response
    Given a REST API about Greek gods
    When  the client sends the request
    And   execute a Retry Policy
    Then  return all gods starting with `a`

Scenario: Test a bad internal configuration
    Given a REST API about Greek gods
    When  the client sends the request
    And   execute a Retry Policy
    Then  return all gods starting with `a`

```

![](./sequence-diagram-latency-problem6.svg)

**Notes:**

- Try to test the solution without any Internet call
- Review the timeout for Every connection.
- Review the retry options
- REST API 1: https://my-json-server.typicode.com/jabrena/latency-problems/greek
