# Fitness Tracker Database

This repository contains the schema and SQL queries for a fitness tracker database designed to track users, their workouts, meals, goals, and progress.

## Entity-Relationship (ER) Diagram

![ER Diagram](https://github.com/Yasmeen-Hezma/fitness-tracker-db/blob/main/Fitness_Tracker_ERD.png)

## Description

The database consists of the following tables:
- `users`: Stores user information such as user_id, first name, last name, age, weight, and height.
- `goals`: Contains various fitness goals that users can set.
- `workouts`: Records details of each workout session including start time, end time, calories burned, and user_id.
- `meals`: Stores meal information such as meal_id, meal name, calories consumed, and user_id.
- `progress`: Tracks users' weight progress over time.
- `exercises`: Contains details of different exercises including exercise_id, exercise name, and muscle group.
- `workout_exercise`: Represents the relationship between workouts and exercises.
- `user_goal`: Represents the relationship between users and their goals.

## Usage

1. Clone the repository:`https://github.com/Yasmeen-Hezma/fitness-tracker-db.git`.

2. Import the schema (`schema.sql`) into your database management system.

3. Execute the SQL queries (`queries.sql`) to populate the database with sample data and perform various operations.



