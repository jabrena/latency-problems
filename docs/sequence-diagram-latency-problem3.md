# Sequence diagram for Latency problem 3

- https://mermaidjs.github.io/mermaid-live-editor

## Diagram:

```
sequenceDiagram
    loop Stream
        ConsumerTest->>Gateway: GET /{god}
        Gateway->>Greek: GET /greek
        Greek-->>Gateway: List of gods
       Note over Gateway, Greek: or
        Gateway->>Roman: GET /roman
        Roman-->>Gateway: List of gods
       Note over Gateway, Greek: or
        Gateway->>Nordic: GET /nordic
        Nordic-->>Gateway: List of gods
        Gateway-->>ConsumerTest: List of gods
        ConsumerTest->ConsumerTest: Assert
    end
```

## Config:

```
{
  "theme": "forest"
}
```
