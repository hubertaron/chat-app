-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2024. Okt 03. 13:13
-- Kiszolgáló verziója: 10.4.28-MariaDB
-- PHP verzió: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `chat`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `chat`
--

CREATE TABLE `chat` (
  `id` int(11) NOT NULL,
  `content` varchar(200) NOT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `sender_id` int(11) NOT NULL,
  `to_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- A tábla adatainak kiíratása `chat`
--

INSERT INTO `chat` (`id`, `content`, `created_at`, `sender_id`, `to_id`) VALUES
(4, 'Sey', '2024-10-02 09:00:17.558', 1, 2),
(6, '12', '2024-10-02 09:22:39.492', 1, 2),
(13, 's', '2024-10-02 10:57:07.375', 1, 5),
(15, 'ghghg9👾😿🐎🐎🐎🐎🐎🐎🐎🐎🥙', '2024-10-03 09:48:58.032', 5, 2),
(17, 'aWD', '2024-10-03 11:08:08.824', 5, 1);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(191) NOT NULL,
  `password` varchar(191) NOT NULL,
  `email` varchar(191) NOT NULL,
  `birth_date` datetime(3) NOT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updated_at` datetime(3) NOT NULL,
  `isAdmin` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- A tábla adatainak kiíratása `user`
--

INSERT INTO `user` (`id`, `username`, `password`, `email`, `birth_date`, `created_at`, `updated_at`, `isAdmin`) VALUES
(1, 'Jingadunszki Márton', 'Mária3', 'martonj@gmail.com', '2000-11-15 11:56:51.000', '2024-10-01 11:18:58.000', '2024-10-01 11:18:58.000', 0),
(2, 'Kolompár Tamás', 's', 'koltam@citromail.hu', '2014-10-02 10:55:23.000', '2024-10-01 11:19:17.000', '2024-10-01 10:55:23.000', 0),
(5, 'fasdf', '$2b$10$yxrQsR9j4Fp4eI05z0aI4uVoROelTU2bl9X8DEEi9i/LHa7Wo5iGi', 'dfasdf@o.com', '1200-02-01 00:00:00.000', '2024-10-02 10:14:33.536', '2024-10-02 10:14:33.536', 0),
(6, 'sdaf', '$2b$10$.UTxKzJ77y48kSGnE9v5TeM9OzEjGRnQvHs/wkU2HufktPYfAzECq', 'sadf@sadf.cs', '0211-01-01 00:00:00.000', '2024-10-02 10:19:46.955', '2024-10-02 10:19:46.955', 0),
(9, 'gjzu', 'gtnr689', 'gh@ghgh.gfm', '2001-02-14 00:00:00.000', '2024-10-03 10:39:42.919', '2024-10-03 10:39:42.919', 0),
(10, 'sdfasdfgf', 'asdf', 'sdfghsdfgasdf@safvasd.cpom', '2001-02-13 00:00:00.000', '2024-10-03 10:57:59.017', '2024-10-03 10:57:59.017', 0),
(11, 'ASD', 'rrttzz', 'ASD@tttttttttttt.fr', '2024-08-29 00:00:00.000', '2024-10-03 11:08:37.562', '2024-10-03 11:08:37.562', 0);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `_prisma_migrations`
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
-- A tábla adatainak kiíratása `_prisma_migrations`
--

INSERT INTO `_prisma_migrations` (`id`, `checksum`, `finished_at`, `migration_name`, `logs`, `rolled_back_at`, `started_at`, `applied_steps_count`) VALUES
('621680d6-9da7-43ea-b59f-79e4b973f7b6', '661a2bf862368a3c52d42097284e5e57d2d211fd106260a894e36bdc85552567', '2024-10-02 10:22:46.674', '20241002102246_add_is_admin_to_user', NULL, NULL, '2024-10-02 10:22:46.665', 1),
('9fe6fec1-4f9b-423f-a208-6acd50c7bce7', '8af9fbbf77a317bd99641cd80f6dc8574fbe5682c9f524ae2e9a61e9d3374534', '2024-09-30 09:51:48.098', '20240930095146_init', NULL, NULL, '2024-09-30 09:51:46.088', 1),
('b8899d52-19f5-4add-a0a8-d31edb728c91', '77049ad8cb66be55cb3d4b44108a1116b6fdbcf6f316447ade1955f032542507', '2024-10-02 10:13:52.634', '20241002101352_add_cascade_delete', NULL, NULL, '2024-10-02 10:13:52.599', 1);

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `chat`
--
ALTER TABLE `chat`
  ADD PRIMARY KEY (`id`),
  ADD KEY `chat_sender_id_fkey` (`sender_id`),
  ADD KEY `chat_to_id_fkey` (`to_id`);

--
-- A tábla indexei `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_username_key` (`username`),
  ADD UNIQUE KEY `user_email_key` (`email`);

--
-- A tábla indexei `_prisma_migrations`
--
ALTER TABLE `_prisma_migrations`
  ADD PRIMARY KEY (`id`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `chat`
--
ALTER TABLE `chat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT a táblához `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `chat`
--
ALTER TABLE `chat`
  ADD CONSTRAINT `chat_sender_id_fkey` FOREIGN KEY (`sender_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `chat_to_id_fkey` FOREIGN KEY (`to_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
