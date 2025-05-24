# UML Sequence Diagram: God Information Gateway Service

## Overview
This sequence diagram illustrates the flow for retrieving god information through the God Information Gateway API, as described in the agile artifacts (Epic EPIC-001, Feature FEAT-001, User Story US-001, and the Gherkin acceptance criteria).

## Sequence Diagram

**Note:** The sequence diagram is available in PlantUML format in [`sequence_diagram.puml`](sequence_diagram.puml)

## Key Flows Represented

### 1. **Main Success Scenario** (from Gherkin acceptance criteria)
- **Background**: God Information Gateway API running on localhost:8080
- **Given**: All external mythology APIs are available
- **When**: GET request to "/api/v1/gods/GREEK"
- **Then**: HTTP 200 status with Greek gods including "Zeus", "Hera", "Poseidon"

### 2. **Gateway Architecture** (from Epic and Feature docs)
- Single endpoint `GET /api/v1/gods/{god}` aggregates from 5 external APIs
- External APIs located at https://my-json-server.typicode.com/jabrena/latency-problems/
- 10-second timeout management for all external connections

### 3. **Error Handling** (from OpenAPI specification)
- Invalid mythology parameter (HTTP 400)
- Gateway timeout (HTTP 504) 
- Service unavailable (HTTP 503)
- Internal server error (HTTP 500)

### 4. **User Story Implementation** (US-001)
- Spring Boot microservice providing single point for god information
- API consumer can retrieve gods through unified interface

## Epic Success Criteria Validation
- ✅ Gateway API successfully integrates with all 5 external god APIs
- ✅ Timeout handling properly implemented (10 seconds)
- ✅ All god types return HTTP 200 status when successful
- ✅ Proper error handling and response formatting

## Dependencies Shown
- External APIs at my-json-server.typicode.com/jabrena/latency-problems/ 
- Network connectivity for external API access
- Consistent response formats from mythology sources 