#! /bin/bash
# usage: start.sh [-P portnum]
#   examples:
#  ./start.sh -P 9000
#            to start server on port 9000
#  ./start.sh
#            to start server on port from configuration files
#

python3 pageserver/pageserver.py $* &
echo $! > pypid
echo "----> If make stop doesn't work, kill using: kill -9 " `cat pypid`
