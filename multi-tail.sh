#!/bin/bash

# RUN ::  sudo /home/amzad/dev/ubuntu/multi-tail.sh /home/amzad/dev/theroyals/logfiles/error_log /home/amzad/dev/theroyals/logfiles/access_log
# RUN ::  sudo /home/amzad/dev/ubuntu/multi-tail.sh  error_log  access_log
# RUN ::  tail -f /home/amzad/dev/theroyals/logfiles/access_log
# RUN :: multitail /home/amzad/dev/theroyals/logfiles/access_log

echo " Thank you for choosing this script !!!"

	if [ -f /usr/bin/multitail ]
	then
	    echo "multitail :: already installed in your system"
	else
        sudo apt-get install multitail
    fi

    # When this exits, exit all back ground process also.
    trap 'kill $(jobs -p)' EXIT

    # iterate through the each given file names,
    for file in "$@"
    do
        # show tails of each in background.
        tail -f $file &
    done

    echo "wait .. until CTRL+C"
    wait

echo " Thank you for using this Script.  Enjoy !!!"

