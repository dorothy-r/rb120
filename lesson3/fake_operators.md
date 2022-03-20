# Fake Operators

As we saw in the Equivalence assignment earlier, `==` appears to be an operator, but is actually a method.
Because of Ruby's syntactical sugar, it looks like an operator:
We can call `str1 == str2` instead of `str1.==(str2)`
This reads more naturally, but can make it difficult to understand that there is actually a method definition behind the scenes governing the behavior of `==`/
Many other operators are actually methods in Ruby. Here is a table, organized by order of precedence, that shows which operators are actually operators and which are methods:

| Operator              | Method   | Description                         |
| --------------------- | -------- | ----------------------------------- |
| `.`, `::`             | no       | Method/constant resolution          |
| ------------------    | -------- | ----------------------------------- |
| `[]`, `[]=`           | yes      | Collection element getter/setter    |
| ------------------    | -------- | ----------------------------------- |
| `**`                  | yes      | Exponential operator                |
| ------------------    | -------- | ----------------------------------- |
| `!`, `~`, `+`, `-`    | yes      | Not, complement, unary plus/minus   |
| ------------------    | -------- | ----------------------------------- |
| `*`, `/`, `%`         | yes      | Multiply, divide, and modulo        |
| ------------------    | -------- | ----------------------------------- |
| `+`, `-`              | yes      | Plus, minus                         |
| ------------------    | -------- | ----------------------------------- |
| `<<`, `>>`            | yes      | Left and right shift                |
| ------------------    | -------- | ----------------------------------- |
| `&`                   | yes      | Bitwise "and"                       |
| ------------------    | -------- | ----------------------------------- |
| `^`, `\|`             | yes      | Bitwise exclusive and regular "or"  |
| ------------------    | -------- | ----------------------------------- |
| `<=`, `<`,            | yes      | Less than/equal to, less than,      |
| `>`, `>=`             |          | greater than/equal to, greater than |
| ------------------    | -------- | ----------------------------------- |
| `<=>`, `==`, `!=`,    | yes      | Equality/pattern matching (can't    |
| `=~`, `!=`            |          | define `!=` and `!~` directly)      |
| ------------------    | -------- | ----------------------------------- |
| `&&`                  | no       | Logical "and"                       |
| ------------------    | -------- | ----------------------------------- |
| `\|\|`                | no       | Logical "or"                        |
| ------------------    | -------- | ----------------------------------- |
| `..`, `...`           | no       | Inclusive and exclusive range       |
| ------------------    | -------- | ----------------------------------- |
| `? :`                 | no       | Ternary if-then-else                |
| ------------------    | -------- | ----------------------------------- |
| `=`, `%=`, `/=`,      | no       | Assignment (and shortcuts) and      |
| `-=`, `+=`, `\| =`,   |          | block delimiter                     |
| `&=`, `>>=`, `<<=`,   |          |                                     |
| `*=`, `&&=`, `\|\|=`, |          |                                     |
| `**=`, `{}`           |          |                                     |
| ------------------    | -------- | ----------------------------------- |

The operators that have a "yes" in the Method column means that they are actually methods. This means that we can define them in our classes and change their default behaviors.
This can be useful, but the downside is that since any class can provide a fake operator, we may not know what something like `obj1 + obj2` means.
We should be careful to use fake operators in a sensible way.
_note_ The `.` and `::` resolution operators (e.g. `dog.bark` and `Math::PI`) are often omitted from Ruby documentation about operators, but they are operators and have the highest precedence of all.

## Equality methods

One of the most common fake operators to be overridden is the `==` equality operator, as discussed in the Equivalence assignment.
It is often useful to provide your own `==` method. When we define this method, we get a corresponding `!=` method automatically.

## Comparison methods

Implementing the comparison methods gives us a nice, clear syntax for comparing objects.
If we want to compare `Person` objects based on a certain aspect of their state, we can define a `>` method for that class:

```ruby
class Person
  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end

  def >(other_person)
    age > other_person.age
  end
end
```

The above implementation will return `true` if the current object's age is greater than `other_person`'s age, and `false` otherwise. We are using `Integer#>` to get this functionality.
Defining a `>` method doesn't automatically give us `<`. If we want this method, we need to implement it explicitly.

## The `<<` and `>>` shift methods

We often use the `<<` method when working with arrays and strings.
However, `Hash` doesn't contain a `<<` method, so trying to use it with a hash will cause a `NoMethodError`.
As with other fake operators, we can implement `<<` or `>>` to do anything. It is not common to implement `>>`, so we won't discuss it here.
When implementing `<<` and other fake operators, choose some functionality that makes sense when used with the special operator-like syntax. For `<<`, it makes sense to use it in classes that represent collections:

```ruby
class Team
  attr_accessor :name, :members

  def initialize(name)
    @name = name
    @members = []
  end

  def <<(person)
    members.push person
  end
end

cowboys = Team.new("Dallas Cowboys")
emmitt = Person.new("Emmitt Smith", 46)    # using the Person class from before

cowboys << emmitt
cowboys.members                            # [#<Person:0x007fe08c209530>]
```

This creates a very clean interface for adding new members to a collection object.
We can also build in guard clauses to these methods, for example:

```ruby
def <<(person)
  return if person.not_yet_18?
  members.push person
end
```

## The plus method

The simple line of code, `1 + 1` actually contains a method call: `1.+(1)`.
Integers are objects of the `Integer` class, and have access to the `Integer#+` method.
In what circumstances should we write a `+` method for our custom objects?
Let's see how it is used in the standard library:

- `Integer#+`: increments the value by the value of the argument; returns a new integer
- `String#+`: concatenates with the argument; returns a new string
- `Array#+`: concatenates with the argument; returns a new array
- `Date#+`: increments the date in days by value of the argument; returns a new date
  Based on the standard library, the functionality of `+` should be either incrementing or concatenation with the argument.
  Here's an example that we could add to the `Team` class defined above:

```ruby
class Team
  # ... as above

  def +(other_team)
    members + other_team.members
  end
end
```

The implementation above returns a new Array of `Person` objects. But does this match the general pattern we saw in the standard library? No. The standard library methods listed above all return a new object of the same type as the calling object.
If we want to match that, our `Team#+` method should return a new `Team` object.
We could implememnt it like this:

```ruby
class Team
  # ... as above

  def +(other_team)
    temp_team = Team.new("Temporary Team")
    temp_team.members = members + other_team.members
    temp_team
  end
end
```

Now `Team#<<` returns a `Team` object instead of an array.

## Element setter and getter methods

The most surprising fake operators might be `[]` and`[]=`, partly because the syntactical sugar really obscures this:

```ruby
my_array[2]   # is equivalent to:
my_array.[](2)

# and even more surprisingly
my_array[4] = "fifth"   # is equivalent to:
my_array.[]=(4, "fifth")
```

The syntactical sugar provided by Ruby makes the code read much more naturally, but it does make it harder to understand how these methods are defined.
If we want to implement the element setter and getter methods in a custom class, we should follow the lead of the standard library and define them as simple getter and setter methods for a class that represents a collection.

```ruby
class Team
# ... as above

  def [](idx)
    members[idx]
  end

  def []=(idx, obj)
    members[idx] = obj
  end
end
```

Because `@members` is an array, we can use the Array class methods in our implementation.

## Summary

Many operators are actually methods that Ruby provides a special syntax for.
Because they are methods, we can implement them in custom classes and take advantage of that syntactical sugar.
To avoid confusion, we should follow the conventions of the Ruby standard library when implementing these methods in our classes.
Understanding fake operators/syntactical sugar can help us read Ruby code.
