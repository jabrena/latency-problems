# Sequence diagram for Latency problem 9

- https://mermaidjs.github.io/mermaid-live-editor

## Diagram:

```
sequenceDiagram
    loop bulkhead
        Consumer->>GodCollector: GET /gods
        GodCollector->>Greek: GET /greek
        GodCollector->>Roman: GET /roman
        Greek-->>GodCollector: List of gods
        Roman-->>GodCollector: List of gods
        GodCollector-->>Consumer: List of gods
    end
```

## Config:

```
{
  "theme": "forest"
}
```
