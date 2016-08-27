#!/bin/sh

tmux new -d -s mail 'mutt'\; \
    new-window -d 'mailsync'\; \
    attach \;
