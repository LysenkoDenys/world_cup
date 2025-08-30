# 🏆 World Cup Database Project

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![PostgreSQL](https://img.shields.io/badge/Database-PostgreSQL-blue)](https://www.postgresql.org/)

## 🚀 Overview

This project is a **PostgreSQL database** that stores and queries data about the **FIFA World Cup**.  
It models teams, games, and results across different tournaments.  
Built as a practice exercise in **database design, Bash scripting, and SQL queries**.

## 🗂️ Database Structure

The database contains **two main tables**:

1. **teams** – Stores information about each football team.
2. **games** – Stores all World Cup matches, linked to the teams.

### 🔗 Relationships

- **Team → Game**:  
  Each game has a **winner** and an **opponent**, both referencing the `teams` table.

### 🖼️ Visualization

```text
teams
------
team_id (PK)
name

games
------
game_id (PK)
year
round
winner_id (FK → teams.team_id)
opponent_id (FK → teams.team_id)
winner_goals
opponent_goals

```

## ⚙️ Installation

Clone the repository:

git clone https://github.com/LysenkoDenys/world_cup
cd worldcup-db


Create and import the database:

psql -U freecodecamp -d worldcup -f worldcup.sql

Run the data import script (from games.csv):

./insert_data.sh

## 🛒 Usage

Once imported, you can explore the data:

-- List all teams
SELECT * FROM teams;

-- Get all games from 2018 Final
SELECT g.year, g.round, t1.name AS winner, t2.name AS opponent
FROM games g
JOIN teams t1 ON g.winner_id = t1.team_id
JOIN teams t2 ON g.opponent_id = t2.team_id
WHERE g.year = 2018 AND g.round = 'Final';


Or run the query script:

./queries.sh

This script outputs answers like:
Total number of goals
Average goals per game
Winner of the 2018 World Cup
Teams that reached the quarter-finals in 2014, etc.

## 🗂️ Files

worldcup.sql – Schema and initial database structure

games.csv – Raw data for World Cup matches

insert_data.sh – Bash script to insert data into the database

queries.sh – Bash script with analytical queries

README.md – Project documentation

## 🧻 License

This project is released under the MIT License.