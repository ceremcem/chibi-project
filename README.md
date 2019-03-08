# Description

This is the boilerplate for starting up a ChibiOS project on Linux.

# Benefits

1. Automatically a `dependencies.txt` for future-proof builds which does not bloat disk usage.
2. Provides an easier way to put breakpoints while using command line GDB client: 

      1. Switch to your code editor and place `// debugger` at the end of the line which you want to place a breakpoint.
      2. Switch to your GDB prompt
      3. Ctrl+C
      4. `update-breakpoints` (or `upp` for short)
      5. Type `c` to continue. 
3. You can share your custom headers (see [`./include`](./include) folder) between your projects.
4. Provides an easy switch for `Debug` and `Release` build targets (see `Target` file)

# Usage

1. Create your project directory, eg. "myproject"

        mkdir myproject
        cd myproject 
        
2. Add this library as a submodule:

        git submodule add https://github.com/ceremcem/chibi-project

3. Initialize:

        ./chibi-project/init

4. Your main file is `app/main.c`.
5. Build your project:

        make

6. Flash or debug your project:

        make write # for only flashing
        make start-debugging # to start debugging your application.

# Example 

See https://github.com/ceremcem/chibi-examples2 as an example usage of this tool.
