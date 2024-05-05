--Add new users:
INSERT INTO "users" ("user_id", "first_name", "last_name", "age", "weight", "height")
VALUES
    (1, 'John', 'Doe', 30, 75.5, 180),
    (2, 'Jane', 'Smith', 25, 65.2, 165),
    (3, 'Michael', 'Johnson', 40, 85.0, 175);

--Add new goals:
INSERT INTO "goals" ("goal_id", "goal_name")
VALUES
    (1, 'Weight Loss'),
    (2, 'Muscle Gain'),
    (3, 'Fitness Maintenance');

--Add new workouts:
INSERT INTO "workouts"("workout_id", "workout_name", "start_time", "end_time", "calories_burned", "user_id")
VALUES
    (1, 'Cardio Session', '2024-03-31 09:00:00', '2024-03-31 10:00:00', 300, 1),
    (2, 'Weightlifting', '2024-03-31 15:00:00', '2024-03-31 16:00:00', 250, 2),
    (3, 'Yoga Class', '2024-03-31 18:00:00', '2024-03-31 19:00:00', 150, 3);

--Add new meals:
INSERT INTO "meals" ("meal_id", "meal_name", "calories_consumed", "user_id")
VALUES
    (1, 'Breakfast', 500, 1),
    (2, 'Lunch', 700, 2),
    (3, 'Dinner', 600, 3);

--Add new progress records:
INSERT INTO "progress" ("progress_id", "date", "weight", "user_id")
VALUES
    (1, '2024-03-01', 70.2, 1),
    (2, '2024-03-01', 63.5, 2),
    (3, '2024-03-01', 80.0, 3);

--Add new exercises:
INSERT INTO "exercises"("exercise_id", "exercise_name", "muscle_group", "weight_used", "duration_minutes")
VALUES
    (1, 'Treadmill Run', 'Cardio', 20, 30),
    (2, 'Bench Press', 'Chest', 50, 45),
    (3, 'Yoga Stretching', 'Flexibility', 40, 60);

--Add new records into "workout_exercise" table:
INSERT INTO "workout_exercise" ("id", "workout_id", "exercise_id")
VALUES
    (1, 1, 1),
    (2, 2, 2),
    (3, 3, 3);

--Add new records into "user_goal" table:
INSERT INTO "user_goal" ("user_id", "goal_id")
VALUES
    (1, 1),
    (2, 2),
    (3, 3);

--List all users:
SELECT * FROM "users";

--List all workouts for a specific user:
SELECT * FROM "workouts" WHERE "user_id" =1 ;

--List all meals for a specific user:
SELECT * FROM "meals" WHERE "user_id" =1;

--List all goals for a specific user:
SELECT * FROM "user_goals_view" WHERE "user_id"=1;

--retrieve progress for a specific user:
SELECT * FROM "progress" WHERE "user_id" =1;

--List exercises for a specific workout:
SELECT "exercise_id","exercise_name"
FROM "workout_exercises_view" WHERE "workout_id"=1;

--List workouts for a specific exercise:
SELECT "workout_id","workout_name","start_time","end_time","calories_burned"
FROM "workout_exercises_view" WHERE "exercise_id"=1;

--List all workouts that burned more than a specified number of calories:
SELECT * FROM "workouts"
WHERE "calories_burned" > 200;

--Get workout statistics for users:
SELECT * FROM "user_workouts_stats";

--Get meal statistics for users:
SELECT * FROM "user_meals_stats";

--Get progress statistics for users:
SELECT * FROM "user_progress_stats";

--Calculate average calories burned for each user:
SELECT "first_name","last_name", AVG("calories_burned") AS "avg_calories_burned"
FROM "user_workouts_view"
GROUP BY "user_id";

--Count the number of workouts for each user:
SELECT "first_name","last_name", COUNT("workout_id") AS 'workout_count'
FROM "user_workouts_view"
GROUP BY "user_id";

--Calculate the total number of exercises per workout for a specific user:
SELECT "workouts"."workout_id", "workouts"."workout_name", COUNT("workout_exercise"."exercise_id") AS 'exercise_count'
FROM "workouts"
JOIN "workout_exercise" ON "workouts"."workout_id" = "workout_exercise"."workout_id"
WHERE "workouts"."user_id" = 1
GROUP BY "workouts"."workout_id";

--Update user information:
UPDATE "users"
SET "age" = 31, "weight" = 76.0, "height" = 181
WHERE "user_id" = 1;

--Update workout details:
UPDATE "workouts"
SET "calories_burned" = 320, "start_time" = '2024-04-01 09:30:00', "end_time" = '2024-04-01 10:30:00'
WHERE "workout_id" = 1;

--Delete a specific workout record:
DELETE FROM "workouts"
WHERE "workout_id" = 2;

--Delete a specific meal record:
DELETE FROM "meals"
WHERE "meal_id" = 2;

--Delete a specific user record:
DELETE FROM "users"
WHERE "user_id" = 3;

--Delete a specific exercise record:
DELETE FROM "exercises"
WHERE "exercise_id" = 3;






















