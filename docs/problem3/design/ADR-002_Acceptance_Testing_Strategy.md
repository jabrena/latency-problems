# ADR-002: Acceptance Testing Strategy for God Information Gateway API

**Date:** 2025-01-24  
**Status:** Proposed  
**Technical Area:** Acceptance Testing Strategy  
**Software Type:** Web API/Microservices  

## Context

### Software Overview
**Type:** Web API/Microservices (Gateway Pattern)  
**Architecture:** Spring Boot-based API Gateway with external service integration  
**Technology Stack:** 
- Backend: Spring Boot 3.5.0, Java 24, Spring RestClient
- External APIs: 5 mythology services at my-json-server.typicode.com
- Documentation: OpenAPI 3.0.3 with SpringDoc
- Monitoring: Spring Boot Actuator

### Business Context
The God Information Gateway API provides unified access to mythology data from five external ancient civilization sources (Greek, Roman, Nordic, Indian, Celtiberian). The system serves mythology enthusiasts and API consumers who need simplified integration without managing multiple external API endpoints. Critical business requirements include 10-second timeout enforcement, consistent response formatting, and reliable external service aggregation.

### Current State
**Existing Testing Artifacts:**
- Gherkin acceptance criteria defined in `basic_god_information_gateway_service.feature`
- OpenAPI specifications for both gateway and external APIs
- C4 architecture documentation with component interaction details
- Background scenarios validating API availability and response formats

**Testing Infrastructure:**
- Development environment: localhost:8080
- External API dependencies: my-json-server.typicode.com/jabrena/latency-problems/
- Existing acceptance criteria covering HTTP 200 responses, JSON formatting, and data validation

### Problem Statement
How to implement a comprehensive acceptance testing strategy that validates the gateway's integration with five external mythology APIs, ensures proper timeout handling, validates response aggregation accuracy, and maintains reliable testing despite external service dependencies.

## Functional Requirements Impact

### Critical User Journeys
1. **Primary API Consumer Flow:**
   - Request mythology data via `GET /api/v1/gods/{mythology}`
   - Validate response format with metadata (mythology, gods, count, source, timestamp)
   - Ensure consistent behavior across all five mythology types

2. **Error Handling Scenarios:**
   - Invalid mythology parameter validation (HTTP 400)
   - External service timeout handling (HTTP 504)
   - External service unavailability (HTTP 503)
   - Internal gateway errors (HTTP 500)

3. **Performance Requirements:**
   - 10-second timeout enforcement for all external API calls
   - Response time validation under normal and stress conditions

### User Types and Personas
- **API Consumers:** Developers integrating mythology data into applications
- **Mythology Enthusiasts:** End users accessing data through client applications
- **System Administrators:** Monitoring and maintaining gateway health

### Integration Points
**Critical External Dependencies:**
- Greek gods API: `/greek` endpoint
- Roman gods API: `/roman` endpoint  
- Nordic gods API: `/nordic` endpoint
- Indian gods API: `/indian` endpoint
- Celtiberian gods API: `/celtiberian` endpoint

**Integration Risk Level:** HIGH - Gateway functionality completely dependent on external API availability

### Data and Compliance Requirements
- No sensitive data handling (public mythology information)
- No specific compliance requirements
- Data accuracy validation against known mythology god lists

## Decision

We have decided to implement **BDD-driven API Testing Strategy with External Service Simulation**.

### Testing Strategy Overview
Implement a three-tier acceptance testing approach:
1. **Contract Testing** with external API simulation for reliable automated testing
2. **End-to-End Integration Testing** with real external services for production validation
3. **BDD Scenarios** using existing Gherkin criteria for business requirement validation

### Testing Scope and Coverage
- **API Contract Testing:** 95% automated coverage of all endpoint combinations
- **Integration Testing:** Real external API testing for critical scenarios
- **Performance Testing:** Timeout validation and response time verification
- **Error Handling Testing:** Comprehensive negative scenario coverage
- **Regression Testing:** Automated validation of existing Gherkin scenarios

