An alternative to ACID is BASE:

Basic Availability
Soft-state
Eventual consistency
Rather than requiring consistency after every transaction, it is enough for the database to eventually be in a consistent state. (Accounting systems do this all the time. It’s called “closing out the books.”) It’s OK to use stale data, and it’s OK to give approximate answers.

It’s harder to develop software in the fault-tolerant BASE world compared to the fastidious ACID world, but Brewer’s CAP theorem says you have no choice if you want to scale up. However, as Brewer points out in this presentation, there is a continuum between ACID and BASE. You can decide how close you want to be to one end of the continuum or the other according to your priorities.