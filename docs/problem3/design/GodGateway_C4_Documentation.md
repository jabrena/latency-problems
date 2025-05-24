# C4 Model Documentation: God Information Gateway API

## Overview
This documentation describes the C4 model diagrams for the God Information Gateway API as derived from the following agile artifacts:

- **Epic:** EPIC-001_God_Information_Gateway_API.md
- **Feature:** FEAT-001_God_Information_Gateway_API.md
- **User Story:** US-001_Basic_God_Information_service.md
- **Gherkin Feature:** basic_god_information_gateway_service.feature
- **OpenAPI Gateway Spec:** gateway-api.yaml
- **OpenAPI External Spec:** my-json-server-oas.yaml
- **Sequence Diagram:** sequence_diagram.puml

## C4 Model Levels

### Level 1: System Context
**File:** `GodGateway_Context.puml`

**Purpose:** Shows the system in its environment, focusing on users and external systems.

**Key Elements:**
- **Mythology Enthusiast:** Primary end user seeking comprehensive god information from various ancient civilizations
- **API Consumer:** Developers building applications that need mythology data integration
- **God Information Gateway API:** Central system providing unified access to mythology data
- **External Mythology APIs:** Five separate services for Greek, Roman, Nordic, Indian, and Celtiberian god data

**Main Interactions:**
- **User Queries:** Mythology enthusiasts and API consumers query god information via HTTPS/REST API
- **Data Aggregation:** Gateway fetches data from five external mythology APIs via HTTPS/JSON
- **Unified Response:** System provides consistent response format regardless of source mythology

### Level 2: Containers
**File:** `GodGateway_Container.puml`

**Purpose:** Shows the high-level technology choices and how responsibilities are distributed across containers.

**Key Containers:**
- **Gateway REST API** (Spring Boot / Java): Provides REST endpoints with unified response format
- **Gateway Service** (Spring Boot / Java): Orchestrates external API requests, handles timeouts, aggregates responses
- **External API Clients** (Spring RestClient / Java): HTTP clients for communicating with external mythology services
- **Timeout Manager** (Spring Boot / Java): Manages 10-second timeout policy for all external API calls

**Key Data Flows:**
- **Request Flow:** Users → Gateway REST API → Gateway Service → External API Clients → External APIs
- **Response Flow:** External APIs → External API Clients → Gateway Service → Gateway REST API → Users
- **Timeout Management:** Timeout Manager enforces 10-second limits on all external API calls

### Level 3: Components
**File:** `GodGateway_Component.puml`

**Purpose:** Shows the internal structure of the Gateway Service container, detailing the main components and their interactions.

**Key Components:**
- **God Controller** (Spring MVC @RestController): Handles HTTP requests for /api/v1/gods/{mythology} endpoint
- **Mythology Service** (Spring @Service): Core business logic for mythology data aggregation
- **Mythology Validator** (Spring Component): Validates mythology type parameters (GREEK, ROMAN, NORDIC, INDIAN, CELTIBERIAN)
- **Response Aggregator** (Spring Component): Aggregates and formats responses with metadata (count, source, timestamp)
- **API Clients** (Spring RestClient): Five dedicated HTTP clients for each mythology service
- **Timeout Configuration** (Spring Configuration): Configures 10-second timeout for all external API calls
- **Error Handler** (Spring @ControllerAdvice): Handles exceptions and converts to appropriate HTTP responses

**Component Interactions:**
- **Request Processing:** Controller → Validator → Service → API Clients → External APIs
- **Response Aggregation:** API Clients → Service → Response Aggregator → Controller → Client
- **Error Handling:** Any component → Error Handler → HTTP error response
- **Configuration:** Timeout Configuration applies to all API clients uniformly

## Architecture Decision Records (ADRs) Derived from Artifacts

### Technology Choices
- **Spring Boot Framework:** Chosen for rapid microservice development and comprehensive ecosystem
- **Spring RestClient:** Selected for HTTP client capabilities and timeout management
- **REST API Pattern:** RESTful design for simple, stateless client-server communication
- **Gateway Pattern:** Centralized access point to hide complexity of multiple external services

