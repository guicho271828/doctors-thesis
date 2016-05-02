#! /bin/bash

if (cat $1 | grep -E "Overfull" | column -t)
then
    exit 1
fi
