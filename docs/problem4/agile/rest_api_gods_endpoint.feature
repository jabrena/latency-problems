Feature: REST API Gods Endpoint

Background:
  Given the mythology aggregation service is running
  And all external mythology APIs are available

Scenario: Successfully retrieve all mythology gods data
  Given the client application is ready to make API requests
  When the client sends a GET request to "/api/v1/gods"
  Then the response status should be 200
  And the response should contain JSON formatted mythology data
  And the response should include gods from all mythologies
  And the response time should be less than 5 seconds
  And the response should have the following structure:
    """
    [
        {
            "id": 1,
            "mythology": "greek",
            "god": "Zeus"
        },
        {
            "id": 2,
            "mythology": "roman",
            "god": "Jupiter"
        },
        {
            "id": 3,
            "mythology": "nordic",
            "god": "Odin"
        }
    ]
    """

Scenario: Validate response format structure
  Given the client application is ready to make API requests
  When the client sends a GET request to "/api/v1/gods"
  Then the response status should be 200
  And the response content type should be "application/json"
  And each god entry should contain "id", "mythology", and "god" fields
  And the "id" field should be a number
  And the "mythology" field should be a string
  And the "god" field should be a string
  And the response should include data from Greek mythology
  And the response should include data from Roman mythology
  And the response should include data from Nordic mythology
  And the response should include data from Indian mythology
  And the response should include data from Celtiberian mythology
