When using Rubocop, you can resolve most complexity complaints by refactoring the method: either removing repetitive code or breaking it down into smaller logical tasks.
There is one complexity complaint in particular that can be harder to address: the **Assignment Branch Condition size** or **AbcSize**.
This complexity warning counts the assignments (a), branches (b) (aka method calls), and conditions (c) in a method, then reduces those numbers to a single metric that describes its complexity.
It uses the following formula to do that:

```ruby
abc_size = Math.sqrt(a**2 + b**2 + c**2)
```

If the resulting value is greater than 18, Rubocop flags the method as too complex.
So for example, if a method has 6 assignments, 16 method calls, and 7 conditions, then the AbcSize is `Math.sqrt(6**2 + 16**2 + 7 **2)`, which equals 18.47. To address the complaint, you'd need to reduce one or more of these components. Eliminating one method call drops the AbcSize down to 17.6.
Reducing the occurrences of the most frequent type (branches(method calls) in the above example) has the most effect on the computed AbcSize.

There are strategies to reducing each component of the AbcSize.
You can often reduce assignments by finding repetitive assignments, or by removing intermediate values (if this doesn't affect readility too much).
The most effective ways to reduce the condition count are to refactor repetitive conditions and complicated conditional expressions. We can often extract these complicated conditionals into a separate method.
Counting branches can be tricky, since many method calls are hidden by Ruby syntax. Element reference, as well as many operators, are methods in disguise, and they contribute to the branch count. In OOP, every reference to a getter or setter method is a method call, and increases the branch count.

When faced with an AbcSize complaint, you should:

- try to simplify your code
- examine the results
- use your best judgment -- have you improved the code?
