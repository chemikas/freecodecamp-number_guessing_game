#! /bin/bash

echo -e "\nEnter your username:"
read NAME

echo -e "Welcome back, $NAME! You have played <games_played> games, and your best game took <best_game> guesses."

echo $(( $RANDOM % 1000 + 1 ))