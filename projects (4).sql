-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 31, 2025 at 04:45 AM
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
(8, 'Z27K-ZRC6-XTKQ', 1, 1, 1, '1', 1, '2025-12-30 22:09:46', '2025-12-30 22:09:46', 1, 4, 'TZzOF0dsgI9JoSu30qD9ZbodFkgNyesq', 1, 2, 0, 0);

--
-- Indexes for dumped tables
--

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
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `projects`
--
ALTER TABLE `projects`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

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
