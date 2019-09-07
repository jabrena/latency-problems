# Sequence diagram for Latency problem 4

- https://mermaidjs.github.io/mermaid-live-editor

## Diagram:

```
sequenceDiagram
    Consumer->>Transferwise: GET /convert
    Consumer->>XE: GET /convert
    Consumer->>Iban: GET /convert
    Consumer->>XRates: GET /convert
    Transferwise-->>Consumer: Exchange rate
    XE-->>Consumer: Exchange rate
    Iban-->>Consumer: Exchange rate
    XRates-->>Consumer: Exchange rate
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