### Automation vs Manual Balance
- **Automated Testing (85%):**
  - All Gherkin scenarios automated with REST Assured
  - Contract testing with WireMock for external API simulation
  - CI/CD pipeline integration for continuous validation
  
- **Manual Testing (10%):**
  - Exploratory testing of edge cases
  - User experience validation for error responses
  - Production environment smoke testing

- **Exploratory Testing (5%):**
  - Investigation of external API behavior changes
  - Performance characteristics under varying loads

### Tool Selection
**Primary Testing Tools:**
- **API Testing:** REST Assured with TestNG - Comprehensive REST API testing framework for Spring Boot
- **BDD Testing:** Cucumber with Gherkin - Leverages existing feature files and scenarios
- **Service Virtualization:** WireMock - Simulates external mythology APIs for reliable testing
- **Performance Testing:** JMeter - Validates timeout behavior and load characteristics
- **Test Management:** Maven Surefire - Integrated with Spring Boot build process
- **CI/CD Integration:** GitHub Actions/Jenkins - Automated test execution in build pipeline

## REST Assured Implementation for HTTP Testing

### REST Assured Framework Selection Rationale
REST Assured has been chosen as the primary HTTP client testing framework for the God Information Gateway API acceptance tests based on its comprehensive capabilities for API testing and seamless Spring Boot integration.

### Core HTTP Testing Capabilities
**API Endpoint Testing:**
REST Assured will handle all HTTP calls to the gateway API endpoint `GET /api/v1/gods/{mythology}` with fluent, readable test syntax that maps directly to the existing Gherkin acceptance criteria.

**Example Implementation for Gherkin Scenario:**
```java
// From: basic_god_information_gateway_service.feature
// Scenario: Successfully retrieve Greek gods list
@Test
public void testSuccessfullyRetrieveGreekGodsList() {
    given()
        .baseUri("http://localhost:8080")
        .when()
        .get("/api/v1/gods/GREEK")
        .then()
        .statusCode(200)
        .contentType("application/json")
        .body("mythology", equalTo("GREEK"))
        .body("gods", hasItems("Zeus", "Hera", "Poseidon"))
        .body("count", equalTo(20))
        .body("source", equalTo("external_api"))
        .body("timestamp", notNullValue());
}
```

### Integration with Existing Gherkin Scenarios
**Background Step Implementation:**
```java
// Background: Given the God Information Gateway API is running on localhost:8080
@Given("the God Information Gateway API is running on localhost:8080")
public void theGodInformationGatewayApiIsRunning() {
    RestAssured.baseURI = "http://localhost:8080";
    // Health check to ensure gateway is available
    given()
        .when()
        .get("/actuator/health")
        .then()
        .statusCode(200);
}

// Background: And all external mythology APIs are available
@Given("all external mythology APIs are available at {string}")
public void allExternalMythologyApisAreAvailable(String baseUrl) {
    // This will be handled by WireMock simulation in contract tests
    // or validated against real APIs in integration tests
}
```

**Primary Test Scenario Implementation:**
```java
@When("I make a GET request to {string}")
public void iMakeAGetRequestTo(String endpoint) {
    response = given()
        .when()
        .get(endpoint);
}

@Then("I should receive HTTP {int} status")
public void iShouldReceiveHttpStatus(int expectedStatusCode) {
    response.then().statusCode(expectedStatusCode);
}

@Then("the response should be in JSON format")
public void theResponseShouldBeInJsonFormat() {
    response.then().contentType("application/json");
}

@Then("the response should include gods {string}, {string}, {string}")
public void theResponseShouldIncludeGods(String god1, String god2, String god3) {
    response.then()
        .body("gods", hasItems(god1, god2, god3));
}
```

