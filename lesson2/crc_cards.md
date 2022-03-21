# CRC Cards

**Class Responsibility Collaborator (CRC)** cards are a way to model the various classes of a program. They help us flesh out, design, and map iteractions between classes.
They look like this:

```
--------------------------------------------
| Class Name                               |
--------------------------------------------
|                          |               |
|                          |               |
|    Responsibilities      | Collaborators |
|                          |               |
|                          |               |
|                          |               |
--------------------------------------------
```

Here is an example of a CRC card for the `Human` class from RPS:

```
--------------------------------------------
| Human                Super-class: Player |
--------------------------------------------
|                          |               |
|   - has a name           |  - Move       |
|   - has a move           |               |
|   - can choose a move    |               |
|                          |               |
|                          |               |
--------------------------------------------
```

And for the `RPSGame` class:

```
--------------------------------------------
| RPSGame                                  |
--------------------------------------------
|                          |               |
|  - has a human player    | - Human       |
|  - has a computer player | - Computer    |
|  - can start a new game  |               |
|                          |               |
|                          |               |
--------------------------------------------
```

Note that we didn't list all the methods in `RPSGame`, only the _public_ methods that can/should be called from outside the class. Methods that are used internally are implementation details that don't need to be included.

Follow this general approach to orgaanize ideas:

1. Write a description of the problem and extract major nouns and verbs.
2. Make an initial guess at organizing the verbs and nouns into methods and classes/modules, then do a spike to explore the problem with temporary code.
3. When you have a better idea of the problem, model your thoughts into CRC cards.
