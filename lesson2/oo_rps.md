# Assignment: OO Rock Paper Scissors

We will build another RPS game. The flow will be the same as in the previous course:

- the user makes a choice
- the computer makes a choice
- the winner is displayed

This time, we will be coding it in OOP style, using classes and objects.

## Approach to OOP

The classical approach to OOP is:

1. Write a description of the problem or exercise
2. Extract the major nouns and verbs from the description.
3. Organize and associate the verbs with the nouns.
4. The nouns are the classes and the verbs are the behaviors or methods.

In OOP, we don't think about the logic flow of the game at all at this stage.
The goal is to organize and modularize the code into a cohesive structure of classes.
We won't consider the flow of the program using objects instantiated from the classes until the final step of planning.

Here is how we could follow the above steps for RPS:

1. Rock, Paper, Scissors is a two-player game where each player chooses one of three possible moves: rock, paper, or scissors. The chosen moves will then be compared to see who wins, according to the following rules:

- rock beats scissors
- scissors beats paper
- paper beats rock
  If the players choose the same move, then it's a tie.

2. Nouns: player, move, rule
   Verbs: choose compare

3. Player
   -choose

   Move

   Rule

   compare

4. Initial skeleton classes/methods (still lots of uncertainty):

```ruby
  class Player
    def initialize
      # maybe a "name"? what about a "move"?
    end

    def choose
    end
  end

  class Move
    def initialize
      # seems like we need something to keep track of the choice
      # a move object can be "paper", "rock", or "scissors"
    end
  end

  class Rule
    def initialize
      # not sure what the "state" of a rule object should be
    end
  end

  # not sure where "compare" goes yet
  def compare(move1, move2)
  end
```

## Orchestration Engine

Once we have the nouns and verbs organized into classes, we need an "engine" to orchestrate the objects. This will be a class where the procedural program flow goes.
In this program, we will create a class called `RPSGame`
We will start off with an easy interface, so we need a way to instantiate an object and a method called `play`. We can then outline what is required to facilitate the game:

```ruby
class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Player.new
    @computer = Player.new
  end

  def play
    display_welcome_message
    human.choose
    computer.choose
    display_winner
    display_goodbye_message
  end
end
```

This shows how things are starting to take shape. We still need to figure out how or even whether we should use the `Move` and `Rule` classes. We'll continue exploring this in code in the next assignment.
Here, we have seen an outline of how to approach problem solving in OOP. In OOP, there is no absolute "right" solution. It is all a matter of tradeoffs. (There are definitely wrong approaches, though.) At this stage, our goal is to avoid wrong approaches and understand the core concepts, not to find the most optimal design.

In object-oriented design, "we're always juggling a tradeoff between more flexible code and indirection. Put another way, the more felxible your code, the more indirection you'll introduce by way of more classes. There's likeley an optimal tradeoff on that spectrum for your application somewhere, but that place likely changes as your application matures. This is the source of never-ending debate and discussion in the software development field, but it really comes down to that tradeoff. This is where the 'art' of programming comes in." (From Lesson 2.16 Walk-through: OO RPS Design Choice 2)
