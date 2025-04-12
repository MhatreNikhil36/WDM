-- init.sql
-- MySQL Script generated by MySQL Workbench
-- Sat Apr 12 16:02:39 2025
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

-- init.sql
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema fitness_tracker
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `fitness_tracker` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `fitness_tracker`;

-- Create a dedicated user for your backend with consistent password
CREATE USER IF NOT EXISTS 'ft_appuser'@'%' IDENTIFIED BY 'StrongPassword123!';
GRANT ALL PRIVILEGES ON fitness_tracker.* TO 'ft_appuser'@'%';
FLUSH PRIVILEGES;

-- -----------------------------------------------------
-- Table `fitness_tracker`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_tracker`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `password_hash` VARCHAR(255) NOT NULL,
  `date_of_birth` DATE NULL DEFAULT NULL,
  `gender` ENUM('male', 'female', 'other') NULL DEFAULT NULL,
  `height_cm` DECIMAL(5,2) NULL DEFAULT NULL,
  `weight_kg` DECIMAL(5,2) NULL DEFAULT NULL,
  `is_admin` TINYINT(1) NULL DEFAULT '0',
  `is_active` TINYINT(1) NULL DEFAULT '1',
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `country` VARCHAR(100) NULL DEFAULT NULL,
  `city` VARCHAR(100) NULL DEFAULT NULL,
  `state` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email` (`email` ASC) VISIBLE,
  INDEX `idx_user_email` (`email` ASC) VISIBLE
)
ENGINE = InnoDB
AUTO_INCREMENT = 18
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `fitness_tracker`.`activities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_tracker`.`activities` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `activity_type` VARCHAR(50) NOT NULL,
  `duration` INT NOT NULL,
  `intensity` ENUM('low', 'medium', 'high') NULL DEFAULT NULL,
  `calories_burned` INT NULL DEFAULT NULL,
  `date` DATE NOT NULL,
  `notes` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_activities_user_date` (`user_id` ASC, `date` ASC) VISIBLE,
  CONSTRAINT `activities_ibfk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `fitness_tracker`.`users` (`id`)
    ON DELETE CASCADE
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `fitness_tracker`.`aiprompts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_tracker`.`aiprompts` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `prompt_type` VARCHAR(50) NOT NULL,
  `prompt_template` TEXT NOT NULL,
  `variables` JSON NULL DEFAULT NULL,
  `is_active` TINYINT(1) NULL DEFAULT '1',
  `created_by` INT NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `created_by` (`created_by` ASC) VISIBLE,
  CONSTRAINT `aiprompts_ibfk_1`
    FOREIGN KEY (`created_by`)
    REFERENCES `fitness_tracker`.`users` (`id`)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `fitness_tracker`.`workouttemplates`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_tracker`.`workouttemplates` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `difficulty_level` ENUM('beginner', 'intermediate', 'advanced') NULL DEFAULT NULL,
  `estimated_duration` INT NULL DEFAULT NULL,
  `equipment_needed` JSON NULL DEFAULT NULL,
  `created_by` INT NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `created_by` (`created_by` ASC) VISIBLE,
  CONSTRAINT `workouttemplates_ibfk_1`
    FOREIGN KEY (`created_by`)
    REFERENCES `fitness_tracker`.`users` (`id`)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `fitness_tracker`.`completedworkouts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_tracker`.`completedworkouts` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `template_id` INT NULL DEFAULT NULL,
  `workout_date` DATE NOT NULL,
  `duration` INT NULL DEFAULT NULL,
  `calories_burned` INT NULL DEFAULT NULL,
  `notes` TEXT NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `template_id` (`template_id` ASC) VISIBLE,
  INDEX `idx_completed_workouts_user` (`user_id` ASC) VISIBLE,
  CONSTRAINT `completedworkouts_ibfk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `fitness_tracker`.`users` (`id`)
    ON DELETE CASCADE,
  CONSTRAINT `completedworkouts_ibfk_2`
    FOREIGN KEY (`template_id`)
    REFERENCES `fitness_tracker`.`workouttemplates` (`id`)
    ON DELETE SET NULL
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `fitness_tracker`.`exercisecategories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_tracker`.`exercisecategories` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `created_by` INT NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `created_by` (`created_by` ASC) VISIBLE,
  CONSTRAINT `exercisecategories_ibfk_1`
    FOREIGN KEY (`created_by`)
    REFERENCES `fitness_tracker`.`users` (`id`)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `fitness_tracker`.`exercises`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_tracker`.`exercises` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `category_id` INT NOT NULL,
  `difficulty_level` ENUM('beginner', 'intermediate', 'advanced') NULL DEFAULT NULL,
  `muscle_groups` JSON NULL DEFAULT NULL,
  `equipment_needed` JSON NULL DEFAULT NULL,
  `instructions` TEXT NULL DEFAULT NULL,
  `video_url` VARCHAR(255) NULL DEFAULT NULL,
  `image_url` VARCHAR(255) NULL DEFAULT NULL,
  `created_by` INT NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `category_id` (`category_id` ASC) VISIBLE,
  INDEX `created_by` (`created_by` ASC) VISIBLE,
  CONSTRAINT `exercises_ibfk_1`
    FOREIGN KEY (`category_id`)
    REFERENCES `fitness_tracker`.`exercisecategories` (`id`),
  CONSTRAINT `exercises_ibfk_2`
    FOREIGN KEY (`created_by`)
    REFERENCES `fitness_tracker`.`users` (`id`)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `fitness_tracker`.`completedworkoutexercises`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_tracker`.`completedworkoutexercises` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `completed_workout_id` INT NOT NULL,
  `exercise_id` INT NOT NULL,
  `sets_completed` INT NULL DEFAULT NULL,
  `reps_completed` INT NULL DEFAULT NULL,
  `weight_used` DECIMAL(5,2) NULL DEFAULT NULL,
  `notes` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `completed_workout_id` (`completed_workout_id` ASC) VISIBLE,
  INDEX `exercise_id` (`exercise_id` ASC) VISIBLE,
  CONSTRAINT `completedworkoutexercises_ibfk_1`
    FOREIGN KEY (`completed_workout_id`)
    REFERENCES `fitness_tracker`.`completedworkouts` (`id`)
    ON DELETE CASCADE,
  CONSTRAINT `completedworkoutexercises_ibfk_2`
    FOREIGN KEY (`exercise_id`)
    REFERENCES `fitness_tracker`.`exercises` (`id`)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `fitness_tracker`.`goals`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_tracker`.`goals` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `goal_type` ENUM('lose_weight', 'gain_muscle', 'add_weight', 'custom') NOT NULL,
  `target_value` DECIMAL(5,2) NULL DEFAULT NULL,
  `current_value` DECIMAL(5,2) NULL DEFAULT NULL,
  `status` ENUM('in_progress', 'completed', 'abandoned') NULL DEFAULT 'in_progress',
  `deadline` DATE NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `idx_goals_user` (`user_id` ASC) VISIBLE,
  CONSTRAINT `goals_ibfk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `fitness_tracker`.`users` (`id`)
    ON DELETE CASCADE
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `fitness_tracker`.`healthmetrics`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_tracker`.`healthmetrics` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `weight_kg` DECIMAL(5,2) NULL DEFAULT NULL,
  `body_fat_percentage` DECIMAL(5,2) NULL DEFAULT NULL,
  `muscle_mass_kg` DECIMAL(5,2) NULL DEFAULT NULL,
  `height_cm` DECIMAL(5,2) NULL DEFAULT NULL,
  `recorded_date` DATE NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `user_id` (`user_id` ASC) VISIBLE,
  CONSTRAINT `healthmetrics_ibfk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `fitness_tracker`.`users` (`id`)
    ON DELETE CASCADE
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `fitness_tracker`.`nutrition`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_tracker`.`nutrition` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `date` DATE NOT NULL,
  `meal_type` VARCHAR(50) NULL DEFAULT NULL,
  `calories` INT NULL DEFAULT NULL,
  `protein` DECIMAL(5,2) NULL DEFAULT NULL,
  `carbs` DECIMAL(5,2) NULL DEFAULT NULL,
  `fats` DECIMAL(5,2) NULL DEFAULT NULL,
  `notes` TEXT NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `idx_nutrition_user_date` (`user_id` ASC, `date` ASC) VISIBLE,
  CONSTRAINT `nutrition_ibfk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `fitness_tracker`.`users` (`id`)
    ON DELETE CASCADE
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `fitness_tracker`.`progress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_tracker`.`progress` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `goal_id` INT NULL DEFAULT NULL,
  `recorded_value` DECIMAL(5,2) NOT NULL,
  `measurement_type` VARCHAR(50) NOT NULL,
  `recorded_date` DATE NOT NULL,
  `notes` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `goal_id` (`goal_id` ASC) VISIBLE,
  INDEX `idx_progress_user` (`user_id` ASC) VISIBLE,
  CONSTRAINT `progress_ibfk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `fitness_tracker`.`users` (`id`)
    ON DELETE CASCADE,
  CONSTRAINT `progress_ibfk_2`
    FOREIGN KEY (`goal_id`)
    REFERENCES `fitness_tracker`.`goals` (`id`)
    ON DELETE SET NULL
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `fitness_tracker`.`usercredentials`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_tracker`.`usercredentials` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `provider` VARCHAR(50) NOT NULL,
  `provider_user_id` VARCHAR(255) NOT NULL,
  `access_token` TEXT NULL DEFAULT NULL,
  `refresh_token` TEXT NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `unique_provider_user` (`provider` ASC, `provider_user_id` ASC) VISIBLE,
  INDEX `user_id` (`user_id` ASC) VISIBLE,
  CONSTRAINT `usercredentials_ibfk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `fitness_tracker`.`users` (`id`)
    ON DELETE CASCADE
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `fitness_tracker`.`usersettings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_tracker`.`usersettings` (
  `user_id` INT NOT NULL,
  `notification_preferences` JSON NULL DEFAULT NULL,
  `privacy_settings` JSON NULL DEFAULT NULL,
  `theme_preferences` JSON NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `usersettings_ibfk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `fitness_tracker`.`users` (`id`)
    ON DELETE CASCADE
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `fitness_tracker`.`workouttemplateexercises`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_tracker`.`workouttemplateexercises` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `template_id` INT NOT NULL,
  `exercise_id` INT NOT NULL,
  `sets` INT NOT NULL,
  `reps` INT NOT NULL,
  `rest_time` INT NULL DEFAULT NULL,
  `sequence_order` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `template_id` (`template_id` ASC) VISIBLE,
  INDEX `exercise_id` (`exercise_id` ASC) VISIBLE,
  CONSTRAINT `workouttemplateexercises_ibfk_1`
    FOREIGN KEY (`template_id`)
    REFERENCES `fitness_tracker`.`workouttemplates` (`id`)
    ON DELETE CASCADE,
  CONSTRAINT `workouttemplateexercises_ibfk_2`
    FOREIGN KEY (`exercise_id`)
    REFERENCES `fitness_tracker`.`exercises` (`id`)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
