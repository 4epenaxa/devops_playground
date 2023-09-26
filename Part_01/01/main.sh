#!/bin/bash
if [ $# -eq 1 ]; then
  number="^[+-]?[0-9]+([.][0-9]+)?$";
  if ! [[ $1 =~ $number ]]; then
    echo $1;
  else
    echo "Please use letters in parameter";
  fi
elif [ $# \< 1 ]; then
    echo "There shoud be at least one parameter";
  else
    echo "Parameter should be only one";
fi