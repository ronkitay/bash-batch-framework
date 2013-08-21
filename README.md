bash-batch-framework
====================

A "framework" for running batch processes based on BASH

This is basically a BASH script you include in all your scripts and it provides you basic capabilities for logging and execution of commands in your batch processes.

It is intendend for scripts that need to maintain some flow with error handling and reporting.

It provides 2 Key features:

* Logging functions: Error, Info, Debug (based on a DEBUG flag)
* Command execution framework: ExecuteCommand(description, command)

You can override the "framework"'s behavior by "overriding" the same functions in your own script.
