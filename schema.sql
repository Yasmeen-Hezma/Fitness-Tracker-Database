-- Represent users of the Fitness Tracker
CREATE TABLE "users" (
    "user_id" INT,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "age" INT NOT NULL CHECK("age">0),
    "weight" REAL NOT NULL CHECK("weight">0),
    "height" REAL NOT NULL CHECK("height">0),
    PRIMARY KEY("user_id")
);

-- Represent goals of the users
CREATE TABLE "goals"(
    "goal_id" INT,
    "goal_name" TEXT NOT NULL,
    PRIMARY KEY("goal_id")
);

-- Represent workouts of the users
CREATE TABLE "workouts"(
    "workout_id" INT,
    "workout_name" TEXT NOT NULL,
    "start_time" TEXT NOT NULL,
    "end_time" TEXT NOT NULL,
    "calories_burned" REAL NOT NULL CHECK("calories_burned">0),
    "user_id" INT NOT NULL,
    PRIMARY KEY("workout_id"),
    FOREIGN KEY("user_id") REFERENCES "users"("user_id") ON DELETE CASCADE
);

-- Represent meals of the users
CREATE TABLE "meals"(
    "meal_id" INT,
    "meal_name" TEXT NOT NULL,
    "calories_consumed" REAL NOT NULL CHECK("calories_consumed">0),
    "user_id" INT NOT NULL,
    PRIMARY KEY("meal_id"),
    FOREIGN KEY("user_id") REFERENCES "users"("user_id") ON DELETE CASCADE
);

-- Represent progress of the users
CREATE TABLE "progress"(
    "progress_id" INT,
    "date" TEXT  NOT NULL,
    "weight" REAL  NOT NULL CHECK("weight">0),
    "user_id" INT  NOT NULL,
    PRIMARY KEY("progress_id"),
    FOREIGN KEY("user_id") REFERENCES "users"("user_id") ON DELETE CASCADE
);

-- Represent exercises of the users
CREATE TABLE "exercises"(
    "exercise_id" INT,
    "exercise_name" TEXT NOT NULL,
    "muscle_group" TEXT NOT NULL,
    "weight_used" REAL NOT NULL CHECK("weight_used">0),
    "duration_minutes" INT NOT NULL CHECK("duration_minutes">0),
    PRIMARY KEY("exercise_id")
);

-- Represent relation between workouts & exercises
CREATE TABLE "workout_exercise" (
    "id" INT,
    "workout_id" INT,
    "exercise_id" INT,
    PRIMARY KEY ("id"),
    FOREIGN KEY ("workout_id") REFERENCES "workouts"("workout_id") ON DELETE CASCADE,
    FOREIGN KEY ("exercise_id") REFERENCES "exercises"("exercise_id") ON DELETE CASCADE
);

-- Represent relation between users & goals
CREATE TABLE "user_goal" (
    "user_id" INT,
    "goal_id" INT,
    PRIMARY KEY ("user_id", "goal_id"),
    FOREIGN KEY ("user_id") REFERENCES "users"("user_id") ON DELETE CASCADE,
    FOREIGN KEY ("goal_id") REFERENCES "goals"("goal_id") ON DELETE CASCADE
);

-- Create indexes to speed common searches
CREATE INDEX "user_name_search" ON "users"("first_name", "last_name");
CREATE INDEX "workout_name_search" ON "workouts"("workout_name");
CREATE INDEX "exercise_name_search" ON "exercises"("exercise_name");

-- create view for users & workouts relation
CREATE VIEW "user_workouts_view" AS
SELECT "users"."user_id","users"."first_name","users"."last_name",
"workouts"."workout_id","workouts"."workout_name","workouts"."start_time",
"workouts"."end_time","workouts"."calories_burned"
FROM "users"
JOIN "workouts"
ON "users"."user_id"="workouts"."user_id";

-- create view for exercises & workouts relation
CREATE VIEW "workout_exercises_view" AS
SELECT "exercises"."exercise_id","exercises"."exercise_name","workouts"."workout_id",
"workouts"."workout_name","workouts"."start_time",
"workouts"."end_time","workouts"."calories_burned"
FROM "exercises","workouts","workout_exercise"
WHERE "exercises"."exercise_id"="workout_exercise"."exercise_id"
AND "workouts"."workout_id"="workout_exercise"."workout_id";

-- create view for users & meals relation
CREATE VIEW "user_meals_view" AS
SELECT "users"."user_id","users"."first_name","users"."last_name",
"meals"."meal_id","meals"."meal_name","meals"."meal_name","meals"."calories_consumed"
FROM "users"
JOIN "meals"
ON "users"."user_id"="meals"."user_id";

-- create view for users & goals relation
CREATE VIEW "user_goals_view" AS
SELECT "users"."user_id","users"."first_name","users"."last_name","goals"."goal_id","goals"."goal_name"
FROM "users","goals","user_goal"
WHERE "users"."user_id"="user_goal"."user_id"
AND "goals"."goal_id"="user_goal"."goal_id";

-- create view for users & progress relation
CREATE VIEW "user_progress_view" AS
SELECT "users"."user_id","users"."first_name","users"."last_name",
"progress"."progress_id","progress"."date","progress"."weight"
FROM "users" JOIN "progress"
ON "users"."user_id"="progress"."user_id";

-- create view for users & workouts statistics
CREATE VIEW "user_workouts_stats" AS
SELECT "user_id","first_name","last_name",
COUNT("workout_id") AS "total_workouts",
SUM("calories_burned") AS "total_calories_burned"
FROM "user_workouts_view"
GROUP BY "user_id";

-- create view for users & meals statistics
CREATE VIEW "user_meals_stats" AS
SELECT "user_id","first_name","last_name",
COUNT("meal_id") AS "total_meals",
SUM("calories_consumed") AS "total_calories_consumed"
FROM "user_meals_view"
GROUP BY "user_id";

-- create view for users & progress statistics
CREATE VIEW "user_progress_stats" AS
SELECT "user_id","first_name","last_name",
MIN("weight") AS "min_weight",
MAX("weight") AS "max_weight",
AVG("weight") AS "average_weight"
FROM "user_progress_view"
GROUP BY "user_id";




















