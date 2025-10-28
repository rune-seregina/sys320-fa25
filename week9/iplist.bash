#!/bin/bash

# list all the ips in the given network prefix
# /24 only

# usage: bash iplist.bash 10.0.17
[ $# -ne 1 ] && echo "Usage: $0 <Prefix>" && exit 1

# prefix is the first input taken
prefix=$1

# verify input length
[ ${#1} -lt 5 ] && \
printf "Prefix length is too short\nPrefix example: 10.0.17\n" && \
exit 1

for i in {1..254}
do
	ping -c 1 "$prefix.$i" | grep -o  "64 bytes from $prefix.$i" | \
	 grep -o -E "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"
done