### HTTP Error Scenario Testing
**Timeout Validation with REST Assured:**
```java
// Test 10-second timeout enforcement
@Test
public void testGatewayTimeoutHandling() {
    given()
        .baseUri("http://localhost:8080")
        .when()
        .get("/api/v1/gods/GREEK")
        .then()
        .time(lessThan(10000L)) // Validates response within 10 seconds
        .statusCode(anyOf(equalTo(200), equalTo(504))); // Success or timeout
}
```

**Invalid Parameter Testing:**
```java
@Test
public void testInvalidMythologyParameter() {
    given()
        .baseUri("http://localhost:8080")
        .when()
        .get("/api/v1/gods/INVALID")
        .then()
        .statusCode(400)
        .body("error", equalTo("INVALID_MYTHOLOGY"))
        .body("message", containsString("GREEK, ROMAN, NORDIC, INDIAN, CELTIBERIAN"));
}
```

### Integration with WireMock for Contract Testing
**External API Simulation Setup:**
```java
@BeforeEach
public void setupWireMock() {
    // Configure WireMock to simulate external mythology APIs
    wireMockServer = new WireMockServer(8089);
    wireMockServer.start();
    
    // Configure Spring Boot to use WireMock endpoints
    TestPropertyValues.of(
        "mythology.api.base-url=http://localhost:8089"
    ).applyTo(applicationContext);
}

// Mock external Greek API response
public void mockGreekApiResponse() {
    wireMockServer.stubFor(get(urlEqualTo("/greek"))
        .willReturn(aResponse()
            .withStatus(200)
            .withHeader("Content-Type", "application/json")
            .withBody("""
                ["Zeus", "Hera", "Poseidon", "Demeter", "Ares", 
                 "Athena", "Apollo", "Artemis", "Hephaestus", "Aphrodite",
                 "Hermes", "Dionysus", "Hades", "Hypnos", "Nike",
                 "Janus", "Nemesis", "Iris", "Hecate", "Tyche"]
                """)));
}
```

### Spring Boot Test Integration
**Test Configuration with REST Assured:**
```java
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@TestMethodOrder(OrderAnnotation.class)
public class GodGatewayAcceptanceTest {
    
    @LocalServerPort
    private int port;
    
    @BeforeEach
    public void setup() {
        RestAssured.port = port;
        RestAssured.baseURI = "http://localhost";
    }
    
    // Test methods using REST Assured
}
```

### Response Validation and Assertion Strategy
**Comprehensive Response Validation:**
```java
// Validate complete response structure as per OpenAPI specification
public void validateGodsResponse(String mythology, List<String> expectedGods) {
    given()
        .when()
        .get("/api/v1/gods/" + mythology)
        .then()
        .statusCode(200)
        .body("mythology", equalTo(mythology))
        .body("gods", hasSize(greaterThan(0)))
        .body("gods", containsInAnyOrder(expectedGods.toArray()))
        .body("count", equalTo(expectedGods.size()))
        .body("source", equalTo("external_api"))
        .body("timestamp", matchesPattern("\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}Z"));
}
```

### Performance and Load Testing Integration
**JMeter Integration with REST Assured Results:**
```java
// Performance baseline validation
@Test
public void validateResponseTimeBaseline() {
    for (String mythology : Arrays.asList("GREEK", "ROMAN", "NORDIC", "INDIAN", "CELTIBERIAN")) {
        given()
            .when()
            .get("/api/v1/gods/" + mythology)
            .then()
            .time(lessThan(10000L)) // 10-second SLA
            .statusCode(200);
    }
}
```

### Test Data Management
**Parameterized Testing for All Mythology Types:**
```java
@ParameterizedTest
@ValueSource(strings = {"GREEK", "ROMAN", "NORDIC", "INDIAN", "CELTIBERIAN"})
public void testAllMythologyTypes(String mythology) {
    given()
        .when()
        .get("/api/v1/gods/" + mythology)
        .then()
        .statusCode(200)
        .body("mythology", equalTo(mythology))
        .body("gods", not(empty()))
        .body("count", greaterThan(0));
}
```

