# Sequence diagram for Latency problem 6

- https://mermaidjs.github.io/mermaid-live-editor

## Diagram:

```
sequenceDiagram
    loop retry
        Consumer->>Greek: GET /greek
        Greek-->>Consumer: List of gods
    end
    loop Stream    
        Consumer->Consumer: filter
    end
```

## Visualization:

![](./sequence-diagram-latency-problem6.svg)


## Config:

```
{
  "theme": "forest"
}
```
