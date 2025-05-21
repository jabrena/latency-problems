Feature: Consume some REST God Services

Background: Decimal representation of `Zeus` is 122101117115

Scenario: Consume the APIs in a Happy path scenario
    Given a list of REST API about Greek, Roman & Nordic
    When  call and retrieve all API info
    Then  filter by god starting with `n`
    And   convert the names into a decimal format
    And   sum

Scenario: Consume the APIs considering some latency in the greek service
    Given a list of REST API about Greek, Roman & Nordic
    When  call and retrieve all API info from the good list
    Then  filter by god starting with `n`
    And   convert the names into a decimal format
    And   sum