### Benefits of REST Assured for This Implementation
- **Gherkin Integration:** Direct mapping from Gherkin steps to REST Assured test methods
- **Fluent API:** Readable test code that matches business language in acceptance criteria
- **Spring Boot Compatibility:** Seamless integration with Spring Boot Test framework
- **Comprehensive Assertions:** Built-in JSON path validation and response time measurement
- **HTTP Protocol Support:** Full HTTP request/response lifecycle management
- **Mock Integration:** Easy integration with WireMock for external API simulation

## Alternatives Considered

### Option 1: Pure End-to-End Testing with Real External APIs
**Description:** Only test against real external services without simulation
**Pros:** 
- True integration validation
- Real network condition testing
- Authentic external service behavior
**Cons:** 
- Test flakiness due to external service instability
- Limited test execution control
- Potential test environment pollution
**Why Not Chosen:** External service dependencies create unreliable test results

### Option 2: Manual Testing Only
**Description:** Rely primarily on manual testing with limited automation
**Pros:**
- Flexibility in testing scenarios
- Human insight into user experience
- Lower initial tooling investment
**Cons:**
- Slow feedback cycle
- Limited regression testing capability
- Inconsistent test execution
**Why Not Chosen:** Insufficient for CI/CD pipeline requirements and comprehensive coverage

### Option 3: Unit Testing Focused Approach
**Description:** Primarily unit tests with minimal integration testing
**Pros:**
- Fast execution
- Reliable test results
- Easy to maintain
**Cons:**
- Misses integration issues
- Limited external API validation
- Gap in business scenario coverage
**Why Not Chosen:** Insufficient coverage of critical gateway integration requirements

## Implementation Strategy

### Phase 1: Foundation Setup (Week 1-2)
- Install and configure REST Assured with TestNG in Spring Boot project
- Set up WireMock for external API simulation with mythology response data
- Configure Maven test profiles for different testing scenarios
- Implement base test framework classes and utilities

### Phase 2: Core Test Development (Week 3-4)
- Automate existing Gherkin scenarios using Cucumber + REST Assured
- Develop contract tests for all five mythology API integrations
- Implement timeout testing with configurable WireMock delays
- Create error scenario tests for all HTTP error codes

### Phase 3: Full Coverage and Integration (Week 5-6)
- Develop performance acceptance tests with JMeter
- Integrate tests into CI/CD pipeline with proper test stages
- Implement test data management for consistent mythology datasets
- Create monitoring and reporting infrastructure

### Team Structure and Responsibilities
- **Development Team:** Test automation code development, test maintenance, CI/CD integration
- **QA Team:** Test scenario design, manual exploratory testing, test execution monitoring
- **Business Analysts:** Gherkin scenario validation, acceptance criteria refinement

### CI/CD Integration
**Pipeline Stages:**
1. **Fast Tests:** Unit tests + Contract tests with WireMock (< 2 minutes)
2. **Integration Tests:** Real external API tests for critical scenarios (< 5 minutes)  
3. **Performance Tests:** Timeout and load validation (< 10 minutes)
4. **Deployment Gate:** All acceptance tests must pass before production deployment

## Success Metrics and Quality Gates

### Testing KPIs
- **Test Coverage:** 95% of API endpoint combinations automated
- **Test Execution Time:** < 10 minutes for full acceptance test suite
- **Test Reliability:** < 2% flakiness rate in automated test results
- **Defect Detection Rate:** 90% of integration issues caught in acceptance testing

### Quality Gates
- All Gherkin scenarios must pass with real external API integration
- Timeout behavior must be validated under simulated delay conditions
- Response format validation must pass for all mythology types
- Error handling scenarios must return appropriate HTTP status codes

