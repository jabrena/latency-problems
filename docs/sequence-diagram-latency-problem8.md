# Sequence diagram for Latency problem 8

- https://mermaidjs.github.io/mermaid-live-editor

## Diagram:

```
sequenceDiagram
    loop rate limiter
        Consumer->>Indian: GET /indian
        Indian-->>Consumer: List of gods
    end
    loop Stream    
        Consumer->Consumer: filter
    end
```

## Visualization:

![](./sequence-diagram-latency-problem8.svg)


## Config:

```
{
  "theme": "forest"
}
```
