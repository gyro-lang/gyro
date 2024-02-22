
## Syntax

Gyro would use curly braces { } for blocks, like C++ and JavaScript.

It would use semicolons at the end of each statement, like JavaScript and C++.

It would use parentheses ( ) for function calls and expressions, like JavaScript and Lisp.

It would use square brackets [ ] for arrays and indexing, like JavaScript and Rust.

It would use the dollar sign $ as a shorthand for calling functions, like Ruby.

## Types

Gyro would be statically typed, like Rust and C++.

It would have strong typing, like Rust and C++.

It would support type inference, like Rust and JavaScript.

It would have first-class functions, like JavaScript and Lisp.

It would have closures, like JavaScript and Ruby.

## Memory Management

Gyro would use a combination of garbage collection and manual memory management, like JavaScript and C++.

It would have optional ownership and borrowing, like Rust.

## Concurrency

Gyro would support concurrency with threads and channels, like Rust.

It would also have async/await syntax for non-blocking I/O, like JavaScript.

## Functions

Gyro would support functions as first-class citizens, like JavaScript and Lisp.

It would also support multiple return values, like Ruby and Lisp.

It would have function overloading, like C++.

## Error Handling

Gyro would use a combination of exceptions and return codes, like C++ and Rust.

It would also have optional error handling with the Result type, like Rust.

### Functions, Generics, Static Typing

```gyro
// Declare a function that takes a closure as an argument
fn map<T, U>(arr: [T], f: fn(T) -> U) -> [U] {
  let mut result = [];
  for element in arr {
    let mapped_element = f(element);
    result.push(mapped_element);
  }
  return result;
}

// Use the function with a closure
let numbers = [1, 2, 3];
let squared_numbers = map(numbers, |n| n * n);
// Same as using map(numbers, :*)
print(squared_numbers);
```

### Classes

```gyro
// Declare a class with a constructor and methods
class Rectangle {
  let width: i32;
  let height: i32;

  fn new(w: i32, h: i32) -> Rectangle {
    Rectangle { width: w, height: h }
  }

  fn area(&self) -> i32 {
    return self.width * self.height;
  }
}

// Create an instance of the class and call a method
let rectangle = Rectangle::new(3, 4);
let area = rectangle.area();
print(area);
```

### Language Switching

```gyro
// Switch the active language
// This block will be integrated into the final code
fn squareArea(area: int32) -> int32, String {
	// Assume there will be scoping issues if we let @javascript access the entirety of our environment
	// therefore we bind `area` to the global scope of `@javascript` so that only the `area` variable
	// will be leaked into the javascript scope
	// If we were to remove the `(area)` we would simply expose the entire environment to the `@javascript` embedding.
	return @javascript(area) -> int32 {
		// Use the area variable that was defined in Gyro-Native
		return area ** 2;
	}, "javascript";
}

// Call the `squareArea` function with object destructuring to get both return values.
let result, language = squareArea(area);
```


### Operator overloading

```gyro
class Vector3 {
	let x: int32;
	let y: int32;
	let z: int32;

  fn new(x: int32, y: int32, z: int32) -> Vector3 {
		// Automatic key -> value assignment when using defined names, like in JavaScript.
		return Vector3 { x, y, z }
  }

  // Define an operator overload for addition
  __add(other: Vector3) @javascript {
    return new Vector3(this.x + other.x, this.y + other.y, this.z + other.z);
  }

  // Define an operator overload for multiplication
  __mul(scalar: int32) @rust {
    Vector3(self.x * scalar, self.y * scalar, self.z * scalar)
  }
}

// Create two vectors
let v1 = Vector3::new(1, 2, 3);
let v2 = Vector3::new(4, 5, 6);

// Add the vectors using the overloaded '+' operator
let result = v1 + v2;
console.log(result); // Output: Vector3 { x: 5, y: 7, z: 9 }

// Multiply a vector by a scalar using the overloaded '*' operator
let scaled = v1 * 2;
console.log(scaled); // Output: Vector3 { x: 2, y: 4, z: 6 }
```

### Interfaces and Anonymous Functions

```gyro
// Define an interface for objects that can be sorted
interface Sortable {
  fn compare(other: Self) -> i32;
}

// Define a generic sorting function that takes a slice of sortable objects and a comparison function
fn sort<T: Sortable>(arr: &[T], compare_fn: fn(a: &T, b: &T) -> i32) {
  let mut vec = arr.to_vec();
  vec.sort_by(|a, b| compare_fn(a, b));
	// String interpolation
  print("#{vec}");
}

// Define a struct that implements the Sortable interface
struct Person {
  name: String,
  age: u32,
}

impl Sortable for Person {
  fn compare(other: Self) -> i32 {
    self.age.cmp(&other.age)
  }
}

// Define an anonymous function that compares people by name
let name_cmp = |a: &Person, b: &Person| a.name.cmp(&b.name);

// Create some people
let alice = Person { name: "Alice", age: 30 };
let bob = Person { name: "Bob", age: 25 };
let charlie = Person { name: "Charlie", age: 35 };

// Sort the people by age
sort(&[&alice, &bob, &charlie], Person::compare);

// Sort the people by name using the anonymous function
sort(&[&alice, &bob, &charlie], name_cmp);
```

