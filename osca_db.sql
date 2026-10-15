-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 15, 2026 at 01:18 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `osca_db`
--
CREATE DATABASE IF NOT EXISTS `osca_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `osca_db`;

-- --------------------------------------------------------

--
-- Table structure for table `api_tokens`
--

DROP TABLE IF EXISTS `api_tokens`;
CREATE TABLE `api_tokens` (
  `token_hash` char(64) NOT NULL,
  `user_id` int(11) NOT NULL,
  `expires_at` datetime NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_used_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `api_tokens`
--

INSERT INTO `api_tokens` (`token_hash`, `user_id`, `expires_at`, `created_at`, `last_used_at`) VALUES
('4e0949e3474a26a0402a361a952e4cf1574856acd33d628a928784f72a42253e', 4, '2026-11-12 07:25:08', '2026-10-12 23:25:08', '2026-10-13 07:25:18'),
('9eb32f147fc0fe0603e2cc8d28b8b33874c25c78add65c445ecdf812b7d0a091', 5, '2026-11-13 13:24:22', '2026-10-14 05:24:22', '2026-10-14 13:24:29');

-- --------------------------------------------------------

--
-- Table structure for table `coordinator_schedules`
--

DROP TABLE IF EXISTS `coordinator_schedules`;
CREATE TABLE `coordinator_schedules` (
  `id` int(11) NOT NULL,
  `group_type` enum('Sport','Dance Troupe') NOT NULL,
  `group_name` varchar(100) NOT NULL,
  `practice_date` date NOT NULL,
  `practice_time` time NOT NULL,
  `location` varchar(150) NOT NULL,
  `status` enum('upcoming','cancelled') NOT NULL DEFAULT 'upcoming',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `coordinator_schedules`
--

INSERT INTO `coordinator_schedules` (`id`, `group_type`, `group_name`, `practice_date`, `practice_time`, `location`, `status`, `created_at`) VALUES
(1, 'Sport', 'Basketball', '2026-10-16', '06:33:00', 'School ground', 'upcoming', '2026-10-14 05:29:31');

-- --------------------------------------------------------

--
-- Table structure for table `coordinator_sports`
--

DROP TABLE IF EXISTS `coordinator_sports`;
CREATE TABLE `coordinator_sports` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `coordinator_sports`
--

INSERT INTO `coordinator_sports` (`id`, `name`) VALUES
(1, 'Basketball');

-- --------------------------------------------------------

--
-- Table structure for table `coordinator_students`
--

DROP TABLE IF EXISTS `coordinator_students`;
CREATE TABLE `coordinator_students` (
  `id` int(11) NOT NULL,
  `student_id` varchar(50) NOT NULL,
  `full_name` varchar(180) NOT NULL,
  `course` varchar(120) NOT NULL DEFAULT '',
  `year_level` varchar(30) NOT NULL DEFAULT '',
  `enrollment_year` varchar(10) NOT NULL DEFAULT '',
  `jersey_number` varchar(20) NOT NULL DEFAULT '',
  `sport_id` int(11) DEFAULT NULL,
  `dance_member` tinyint(1) NOT NULL DEFAULT 0,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `profile_image` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
CREATE TABLE `courses` (
  `id` int(11) NOT NULL,
  `title` varchar(55) NOT NULL,
  `created` datetime NOT NULL DEFAULT current_timestamp(),
  `modified` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `osca_achievements`
--

DROP TABLE IF EXISTS `osca_achievements`;
CREATE TABLE `osca_achievements` (
  `id` int(11) NOT NULL,
  `student_name` varchar(180) NOT NULL,
  `student_id` varchar(50) NOT NULL,
  `title` varchar(180) NOT NULL,
  `details` text NOT NULL,
  `achievement_date` date NOT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `osca_activity_feedback`
--

DROP TABLE IF EXISTS `osca_activity_feedback`;
CREATE TABLE `osca_activity_feedback` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `student_name` varchar(180) NOT NULL DEFAULT '',
  `student_id` varchar(50) NOT NULL DEFAULT '',
  `activity` varchar(180) NOT NULL,
  `rating` tinyint(3) UNSIGNED NOT NULL,
  `choice` varchar(180) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `osca_activity_feedback`
--

INSERT INTO `osca_activity_feedback` (`id`, `user_id`, `student_name`, `student_id`, `activity`, `rating`, `choice`, `created_at`) VALUES
(1, 5, 'John A. Quiambao', '1234567', 'Campus Intramurals 2026', 5, 'The schedule needs improvement', '2026-10-14 05:16:32');

-- --------------------------------------------------------

--
-- Table structure for table `osca_announcements`
--

DROP TABLE IF EXISTS `osca_announcements`;
CREATE TABLE `osca_announcements` (
  `id` int(11) NOT NULL,
  `title` varchar(180) NOT NULL,
  `message` text NOT NULL,
  `audience` enum('All Members','Student-Athletes','Performers') NOT NULL DEFAULT 'All Members',
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `osca_announcements`
--

INSERT INTO `osca_announcements` (`id`, `title`, `message`, `audience`, `created_by`, `created_at`) VALUES
(1, 'Morning Announcement', 'Good Morning Guyss', 'All Members', 4, '2026-10-13 23:54:30');

-- --------------------------------------------------------

--
-- Table structure for table `osca_student_concerns`
--

DROP TABLE IF EXISTS `osca_student_concerns`;
CREATE TABLE `osca_student_concerns` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `student_name` varchar(180) NOT NULL DEFAULT '',
  `student_id` varchar(50) NOT NULL DEFAULT '',
  `title` varchar(180) NOT NULL,
  `category` enum('Activity Record','Membership','Activity Schedule','Other') NOT NULL,
  `details` text NOT NULL,
  `status` enum('Open','In Progress','Resolved') NOT NULL DEFAULT 'Open',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `schedules`
--

DROP TABLE IF EXISTS `schedules`;
CREATE TABLE `schedules` (
  `id` int(11) NOT NULL,
  `group_name` varchar(100) NOT NULL,
  `day_of_week` enum('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday') NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `venue` varchar(100) NOT NULL,
  `remarks` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
CREATE TABLE `students` (
  `id` int(11) NOT NULL,
  `student_id` varchar(50) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `main_category` enum('Sports','Dance','Singing') NOT NULL,
  `sub_category` varchar(50) NOT NULL,
  `jersey_number` varchar(10) DEFAULT NULL,
  `course` varchar(50) NOT NULL,
  `year_level` int(11) NOT NULL,
  `photo` varchar(255) DEFAULT 'default.png',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','student','teacher') NOT NULL DEFAULT 'student',
  `otp_code` varchar(20) DEFAULT NULL,
  `otp_expiry` datetime DEFAULT NULL,
  `status` enum('pending','verified','banned') NOT NULL DEFAULT 'pending',
  `profile_completed` tinyint(1) NOT NULL DEFAULT 0,
  `first_name` varchar(100) DEFAULT NULL,
  `middle_initial` varchar(20) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `suffix` varchar(20) DEFAULT NULL,
  `full_name` varchar(200) DEFAULT NULL,
  `student_id` varchar(50) DEFAULT NULL,
  `teacher_id` varchar(50) DEFAULT NULL,
  `year_level` varchar(30) DEFAULT NULL,
  `section` varchar(100) DEFAULT NULL,
  `academic_role` varchar(50) DEFAULT NULL,
  `teacher_approval_status` enum('pending','approved','declined') DEFAULT NULL,
  `teacher_approved_at` datetime DEFAULT NULL,
  `teacher_declined_at` datetime DEFAULT NULL,
  `profile_image` varchar(255) NOT NULL DEFAULT 'default.png',
  `password_reset_pending` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `username`, `password`, `role`, `otp_code`, `otp_expiry`, `status`, `profile_completed`, `first_name`, `middle_initial`, `last_name`, `suffix`, `full_name`, `student_id`, `teacher_id`, `year_level`, `section`, `academic_role`, `teacher_approval_status`, `teacher_approved_at`, `teacher_declined_at`, `profile_image`, `password_reset_pending`, `created_at`) VALUES
(1, 'admin@osca.local', 'admin', '$2y$12$X37SYBhYTdTZwXJJKNufmuipNTrj0g6KqIXRxIoYI7w.fY/qvskOe', 'admin', NULL, NULL, 'verified', 1, 'Admin', NULL, 'Account', NULL, 'Admin Account', NULL, NULL, NULL, NULL, 'Administrator', NULL, NULL, NULL, 'default.png', 0, '2026-09-10 14:49:21'),
(4, 'https.jaq@gmail.com', 'JAQ', '$2y$10$W0MlWfp/IEMy8.cEUjt28eofFM7OK15IuDbOV48qxvMV2PvOXCFkS', 'teacher', NULL, NULL, 'verified', 1, 'Drei', 'A', 'Lotus', '', 'Drei A. Lotus', NULL, '24100735', NULL, NULL, 'Coordinator', 'approved', '2026-10-13 00:26:52', NULL, 'default.png', 0, '2026-10-12 16:24:52'),
(5, 'vermillionnash@gmail.com', 'dreiiii', '$2y$10$zYwYBgMo7K/e8xxc1asHlOCSuUuZiqLq18wKsfssi.eJj/IPMIa5O', 'student', NULL, NULL, 'verified', 1, 'John', 'A', 'Quiambao', '', 'John A. Quiambao', '1234567', NULL, '1st Year', 'B', 'Student', NULL, NULL, NULL, 'default.png', 0, '2026-10-14 05:12:39');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `api_tokens`
--
ALTER TABLE `api_tokens`
  ADD PRIMARY KEY (`token_hash`),
  ADD KEY `idx_api_tokens_user_id` (`user_id`),
  ADD KEY `idx_api_tokens_expires_at` (`expires_at`);

--
-- Indexes for table `coordinator_schedules`
--
ALTER TABLE `coordinator_schedules`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `coordinator_sports`
--
ALTER TABLE `coordinator_sports`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `coordinator_students`
--
ALTER TABLE `coordinator_students`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `student_id` (`student_id`),
  ADD KEY `fk_coordinator_students_creator` (`created_by`);

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `title` (`title`);

--
-- Indexes for table `osca_achievements`
--
ALTER TABLE `osca_achievements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_osca_achievements_student_id` (`student_id`),
  ADD KEY `idx_osca_achievements_date` (`achievement_date`),
  ADD KEY `fk_osca_achievements_creator` (`created_by`);

--
-- Indexes for table `osca_activity_feedback`
--
ALTER TABLE `osca_activity_feedback`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_osca_feedback_user_id` (`user_id`),
  ADD KEY `idx_osca_feedback_student_id` (`student_id`);

