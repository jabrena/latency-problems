# Sequence diagram for Latency problem 7

- https://mermaidjs.github.io/mermaid-live-editor

## Diagram:

```
sequenceDiagram
    loop circuit breaker
        Consumer->>Roman: GET /roman
        Roman-->>Consumer: List of gods
    end
    loop Stream    
        Consumer->Consumer: filter
    end
```

## Config:

```
{
  "theme": "forest"
}
```
