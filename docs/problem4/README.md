# Problem 4

Provide a REST API to offer in a single endpoint God Data from multiple Mythologies like `greek`, `roman`, `nordic`, `indian` or `celtiberian`.
The endpoint will accept request in the following endpoint: `GET /api/v1/gods`.
The development will return the information once the endpoint aggregate the information from all mythologies.

**Notes:**

- Review the timeout for Every connection.
- REST API 1: https://my-json-server.typicode.com/jabrena/latency-problems/greek
- REST API 2: https://my-json-server.typicode.com/jabrena/latency-problems/roman
- REST API 3: https://my-json-server.typicode.com/jabrena/latency-problems/nordic
- REST API 4: https://my-json-server.typicode.com/jabrena/latency-problems/indian
- REST API 5: https://my-json-server.typicode.com/jabrena/latency-problems/celtiberian

**Examples:**

- `GET /api/v1/gods` - Returns all gods using the following structure:

```json
[
    {
        "id": 1,
        "mythology":"greek",
        "god": "Zeus"
    }
]
```
