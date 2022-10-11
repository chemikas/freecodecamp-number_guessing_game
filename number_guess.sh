#! /bin/bash
PSQL="psql -X --username=freecodecamp --dbname=postgres -t --no-align -c"

echo -e "\nEnter your username:"
read NAME

# get name id
NAME_ID=$($PSQL "SELECT id FROM users WHERE name='$NAME'")

if [[ -z $NAME_ID ]]
then
  echo -e "Welcome, $NAME! It looks like this is your first time here."
  PSQL "insert into users(name) values ('$NAME');"
  #echo -e PSQL "insert into users(name) values ('$NAME');"
else
  # get games played
  GAMES_PLAYED=$($PSQL "select COUNT(guessed) from games where id=$NAME_ID;")
  BEST_GUESS=$($PSQL "select MIN(guessed) from games where id=$NAME_ID;")
  echo -e "Welcome back, $NAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GUESS guesses."
fi

SECRET_NUMBER=$(( $RANDOM % 1000 + 1 ))
COUNT=0

echo -e "Guess the secret number between 1 and 1000:"
read GUESSED_NUMBER

GAME() {
  if (( $SECRET_NUMBER > $GUESSED_NUMBER ))
  then
  echo -e "It's lower than that, guess again:"
  else
  echo -e "It's higher than that, guess again:"
  fi
}

GAME