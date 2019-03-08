# Description

This is the boilerplate for starting up a ChibiOS project on Linux.

# Usage

1. Create your project directory, eg. "myproject"
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
