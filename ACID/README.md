Database developers all know the ACID acronym. It says that database transactions should be:

Atomic: Everything in a transaction succeeds or the entire transaction is rolled back.
Consistent: A transaction cannot leave the database in an inconsistent state.
Isolated: Transactions cannot interfere with each other.
Durable: Completed transactions persist, even when servers restart etc.
These qualities seem indispensable, and yet they are incompatible with availability and performance in very large systems. For example, suppose you run an online book store and you proudly display how many of each book you have in your inventory. Every time someone is in the process of buying a book, you lock part of the database until they finish so that all visitors around the world will see accurate inventory numbers. That works well if you run The Shop Around the Corner but not if you run Amazon.com.

Amazon might instead use cached data. Users would not see not the inventory count at this second, but what it was say an hour ago when the last snapshot was taken. Also, Amazon might violate the “I” in ACID by tolerating a small probability that simultaneous transactions could interfere with each other. For example, two customers might both believe that they just purchased the last copy of a certain book. The company might risk having to apologize to one of the two customers (and maybe compensate them with a gift card) rather than slowing down their site and irritating myriad other customers.

There is a computer science theorem that quantifies the inevitable trade-offs. Eric Brewer’s CAP theorem says that if you want consistency, availability, and partition tolerance, you have to settle for two out of three. (For a distributed system, partition tolerance means the system will continue to work unless there is a total network failure. A few nodes can fail and the system keeps going.)