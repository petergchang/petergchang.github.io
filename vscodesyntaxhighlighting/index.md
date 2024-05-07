# How to Resolve VSCode Syntax Highlighting Issue


# The Problem
I've started to experience significant delays in trivial tasks on VSCode.
For example, every time I pressed the enter button, it would take >3 seconds 
for the cursor to move to the next line. This was, for obvious reasons,
extremely frustrating and significantly hampered with my productivity as well as the
desire to engage in programming.

In addition, at some point, the syntax highlighting stopped working.

I'd assumed these were orthogonal issues, but they were not!

# Solution

Pylance should provide nice syntax highlighting. In order to ensure this,
on `settings.json`, add `"python.languageServer": "Pylance",`.

The problem was that within my project directory, I had been adding a
significant number of data files used for experiments,
and also generating significant number of results / analysis files.
And since Pylance had to access all of those files, this was 
causing the Language server to shut down, causing the syntax highlighting
issue!

A way I could observe this was by viewing 
the `Python: Show Language Server Output` from the Command Palette
and reading the complaints that the language server was generating.

I believe the Copilot delay is related to this (it has to access
all of the files to make suggestions), but I am unsure yet
of how to resolve this issue.
