# Custom Compiler Project

This project involves the design and implementation of a **custom compiler** that processes a defined set of commands, directives, variables, control structures, and functions. The compiler is written using **Lex** and **Yacc** and is capable of validating directives, declaring variables, executing arithmetic operations, handling loops, conditional blocks, and managing functions.

## Features

- **Directive Handling**: Supports directives such as `includes` and `defines`.
- **Variable Declarations**: Supports integer, float, and character variables with assignment and validation of duplicate declarations.
- **Constants**: Handles constant declarations with validity checks.
- **Control Structures**:
  - Supports `if`, `if-else`, and `if-elif-else` conditions.
  - `for` and `while` loops are supported, including nested loops.
- **Function Definitions**: Handles functions with different return types (e.g., `INT`, `FLOAT`, `VOID`).
- **Arrays**: Supports declaration and initialization of integer, float, and character arrays.
- **Arithmetic and Logical Operations**: Handles arithmetic and logical operations such as addition, multiplication, comparison, and more.
- **Error Detection**: Detects invalid directives, duplicate variables, undeclared variables, and type conflicts.

## Files in the Repository

1. **input.txt**: Contains a sample input program for the compiler. The program includes variable declarations, conditional statements, loops, function definitions, and array manipulations.
2. **output.txt**: Displays the results of running the `input.txt` program through the custom compiler, including error messages and successful execution results.
3. **project.l**: Lex file that handles lexical analysis for the compiler.
4. **project.y**: Yacc file that defines the grammar rules and syntax for the custom compiler.

## Compilation and Execution

1. **Install Lex and Yacc**:
   Make sure you have **Lex** and **Yacc** installed on your system. You can install them using the following commands:
   ```bash
   sudo apt-get install flex bison
