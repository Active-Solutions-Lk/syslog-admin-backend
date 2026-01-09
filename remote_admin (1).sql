-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 30, 2025 at 11:45 AM
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
-- Database: `remote_admin`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` int(11) NOT NULL,
  `name` varchar(191) DEFAULT NULL,
  `email` varchar(191) NOT NULL,
  `passwordHash` varchar(191) DEFAULT NULL,
  `role` varchar(50) DEFAULT NULL,
  `status` double NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `name`, `email`, `passwordHash`, `role`, `status`, `createdAt`, `updatedAt`) VALUES
(1, 'John Admin', 'admin@example.com', '$2b$10$Y54Js8ETEgU/RdpNnupRBu7oTAhpzz4uz3z0k12qyjYEZgO83mGXS', 'Admin', 1, '2025-11-22 07:40:32.783', '2025-11-22 07:40:32.783'),
(2, 'Jane Manager', 'manager@example.com', '$2b$10$AX5QHfhumATB6zykF/NOs.l2GWFZ/2hMXShXUX/p5a4TwQvxyS5wu', 'Manager', 1, '2025-11-22 07:40:32.882', '2025-11-22 07:40:32.882'),
(3, 'Bob User', 'user@example.com', '$2b$10$o9Z/43lYR3fL6cSg4i1ArOw8mCeKMVP9LYAwZwfieAZ8Y3aPa3mYq', 'User', 1, '2025-11-22 07:40:32.988', '2025-11-22 07:40:32.988');

-- --------------------------------------------------------

--
-- Table structure for table `analyzers`
--

CREATE TABLE `analyzers` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `ip` varchar(50) NOT NULL,
  `domain` varchar(50) DEFAULT NULL,
  `status` tinyint(4) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `analyzers`
--

INSERT INTO `analyzers` (`id`, `name`, `ip`, `domain`, `status`, `created_at`, `updated_at`) VALUES
(1, 'an-sg-01.synalyze.net', '142.91.101.137', 'http://an-sg-01.synalyze.net', 1, '2025-12-18 23:38:59', '2025-12-18 23:38:59'),
(2, 'Analyzer 1', '192.168.10.10', 'analyzer1.example.com', 1, '2025-12-19 01:14:59', '2025-12-19 01:14:59'),
(3, 'Analyzer 2', '192.168.10.11', 'analyzer2.example.com', 1, '2025-12-19 01:14:59', '2025-12-19 01:14:59'),
(4, 'Analyzer 3', '192.168.10.12', 'analyzer3.example.com', 0, '2025-12-19 01:14:59', '2025-12-19 01:14:59'),
(123, NULL, '192.168.1.100', NULL, 1, '2025-12-30 10:20:17', '2025-12-30 10:20:17');

-- --------------------------------------------------------

--
-- Table structure for table `api_logs`
--

CREATE TABLE `api_logs` (
  `id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `cpu_status` int(11) NOT NULL,
  `ram_status` int(11) NOT NULL,
  `log_count` int(11) NOT NULL,
  `type` varchar(10) NOT NULL,
  `device_count` int(11) NOT NULL,
  `last_login_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `description` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `api_logs`
--

INSERT INTO `api_logs` (`id`, `project_id`, `cpu_status`, `ram_status`, `log_count`, `type`, `device_count`, `last_login_date`, `description`, `created_at`, `updated_at`) VALUES
(1, 1, 50, 60, 1000, '', 10, '2025-12-16 05:49:55', 'System log entry #1 for project 1', '2025-12-19 01:18:08', '2025-12-19 01:18:08'),
(2, 1, 60, 65, 1500, '', 11, '2025-12-15 12:52:57', 'System log entry #2 for project 1', '2025-12-19 01:18:08', '2025-12-19 01:18:08'),
(3, 2, 50, 60, 1000, '', 10, '2025-12-20 06:31:39', 'System log entry #1 for project 2', '2025-12-15 01:18:08', '2025-12-20 06:31:39'),
(4, 2, 60, 65, 1500, '', 11, '2025-12-18 18:48:44', 'System log entry #2 for project 2', '2025-12-19 01:18:08', '2025-12-19 01:18:08'),
(5, 2, 70, 70, 2000, '', 12, '2025-12-20 06:31:59', 'System log entry #3 for project 2', '2025-12-14 01:18:09', '2025-12-20 06:31:59'),
(6, 3, 50, 60, 1000, '', 10, '2025-12-18 05:17:36', 'System log entry #1 for project 3', '2025-12-19 01:18:09', '2025-12-19 01:18:09'),
(7, 3, 60, 65, 1500, '', 11, '2025-12-17 02:47:23', 'System log entry #2 for project 3', '2025-12-19 01:18:09', '2025-12-19 01:18:09'),
(8, 2, 70, 70, 2000, '', 12, '2025-12-20 06:31:59', 'System log entry #3 for project 2', '2025-12-16 01:18:09', '2025-12-20 06:31:59'),
(9, 1, 65, 72, 12500, '', 0, '2025-12-22 10:32:28', 'Collector heartbeat', '2025-12-22 10:32:28', '2025-12-22 10:32:28'),
(10, 2, 65, 72, 12500, '', 0, '2025-12-22 10:34:30', 'Collector heartbeat', '2025-12-22 10:34:30', '2025-12-22 10:34:30'),
--
-- Table structure for table `collectors`
--

CREATE TABLE `collectors` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `ip` varchar(100) NOT NULL,
  `domain` varchar(50) DEFAULT NULL,
  `secret_key` varchar(100) DEFAULT NULL,
  `last_fetched_id` int(11) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `collectors`
--

INSERT INTO `collectors` (`id`, `name`, `ip`, `domain`, `secret_key`, `last_fetched_id`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Default', 'localhost', 'http://localhost/', 'collector-secret-1', 0, 1, '2025-11-22 02:10:33', '2025-12-23 05:51:49'),
(2, 'Collector 2', '192.168.0.91', '', 'collector-secret-2', 0, 1, '2025-11-22 02:10:33', '2025-12-29 07:25:00'),
(3, 'Collector 3', '142.91.101.142', 'https://coll-sg-01.synalyze.net/', 'collector-secret-3', 0, 1, '2025-11-22 02:10:33', '2025-12-30 09:03:34'),
(4, 'Collector 1', '192.168.0.91', '', 'collector-secret-1', 0, 1, '2025-11-24 22:24:35', '2025-12-30 10:40:02');

-- --------------------------------------------------------

--
-- Table structure for table `end_customer`
--

CREATE TABLE `end_customer` (
  `id` int(11) NOT NULL,
  `company` varchar(50) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `contact_person` varchar(50) NOT NULL,
  `tel` int(11) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `end_customer`
--

INSERT INTO `end_customer` (`id`, `company`, `address`, `contact_person`, `tel`, `email`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Alpha Corp', '789 Broadway, New York, NY', 'Alice Johnson', 1234567890, 'alice@alphacorp.com', 1, '2025-11-22 02:10:33', '2025-11-22 02:10:33'),
(2, 'Beta LLC', '321 Elm St, San Francisco, CA', 'Bob Smith', 2147483647, 'bob@betallc.com', 1, '2025-11-22 02:10:33', '2025-11-22 02:10:33');

-- --------------------------------------------------------

--
-- Table structure for table `internal_log`
--

CREATE TABLE `internal_log` (
  `id` int(11) NOT NULL,
  `related_table` varchar(100) DEFAULT NULL,
  `related_table_id` int(11) DEFAULT NULL,
  `severity` int(11) NOT NULL,
  `message` varchar(100) NOT NULL,
  `admin_id` int(11) DEFAULT NULL,
  `action` varchar(100) NOT NULL,
  `status_code` int(11) NOT NULL,
  `additional_data` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `internal_log`
--

INSERT INTO `internal_log` (`id`, `related_table`, `related_table_id`, `severity`, `message`, `admin_id`, `action`, `status_code`, `additional_data`, `created_at`, `updated_at`) VALUES
(1, NULL, NULL, 1, 'Project validation request received', NULL, 'project_validation_request', 200, '{\"method\":\"POST\",\"url\":\"http://localhost:3001/api/project_validate\",\"client_ip\":\"::ffff:192.168.0.42', '2025-11-23 23:17:06', '2025-11-23 23:17:06'),
(2, NULL, 3, 1, 'Project validated successfully', NULL, 'project_validation_success', 200, '{\"project_id\":3,\"activation_key\":\"ACT-KEY-003\",\"logger_ip\":\"192.168.0.42\"}', '2025-11-23 23:17:06', '2025-11-23 23:17:06'),
(3, NULL, NULL, 1, 'Project activation request received', NULL, 'project_activation_request', 200, '{\"method\":\"POST\",\"url\":\"http://localhost:3001/api/project_activation\",\"client_ip\":\"::ffff:192.168.0.', '2025-11-23 23:45:45', '2025-11-23 23:45:45'),
(4, NULL, NULL, 3, 'Missing required fields', NULL, 'project_activation_error', 400, '{\"missing_fields\":{\"activation_key\":true,\"host_ip\":false,\"secure_token\":true}}', '2025-11-23 23:45:45', '2025-11-23 23:45:45'),
(5, NULL, NULL, 1, 'Project activation request received', NULL, 'project_activation_request', 200, '{\"method\":\"POST\",\"url\":\"http://localhost:3003/api/project_activation\",\"client_ip\":\"::1\"}', '2025-11-23 23:52:08', '2025-11-23 23:52:08'),
(6, NULL, 3, 1, 'On-prem project activated successfully', NULL, 'project_activation_success', 200, '{\"project_id\":3,\"logger_ip\":\"192.168.0.42\"}', '2025-11-23 23:52:08', '2025-11-23 23:52:08'),
(7, NULL, NULL, 1, 'Project activation request received', NULL, 'project_activation_request', 200, '{\"method\":\"POST\",\"url\":\"http://localhost:3001/api/project_activation\",\"client_ip\":\"::ffff:192.168.0.', '2025-11-23 23:54:57', '2025-11-23 23:54:57'),
(8, NULL, 3, 1, 'On-prem project activated successfully', NULL, 'project_activation_success', 200, '{\"project_id\":3,\"logger_ip\":\"192.168.0.42\"}', '2025-11-23 23:54:57', '2025-11-23 23:54:57'),
(9, NULL, NULL, 1, 'Project activation request received', NULL, 'project_activation_request', 200, '{\"method\":\"POST\",\"url\":\"http://localhost:3001/api/project_activation\",\"client_ip\":\"::ffff:192.168.0.', '2025-11-24 01:22:29', '2025-11-24 01:22:29'),
(10, NULL, 3, 1, 'On-prem project activated successfully', NULL, 'project_activation_success', 200, '{\"project_id\":3,\"logger_ip\":\"192.168.0.42\"}', '2025-11-24 01:22:29', '2025-11-24 01:22:29'),
-- --------------------------------------------------------

--
-- Table structure for table `packages`
--

CREATE TABLE `packages` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `log_count` int(11) NOT NULL,
  `log_duration` varchar(50) NOT NULL,
  `project_duration` varchar(50) NOT NULL,
  `device_count` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `packages`
--

INSERT INTO `packages` (`id`, `name`, `log_count`, `log_duration`, `project_duration`, `device_count`, `created_at`, `updated_at`) VALUES
(1, 'Basic Package', 1000, '', '30', 5, '2025-11-22 02:10:32', '2025-11-22 02:10:32'),
(2, 'Standard Package', 5000000, '30', '90', 20, '2025-11-22 02:10:32', '2025-12-21 22:10:32'),
(3, 'Premium Package', 10000, '', '365', 100, '2025-11-22 02:10:33', '2025-11-22 02:10:33');

-- --------------------------------------------------------

--
-- Table structure for table `ports`
--

CREATE TABLE `ports` (
  `id` int(11) NOT NULL,
  `port` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ports`
