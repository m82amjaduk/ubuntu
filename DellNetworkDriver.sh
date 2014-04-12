#!/bin/bash
# Run $ chmod +x DellNetworkDriver.sh
# $ ./DellNetworkDriver.sh

DIR_SCRIPT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
FILE_SCRIPT=$(basename $0);







echo "FILE :: $DIR_SCRIPT/$FILE_SCRIPT";
chmod 400 $DIR_SCRIPT/$FILE_SCRIPT;