### Reporting and Documentation
- **Test Results:** Cucumber HTML reports with scenario-level results
- **Coverage Reports:** REST Assured test coverage metrics
- **Performance Reports:** JMeter response time and timeout validation reports
- **CI/CD Dashboard:** Test execution status and trends visualization

## Consequences

### Positive Outcomes
- **Reliable Testing:** WireMock simulation eliminates external service dependency issues
- **Fast Feedback:** Automated Gherkin scenarios provide rapid validation of business requirements
- **Comprehensive Coverage:** Multi-tier approach captures both contract and integration issues
- **Maintainable Framework:** REST Assured + Spring Boot integration simplifies test maintenance

### Negative Outcomes and Mitigation
- **Initial Setup Complexity:** Significant tooling configuration required
  - *Mitigation:* Phased implementation with incremental capability building
- **Test Data Management:** Maintaining consistent mythology datasets across test scenarios
  - *Mitigation:* Version-controlled test data files with automated data setup
- **External API Changes:** Real mythology API modifications may break integration tests
  - *Mitigation:* Regular monitoring and contract testing to detect API changes early

### Risks and Contingencies
- **External Service Instability:** Real API tests may fail due to service issues
  - *Contingency:* Circuit breaker pattern in tests with graceful degradation
- **Performance Variations:** External API response times may vary significantly
  - *Contingency:* Configurable timeout thresholds and retry mechanisms in tests
- **Test Environment Availability:** localhost:8080 gateway may not always be accessible
  - *Contingency:* Docker containerization for consistent test environment setup

## Compliance and Standards

### Testing Standards
- **BDD Standards:** Gherkin best practices with Given-When-Then scenario structure
- **API Testing Standards:** REST Assured conventions with consistent assertion patterns
- **Spring Boot Testing:** Spring Boot Test slice annotations and test configuration patterns
- **Documentation Standards:** Living documentation with automated test scenario reports

## Maintenance and Evolution

### Test Maintenance Strategy
- **Automated Test Updates:** Tests updated as part of feature development process
- **Test Data Refresh:** Monthly validation of external API response formats and mythology data
- **Framework Updates:** Quarterly evaluation of testing tool versions and capabilities
- **Performance Baseline:** Regular performance test execution to maintain timeout validation accuracy

### Review and Update Schedule
- **Regular Reviews:** Monthly test strategy review with development and QA teams
- **Strategy Evolution:** Quarterly assessment of testing coverage and effectiveness
- **Tool Evaluation:** Bi-annual review of testing tools and potential improvements
- **External API Monitoring:** Continuous monitoring of external service changes

## References

### Related Documents
- [ADR-001: God Information Gateway REST API Implementation](ADR-001_God_Information_Gateway_REST_API.md)
- [EPIC-001: God Information Gateway API](../agile/EPIC-001_God_Information_Gateway_API.md)
- [FEAT-001: God Information Gateway API](../agile/FEAT-001_God_Information_Gateway_API.md)
- [US-001: Basic God Information Service](../agile/US-001_Basic_God_Information_service.md)
- [Gherkin Acceptance Criteria](../agile/basic_god_information_gateway_service.feature)

### External Standards and Frameworks
- [REST Assured Documentation](https://rest-assured.io/)
- [Cucumber-JVM Documentation](https://cucumber.io/docs/cucumber/)
- [WireMock Documentation](http://wiremock.org/docs/)
- [Spring Boot Testing Guide](https://spring.io/guides/gs/testing-web/)
- [JMeter Performance Testing](https://jmeter.apache.org/usermanual/index.html)

### Tool Documentation
- [TestNG Framework](https://testng.org/doc/)
- [Maven Surefire Plugin](https://maven.apache.org/surefire/maven-surefire-plugin/)
- [Spring Boot Test Slices](https://docs.spring.io/spring-boot/docs/current/reference/html/features.html#features.testing)

---
*This ADR defines acceptance testing strategy based on functional requirements and gateway integration architecture. Last updated: 2025-01-24* 