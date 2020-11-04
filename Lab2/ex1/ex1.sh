#!/bin/bash

echo -e "The number of user processes:"
userProcesses=$(ps -l -u $USER | wc -l)
echo $userProcesses

echo -e "The number of root processes:"
pgrep root | wc -l