### SECTION: Async/Await

```gyro
// Define a coroutine function that asynchronously fetches data from a URL
async fn fetch(url: string) -> Promise<string> {
  let response = await http.get(url);
  return response.body;
}

// Use the coroutine function to fetch data from a URL
let data = await fetch("https://example.com/data.json");
```

### SECTION: Generator Functions

```gyro
// Define a generator function that yields the first n Fibonacci numbers
fn* fibonacci(n: int32) -> Array<int32> {
  let a = 0, b = 1;
  for (let i = 0; i < n; i++) {
    yield a;
    [a, b] = [b, a + b];
  }
}

// Use the generator function to print the first 10 Fibonacci numbers
for (let n of fibonacci(10)) {
  print(n);
}
```

### SECTION: Preprocessor Directives

```gyro
#if DEBUG
print("Debug mode enabled");
#endif
```

### Compile-Time compiler modifications

```gyro
@compiler {
  .EXTEND GYRO WITH E_NUMBERS

  // Support number formats like this: 2e2
  E_NUMBERS = .NUMBER ->("LDC" *) "e" ->("LDC" "10") .NUMBER ->("LDC" *) ->("POW") ->("MUL");

	.END
}
```

### Advanced Operators

```gyro
// Array map shorthand
// Curly braces are optional
[1,2,3] @. {|a| 5}; // [5,5,5]

// Array reduce shorthand
// Curly braces are optional
[1,2,3] @: {|a,c| a+c, 0}; // 6
```

## Additional Feature Ideas

### Modules

Support for modular programming to organize code into separate, reusable components.

```gyro
// Import from "gyro_modules" directory
import math;
import * from math;
import { add } from math;

// Relative to script path.
import { subtract } from "./math-addons.gyro";
```

### Macros

Allow developers to write code that writes other code. Macros would make it easier to write repetitive code or simplify complex code.

```gyro
macro repeat(n, body) {
	for (let i = 0; i < n; i++) {
		body;
	}
}

repeat(3, {
	print("Hello, world!");
});
```

### Type Aliases

Ability to create an alias for a complex or lengthy type definition.

```gyro
type Point = { x: i32, y: i32 };
```

### Pattern Matching

Pattern matching would enable programmers to match data structures against a set of patterns, allowing for more concise and readable code.

```gyro
match value {
	0 => print("Zero"),
	1 => print("One"),
	_ => print("Other"),
}
```

### Immutable Data Structures

Immutable data structures would help enforce immutability and eliminate bugs caused by unintentional mutations.

```gyro
let imm list = [1, 2, 3];
let newList = list.push(4); // Error: list is immutable
```

### Enumerations

Enumerations would allow developers to define a set of named constants and associate values with them.

```gyro
enum Color {
	Red,
	Green,
	Blue,
}
```

### Garbage Collector Control

Support for configuring and controlling the garbage collector to optimize performance.

```gyro
import gc from "gyro:std/gc";

gc.setThreshold(100);
```

### Anonymous Structs

Ability to define anonymous structs to group together related data fields.

### Generics in Structs

Ability to define structs with generic types.

```gyro
struct Pair<T> {
	first: T,
	second: T,
}
```

### Runtime Type Information

Provide runtime type information to enable reflection and dynamic dispatch.

```gyro
let type = typeof(value);
```

### Property Syntax

Support for defining properties on classes and structs with a concise syntax.

```gyro
class Rectangle {
	let width: i32;
	let height: i32;

	fn area() -> int32 {
		return this.width * this.height;
	}
}
```

### Iterators

Support for iterators and generators to make it easier to work with collections of data.

### Parallel Programming

Support for parallel programming to take advantage of multi-core processors.

```gyro
import parallel from "gyro:std/parallel";

let result = parallel.map(data, |item| process(item));
```

### Named Parameters

Support for named parameters to make it easier to use functions with many parameters.

```gyro
fn drawCircle(x: i32, y: i32, radius: i32) {
	// Draw a circle
}

drawCircle(x: 10, y: 20, radius: 5);
```

### Optional Function Parameters

Ability to define optional function parameters with default values.

```gyro
fn greet(name: string, message: string = "Hello") {
	print("#{message}, #{name}!");
}

greet("Alice"); // Output: Hello, Alice!

greet("Bob", "Hi"); // Output: Hi, Bob!
```

### Safe Concurrency

Safe and easy to use concurrency constructs like channels, mutexes, and semaphores.

```gyro
let channel = new Channel<i32>();

spawn {
	channel.send(42);
}

let value = channel.receive(); // 42
```

### Tail Call Optimization

Support for tail call optimization to enable efficient recursion.

```gyro
fn factorial(n: i32, acc: i32 = 1) -> i32 {
	if (n <= 1) {
		return acc;
	} else {
		return factorial(n - 1, n * acc);
	}
}
```