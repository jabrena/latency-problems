# Latency problems

## Motivation

[Euler problems](https://projecteuler.net/archives) are an excellent source of Mathematical
problems to improve your programming skills. The problems are able to be solved with multiple
programming paradigms like Object Oriented, Functional or Reactive.

But in the implementation process, I missed that the problems don´t add any Latency factor to
increase the complexity and this is part of the daily problems for every Software Engineer in the market.

Modern programming languages provide native solutions to manage latency.
In `Java`, you can use [Structured Concurrency with Virtual Threads](https://docs.oracle.com/en/java/javase/24/docs/api/java.base/java/util/concurrent/StructuredTaskScope.html) or [CompletableFuture](https://docs.oracle.com/javase/8/docs/api/java/util/concurrent/CompletableFuture.html),
in `Kotlin` you can use [Coroutines](https://kotlinlang.org/docs/reference/coroutines-overview.html),
in `Scala` you can use [Future](https://www.scala-lang.org/api/2.12.3/scala/concurrent/Future.html),
in `Clojure` you can use [Future](https://clojuredocs.org/clojure.core/future).

On top of the languages, exist libraries that improve the way to manage [asynchronous](https://www.reactivemanifesto.org/glossary#Asynchronous) calls with [jox](https://jox.softwaremill.com/latest/index.html) or use a Reactive solutions with   [Backpressure](https://www.reactivemanifesto.org/glossary#Back-Pressure) support out of the box.

In `Reactor` you can use [Mono<T>](https://projectreactor.io/docs/core/release/api/reactor/core/publisher/Mono.html) or
[Flux<T>](https://projectreactor.io/docs/core/release/api/reactor/core/publisher/Flux.html) objects,
in `RxJava`, you can use [Flowable<T>](http://reactivex.io/RxJava/2.x/javadoc/io/reactivex/Flowable.html) & finally, in [Mutiny](https://quarkus.io/guides/mutiny-primer) you have [Uni or Multi](https://smallrye.io/smallrye-mutiny/latest/reference/uni-and-multi/).

Finally, exist libraries that offer rich implementations of Reactive programming patterns.
In `Resilience4j`, you could find solutions for: `Circuit breaking`, `Rate limiting`, `Bulkheading`, `Automatic retrying`

The purpose of this repository is the design of a set problems adding the Latency as part of the problem to be solved in several ways.

Enjoy the journey!

Juan Antonio Breña Moral

---

## Problems

- **[Problem 1:](./docs/problem1/README.md)**  Consume God APIS (Greek, Roman & Nordic) and filter gods starting by 'n', convert into Decimal format and sum.
- **[Problem 2:](./docs/problem2/README.md)**  Calculate what Greek god has more literature in Wikipedia.
- **[Problem 3:](./docs/problem3/README.md)**  Develop a REST Gateway about Gods.
- **[Problem 4:](./docs/problem4/README.md)**  Develop a REST API to offer in a single endpoint God Data from multiple Mythologies
- **[Problem 5:](./docs/problem5/README.md)**  Pending to Refactor.
- **[Problem 6:](./docs/problem6/README.md)**  Return all Greek gods starting with `a` and apply a Retry behaviour.
- **[Problem 7:](./docs/problem7/README.md)**  Return all Roman gods finishing the name with `s` and apply a Circuit Breaker behaviour.
- **[Problem 8:](./docs/problem8/README.md)**  Return all gods who contains in the name `a` & `i` and apply a Rate limit policy.
- **[Problem 9:](./docs/problem9/README.md)**  Return all Greek & Roman gods and apply a Bulk head policy.
- **[Problem 10:](./docs/problem10/README.md)** Calculate the popularity of Indian gods in Mahabharata

## [Troubleshooting](./TROUBLESHOOTING.md)

## [References](./REFERENCES.md)

