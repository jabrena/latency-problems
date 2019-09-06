# Sequence diagram for Latency problem 1

- https://mermaidjs.github.io/mermaid-live-editor

## Diagram:

```
sequenceDiagram
    Consumer->>Greek: GET /greek
    Consumer->>Roman: GET /roman
    Consumer->>Nordic: GET /nordic
    Greek-->>Consumer: List of gods
    Roman-->>Consumer: List of gods
    Nordic-->>Consumer: List of gods
    Note over Consumer, Greek: All response use the same Type
    loop Stream
        Consumer->Consumer: Filter
        Consumer->Consumer: toDigits
        Consumer->Consumer: sum
    end
```

## Config:

```
{
  "theme": "forest"
}
```
