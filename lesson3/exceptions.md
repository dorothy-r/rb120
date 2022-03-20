# Getting Started with Ruby Exceptions

https://launchschool.medium.com/getting-started-with-ruby-exceptions-d6318975b8d1

## What is an Exception?

Simply, it is Ruby's way of letting you know that your code is behaving unexpectedly.
If your code does not handle the exception, your program will crash and you'll get a message telling you what kind of error occurred.
Ruby provides a hierarchy of classes to handle exceptions. The exception names that you see in an error message (e.g. `TypeError`) are actually class names. They all subclass from the `Exception` class.

## The Exception Class Hierarchy

Here is the hierarchy of Ruby's exception classes:

```
Exception
  NoMemoryError
  ScriptError
    LoadError
    NotImplementedError
    SyntaxError
  SecurityError
  SignalException
    Interrupt
  StandardError
    ArgumentError
      UncaughtThrowError
    EncodingError
    FiberError
    IOError
      EOFError
    IndexError
      KeyError
      StopIteration
    LocalJumpError
    NameError
      NoMethodError
    RangeError
      FloatDomainError
    RegexpError
    RuntimeError
    SystemCallError
      Errno::*
    ThreadError
    TypeError
    ZeroDivisionError
  SystemError
  SystemStackError
  fatal
```

## When Should You Handle an Exception?

The errors you are most likely to handle are descendents of the `StandardError` class.
These may be caused by a variety of circumstances, including unexpected input, faulty type conversions or dividing by 0. It is generally safe to handle these excpetions and continue running the program.
It can be quite dangerous to handle other types of errors. Some are very serious, and we _should_ allow them to crash our programs. Errors such as `NoMemoryError`, `SyntaxError`, and `LoadError` must be addressed if we want a program to operate correctly. If we handle all exceptions, we may miss critical errors and have trouble debugging.
It is important to be intentional and specific about deciding which exceptions to handle, and what actions you want to take when handling them.

## How to Handle an Exceptional State

**The `begin`/`rescue` Block**
Using a `begin`/`rescue` block can keep your program from crashing if the execption you have specified is raised. It works like this:

```ruby
begin
  # code at risk of failing
rescue TypeError
  # action to take
end
```

If the code on line 2 raises a `TypeError`, Ruby will execute the code in the `rescue` clause instead of exiting the program.
A few things to note about the `rescue` clause:

- if we don't specify an exception type, all `StandardError` exceptions will be rescued and handled
- never tell Ruby to rescue `Exception` class exceptions; this will rescue _all_ exceptions, which is dangerous
- if you would like to take the same action for more than one type of exception, you can include multiple comma-separated exception classes after `rescue`
- you can also include multiple `rescue` clauses to handle different types of exceptions differently:

```ruby
begin
  # code at risk of failing
rescue TypeError
  # action to take
rescue ArgumentError
  # different action to take
end
```

## Exception Objects and Built-In Methods

Exception objects are just regular Ruby objects. Ruby provides built-in behaviors for these objects that we can use when handling an exception or debugging.
(The documentation for Ruby's `Exxception` class is useful.)
How do we use an exception object?
The following syntax is used to store the exception object in a variable (in this case, `e`):
`rescue TypeError => e`
Once we have stored an exception object, we can use the instance methods Ruby provides for the `Exception` class. Here's an example:

```ruby
begin
  # codeat risk of failing
rescue StandardError => e   # stores the exception object in `e`
  puts e.message            # outputs error message associated with the exception
end
```

Code like this can be useful for debugging and narrowing down the cause of an error.

### `ensure`

We can also include an `ensure` clause in a `begin`/`rescue` block. It comes after the last `rescue` clause and always executes, whether or not an exception was raised.
Here's an example of how this might be used when working with a file:

```ruby
file = open(file_name, 'w')

begin
  # do something with file
rescue
  # handle exception
rescue
  #handle a different exception
ensure
  file.close                    # this executes every time
end
```

It is critical that the code in the `ensure` clause does not itself raise an exception. This can mask any exception raised earlier and make debugging difficult.

### `retry`

We won't often use `retry`. It redirects the program back to the `begin` statement and allows it to make another attempt to run the code that raised an exception.
`retry` must be called within the `rescue` block. Using it elsewhere raises a `SyntaxError`.
This could be useful when connecting to a remote server, for example.
However, if the code continually fails, you risk ending up in an infinite loop.
To avoid this, set a limit on the number of times you want `retry` to execute:

```ruby
RETRY_LIMIT = 5

begin
  attempts = attempts || 0
  # do something
rescue
  attempts += 1
  retry if attempts < RETRY_LIMIT
end
```

## Raising Exceptions Manually

Ruby allows us to manually raise exceptions by calling `Kernel#raise`. This allows us to choose what type of exception to raise and set our own error message.
If we don't specify an exception, Ruby will default to `RuntimeError`. Here's an example:

```ruby
def validate_age(age)
  raise("invalid age") unless (0..105).include?(age)
end
```

The above code raises a `RuntimeError` cand gives the specified error message, "invalid age".
We can handle exceptions that we raise manually in the same way that we handle exceptions that Ruby raises automatically.

## Raising Custom Exceptions

Ruby also allows us to create our own custom exception classes:
`class ValidateAgeError < StandardError; end`
We will usually want to inherit from `StandardError`.
One advantage to using a custom exception class is the ability to be specific about the error and give the class a very descriptive name.
We can raise and handle custom exceptions just like any built-in exception provided by Ruby.
