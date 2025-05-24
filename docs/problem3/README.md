# Problem 3

God fans require a specific REST API Development which provide in a single place to retrieve information about `greek`, `roman`, `nordic`, `indian` or `celtiberian` gods.
The endpoint will accept request in the following endpoint: `GET /api/v1/gods/{god}`
The development will behave like a Gateway to the source of truth located in: https://my-json-server.typicode.com/jabrena/latency-problems/

**Notes:**

- API now accepts lowercase mythology parameters (e.g., `greek` instead of `GREEK`) for improved user experience
- Backward compatibility is maintained for uppercase parameters
- All responses return lowercase mythology names regardless of input case
- Review the timeout for Every connection.
- REST API 1: https://my-json-server.typicode.com/jabrena/latency-problems/greek
- REST API 2: https://my-json-server.typicode.com/jabrena/latency-problems/roman
- REST API 3: https://my-json-server.typicode.com/jabrena/latency-problems/nordic
- REST API 4: https://my-json-server.typicode.com/jabrena/latency-problems/indian
- REST API 5: https://my-json-server.typicode.com/jabrena/latency-problems/celtiberian

**Examples:**

- `GET /api/v1/gods/greek` - Returns Greek gods (recommended)
- `GET /api/v1/gods/GREEK` - Also returns Greek gods (backward compatibility)
- `GET /api/v1/gods/Roman` - Returns Roman gods (mixed case also supported)

