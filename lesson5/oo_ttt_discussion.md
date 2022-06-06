1. When writing the program, we had to test for regression after every change. How can we ease this burden? Preventing regression is one of the most important jobs for tests. We'll talk about this in a later lesson.

2. Modifying this program was easier and safer than modifying the procedural TTT program we wrote earlier. OOP forces us to set up more indirection, but that also allows us to isolate concerns so they don't affect the entire codebase. Changes are encapsulated to a class or object. The interface used to interact with the class or object can remain the same, even when the specific implementation changes.

3. Many of the classes in this game have a generic name, like `Player` or `Board`. If we wanted to wrap our game up into a library and allow others to use it, we should use a namespace for our application's classes, so they don't bleed into the global namespace.

4. The `Player` class is quite bare. Do we enven need a class in this case? Could we just use a `Struct` for `Player`, since it's currently nothing more than a data structure? That is, it contains some data, but no behaviors.

5. As we have more classes, we can start to build a 'dependency graph' of our classes. In OOP, we don't want the dependency graph to look like a spider web: classes should collaborate with _some_ other classes, but should not _all_ collaborate with each other. If we see that happening, we should reconsider our OO design. The dependency graph of our program looks like this:

- TTTGame collaborates with Player
- TTTGame collaborates with Board
- Board collaborates with Square

Player knows nothing about Square, and Board knows nothing about Player. This encapsulates and mitigates the ripple effects of any changes we might make.

6. Here are the main methods (behvaiors) in the `Board` and `Square` classes:

|----------------------------|-------------|
| Board | Square |
|----------------------------|-------------|
| `[]=` | `to_s` |
|----------------------------|-------------|
| `unmarked_keys` | `unmarked?` |
|----------------------------|-------------|
| `full?` | `marked?` |
|----------------------------|-------------|
| `someone_won?` | `marker` |
|----------------------------|-------------|
| `winning_marker` | `marker=` |
|----------------------------|-------------|
| `reset` | |
|----------------------------|-------------|
| `draw` | |
|----------------------------|-------------|
| `three_identical_markers?` | |
|----------------------------|-------------|

Notice how the methods only deal with concerns related to the class. The only suspect method is `Board#three_identical_markers?`, since the game logic of "3 winning squares" has leaked into the board. However, this is a private method, so if the "winning" logic changes, we can udate that private method while still preserving our public interface (`Board#someone_won?` and `Board#winning_marker`).
When working with classes, it is important to focus on the behaviors and data in that class. It can be tempting to inject additional collaborators, but that will also introduce additonal dependency. `Board` knows about `Square`, but not `Player` or even `TTTGame`. The fewer collaborators, the closer a class is to a generic class, like `Array` or `Hash`.

7. Here's an example that illustrates the above point. What if we think the behavior in `TTTGame#human_moves` and `TTTGame#computer_moves` should be moved to the `Player` class, in a method `Player#move`?
   We would first have to change the `Player` class to be aware of the difference between a "human" and a "computer". That would mean differentiating between the two at instantiation:

```ruby
class Player
# ... rest of class omitted for brevity
  def intialize(marker, player_type = :human)
    @marker = marker
    @player_type = player_type
  end

  private

  def human?
    @player_type == :human
  end
end

@human = Player.new(HUMAN_MARKER)
@computer = Player.new(COMPUTER_MARKER, :computer)
```

And then creating a `Player#move` method that consolidates `TTTGame#human_moves` and `TTTGame#computer_moves` into one method:

```ruby
class Player
  # ... rest of code omitted

  def move
    if human?
      puts "Choose a square (#{board.unmarked_keys.join(', ')}) "
      square = nil
      loop do
        square = gets.chomp.to_i
        break if board.unmarked_keys.include?(square)
        puts "Sorry, that's not a valid choice."
      end

      board[square] = marker
    else
      board[board.unmarked_keys.sample] = marker
    end
  end
end
```

This code won't work as written, because the `Player` object is not aware of the board it needs to mark. To fix this, we can update the method to take a `Board` object.
However, from a design perspective, it is important to consider the tradeoffs we're making by introducing a new dependency between the `Player` and `Board` classes.
Conceptually, there is a collaboration between `Player` and `Board`: the player marks the board. The question is, where and how should we organize that collaboration? In the `Player` class (`@human.marks(board)`)? In the `Board` class? (`board.marked_by(@human)`)?
In our original code, `Player` and `Board` did not directly collaborate, and instead relied on the orchestrator class, `TTTGame`, to capture the collaboration between the objects in the `human_moves` and `computer_moves` methods.
There is rarely one "right" way to program in OOP. It all comes down to tradeoffs around how tightly we want to couple dependencies.
Tightly couples dependencies are easier to understand, but offer less flexibility.
Loosely coupled dependencies are more difficult to understand, but offer more long-term flexibility.
Neither is "right"--it depends on your application. At this stage it is premature to get too hung up on design patterns/optimizing architecture. It is good to recognize when we are introducing coupling and dependency, and to eliminate unnecessary coupling when possible.

8. What if `Board` had used an array of `Square` objects, rather than a hash?
   What if `Square` obejcts contained the position `number` that they were in?
   Given that we want a collection of squares that have different numbers, should we use a `Set` collection?
