# Sequence diagram for Latency problem 4

- https://mermaidjs.github.io/mermaid-live-editor

## Diagram:

```
sequenceDiagram
    Consumer->>Transferwise: GET /convert
    Consumer->>XE: GET /convert
    Consumer->>Iban: GET /convert
    Consumer->>XRates: GET /convert
    Note left of Consumer: Parallel calls
    Transferwise-->>Consumer: Exchange rate
    Consumer->Consumer: Serialize
    XE-->>Consumer: Exchange rate
    Consumer->Consumer: Serialize
    Iban-->>Consumer: Exchange rate
    Consumer->Consumer: Serialize
    XRates-->>Consumer: Exchange rate
    Consumer->Consumer: Serialize
    Note over Consumer, Transferwise: All response use the same Type
    loop Stream
        Consumer->Consumer: average
    end
```

## Config:

```
{
  "theme": "forest"
}
```
