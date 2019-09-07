# Sequence diagram for Latency problem 8

- https://mermaidjs.github.io/mermaid-live-editor

## Diagram:

```
sequenceDiagram
    loop rate limiter
        Consumer->>Greek: GET /greek
        Greek-->>Consumer: List of gods
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
