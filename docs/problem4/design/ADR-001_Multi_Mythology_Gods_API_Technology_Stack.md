# ADR-001: Multi-Mythology Gods Data Aggregation API - Technology Stack and Architecture

**Date:** 2024-12-19
**Status:** Proposed
**Deciders:** God Operator, Development Team
**Technical Area:** REST API Development

## Context

### Business Context
The Multi-Mythology Gods Data Aggregation API addresses the need to simplify access to mythology data for mythology enthusiasts and client applications. Currently, users must make separate API calls to 5 different mythology endpoints (Greek, Roman, Nordic, Indian, Celtiberian) to gather comprehensive god information across various mythologies. This creates complexity and inefficiency in client applications.

**Business Value:**
- Provides a unified entry point for mythology data access
- Eliminates the need for clients to interact with multiple separate APIs
- Simplifies integration for client applications and reduces API call overhead
- Enables consistent data format across all mythologies

**Target Users:**
- Mythology enthusiasts
- Client application developers
- Third-party integrators building mythology-related applications

### Technical Context
The API must integrate with 5 external mythology APIs hosted at `https://my-json-server.typicode.com/jabrena/latency-problems/` providing data for different mythologies. Each external API returns arrays of god names that need to be transformed into a structured format with consistent schema.

**External Dependencies:**
- Greek gods API: `/greek`
- Roman gods API: `/roman`
- Nordic gods API: `/nordic`
- Indian gods API: `/indian`
- Celtiberian gods API: `/celtiberian`

**Team Context:**
- Expertise in Java 24, Maven, Spring Boot Servlet
- Organizational preference for traditional servlet-based architecture over reactive programming
- No specific performance or timeline constraints

### Problem Statement
Design and implement a REST API that aggregates mythology data from 5 external services into a single endpoint, providing unified data format, resilient operation with partial results capability, and optimal performance through parallel processing and caching.

## Decision

### Chosen Solution
Implementation of a single REST endpoint `/api/v1/gods` that aggregates data from 5 external mythology APIs using Spring Boot Servlet architecture with parallel processing, caching, and graceful degradation capabilities.

### Technical Details

#### Core Technology Stack
- **Programming Language:** Java 24
  - *Rationale:* Team expertise and access to latest Java features for improved performance and development experience
- **Build Tool:** Maven
  - *Rationale:* Organizational standard and team familiarity
- **Framework:** Spring Boot Servlet (Traditional, Non-Reactive)
  - *Rationale:* Team expertise, organizational preference, and sufficient for the use case requirements
- **Architecture Pattern:** Monolithic REST API
  - *Rationale:* Single-purpose aggregation service with clear boundaries, no need for microservices complexity

#### API Design & Data Management
- **Endpoint Design:** Single read-only endpoint `GET /api/v1/gods`
  - *Rationale:* Focused, single-purpose API aligned with business requirements
- **ID Generation:** UUID-based identification for aggregated god entries
  - *Rationale:* Ensures uniqueness across mythologies and avoids collision issues
- **Data Transformation:** Convert external API arrays to structured JSON with `id`, `mythology`, and `god` fields
  - *Rationale:* Provides consistent, structured response format for easy client consumption

#### External Service Integration
- **HTTP Client:** Spring's RestClient with CompletableFuture for parallel processing
  - *Rationale:* Native Spring Boot integration, supports parallel execution without reactive complexity
- **Concurrency Strategy:** Parallel concurrent calls to all 5 external APIs
  - *Rationale:* Minimizes response time by calling external services simultaneously
- **Timeout Configuration:** 5-second timeout for external API calls
  - *Rationale:* Balances responsiveness with allowing sufficient time for external service responses
- **Resilience Strategy:** Return partial results when some external services fail
  - *Rationale:* Provides graceful degradation, ensuring users get available data even if some services are unavailable

#### Caching Strategy
- **Caching Technology:** Ehcache (In-Memory)
  - *Rationale:* Mythology data is relatively static, in-memory caching provides fast access without external dependencies
- **Caching Scope:** Cache individual mythology API responses
  - *Rationale:* Reduces external API calls and improves response times for subsequent requests

#### Security & API Management
- **Authentication:** No authentication required (Public API)
  - *Rationale:* Mythology data is public information, no sensitive data protection needed
- **API Versioning:** URL-based versioning (`/api/v1/`)
  - *Rationale:* Clear, simple versioning strategy for future evolution (not actively managed initially)

#### Error Handling & Quality Assurance
- **Exception Handling:** Central controller advice for global exception management
  - *Rationale:* Centralized error handling ensures consistent error responses across the API
- **Testing Strategy:** WireMock for external service integration testing
  - *Rationale:* Enables reliable, repeatable testing without dependency on external service availability
- **Test Coverage:** Unit tests, integration tests with mocked external services

#### Infrastructure & Deployment
- **Deployment:** Container-based deployment (Docker)
  - *Rationale:* Ensures consistent deployment environments and simplified scaling/management

### Implementation Approach

1. **Core API Structure:**
   - Create Spring Boot REST controller with `GET /api/v1/gods` endpoint
   - Implement service layer for aggregation logic
   - Configure RestClient beans for external API communication

2. **External Service Integration:**
   - Implement parallel HTTP calls using CompletableFuture.allOf()
   - Configure connection timeouts and error handling
   - Transform external API responses to internal data model

3. **Caching Implementation:**
   - Configure Ehcache for external API response caching
   - Implement cache-aside pattern for external service calls
   - Define appropriate cache TTL based on data volatility

4. **Error Handling:**
   - Implement @ControllerAdvice for global exception handling
   - Handle partial failures gracefully
   - Provide meaningful error responses for different failure scenarios

