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
((COUNT+=1))

GAME() {
  if [[ ! $GUESSED_NUMBER =~ '^[0-9]+$' ]]
  then
    echo -e "That is not an integer, guess again:"
    read GUESSED_NUMBER
    
  else
    if (( $SECRET_NUMBER > $GUESSED_NUMBER ))
    then
      echo -e "It's lower than that, guess again:"
      read GUESSED_NUMBER
      ((COUNT+=1))
    elif (( $SECRET_NUMBER < $GUESSED_NUMBER ))
      echo -e "It's higher than that, guess again:"
      read GUESSED_NUMBER
      ((COUNT+=1))
    else
      echo -e "You guessed it in $COUNT tries. The secret number was $SECRET_NUMBER. Nice job!"
    fi
  fi
}

while (( ! $SECRET_NUMBER = $GUESSED_NUMBER ))
do
  GAME
done