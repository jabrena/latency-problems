Feature: God Mythology API Concurrent Access and Thread Safety
  This feature ensures that the God Mythology API can handle concurrent requests
  for different mythologies (GREEK, ROMAN, NORDIC) and maintain data integrity (thread safety).

  Background:
    Given the God Mythology API is configured
    And the API provides information for GREEK, ROMAN, and NORDIC mythologies

  Scenario Outline: Concurrent retrieval of god information for a specific mythology
    When many users concurrently request information for "<Mythology>" gods
    Then all users receive a successful response
    And each response contains the correct and complete list of "<Mythology>" gods
    And the information is consistent across all responses for "<Mythology>" gods

    Examples:
      | Mythology |
      | GREEK     |
      | ROMAN     |
      | NORDIC    |

  Scenario: Mixed concurrent requests ensure overall system thread safety
    When many users concurrently request information for GREEK, ROMAN, and NORDIC gods simultaneously
    Then all requests for "GREEK" gods retrieve the correct list of Greek gods
    And all requests for "ROMAN" gods retrieve the correct list of Roman gods
    And all requests for "NORDIC" gods retrieve the correct list of Nordic gods
    And the system ensures data integrity and thread safety for all concurrent operations
