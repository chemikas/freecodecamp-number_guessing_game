#! /bin/bash
PSQL="psql --username=freecodecamp --dbname=postgres -t --no-align -c"

echo -e "\nEnter your username:"
read NAME

# get name id
NAME_ID=$($PSQL "SELECT id FROM users WHERE name='$NAME'")

if [[ -z $NAME_ID ]]
then
  echo -e "Welcome, $NAME! It looks like this is your first time here."
  PSQL "insert into users(name) values($NAME);"
else
  # get games played
  GAMES_PLAYED=$($PSQL "COUNT(guessed) from games where id=$NAME_ID")
  BEST_GUESS=$($PSQL "MIN(guessed) from games where id=$NAME_ID")
  echo -e "Welcome back, $NAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GUESS guesses."
fi

echo $(( $RANDOM % 1000 + 1 ))