--
-- Indexes for table `osca_announcements`
--
ALTER TABLE `osca_announcements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_osca_announcements_created_at` (`created_at`),
  ADD KEY `fk_osca_announcements_creator` (`created_by`);

--
-- Indexes for table `osca_student_concerns`
--
ALTER TABLE `osca_student_concerns`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_osca_concerns_user_id` (`user_id`),
  ADD KEY `idx_osca_concerns_student_id` (`student_id`),
  ADD KEY `idx_osca_concerns_status` (`status`);

--
-- Indexes for table `schedules`
--
ALTER TABLE `schedules`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `uq_users_email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `coordinator_schedules`
--
ALTER TABLE `coordinator_schedules`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `coordinator_sports`
--
ALTER TABLE `coordinator_sports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `coordinator_students`
--
ALTER TABLE `coordinator_students`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `osca_achievements`
--
ALTER TABLE `osca_achievements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `osca_activity_feedback`
--
ALTER TABLE `osca_activity_feedback`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `osca_announcements`
--
ALTER TABLE `osca_announcements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `osca_student_concerns`
--
ALTER TABLE `osca_student_concerns`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `schedules`
--
ALTER TABLE `schedules`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `api_tokens`
--
ALTER TABLE `api_tokens`
  ADD CONSTRAINT `fk_api_tokens_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `coordinator_students`
--
ALTER TABLE `coordinator_students`
  ADD CONSTRAINT `fk_coordinator_students_creator` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `osca_achievements`
--
ALTER TABLE `osca_achievements`
  ADD CONSTRAINT `fk_osca_achievements_creator` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `osca_activity_feedback`
--
ALTER TABLE `osca_activity_feedback`
  ADD CONSTRAINT `fk_osca_feedback_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `osca_announcements`
--
ALTER TABLE `osca_announcements`
  ADD CONSTRAINT `fk_osca_announcements_creator` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `osca_student_concerns`
--
ALTER TABLE `osca_student_concerns`
  ADD CONSTRAINT `fk_osca_concerns_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
