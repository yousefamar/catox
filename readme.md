Catox
=====

About
-----
Catox is a text-based UI that runs on top of [ratox](http://ratox.2f30.org/). Run it in a Tox friend's directory (or pass a friends directory in as a command line argument) and enjoy a customizable, lightweight, minimalistic chat interface in your terminal.

Catox also gives you the ability to use SGR escape codes. Equally, if a friend uses them, catox will apply them accordingly (colors, bold, highlight, etc.).

Usage
-----
Press `i` to enter input mode (default) to enter text to send.

Press `e` to instead input text through your $EDITOR (e.g. vim).

Press `Esc` to exit either mode and then use `j` and `k` to scroll down and up quickly, or `Shift-j` and `Shift-k` to scroll down and up slowly.

Press `q` or `Ctrl-c` to quit.

Note: All of these (and colors) will be customizable in the future.

TODO/Ideas
----------

 1.  Title bar (or below) with name and typing status (when implemented).
     1. Replace line by line name with colours for user identification.
 2.  Remove horizontal rule above input and instead add  opaque background to input line for differentiation.
 3.  Think of shortcut key binding to scroll all the way down.
 4.  Commands for chat logging.
 5.  Print the date on a line before the first message on a day.
 6.  Don't print the time every single time; only once a minute.
 7.  Create ASCII cat.
 8.  Allow for window notifications.
 9.  Find out why Box forces a newline on first line.
 10. Write /help text.
 11. Inform of status and state.


<!-- vim: set wrap linebreak spell : -->
