-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 11, 2017 at 11:05 PM
-- Server version: 10.1.26-MariaDB
-- PHP Version: 7.0.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `todo_app`
--

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(46, '2014_10_12_000000_create_users_table', 1),
(47, '2014_10_12_100000_create_password_resets_table', 1),
(48, '2016_06_01_000001_create_oauth_auth_codes_table', 1),
(49, '2016_06_01_000002_create_oauth_access_tokens_table', 1),
(50, '2016_06_01_000003_create_oauth_refresh_tokens_table', 1),
(51, '2016_06_01_000004_create_oauth_clients_table', 1),
(52, '2016_06_01_000005_create_oauth_personal_access_clients_table', 1),
(53, '2017_11_10_220835_create_tasks_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `oauth_access_tokens`
--

CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `client_id` int(11) NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_access_tokens`
--

INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('43b2b2084910ec15dc45cfcdd95ef89a9c1366e561e96d5ffe47a218f056ce9372e077fe64efb9c4', 5, 2, NULL, '[\"*\"]', 0, '2017-11-12 04:05:38', '2017-11-12 04:05:38', '2018-11-11 20:05:38');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_auth_codes`
--

CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_clients`
--

CREATE TABLE `oauth_clients` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_clients`
--

INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
(1, NULL, 'Laravel Personal Access Client', 'MWroIJqhiER7YUbbsToyKMzogweyOivjxPNXlSip', 'http://localhost', 1, 0, 0, '2017-11-11 23:51:45', '2017-11-11 23:51:45'),
(2, NULL, 'Laravel Password Grant Client', 'GuDIRlPMz3psdS0ac5IGqMYc3JqneV8Y0rG1TAYk', 'http://localhost', 0, 1, 0, '2017-11-11 23:51:45', '2017-11-11 23:51:45');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_personal_access_clients`
--

CREATE TABLE `oauth_personal_access_clients` (
  `id` int(10) UNSIGNED NOT NULL,
  `client_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_personal_access_clients`
--

INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2017-11-11 23:51:45', '2017-11-11 23:51:45');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_refresh_tokens`
--

CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_refresh_tokens`
--

INSERT INTO `oauth_refresh_tokens` (`id`, `access_token_id`, `revoked`, `expires_at`) VALUES
('5e55e073a2d1beee1da1e826c30e994b9c97633769bace8fad9c0952c4b0d8a81b337c5289b3528c', '43b2b2084910ec15dc45cfcdd95ef89a9c1366e561e96d5ffe47a218f056ce9372e077fe64efb9c4', 0, '2018-11-11 20:05:39');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tasks`
--

CREATE TABLE `tasks` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `task_title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `task_body` text COLLATE utf8mb4_unicode_ci,
  `task_files` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_public` tinyint(1) NOT NULL,
  `is_closed` tinyint(1) NOT NULL,
  `task_deadline` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tasks`
--

INSERT INTO `tasks` (`id`, `user_id`, `task_title`, `task_body`, `task_files`, `is_public`, `is_closed`, `task_deadline`, `created_at`, `updated_at`) VALUES
(1, 1, 'helloo', 'firast task', '', 1, 1, '2014-04-01 12:00:33', '2017-11-11 18:05:58', '2017-11-11 18:08:48'),
(2, 2, 'good', 'secound task', '', 1, 0, '2014-04-01 12:00:33', '2017-11-11 19:56:42', '2017-11-11 19:56:42'),
(3, 2, 'private task', 'secound task', '', 0, 0, '2014-04-01 12:00:33', '2017-11-11 19:57:06', '2017-11-11 19:57:06'),
(4, 3, 'sayed task', 'test task', '', 1, 0, '2014-04-01 12:00:33', '2017-11-11 19:57:42', '2017-11-11 19:57:42'),
(5, 5, 'sayed task', 'test task', '', 1, 0, '2014-04-01 12:00:33', '2017-11-12 04:47:55', '2017-11-12 04:47:55');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `username` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `token`, `email`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'hassan', '$2y$10$1HrWDx3ZRg4JxTByyNMxEucYbFFdbpl/Yn4y6g4C0yWAGr0iZgyHO47158184845711452318', 'hassan@hassan.com', '$2y$10$YkRifqxopKRzgYjfT23dPuBEVDNrHsqP2vaNovZWNoKskoUMPyBue', NULL, '2017-11-11 18:05:23', '2017-11-11 18:05:23'),
(2, 'mohssen', '$2y$10$41zRKqYQ5cMQPcNp5BTetu4om1GXN9qDz7NfZCYSBZqc5MHrcrAlm65676314553748335625', 'mohssen@mohssen.com', '$2y$10$ZVedCQHqHRUEmcOo2OPLk.MjP6uzA8FjlCwWJqrLyiUoKNYdcTJKK', NULL, '2017-11-11 19:15:31', '2017-11-11 19:15:31'),
(3, 'elssayed', '$2y$10$wfofhD3Qz8yPOX6sFd33qu.dsAY..Ldkaco9gEdTFLzj4NZM1yy6O82682684167423455243', 'elssayed@elssayed.com', '$2y$10$J4Ta7eBRxYHHWhD2xjNPs.2qNqIBZ3tnGeXFv4A9/zFKIoHEf7UKu', NULL, '2017-11-11 19:56:15', '2017-11-11 19:56:15'),
(4, 'Ahmed Elkfrawy', '$2y$10$VU2DBJ4683PSynyQ.CCwmeDLu947QR4M8Jopwa9a3kdxGfSEwondm32813418415818458311', 'a.atta2014@gmail.com', 'EAAbcpXRhN0sBABT6ZBP6JeGTdVAeyn0QRPQ5uaTwRDs50m5rXel2HwKiXYZAfavNwcaiuZCZAk0smRZA1WSYOZApr9yBuzj36uYzlhpQ26DbJeoU2cD0czxSJNv1tYsPC9YicevHx3ClErsMbBcpEDFksS0oxundF8tFQvSrZBACgZDZD', NULL, '2017-11-12 00:16:43', '2017-11-12 00:16:43'),
(5, 'kamal', '$2y$10$4B3XVnlCecmNiN/v3Sgsweh4BqraAVU2ewWnwkfG7NTDVsvUmaKt616455266354188242733', 'kamal@kamal.com', '$2y$10$BRaRear3ZY6GXVEaLIY65.WP/dI78E25s5h.jD6n7i6T9xSo00H/a', NULL, '2017-11-12 04:02:15', '2017-11-12 04:02:15');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_access_tokens`
--
ALTER TABLE `oauth_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_access_tokens_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_auth_codes`
--
ALTER TABLE `oauth_auth_codes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_clients_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_personal_access_clients_client_id_index` (`client_id`);

--
-- Indexes for table `oauth_refresh_tokens`
--
ALTER TABLE `oauth_refresh_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `tasks`
--
ALTER TABLE `tasks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tasks`
--
ALTER TABLE `tasks`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
