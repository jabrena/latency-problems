# Sequence diagram for Latency problem 5

- https://mermaidjs.github.io/mermaid-live-editor

## Diagram:

```
sequenceDiagram
    Consumer->>Greek1: GET /greek
    Greek1-->>Consumer: List of gods
    Note over Consumer, Greek1: Or
    Consumer->>Greek2: GET /greek
    Greek2-->>Consumer: List of gods
    Note over Consumer, Greek1: Or
    Consumer->>Greek3: GET /greek
    Greek3-->>Consumer: List of gods
    Note over Consumer, Greek1: Or
    Consumer->>Greek4: GET /greek
    Greek4-->>Consumer: List of gods
    Note over Consumer, Greek1: Or
    Consumer->>Greek5: GET /greek
    Greek5-->>Consumer: List of gods
    Note over Consumer, Greek1: All response use the same Type
    loop Stream
        Consumer->Consumer: Filter
    end
```

## Visualization:

![](./sequence-diagram-latency-problem5.svg)


## Config:

```
{
  "theme": "forest"
}
```
