# Object Oriented Coding Tips

- Explore the problem before design
  It can be difficult to come up with the right classes and methods when approaching a problem.
  Use a 'spike' to explore the problem domain. A spike is exploratory code that allows you to play around with the problem, validate hunches and test hupotheses.
  Don't worry about the code quality with a spike--it is throwaway code, kind of like the initial brainstorming phase of an essay.
  As you understand the problem better and possible solutions emerge, begin organizing the code into coherent classes and methods.

- Repetitive nouns in method names is a sign that you are missing a class
  For example, when writing code for RPS, we found ourselves referring to a "move" often. This was a sign that we should encapsulate that logic into a `Move` class.
  Lots of helper methods referring to a "move" variable that is not a custom object lets us know that we could improve the code by creating a custom class that includes the appropriate methods.

- When naming methods, don't include the class name
  It is tempting to name methods like this:

```ruby
class Player
  def player_info
    # returns player data
  end
end
```

In practice, though, this leads to code like this:

```ruby
player1 = Player.new
player2 = Player.new

puts player1.player_info
puts player2.player_info
```

It would read much better if the method were just named `info` (`puts player1.info`).
Always think about the method's usage or _interface_ when defining and naming methods.
Names should be consistent and easy to remember, give an idea of what the method does, and read well at invocation time.

- Avoid long method invocation chains
  When working with object oriented code, it is tempting to keep calling methods on collaborator objects: `human.move.display.size`.
  This kind of method invoation is very fragile and hard to debug.
  Notice when you are tempted to do this, and consider the possibility of `nil` or other unexpected return values in the middle of the chain.
  In the above example, if `human.move` could possibly return `nil`, add a guard expression, like this:

```ruby
move = human.move
puts move.display.size if move
```

- Avoid design patterns for now
  At this stage of learning, it is too early to think about "best practices" or "design patterns" that improve performance or flexibility.
  Don't worry about optimization or writing clever code at this point.
  You'll have the rest of your career to master this (and it requires experience). You should spend time understanding _when_ to use such practices rather than just blindly applying 'best practices'.
