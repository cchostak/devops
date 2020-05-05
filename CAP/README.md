# An Illustrated Proof of the CAP Theorem
The CAP Theorem is a fundamental theorem in distributed systems that states any distributed system can have at most two of the following three properties.

Consistency
Availability
Partition tolerance

This guide will summarize Gilbert and Lynch's specification and proof of the CAP Theorem with pictures!

# What is the CAP Theorem?
The CAP theorem states that a distributed system cannot simultaneously be consistent, available, and partition tolerant. Sounds simple enough, but what does it mean to be consistent? available? partition tolerant? Heck, what exactly do you even mean by a distributed system?

https://mwhittaker.github.io/blog/an_illustrated_proof_of_the_cap_theorem/