--

INSERT INTO `ports` (`id`, `port`, `created_at`, `updated_at`) VALUES
(1, 512, '2025-11-22 02:10:33', '2025-11-23 23:07:04'),
(2, 513, '2025-11-22 02:10:33', '2025-11-23 23:07:11'),
(4, 515, '2025-11-23 23:07:25', '2025-11-23 23:07:25'),
(5, 520, '2025-11-24 00:55:53', '2025-11-24 00:55:53'),
(6, 8080, '2025-11-24 22:25:29', '2025-11-24 22:25:29'),
(7, 5432, '2025-11-24 22:25:29', '2025-11-24 22:25:29'),
(8, 27017, '2025-11-24 22:25:29', '2025-11-24 22:25:29');

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE `projects` (
  `id` int(11) NOT NULL,
  `activation_key` varchar(100) NOT NULL,
  `pkg_id` int(11) NOT NULL,
  `admin_id` int(11) DEFAULT NULL,
  `collector_ip` int(11) DEFAULT NULL,
  `logger_ip` varchar(50) DEFAULT NULL,
  `reseller_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `end_customer_id` int(11) DEFAULT NULL,
  `port_id` int(11) DEFAULT NULL,
  `secret_key` varchar(100) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `type` int(11) NOT NULL,
  `is_active_coll` tinyint(4) NOT NULL,
  `is_active_an` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `projects`
--

INSERT INTO `projects` (`id`, `activation_key`, `pkg_id`, `admin_id`, `collector_ip`, `logger_ip`, `reseller_id`, `created_at`, `updated_at`, `end_customer_id`, `port_id`, `secret_key`, `status`, `type`, `is_active_coll`, `is_active_an`) VALUES
(1, 'ACT-KEY-001', 1, 1, 4, '192.168.1.11', 1, '2025-12-19 01:14:59', '2025-12-19 01:14:59', 1, 6, 'SECRET-KEY-001', 1, 5, 1, 0),
(2, 'ACT-KEY-002', 2, 2, 2, '192.168.2.11', 2, '2025-12-19 01:14:59', '2025-12-19 01:14:59', 2, 7, 'SECRET-KEY-002', 1, 6, 0, 0),
(3, 'ACT-KEY-003', 3, 3, 3, '192.168.3.11', NULL, '2025-12-19 01:14:59', '2025-12-19 01:14:59', NULL, 8, 'SECRET-KEY-003', 1, 7, 0, 0),
(4, 'DSIE-ZE4M-35AQ', 1, 3, 4, '1', 2, '2025-12-29 00:41:25', '2025-12-30 05:03:38', 1, 4, 'EQLnFj4ZnnRnsXUo8QpcMYdF9jgDsjVw', 1, 2, 0, 0),
(6, 'X8RO-VZK5-KQJS', 1, 1, 3, '', 1, '2025-12-30 03:32:56', '2025-12-30 03:32:56', 1, 2, 'rbaS64najt7u4znEEAfrvqyBp2ElJlLq', 1, 1, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `project_types`
--

CREATE TABLE `project_types` (
  `id` int(11) NOT NULL,
  `name` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `project_types`
--

INSERT INTO `project_types` (`id`, `name`) VALUES
(1, 'cloud'),
(2, 'on-prem'),
(5, 'Web App'),
(6, 'Mobile'),
(7, 'IoT'),
(8, 'Server');

-- --------------------------------------------------------

--
-- Table structure for table `reseller`
--

CREATE TABLE `reseller` (
  `customer_id` int(11) NOT NULL,
  `company_name` varchar(100) NOT NULL,
  `address` varchar(250) DEFAULT NULL,
  `type` varchar(100) NOT NULL,
  `credit_limit` varchar(100) DEFAULT NULL,
  `payment_terms` varchar(100) DEFAULT NULL,
  `note` varchar(250) DEFAULT NULL,
  `vat` varchar(11) DEFAULT NULL,
  `city` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `reseller`
--

INSERT INTO `reseller` (`customer_id`, `company_name`, `address`, `type`, `credit_limit`, `payment_terms`, `note`, `vat`, `city`, `created_at`, `updated_at`) VALUES
(1, 'Tech Solutions Inc', '123 Main St, New York, NY', 'Premium', '10000', 'Net 30', 'Long-term partner', 'VAT123456', 10001, '2025-11-22 02:10:33', '2025-11-22 02:10:33'),
(2, 'Network Providers Ltd', '456 Oak Ave, Los Angeles, CA', 'Standard', '5000', 'Net 15', 'Growing business', 'VAT789012', 90001, '2025-11-22 02:10:33', '2025-11-22 02:10:33');

-- --------------------------------------------------------

--
-- Table structure for table `session`
--

CREATE TABLE `session` (
  `id` varchar(191) NOT NULL,
  `userId` varchar(191) NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  `expires` datetime(3) NOT NULL,
  `sessionToken` varchar(191) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `session`
--

INSERT INTO `session` (`id`, `userId`, `createdAt`, `updatedAt`, `expires`, `sessionToken`) VALUES
('session_1_1763797277354', '1', '2025-11-22 07:41:17.354', '2025-11-22 07:41:17.354', '2025-11-23 07:41:17.354', 'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwiZW1haWwiOiJhZG1pbkBleGFtcGxlLmNvbSIsInJvbGUiOiJBZG1pbiIsImlhdCI6MTc2Mzc5NzI3NywiZXhwIjoxNzYzODgzNjc3fQ.EQZhmvs9yO7fPs_BDuidEt6MZAy0Tp532ey2wX7-WHQ'),
('session_1_1763955200632', '1', '2025-11-24 03:33:20.632', '2025-11-24 03:33:20.632', '2025-11-25 03:33:20.632', 'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwiZW1haWwiOiJhZG1pbkBleGFtcGxlLmNvbSIsInJvbGUiOiJBZG1pbiIsImlhdCI6MTc2Mzk1NTIwMCwiZXhwIjoxNzY0MDQxNjAwfQ.GsR5iTztnSXY6EVEEViRjao5XKBaVlM6T8OciizFCzA'),
('session_1_1764044103864', '1', '2025-11-25 04:15:03.864', '2025-11-25 04:15:03.864', '2025-11-26 04:15:03.864', 'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEiLCJlbWFpbCI6ImFkbWluQGV4YW1wbGUuY29tIiwicm9sZSI6IkFkbWluIiwiaWF0IjoxNzY0MDQ0MTAzLCJleHAiOjE3NjQxMzA1MDN9.Z2lH1pYRed3Lg4U1a1mawMD63svEzCCoefzWhYoif4k'),
('session_1_1764044359027', '1', '2025-11-25 04:19:19.027', '2025-11-25 04:19:19.027', '2025-11-26 04:19:19.027', 'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEiLCJlbWFpbCI6ImFkbWluQGV4YW1wbGUuY29tIiwicm9sZSI6IkFkbWluIiwiaWF0IjoxNzY0MDQ0MzU5LCJleHAiOjE3NjQxMzA3NTl9.YRVWqYhVkC5Ggl43LPq4TSCCTPiVOMDkXFNgIhDw9xA'),
('session_1_1764044728619', '1', '2025-11-25 04:25:28.619', '2025-11-25 04:25:28.619', '2025-11-26 04:25:28.619', 'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEiLCJlbWFpbCI6ImFkbWluQGV4YW1wbGUuY29tIiwicm9sZSI6IkFkbWluIiwiaWF0IjoxNzY0MDQ0NzI4LCJleHAiOjE3NjQxMzExMjh9.Ci1fWs9DSyqquyVr_Y6QuZCaC0w7rgurGrws4DjvA2U'),
('session_1_1764045258162', '1', '2025-11-25 04:34:18.162', '2025-11-25 04:34:18.162', '2025-11-26 04:34:18.162', 'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEiLCJlbWFpbCI6ImFkbWluQGV4YW1wbGUuY29tIiwicm9sZSI6IkFkbWluIiwiaWF0IjoxNzY0MDQ1MjU4LCJleHAiOjE3NjQxMzE2NTh9.m14yxHwz5ZMXAdtwfCzlxt9BLaBNkA7c583aZQ2ZWdQ'),
('session_1_1764045433057', '1', '2025-11-25 04:37:13.057', '2025-11-25 04:37:13.057', '2025-11-26 04:37:13.057', 'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEiLCJlbWFpbCI6ImFkbWluQGV4YW1wbGUuY29tIiwicm9sZSI6IkFkbWluIiwiaWF0IjoxNzY0MDQ1NDMzLCJleHAiOjE3NjQxMzE4MzN9.MAoO-jWO8hkA6XMTUqGvOCzYgsB03vB3HSUFXARXYFE'),
('session_1_1764045652273', '1', '2025-11-25 04:40:52.273', '2025-11-25 04:40:52.273', '2025-11-26 04:40:52.273', 'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEiLCJlbWFpbCI6ImFkbWluQGV4YW1wbGUuY29tIiwicm9sZSI6IkFkbWluIiwiaWF0IjoxNzY0MDQ1NjUyLCJleHAiOjE3NjQxMzIwNTJ9.EJViXdLNOigxAe1dEAlOzwt4VsInIwQMh6eM3WuMxL0'),
('session_1_1764152102769', '1', '2025-11-26 10:15:02.769', '2025-11-26 10:15:02.769', '2025-11-27 10:15:02.769', 'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEiLCJlbWFpbCI6ImFkbWluQGV4YW1wbGUuY29tIiwicm9sZSI6IkFkbWluIiwiaWF0IjoxNzY0MTUyMTAyLCJleHAiOjE3NjQyMzg1MDJ9.3xuC4WxxdSx2Rfp_00sPCZiMnx3oFyXAtt71bUKrAuA'),
('session_1_1764152122845', '1', '2025-11-26 10:15:22.845', '2025-11-26 10:15:22.845', '2025-11-27 10:15:22.845', 'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEiLCJlbWFpbCI6ImFkbWluQGV4YW1wbGUuY29tIiwicm9sZSI6IkFkbWluIiwiaWF0IjoxNzY0MTUyMTIyLCJleHAiOjE3NjQyMzg1MjJ9.EJM_l41JI_sM_GHateCpNnvRGuTAkllIp9dKas3rYp4'),
('session_1_1764152415814', '1', '2025-11-26 10:20:15.814', '2025-11-26 10:20:15.814', '2025-11-27 10:20:15.814', 'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEiLCJlbWFpbCI6ImFkbWluQGV4YW1wbGUuY29tIiwicm9sZSI6IkFkbWluIiwiaWF0IjoxNzY0MTUyNDE1LCJleHAiOjE3NjQyMzg4MTV9.hD7HM_tHSRzb-2NHKb9gLUC_aTqpe6-RPzt2gnMyAyI'),
('session_1_1764152464863', '1', '2025-11-26 10:21:04.863', '2025-11-26 10:21:04.863', '2025-11-27 10:21:04.863', 'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEiLCJlbWFpbCI6ImFkbWluQGV4YW1wbGUuY29tIiwicm9sZSI6IkFkbWluIiwiaWF0IjoxNzY0MTUyNDY0LCJleHAiOjE3NjQyMzg4NjR9.qYCJTh5RbLSf2E-uNHF23RnN8rbAuHCRltzKYA8_hZ0'),
('session_1_1764152652768', '1', '2025-11-26 10:24:12.768', '2025-11-26 10:24:12.768', '2025-11-27 10:24:12.768', 'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEiLCJlbWFpbCI6ImFkbWluQGV4YW1wbGUuY29tIiwicm9sZSI6IkFkbWluIiwiaWF0IjoxNzY0MTUyNjUyLCJleHAiOjE3NjQyMzkwNTJ9.aJ0o6gHJy5fJzPBh0YWV9pftMhnrpGCBV8KZiiSKIU8'),
('session_1_1764152675362', '1', '2025-11-26 10:24:35.362', '2025-11-26 10:24:35.362', '2025-11-27 10:24:35.362', 'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEiLCJlbWFpbCI6ImFkbWluQGV4YW1wbGUuY29tIiwicm9sZSI6IkFkbWluIiwiaWF0IjoxNzY0MTUyNjc1LCJleHAiOjE3NjQyMzkwNzV9.9xwzSJKscHMxalUjm7DsfCOgxso_XCtXeXZ8ntmlIac'),
('session_1_1764152700172', '1', '2025-11-26 10:25:00.172', '2025-11-26 10:25:00.172', '2025-11-27 10:25:00.172', 'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEiLCJlbWFpbCI6ImFkbWluQGV4YW1wbGUuY29tIiwicm9sZSI6IkFkbWluIiwiaWF0IjoxNzY0MTUyNzAwLCJleHAiOjE3NjQyMzkxMDB9.0KAyP1ulacFLa4cSxuG2--AFClcP4EB5xArhM9AXuZc'),
('session_1_1764152915889', '1', '2025-11-26 10:28:35.889', '2025-11-26 10:28:35.889', '2025-11-27 10:28:35.889', 'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEiLCJlbWFpbCI6ImFkbWluQGV4YW1wbGUuY29tIiwicm9sZSI6IkFkbWluIiwiaWF0IjoxNzY0MTUyOTE1LCJleHAiOjE3NjQyMzkzMTV9.e0PHlPpYtVF3Khkz5d-KsThX9fwcSS4yEU38ZvZMEwA'),
('session_1_1764153327256', '1', '2025-11-26 10:35:27.256', '2025-11-26 10:35:27.256', '2025-11-27 10:35:27.256', 'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEiLCJlbWFpbCI6ImFkbWluQGV4YW1wbGUuY29tIiwicm9sZSI6IkFkbWluIiwiaWF0IjoxNzY0MTUzMzI3LCJleHAiOjE3NjQyMzk3Mjd9.aKpVM0YeYBWlCts9m2p7HlAjl1ERR3Yrd-PnGQUGU-w'),
('session_1_1764153600461', '1', '2025-11-26 10:40:00.461', '2025-11-26 10:40:00.461', '2025-11-27 10:40:00.461', 'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEiLCJlbWFpbCI6ImFkbWluQGV4YW1wbGUuY29tIiwicm9sZSI6IkFkbWluIiwiaWF0IjoxNzY0MTUzNjAwLCJleHAiOjE3NjQyNDAwMDB9.UA7QlCShhUeA2Tmn_-zreA_Sad0W0H6l8v9_Jhq-h_A'),
('session_1_1764153834741', '1', '2025-11-26 10:43:54.741', '2025-11-26 10:43:54.741', '2025-11-27 10:43:54.741', 'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEiLCJlbWFpbCI6ImFkbWluQGV4YW1wbGUuY29tIiwicm9sZSI6IkFkbWluIiwiaWF0IjoxNzY0MTUzODM0LCJleHAiOjE3NjQyNDAyMzR9.tXsi3A5u1cVw3ynsIsv5RbgzVgL0aBXu0dY-ogedCGs'),
('session_1_1764154070507', '1', '2025-11-26 10:47:50.507', '2025-11-26 10:47:50.507', '2025-11-27 10:47:50.507', 'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEiLCJlbWFpbCI6ImFkbWluQGV4YW1wbGUuY29tIiwicm9sZSI6IkFkbWluIiwiaWF0IjoxNzY0MTU0MDcwLCJleHAiOjE3NjQyNDA0NzB9.9V6nByKg7YIu-RB-dJ1EFfNG2lirOxERa0Wu3HwXyDU'),
('session_1_1764155104661', '1', '2025-11-26 11:05:04.661', '2025-11-26 11:05:04.661', '2025-11-27 11:05:04.661', 'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEiLCJlbWFpbCI6ImFkbWluQGV4YW1wbGUuY29tIiwicm9sZSI6IkFkbWluIiwiaWF0IjoxNzY0MTU1MTA0LCJleHAiOjE3NjQyNDE1MDR9.hXR14_lh6rvBiW_AWat7Q5FPH3EhdoJTGpl1vEhHuJU'),
('session_1_1764155397979', '1', '2025-11-26 11:09:57.979', '2025-11-26 11:09:57.979', '2025-11-27 11:09:57.979', 'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEiLCJlbWFpbCI6ImFkbWluQGV4YW1wbGUuY29tIiwicm9sZSI6IkFkbWluIiwiaWF0IjoxNzY0MTU1Mzk3LCJleHAiOjE3NjQyNDE3OTd9.6ApPtJtNUgLplF5kDjDKKA7yzjtR4uNlVKC8vYHBQGI'),
('session_1_1764155882031', '1', '2025-11-26 11:18:02.031', '2025-11-26 11:18:02.031', '2025-11-27 11:18:02.031', 'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEiLCJlbWFpbCI6ImFkbWluQGV4YW1wbGUuY29tIiwicm9sZSI6IkFkbWluIiwiaWF0IjoxNzY0MTU1ODgyLCJleHAiOjE3NjQyNDIyODJ9.W4Ve9ySVn7-YqDc2OZlTNTiumEQNkz_-Vmov0l16OfA'),
('session_1_1764156243452', '1', '2025-11-26 11:24:03.452', '2025-11-26 11:24:03.452', '2025-11-27 11:24:03.452', 'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEiLCJlbWFpbCI6ImFkbWluQGV4YW1wbGUuY29tIiwicm9sZSI6IkFkbWluIiwiaWF0IjoxNzY0MTU2MjQzLCJleHAiOjE3NjQyNDI2NDN9.MI2kYuo9g0NiJhPc_kuobZQ0b7flRcnwGPgVfYV7OLA'),
('session_1_1764156404798', '1', '2025-11-26 11:26:44.798', '2025-11-26 11:26:44.798', '2025-11-27 11:26:44.798', 'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEiLCJlbWFpbCI6ImFkbWluQGV4YW1wbGUuY29tIiwicm9sZSI6IkFkbWluIiwiaWF0IjoxNzY0MTU2NDA0LCJleHAiOjE3NjQyNDI4MDR9.Akro7i2lSYKKRsUY7_CGCCVNzAEhoGR1tMYydZccvtM'),
('session_1_1765175481801', '1', '2025-12-08 06:31:21.802', '2025-12-08 06:31:21.802', '2025-12-09 06:31:21.802', 'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEiLCJlbWFpbCI6ImFkbWluQGV4YW1wbGUuY29tIiwicm9sZSI6IkFkbWluIiwiaWF0IjoxNzY1MTc1NDgxLCJleHAiOjE3NjUyNjE4ODF9.-oVuIcKKjDXKyl_IoC0UvaF5O4JWjgykfrmLuEvorOs'),
('session_1_1766119780204', '1', '2025-12-19 04:49:40.204', '2025-12-19 04:49:40.204', '2025-12-20 04:49:40.204', 'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEiLCJlbWFpbCI6ImFkbWluQGV4YW1wbGUuY29tIiwicm9sZSI6IkFkbWluIiwiaWF0IjoxNzY2MTE5NzgwLCJleHAiOjE3NjYyMDYxODB9.PR5I0lI-erf7OzFyUUlqY9lcGhEzkOXbTMkdYfwIOTU'),
('session_1_1766133339735', '1', '2025-12-19 08:35:39.736', '2025-12-19 08:35:39.736', '2025-12-20 08:35:39.736', 'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEiLCJlbWFpbCI6ImFkbWluQGV4YW1wbGUuY29tIiwicm9sZSI6IkFkbWluIiwiaWF0IjoxNzY2MTMzMzM5LCJleHAiOjE3NjYyMTk3Mzl9.7HmsbQ_D2haRT3qnfiEqynxYfqVhKLmOIUrWO1jrXTY'),
('session_1_1766206842718', '1', '2025-12-20 05:00:42.718', '2025-12-20 05:00:42.718', '2025-12-21 05:00:42.719', 'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEiLCJlbWFpbCI6ImFkbWluQGV4YW1wbGUuY29tIiwicm9sZSI6IkFkbWluIiwiaWF0IjoxNzY2MjA2ODQyLCJleHAiOjE3NjYyOTMyNDJ9.CFLPqplcLX7CT6OsMnGDQDiLhD6W_RZbnMlaEzi9iY0'),
('session_1_1766373078519', '1', '2025-12-22 03:11:18.519', '2025-12-22 03:11:18.519', '2025-12-23 03:11:18.519', 'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEiLCJlbWFpbCI6ImFkbWluQGV4YW1wbGUuY29tIiwicm9sZSI6IkFkbWluIiwiaWF0IjoxNzY2MzczMDc4LCJleHAiOjE3NjY0NTk0Nzh9.NJ4aLRWXKrlC-iJLue02BBGIBv-x7yOUFxhlT5z58Z0'),
('session_1_1766481515528', '1', '2025-12-23 09:18:35.528', '2025-12-23 09:18:35.528', '2025-12-24 09:18:35.529', 'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEiLCJlbWFpbCI6ImFkbWluQGV4YW1wbGUuY29tIiwicm9sZSI6IkFkbWluIiwiaWF0IjoxNzY2NDgxNTE1LCJleHAiOjE3NjY1Njc5MTV9.r4_b_KYOV849NK4yJhxILRs_PlFoc8Z8psmbGPFOtew'),
('session_1_1766574486107', '1', '2025-12-24 11:08:06.107', '2025-12-24 11:08:06.107', '2025-12-25 11:08:06.107', 'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEiLCJlbWFpbCI6ImFkbWluQGV4YW1wbGUuY29tIiwicm9sZSI6IkFkbWluIiwiaWF0IjoxNzY2NTc0NDg2LCJleHAiOjE3NjY2NjA4ODZ9.6SOuflSGVmwBz8oqBS5SSblIZMM3gIk22hfS7FWG9ps'),
('session_1_1766729009187', '1', '2025-12-26 06:03:29.187', '2025-12-26 06:03:29.187', '2025-12-27 06:03:29.187', 'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEiLCJlbWFpbCI6ImFkbWluQGV4YW1wbGUuY29tIiwicm9sZSI6IkFkbWluIiwiaWF0IjoxNzY2NzI5MDA5LCJleHAiOjE3NjY4MTU0MDl9.OW5KpZgRxTIK2RzYDqqmNVkHvmt13FdRtC6PXRcudi8'),
('session_1_1766818886102', '1', '2025-12-27 07:01:26.102', '2025-12-27 07:01:26.102', '2025-12-28 07:01:26.102', 'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEiLCJlbWFpbCI6ImFkbWluQGV4YW1wbGUuY29tIiwicm9sZSI6IkFkbWluIiwiaWF0IjoxNzY2ODE4ODg2LCJleHAiOjE3NjY5MDUyODZ9.M6fAlpS3Ze8EG4HnK7o1ZRD-JeZgED0GDJcxw0aEstw'),
('session_1_1766981760149', '1', '2025-12-29 04:16:00.149', '2025-12-29 04:16:00.149', '2025-12-30 04:16:00.149', 'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEiLCJlbWFpbCI6ImFkbWluQGV4YW1wbGUuY29tIiwicm9sZSI6IkFkbWluIiwiaWF0IjoxNzY2OTgxNzYwLCJleHAiOjE3NjcwNjgxNjB9.B7oz08EBqqDElTqVtR_fw-_uefKCE8FbnBKNbjh6XOo'),
('session_1_1767072317379', '1', '2025-12-30 05:25:17.379', '2025-12-30 05:25:17.379', '2025-12-31 05:25:17.379', 'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEiLCJlbWFpbCI6ImFkbWluQGV4YW1wbGUuY29tIiwicm9sZSI6IkFkbWluIiwiaWF0IjoxNzY3MDcyMzE3LCJleHAiOjE3NjcxNTg3MTd9.Z8nLq-hEmAwxyTHWspHLcEV6IVBmny2vrsEtvrwWN9E'),
('session-1', '1', '2025-11-22 07:40:33.105', '2025-11-22 07:40:33.105', '2025-11-23 07:40:33.105', 'token-123'),
('session-2', '2', '2025-11-22 07:40:33.109', '2025-11-22 07:40:33.109', '2025-11-23 07:40:33.109', 'token-456');

-- --------------------------------------------------------

--
-- Table structure for table `_prisma_migrations`
--

CREATE TABLE `_prisma_migrations` (
  `id` varchar(36) NOT NULL,
  `checksum` varchar(64) NOT NULL,
  `finished_at` datetime(3) DEFAULT NULL,
  `migration_name` varchar(255) NOT NULL,
  `logs` text DEFAULT NULL,
  `rolled_back_at` datetime(3) DEFAULT NULL,
  `started_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `applied_steps_count` int(10) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `_prisma_migrations`
--

INSERT INTO `_prisma_migrations` (`id`, `checksum`, `finished_at`, `migration_name`, `logs`, `rolled_back_at`, `started_at`, `applied_steps_count`) VALUES
('05ade94e-3a9c-4aa5-95a2-88ab9632fdb4', '8baf1240aaaf61be10eb3121bfe079137a7b85d189640985784888a9a8533872', '2025-11-22 07:20:05.450', '20251117111502_add_port_to_projects', NULL, NULL, '2025-11-22 07:20:05.441', 1),
('3ef02335-08e3-423b-9330-d715650ed91b', 'ec605c4be9eb8a60a923d70c66dafeeca43b60513c41149a9616d0072f622a56', '2025-11-22 07:20:05.439', '20251117110500_add_port_to_projects', NULL, NULL, '2025-11-22 07:20:05.324', 1),
('7740c353-279a-4b02-936d-10f0003cacd7', '78df115e16c0c5306b8c12802ee218c7df141364b3fa1b7f1b434011176fbb08', '2025-11-22 07:20:05.323', '20251117105323_fix_logger_ip_typo', NULL, NULL, '2025-11-22 07:20:04.938', 1),
('78e93cfa-e0d3-4382-a195-43b52a4932ca', 'ed5ee18e31194adaf063a680b919df8ae6029dd9c56b7f550e3443714b2c2d2b', '2025-11-22 07:20:05.549', '20251119034556_fix_port_constraints', NULL, NULL, '2025-11-22 07:20:05.479', 1),
('7c389348-790d-47a3-961f-7c28efe2a802', '51d3ed6556e065a9f93654142db7f2b6a0b3c0be1df6c220246c4638de026b53', NULL, '20251122_add_collector_relation', 'A migration failed to apply. New migrations cannot be applied before the error is recovered from. Read more about how to resolve migration issues in a production database: https://pris.ly/d/migrate-resolve\n\nMigration name: 20251122_add_collector_relation\n\nDatabase error code: 1005\n\nDatabase error:\nCan\'t create table `remote_admin`.`projects` (errno: 150 \"Foreign key constraint is incorrectly formed\")\n\nPlease check the query number 1 from the migration file.\n\n   0: sql_schema_connector::apply_migration::apply_script\n           with migration_name=\"20251122_add_collector_relation\"\n             at schema-engine\\connectors\\sql-schema-connector\\src\\apply_migration.rs:113\n   1: schema_commands::commands::apply_migrations::Applying migration\n           with migration_name=\"20251122_add_collector_relation\"\n             at schema-engine\\commands\\src\\commands\\apply_migrations.rs:95\n   2: schema_core::state::ApplyMigrations\n             at schema-engine\\core\\src\\state.rs:236', '2025-11-22 07:22:29.319', '2025-11-22 07:22:12.047', 0),
('b392d209-2727-4a93-89c6-9b5c78ea51c9', '51d3ed6556e065a9f93654142db7f2b6a0b3c0be1df6c220246c4638de026b53', '2025-11-22 07:22:29.324', '20251122_add_collector_relation', '', NULL, '2025-11-22 07:22:29.324', 0),
('bb958b1b-0ee9-4087-9a24-a8ba0510e39f', '0e0021f0d6f2f0a5e3b547741838e762a12435d5427404439f4e6e88ecac4ab7', '2025-11-22 07:20:05.478', '20251118063529_update_session_model', NULL, NULL, '2025-11-22 07:20:05.452', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `User_email_key` (`email`),
  ADD KEY `id` (`id`);

--
-- Indexes for table `analyzers`
--
ALTER TABLE `analyzers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `api_logs`
--
ALTER TABLE `api_logs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `project_id` (`project_id`);

--
-- Indexes for table `collectors`
--
ALTER TABLE `collectors`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `end_customer`
--
ALTER TABLE `end_customer`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `internal_log`
--
ALTER TABLE `internal_log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `packages`
--
ALTER TABLE `packages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ports`
--
ALTER TABLE `ports`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `projects_activation_key_key` (`activation_key`),
  ADD UNIQUE KEY `projects_secret_key_key` (`secret_key`),
  ADD UNIQUE KEY `unique_collector_port` (`collector_ip`,`port_id`),
  ADD KEY `fk_admin_id_admins_id` (`admin_id`),
  ADD KEY `fk_reseller_id_with_reseller_id` (`reseller_id`),
  ADD KEY `pkg_id` (`pkg_id`),
  ADD KEY `end_customer_id` (`end_customer_id`),
  ADD KEY `port_id` (`port_id`),
  ADD KEY `fk_project_type_id_idx` (`type`),
  ADD KEY `fk_collector_ip_collectors_id_idx` (`collector_ip`);

--
-- Indexes for table `project_types`
--
ALTER TABLE `project_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reseller`
--
ALTER TABLE `reseller`
  ADD PRIMARY KEY (`customer_id`),
  ADD UNIQUE KEY `company_name` (`company_name`),
  ADD KEY `city` (`city`);

--
-- Indexes for table `session`
--
ALTER TABLE `session`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Session_sessionToken_key` (`sessionToken`),
  ADD KEY `Session_userId_fkey` (`userId`);

--
-- Indexes for table `_prisma_migrations`
--
ALTER TABLE `_prisma_migrations`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `analyzers`
--
ALTER TABLE `analyzers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=124;

--
-- AUTO_INCREMENT for table `api_logs`
--
ALTER TABLE `api_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=323;

--
-- AUTO_INCREMENT for table `collectors`
--
ALTER TABLE `collectors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `end_customer`
--
ALTER TABLE `end_customer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `internal_log`
--
ALTER TABLE `internal_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=95;

--
-- AUTO_INCREMENT for table `packages`
--
ALTER TABLE `packages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `ports`
--
ALTER TABLE `ports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `projects`
--
ALTER TABLE `projects`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `project_types`
--
ALTER TABLE `project_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `reseller`
--
ALTER TABLE `reseller`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `api_logs`
--
ALTER TABLE `api_logs`
  ADD CONSTRAINT `fk_project_id_with_projects_id` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `projects`
--
ALTER TABLE `projects`
  ADD CONSTRAINT `fk_admin_id_admins_id` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_collector_ip_collectors_id` FOREIGN KEY (`collector_ip`) REFERENCES `collectors` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_end_customer_id` FOREIGN KEY (`end_customer_id`) REFERENCES `end_customer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_pkgid_package` FOREIGN KEY (`pkg_id`) REFERENCES `packages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_port_id_with_ports_id` FOREIGN KEY (`port_id`) REFERENCES `ports` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_project_type_id` FOREIGN KEY (`type`) REFERENCES `project_types` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_reseller_id_with_reseller_id` FOREIGN KEY (`reseller_id`) REFERENCES `reseller` (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
