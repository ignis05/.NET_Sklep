-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Czas generowania: 22 Lis 2019, 21:38
-- Wersja serwera: 5.5.28
-- Wersja PHP: 7.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `tkantor`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `access_levels`
--

CREATE TABLE `access_levels` (
  `id` tinyint(1) UNSIGNED NOT NULL,
  `name` tinytext COLLATE utf8_polish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `access_levels`
--

INSERT INTO `access_levels` (`id`, `name`) VALUES
(0, 'USER'),
(1, 'ADMIN'),
(2, 'ROOT');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `orders`
--

CREATE TABLE `orders` (
  `id` int(10) UNSIGNED NOT NULL,
  `user` int(10) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `state` tinyint(1) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `orders`
--

INSERT INTO `orders` (`id`, `user`, `date`, `state`) VALUES
(1, 1, '2019-11-08', 2),
(2, 2, '2019-11-21', 0),
(3, 0, '2019-11-22', 2),
(4, 2, '2019-11-03', 3);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `order_contents`
--

CREATE TABLE `order_contents` (
  `order_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `quantity` smallint(5) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `order_contents`
--

INSERT INTO `order_contents` (`order_id`, `product_id`, `quantity`) VALUES
(1, 1, 3);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `order_states`
--

CREATE TABLE `order_states` (
  `id` tinyint(1) UNSIGNED NOT NULL,
  `name` varchar(16) COLLATE utf8_polish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `order_states`
--

INSERT INTO `order_states` (`id`, `name`) VALUES
(0, 'PENDING'),
(1, 'SENT'),
(2, 'FINISHED'),
(3, 'CANCELLED');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `product_categories`
--

CREATE TABLE `product_categories` (
  `id` tinyint(10) UNSIGNED NOT NULL,
  `name` tinytext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `product_categories`
--

INSERT INTO `product_categories` (`id`, `name`) VALUES
(1, 'Narzędzia'),
(2, 'Inne');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `product_info`
--

CREATE TABLE `product_info` (
  `id` int(10) UNSIGNED NOT NULL,
  `category` tinyint(3) UNSIGNED NOT NULL,
  `name` varchar(64) COLLATE utf8_polish_ci NOT NULL,
  `img_path` varchar(260) COLLATE utf8_polish_ci NOT NULL DEFAULT 'assets/img/placeholder.png',
  `description` text COLLATE utf8_polish_ci NOT NULL,
  `price` decimal(65,2) UNSIGNED NOT NULL,
  `supplier` varchar(64) COLLATE utf8_polish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `product_info`
--

INSERT INTO `product_info` (`id`, `category`, `name`, `img_path`, `description`, `price`, `supplier`) VALUES
(1, 1, 'Tester kabli', 'assets/img/tester_kabli.jfif', 'abcde', '123.45', 'QWERTY'),
(2, 2, '22', 'assets/img/placeholder.png', '21376', '4.05', '5');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `stock`
--

CREATE TABLE `stock` (
  `product_id` int(10) UNSIGNED NOT NULL,
  `quantity` smallint(5) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `stock`
--

INSERT INTO `stock` (`product_id`, `quantity`) VALUES
(1, 5);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `username` varchar(16) COLLATE utf8_polish_ci NOT NULL,
  `password_hash` char(32) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `access_level` tinyint(1) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `users`
--

INSERT INTO `users` (`id`, `username`, `password_hash`, `access_level`) VALUES
(0, 'root', '63a9f0ea7bb98050796b649e85481845', 2),
(1, 'admin', '21232f297a57a5a743894a0e4a801fc3', 1),
(2, 'techtad', '9e38e8d688743e0d07d669a1fcbcd35b', 0);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `user_data`
--

CREATE TABLE `user_data` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `email` varchar(320) CHARACTER SET ascii NOT NULL,
  `first_name` tinytext,
  `last_name` tinytext,
  `billing_address` tinytext,
  `verified` bit(1) NOT NULL DEFAULT b'0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `user_data`
--

INSERT INTO `user_data` (`user_id`, `email`, `first_name`, `last_name`, `billing_address`, `verified`) VALUES
(2, 'technicaltad@gmail.com', 'Tad', 'Tech', '-', b'0');

--
-- Indeksy dla zrzutów tabel
--

--
-- Indexes for table `access_levels`
--
ALTER TABLE `access_levels`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user` (`user`),
  ADD KEY `state` (`state`);

--
-- Indexes for table `order_contents`
--
ALTER TABLE `order_contents`
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `order_states`
--
ALTER TABLE `order_states`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_categories`
--
ALTER TABLE `product_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_info`
--
ALTER TABLE `product_info`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category` (`category`);

--
-- Indexes for table `stock`
--
ALTER TABLE `stock`
  ADD UNIQUE KEY `product_id` (`product_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `access_level` (`access_level`);

--
-- Indexes for table `user_data`
--
ALTER TABLE `user_data`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT dla tabeli `product_categories`
--
ALTER TABLE `product_categories`
  MODIFY `id` tinyint(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT dla tabeli `product_info`
--
ALTER TABLE `product_info`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT dla tabeli `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Ograniczenia dla zrzutów tabel
--

--
-- Ograniczenia dla tabeli `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`user`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`state`) REFERENCES `order_states` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ograniczenia dla tabeli `order_contents`
--
ALTER TABLE `order_contents`
  ADD CONSTRAINT `order_contents_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  ADD CONSTRAINT `order_contents_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product_info` (`id`);

--
-- Ograniczenia dla tabeli `product_info`
--
ALTER TABLE `product_info`
  ADD CONSTRAINT `product_info_ibfk_1` FOREIGN KEY (`category`) REFERENCES `product_categories` (`id`);

--
-- Ograniczenia dla tabeli `stock`
--
ALTER TABLE `stock`
  ADD CONSTRAINT `stock_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product_info` (`id`);

--
-- Ograniczenia dla tabeli `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`access_level`) REFERENCES `access_levels` (`id`);

--
-- Ograniczenia dla tabeli `user_data`
--
ALTER TABLE `user_data`
  ADD CONSTRAINT `user_data_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