5. **Testing Setup:**
   - Configure WireMock for integration testing
   - Implement test scenarios for success, partial failure, and complete failure cases
   - Create performance tests for concurrent external API calls

## Rationale

### Why This Decision

**Technology Stack Alignment:** The chosen Java 24 + Spring Boot Servlet stack leverages existing team expertise while providing a proven, stable foundation for REST API development. The traditional servlet approach meets performance requirements without introducing reactive programming complexity.

**Parallel Processing Benefits:** CompletableFuture with RestClient provides optimal performance for calling multiple external services simultaneously while maintaining compatibility with the servlet-based architecture.

**Resilience Strategy:** The partial results approach ensures the API remains useful even when external services experience issues, providing better user experience than complete failure scenarios.

**Caching Optimization:** Ehcache provides performance benefits for relatively static mythology data while keeping the architecture simple with in-memory caching.

### Key Factors Considered

- **Team Expertise:** Leveraged existing Java and Spring Boot knowledge
- **Simplicity:** Chose proven technologies over complex alternatives
- **Performance:** Parallel external API calls minimize response times
- **Reliability:** Partial results strategy ensures service availability
- **Maintainability:** Clean separation of concerns with service layers
- **Testability:** WireMock enables reliable integration testing

## Alternatives Considered

### Reactive Architecture (Spring WebFlux)
**Rejected because:** Team preference for traditional servlet architecture, no compelling performance requirements that justify reactive complexity.

### Sequential External API Calls
**Rejected because:** Would result in significantly slower response times (potentially 25+ seconds vs 5 seconds with parallel calls).

### Fail-Fast Strategy (Complete failure on any external service failure)
**Rejected because:** Reduces API availability and user value; partial results provide better user experience.

### External Caching (Redis)
**Rejected because:** Adds infrastructure complexity without compelling benefits for relatively small, static dataset.

### Multiple CRUD Endpoints
**Rejected because:** Business requirement specifically calls for single aggregation endpoint; CRUD operations not needed.

## Consequences

### Positive Consequences

- **Simplified Client Integration:** Single API call replaces 5 separate external API calls
- **Improved Performance:** Parallel processing and caching reduce response times
- **High Availability:** Partial results strategy ensures service remains functional during external service outages
- **Maintainable Codebase:** Clear separation of concerns with Spring Boot best practices
- **Testable Architecture:** WireMock integration enables comprehensive testing without external dependencies
- **Future-Ready:** URL versioning and modular design support future enhancements

### Negative Consequences

- **External Service Dependency:** API functionality depends on availability of external mythology APIs
- **Limited Scalability:** Monolithic architecture may require refactoring for significant scale increases
- **Cache Consistency:** In-memory caching may serve stale data if external APIs change
- **Error Complexity:** Partial failure scenarios require careful error handling and client communication

### Technical Debt

- **API Versioning Strategy:** Initial implementation doesn't actively manage versioning; will need formal strategy for future versions
- **Monitoring & Observability:** Basic implementation may need enhanced monitoring for production deployment
- **Cache Management:** Manual cache invalidation strategy may be needed for data freshness requirements

## Implementation Guidelines

### Coding Standards
- Follow Spring Boot best practices for REST API development
- Implement proper separation of concerns (Controller -> Service -> Client layers)
- Use proper exception handling with @ControllerAdvice
- Implement comprehensive logging for debugging and monitoring

### Configuration Management
- Externalize configuration for timeouts, cache settings, and external API URLs
- Use Spring Boot profiles for different environments
- Implement proper secrets management for any future authentication requirements

### Testing Approach
- Unit tests for business logic and data transformation
- Integration tests using WireMock for external service simulation
- Performance tests for concurrent external API calls
- Contract tests to validate external API response format assumptions

### Deployment Strategy
- Containerize application with Docker
- Implement health checks for external service connectivity
- Configure appropriate resource limits for container deployment
- Set up monitoring for external API call performance and failure rates

## Monitoring & Success Criteria

### Performance Metrics
- **Response Time:** < 5 seconds for complete aggregation (aligned with external API timeout)
- **Success Rate:** > 95% successful responses (accounting for external service failures)
- **External API Performance:** Track individual mythology API response times and failure rates
- **Cache Hit Ratio:** Monitor cache effectiveness for performance optimization

### Business Success Criteria
- **Functional Success:** HTTP 200 responses with complete or partial mythology data
- **Data Quality:** Successful transformation of external API data to unified format
- **Client Adoption:** Successful integration by client applications

### Monitoring Approach
- Application performance monitoring (APM) for request tracing
- External service health monitoring
- Cache performance metrics
- Error rate tracking and alerting

## Review & Update Schedule

### Regular Review Triggers
- Quarterly architecture review for performance and scalability assessment
- External API changes or deprecations
- Significant increase in usage patterns or performance requirements
- Team feedback on development and maintenance experience

### Update Criteria
- External service integration changes
- Performance requirements evolution
- Security or compliance requirement changes
- Technology stack updates or end-of-life considerations

---

## Related Documentation

- **Epic:** [EPIC-004_Multi_Mythology_Gods_API.md](../agile/EPIC-004_Multi_Mythology_Gods_API.md)
- **Feature:** [FEAT-001_REST_API_Endpoint_Implementation.md](../agile/FEAT-001_REST_API_Endpoint_Implementation.md)
- **User Story:** [US-001_REST_API_Gods_Endpoint.md](../agile/US-001_REST_API_Gods_Endpoint.md)
- **External API Specification:** [my-json-server-oas.yaml](my-json-server-oas.yaml)
- **Acceptance Criteria:** [rest_api_gods_endpoint.feature](../agile/rest_api_gods_endpoint.feature)

---

**Created:** 2024-12-19
**Last Updated:** 2024-12-19
**Next Review:** Q2 2025
