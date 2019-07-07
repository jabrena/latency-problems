# latency-problems

## Motivation

[Euler problems](https://projecteuler.net/archives) is an excellent source of Mathematical
problems to improve your programming skills. The problems are able to be solved in many 
different ways using an Object Oriented, Functional or Reactive approaches.

But in the implementation process, I missed that the problem doesn´t add any Latency ingredient to
increase the complexity and this is part of the daily problems for every Software Engineer.

In `Java`, you can use [CompletableFuture](https://docs.oracle.com/javase/8/docs/api/java/util/concurrent/CompletableFuture.html) objects, 
in `Reactor` you can use [Mono<T>](https://projectreactor.io/docs/core/release/api/reactor/core/publisher/Mono.html) or 
[Flux<T>](https://projectreactor.io/docs/core/release/api/reactor/core/publisher/Flux.html) objects, 
in `Kotlin` you can use [Coroutines](https://kotlinlang.org/docs/reference/coroutines-overview.html), 
in `Scala` you can use [Future](https://www.scala-lang.org/api/2.12.3/scala/concurrent/Future.html).

The purpose of this repository is the creation of a set problems adding the Latency as part of the problem.

Enjoy!

Juan Antonio Breña Moral

## Problems

### Problem 1

Ancient European peoples worshiped many gods like Greek, Roman & Nordic gods.
Every Good is possible to represented as the concatenation of every character converted in Decimal.
Zeus = 122101117115

Load the list of Gods and find the sum of God names starting with the letter `n` converted to number.

**Notes:** 
Every connection with the REST API has a Timeout of 1 second.
If in the process to load the list, the timeout is reached, the process will calculate with the rest of
the lists.
