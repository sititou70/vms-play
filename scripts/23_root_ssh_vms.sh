#/bin/bash
set -eu
cd $(dirname $0)

# main
cd ..

current_session_name=$(tmux list-sessions | grep attached | cut -d ":" -f 1)

tmux new-window

# pane 1
tmux send-key -t $current_session_name.1 \
  "ssh root@192.168.70.2" C-m

# pane 2
tmux split-window -v -t $current_session_name
tmux send-key -t $current_session_name.2 \
  "ssh root@192.168.70.3" C-m

# pane 3
tmux split-window -h -t $current_session_name
tmux send-key -t $current_session_name.3 \
  "ssh root@192.168.70.4" C-m
