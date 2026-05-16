|             | Style         | When to use it                                                                                                                                                             | examples                                                                |     |
| ----------- | ------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------- | --- |
| Monolithic  | Layered       | - small, simple applications<br>- situations with very tight budget and time constraints                                                                                   |                                                                         |     |
| Monolithic  | Microkernel   | - high customizability/extensibility is key<br>- simple, low-cost monolithic apps like product-based software or tools where core functionality is stable but add-ons vary | Eclipse IDE, PMD source code analyzer, Jira, Chrome, Firefox            |     |
| Distributed | Event-driven  | - high scalability, performance, and responsiveness are critical<br>-                                                                                                      | Online auction bidding apps, retail order processing, trading platforms |     |
| Distributed | Microservices | - extreme decoupling, independent teams/deployments, and varying characteristics per domain are needed<br>- large-scale, flexible apps; avoid for simple domains           | Netflix, Amazon, Uber, Spotify                                          |     |
## ratings
comparison table of the characteristics of each architecture style

| Architecture Style | Partitioning Type     | # of Quanta | Deployability | Elasticity | Evolutionary | Fault Tolerance | Modularity | Overall Cost | Performance | Reliability | Scalability | Simplicity | Testability |
| ------------------ | --------------------- | ----------- | ------------- | ---------- | ------------ | --------------- | ---------- | ------------ | ----------- | ----------- | ----------- | ---------- | ----------- |
| Layered            | Technical             | 1           | ★             | ★          | ★            | ★               | ★          | ★★★★★        | ★★          | ★★★         | ★           | ★★★★★      | ★★          |
| Microkernel        | Domain and technical* | 1           | ★★★           | ★          | ★★★          | ★               | ★★★        | ★★★★★        | ★★★         | ★★★         | ★           | ★★★★       | ★★★         |
| Event-driven       | Technical             | 1 to many   | ★★★           | ★★★        | ★★★★★        | ★★★★★           | ★★★★       | ★★★          | ★★★★★       | ★★★         | ★★★★★       | ★          | ★★          |
| Microservices      | Domain                | 1 to many   | ★★★★          | ★★★★★      | ★★★★★        | ★★★★            | ★★★★★      | ★            | ★★          | ★★★★        | ★★★★★       | ★          | ★★★★        |
\*unique in that is the only one that is both domain and technically partitioned
