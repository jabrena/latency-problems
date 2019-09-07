# Sequence diagram for Latency problem 9

- https://mermaidjs.github.io/mermaid-live-editor

## Diagram:

```
sequenceDiagram
    loop bulkhead
        Consumer->>Celtiberian: GET /celtiberian
        Celtiberian-->>Consumer: List of gods
    end
```

## Config:

```
{
  "theme": "forest"
}
```
