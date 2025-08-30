#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

# Clear existing data (good for testing)
$PSQL "TRUNCATE TABLE games, teams RESTART IDENTITY;"

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != "year" ]]  # Skip header line
  then
    # get team_id
        # check winner
        INSERT_WINNER_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER') ON CONFLICT (name) DO NOTHING;")
        if [[ $INSERT_WINNER_RESULT == "INSERT 0 1" ]]
        then
          echo "Inserted team: $WINNER"
        fi
        # check opponent
        INSERT_OPPONENT_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT') ON CONFLICT (name) DO NOTHING;")
        if [[ $INSERT_OPPONENT_RESULT == "INSERT 0 1" ]]
        then
          echo "Inserted team: $OPPONENT"
        fi
        # fill the games table
        WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'" | xargs)
        OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'" | xargs)
        # insert game row
        INSERT_GAME=$($PSQL "INSERT INTO games(year,round,winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS )")
  fi

done


