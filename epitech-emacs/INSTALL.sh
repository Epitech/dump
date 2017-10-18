#!/bin/bash

SRCDIR="src"
DESTDIR="$HOME"

echo "Installing {EPITECH.} Emacs configuration on your session..."

echo "Copying configuration files..."
cat "$SRCDIR/.emacs" >> "$DESTDIR/.emacs"
mkdir -p "$DESTDIR/.emacs.d/lisp"
cp "$SRCDIR/.emacs.d/lisp/std.el" "$DESTDIR/.emacs.d/lisp/"
cp "$SRCDIR/.emacs.d/lisp/std_comment.el" "$DESTDIR/.emacs.d/lisp/"

echo
echo "Installation complete."
