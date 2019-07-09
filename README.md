# latency-problems

## Motivation

[Euler problems](https://projecteuler.net/archives) are an excellent source of Mathematical
problems to improve your programming skills. The problems are able to be solved in many 
different ways using an Object Oriented, Functional or Reactive approaches.

But in the implementation process, I missed that the problem doesn´t add any Latency factor to
increase the complexity and this is part of the daily problems for every Software Engineer in the market.

In `Java`, you can use [CompletableFuture](https://docs.oracle.com/javase/8/docs/api/java/util/concurrent/CompletableFuture.html) objects, 
in `Kotlin` you can use [Coroutines](https://kotlinlang.org/docs/reference/coroutines-overview.html), 
in `Scala` you can use [Future](https://www.scala-lang.org/api/2.12.3/scala/concurrent/Future.html).
in `Reactor` you can use [Mono<T>](https://projectreactor.io/docs/core/release/api/reactor/core/publisher/Mono.html) or 
[Flux<T>](https://projectreactor.io/docs/core/release/api/reactor/core/publisher/Flux.html) objects, 

The purpose of this repository is the creation of a set problems adding the Latency as part of the problem to be solved
in many different ways.

Enjoy in the journey!

Juan Antonio Breña Moral

## Problems

### Problem 1

Ancient European peoples worshiped many gods like Greek, Roman & Nordic gods.
Every God is possible to be represented as the concatenation of every character converted in Decimal.
`Zeus = 122101117115

Load the list of Gods and find the sum of God names starting with the letter `n`.

**Notes:** 
Every connection with any API has a Timeout of `2` seconds.
If in the process to load the list, the timeout is reached, the process will calculate with the rest of
the lists.
REST API: https://my-json-server.typicode.com/jabrena/latency-problems

### Problem 2

Greek gods are quite popular and they have presence in Wikipedia, the multilingual online encyclopedia.
If you try to find further information about `Zeus` you should visit the address: https://en.wikipedia.org/wiki/Zeus

Load the list of Greek Gods and discover what is the God with more literature described on Wikipedia.

**Notes:** 
Every connection with any API has a Timeout of `2` seconds.
REST API 1: https://my-json-server.typicode.com/jabrena/latency-problems/greek
REST API 2: https://en.wikipedia.org/wiki/{greekGod}