### Integration Patterns
- **API Gateway Pattern:** Single entry point for multiple backend services
- **Timeout Pattern:** 10-second timeout prevents hanging requests and ensures responsive user experience
- **Aggregation Pattern:** Combines responses from multiple sources into unified format
- **Fail-Fast Pattern:** Early validation of mythology parameters before external API calls

### Data Architecture
- **Stateless Design:** No persistent storage - acts as pass-through aggregator
- **Response Standardization:** Consistent JSON format with metadata (mythology, gods, count, source, timestamp)
- **External Service Dependencies:** Direct integration with my-json-server.typicode.com services

## Generating Visual Diagrams

### Using PlantUML Online
1. Copy the contents of each `.puml` file
2. Go to http://www.plantuml.com/plantuml/uml/
3. Paste the code and generate the diagram
4. Repeat for all three levels

### Using PlantUML CLI
```bash
# Install PlantUML (requires Java)
# Generate all diagrams
java -jar plantuml.jar GodGateway_Context.puml
java -jar plantuml.jar GodGateway_Container.puml
java -jar plantuml.jar GodGateway_Component.puml
```

### Using VS Code Extension
1. Install the "PlantUML" extension
2. Open each `.puml` file
3. Use Ctrl+Shift+P and select "PlantUML: Preview Current Diagram"

### Using C4-PlantUML with Docker
```bash
# Using the official PlantUML Docker image with C4 support
docker run --rm -v $(pwd):/data plantuml/plantuml:latest -tpng /data/GodGateway_*.puml
```

## Related Agile Artifacts
- **EPIC-001:** Provides business context and strategic goals for the gateway API
- **FEAT-001:** Details functional requirements and acceptance criteria
- **US-001:** Specifies user perspective and basic service requirements
- **Gherkin Feature:** Defines concrete acceptance criteria with testable scenarios
- **OpenAPI Specs:** Technical contract definitions for both gateway and external services
- **Sequence Diagram:** Process flow validation and interaction patterns

## Architecture Evolution Notes
- **Current State:** This C4 model represents the architecture as described in the current agile artifacts
- **Future Considerations:** Potential for caching layer, authentication, rate limiting based on epic scope
- **Validation:** Review these diagrams with technical stakeholders and validate against planned Spring Boot implementation

## Maintenance Guidelines
1. **Update Triggers:** Update diagrams when new mythology sources are added or gateway functionality changes
2. **Review Cycle:** Review diagrams when user stories are updated or new features are added to the epic
3. **Stakeholder Validation:** Share Context diagrams with mythology enthusiasts, Container diagrams with architects, Component diagrams with Spring Boot developers
4. **Tool Integration:** Consider integrating these diagrams into the API documentation pipeline

## C4 Model Best Practices Applied
- **Abstraction Levels:** Each level focuses on different stakeholder needs (business, architecture, implementation)
- **Technology Focus:** Container and Component levels highlight Spring Boot and Java technology stack
- **Business Context:** Context level emphasizes user value and external integrations
- **Consistency:** Consistent naming and styling across all three levels using C4-PlantUML library
- **Documentation:** Each diagram is accompanied by comprehensive explanatory documentation

## Next Steps
1. **Validate Architecture:** Review diagrams with Spring Boot development teams and stakeholders
2. **Implementation Guidance:** Use component diagram to guide Spring Boot package structure and class design
3. **API Documentation:** Integrate context diagram into API documentation for external consumers
4. **Testing Strategy:** Use component interactions to design unit and integration test scenarios
5. **Continuous Updates:** Establish process for keeping diagrams synchronized with evolving user stories and epic requirements

## Spring Boot Implementation Notes
- **Package Structure:** Consider organizing packages based on component boundaries (controller, service, client, config)
- **Configuration Management:** Use Spring profiles for different environments and external API endpoints
- **Testing:** Component diagram guides test structure - unit tests per component, integration tests for external API interactions
- **Monitoring:** Consider adding health checks and metrics based on component responsibilities
- **Documentation:** OpenAPI specification generation from Spring Boot annotations should align with gateway API container 