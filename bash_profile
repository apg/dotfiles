DROPBOX=`which dropbox`
RUNNING=`$DROPBOX running`

if [[ $? -eq 0 ]]
then
    $DROPBOX start
fi

export SSH_AUTH_SOCK=$HOME/.ssh/agent.sock

if ! ([ -S "$SSH_AUTH_SOCK" ] && { ssh-add -l >& /dev/null || [ $? -ne 2 ]; }) ; then
   echo "Starting agent..."
   eval "$(ssh-agent -s -a $SSH_AUTH_SOCK)" > /dev/null
fi
