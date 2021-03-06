# Description

This is the boilerplate for starting up a ChibiOS project on Linux.

# Benefits

1. Automatically tracks important dependencies (ChibiOS hash, GCC version) for [future-proof builds](https://stackoverflow.com/a/54604941/1952991). 
2. Provides an easier way to put breakpoints while using command line GDB client:

      1. Switch to your code editor and place a `// debugger` comment at the end of the line which you want to place a breakpoint.
      2. Switch to your GDB prompt
      3. Ctrl+C
      4. `update-breakpoints` (or `ub` for short)
      5. Type `c` to continue.
3. You can share your custom headers (see [`./include`](./include) folder) between your projects.
4. Provides an easy switch for `Debug` and `Release` build targets (see `Target` file)

Tested only on Linux. 

# Requirements 

1. [STLink](https://github.com/texane/stlink) as the GDB server. 
2. (Optional) Get arm-none-eabi binaries from [developer.arm.com](https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm/downloads/)
    2.1. Depends: "libncurses5, libncurses5:i386" (Recommended: Use [`create-virtual-deps.sh`](https://github.com/ceremcem/multistrap-helpers/blob/cf25ede775110d71b5ea6d3e70049e82576aa2c7/install-to-disk/debian-notes/package-control/create-virtual-deps.sh))
3. (Recommended) Tmux. 

# Usage

1. Create your project directory, eg. "myproject"

        mkdir myproject
        cd myproject

2. Add this library as a submodule:

        git submodule add https://github.com/ceremcem/chibi-project
        git submodule update --init --recursive

3. Initialize:

        ./chibi-project/init

4. Your main file is `app/main.c`.
5. Build your project:

        make

6. Flash or debug your project:

        make write # for only flashing
        make debug # to start debugging your application.

# Example

See https://github.com/ceremcem/chibi-examples2 as an example usage of this tool.
