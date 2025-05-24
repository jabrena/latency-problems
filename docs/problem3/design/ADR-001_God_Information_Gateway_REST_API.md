# ADR-001: God Information Gateway REST API Implementation

**Date:** 2025-01-24  
**Status:** Proposed  
**Deciders:** God Operator, Technical Architect, Development Team  
**Technical Area:** REST API Development

---

## Context

### Business Context
Mythology enthusiasts need simplified access to comprehensive god information from multiple ancient civilizations without managing complex integrations with multiple data sources. The business requires a single point of access to provide god information that hides the complexity of integrating with five different external mythology APIs (Greek, Roman, Nordic, Indian, and Celtiberian).

### Technical Context
The current landscape requires consumers to integrate with five separate external APIs hosted at https://my-json-server.typicode.com/jabrena/latency-problems/ with different endpoints for each mythology type. This creates complexity for clients and inconsistent response handling. The system needs to provide a unified interface while maintaining performance within acceptable timeout limits.

### Problem Statement
How to implement a REST API gateway that aggregates mythology data from five external services into a single, unified endpoint while ensuring reliable performance, proper timeout management, and consistent response formatting for API consumers.

---

## Decision

### Chosen Solution
Implement a Spring Boot-based REST API gateway using servlet programming patterns with Spring RestClient for external service integration and comprehensive timeout management.

### Technical Details
- **Programming Language:** Java - 24 (Non LTS)
- **Framework:** Spring Boot - 3.5.0
- **Build System:** Maven - 3.9.x
- **Key Dependencies:**
  - Spring Boot Web: - REST API development
  - Spring Boot Actuator: - Health checks and monitoring
  - SpringDoc OpenAPI: 2.2.x - API documentation generation
- **Architecture Pattern:** Gateway pattern with service layer separation
- **Data Access:** No persistent storage - pure pass-through aggregation
- **Authentication:** None required for this phase
- **API Documentation:** OpenAPI 3.0.3 with SpringDoc integration

### Implementation Approach
1. **API Layer**: Create REST controller with `@RestController` for `/api/v1/gods/{mythology}` endpoint
2. **Service Layer**: Implement business logic for mythology validation and external API orchestration
3. **Client Layer**: Configure Spring RestClient instances with 10-second timeout for each external mythology service
4. **Error Handling**: Implement global exception handling with `@ControllerAdvice` for consistent error responses
5. **Response Aggregation**: Format all responses with consistent structure including metadata (mythology, gods, count, source, timestamp)

---

## Rationale

### Why This Decision
- **Team Expertise**: Spring Boot provides familiar development patterns for Java teams
- **Performance Requirements**: RestClient supports non-blocking I/O for better throughput when calling multiple external APIs
- **Timeout Management**: Built-in timeout configuration in RestClient ensures reliable 10-second timeout enforcement
- **Maintenance Considerations**: Spring Boot's auto-configuration and dependency injection simplify long-term maintenance

### Key Factors Considered
- **Performance**: Servlet programming model supports concurrent external API calls without blocking threads
- **Scalability**: Spring Boot's embedded server and auto-configuration support horizontal scaling
- **Security**: Current phase requires no authentication, but Spring Security can be added incrementally
- **Maintainability**: Clean separation of concerns with controller, service, and client layers
- **Team Skills**: Java and Spring Boot align with existing team capabilities
- **Cost**: Open-source stack minimizes licensing costs while providing enterprise-grade features

---

## Consequences

### Positive Consequences
- Unified API interface simplifies client integration from five separate APIs to one
- 10-second timeout prevents hanging requests and ensures predictable response times
- Spring Boot's auto-configuration accelerates development and reduces boilerplate
- RestClient enables efficient concurrent external API calls
- Consistent error handling provides better developer experience for API consumers
- OpenAPI documentation generation supports API consumer adoption

### Negative Consequences
- Dependency on external APIs creates single point of failure risk
- Additional network hop introduces latency compared to direct external API access
- Gateway becomes a potential bottleneck for all mythology data access
- Spring Boot startup time may be higher than lighter frameworks

### Technical Debt
- No caching layer implemented initially - may need addition for performance optimization
- No authentication/authorization - will require implementation for production security
- Error categorization is basic - may need more sophisticated retry and circuit breaker patterns

---

## Implementation Notes

### Development Guidelines
- Follow Spring Boot best practices with clear separation of controllers, services, and configuration
- Implement comprehensive unit and integration tests using Spring Boot Test
- Use Spring profiles for environment-specific external API configurations
- Apply consistent naming conventions aligned with OpenAPI specification

### Dependencies Setup
```bash
# Maven dependencies (pom.xml)
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
    <version>3.5.0</version>
</dependency>
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-actuator</artifactId>
    <version>3.5.0</version>
</dependency>
<dependency>
    <groupId>org.springdoc</groupId>
    <artifactId>springdoc-openapi-starter-webmvc-ui</artifactId>
    <version>3.5.0</version>
</dependency>

# Test dependencies
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-test</artifactId>
    <version>3.5.0</version>
    <scope>test</scope>
</dependency>
```

### Configuration Requirements
- **External API Base URLs**: Configure in application.yml for different environments
- **Timeout Settings**: RestClient timeout configuration for 10-second limit
- **Server Port**: Default to 8080 as specified in requirements
- **Actuator Endpoints**: Enable health checks for monitoring

---

## Monitoring & Success Criteria

### Technical Metrics
- Response time: < 10000ms for 99th percentile (external API timeout limit)
- Throughput: > 100 requests/second under normal load
- Error rate: < 5% for valid mythology parameters
- Uptime: > 99.5% availability

### Monitoring Implementation
- Spring Boot Actuator health endpoints for service monitoring
- Structured logging with request/response correlation IDs
- Metrics collection for external API response times and success rates
- Application-specific metrics for mythology type usage patterns

---

## Review & Update Schedule

**Next Review Date:** 2025-02-24  
**Review Triggers:**
- Performance issues with 10-second timeout
- External API availability problems
- New mythology sources requiring integration
- Security requirements introduction
- Team feedback on development experience

---

## References

- [EPIC-001: God Information Gateway API](../agile/EPIC-001_God_Information_Gateway_API.md)
- [FEAT-001: God Information Gateway API](../agile/FEAT-001_God_Information_Gateway_API.md)
- [US-001: Basic God Information Service](../agile/US-001_Basic_God_Information_service.md)
- [Gateway API OpenAPI Specification](gateway-api.yaml)
- [External API OpenAPI Specification](my-json-server-oas.yaml)
- [Gherkin Acceptance Criteria](../agile/basic_god_information_gateway_service.feature)
- [C4 Architecture Documentation](GodGateway_C4_Documentation.md)
- [Spring Boot Documentation](https://spring.io/projects/spring-boot)
