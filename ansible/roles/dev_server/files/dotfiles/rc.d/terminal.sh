#  Some niceties
export BLOCKSIZE=1k

export TERM=xterm-256color                          # for common 256 color terminals (e.g. gnome-terminal)
#export TERM=screen-256color                        # for a tmux -2 session (also for screen)
#export TERM=rxvt-unicode-256color                  # for a colorful rxvt unicode session

# Blinking I-beam cursor
echo -ne '\e[5 q'
