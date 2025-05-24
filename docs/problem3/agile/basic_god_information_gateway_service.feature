# Epic: EPIC-001 - God Information Gateway API
# Feature: FEAT-001 - God Information Gateway API
# User Story: US-001 - Basic God Information Service

Feature: God Information Gateway Service

Background:
  Given the God Information Gateway API is running on localhost:8080
  And all external mythology APIs are available at "https://my-json-server.typicode.com/jabrena/latency-problems/"

Scenario: Successfully retrieve Greek gods list
  Given all external mythology APIs are available
  When I make a GET request to "/api/v1/gods/greek"
  Then I should receive HTTP 200 status
  And the response should be in JSON format
  And the response should contain:
    | field      | value                          |
    | mythology  | "greek"                        |
    | gods       | ["Zeus", "Hera", "Poseidon"]   |
    | count      | 20                             |
    | source     | "external_api"                 |
    | timestamp  | current timestamp              |
  And the response should include gods "Zeus", "Hera", "Poseidon"

Scenario: Backward compatibility with uppercase parameters
  Given all external mythology APIs are available
  When I make a GET request to "/api/v1/gods/GREEK"
  Then I should receive HTTP 200 status
  And the response should be in JSON format
  And the response should contain:
    | field      | value                          |
    | mythology  | "greek"                        |
    | gods       | ["Zeus", "Hera", "Poseidon"]   |
    | count      | 20                             |
    | source     | "external_api"                 |
    | timestamp  | current timestamp              |
  And the response should include gods "Zeus", "Hera", "Poseidon"

