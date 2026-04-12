#  Some niceties
export BLOCKSIZE=1k

export TERM=xterm-256color                          # for common 256 color terminals (e.g. gnome-terminal)
#export TERM=screen-256color                        # for a tmux -2 session (also for screen)
#export TERM=rxvt-unicode-256color                  # for a colorful rxvt unicode session

# Blinking cursor + cursor color
echo -ne '\e[1 q'
echo -ne "\e]12;#696969\a"
