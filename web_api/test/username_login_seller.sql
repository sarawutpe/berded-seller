-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jan 10, 2022 at 04:35 AM
-- Server version: 10.4.17-MariaDB
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `admin_berded`
--

-- --------------------------------------------------------

--
-- Table structure for table `username_login_seller`
--

CREATE TABLE `username_login_seller` (
  `run_id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `phash` varchar(32) NOT NULL,
  `seller_id` varchar(10) NOT NULL DEFAULT '',
  `subdomain` varchar(50) NOT NULL,
  `package_id` int(11) NOT NULL,
  `total_number` int(11) NOT NULL,
  `num_viewed` int(11) NOT NULL,
  `viewed` int(11) NOT NULL,
  `picture_path` varchar(100) NOT NULL,
  `picture_path_new` varchar(100) NOT NULL,
  `cover_path` varchar(100) NOT NULL,
  `edit_name` varchar(100) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `id_card` varchar(13) NOT NULL,
  `id_card_path` varchar(300) NOT NULL,
  `edit_detail_seller` varchar(200) NOT NULL,
  `edit_phone` varchar(100) NOT NULL,
  `line_id` varchar(100) NOT NULL,
  `facebook` varchar(100) NOT NULL,
  `twitter` varchar(100) NOT NULL,
  `instagram` varchar(100) NOT NULL DEFAULT '',
  `edit_email` varchar(100) NOT NULL,
  `edit_web` varchar(100) NOT NULL,
  `edit_detail_payment` varchar(300) NOT NULL,
  `edit_detail_receive_product` varchar(300) NOT NULL,
  `expired_date` date NOT NULL,
  `expired_time` time NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `address` varchar(500) NOT NULL,
  `province` varchar(20) NOT NULL,
  `status` char(1) NOT NULL DEFAULT 'I',
  `hidden` char(1) NOT NULL DEFAULT 'N',
  `token` varchar(255) NOT NULL,
  `draft` int(1) NOT NULL,
  `reset` char(1) NOT NULL DEFAULT 'N',
  `reset_time` datetime NOT NULL,
  `certified` tinyint(1) NOT NULL DEFAULT 0,
  `offer` tinyint(1) NOT NULL DEFAULT 0,
  `buyberded` tinyint(1) NOT NULL DEFAULT 0,
  `analysis` tinyint(1) NOT NULL DEFAULT 0,
  `sort` tinyint(1) NOT NULL DEFAULT 0,
  `sort_by` varchar(20) NOT NULL DEFAULT 'update_from_max',
  `limit` int(11) NOT NULL DEFAULT 30,
  `contact_seller_count` int(11) NOT NULL DEFAULT 0,
  `count_berded` int(11) NOT NULL DEFAULT 0,
  `count_recommend` int(11) NOT NULL DEFAULT 0,
  `flag_status_check_exp` tinyint(1) NOT NULL DEFAULT 0,
  `seller_note` text NOT NULL,
  `registration_date` datetime NOT NULL,
  `update_date` datetime NOT NULL,
  `tokenAPI` varchar(255) DEFAULT NULL,
  `rating` float NOT NULL DEFAULT 0,
  `noti_help` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `username_login_seller`
--

INSERT INTO `username_login_seller` (`run_id`, `username`, `phash`, `seller_id`, `subdomain`, `package_id`, `total_number`, `num_viewed`, `viewed`, `picture_path`, `picture_path_new`, `cover_path`, `edit_name`, `first_name`, `last_name`, `id_card`, `id_card_path`, `edit_detail_seller`, `edit_phone`, `line_id`, `facebook`, `twitter`, `instagram`, `edit_email`, `edit_web`, `edit_detail_payment`, `edit_detail_receive_product`, `expired_date`, `expired_time`, `timestamp`, `address`, `province`, `status`, `hidden`, `token`, `draft`, `reset`, `reset_time`, `certified`, `offer`, `buyberded`, `analysis`, `sort`, `sort_by`, `limit`, `contact_seller_count`, `count_berded`, `count_recommend`, `flag_status_check_exp`, `seller_note`, `registration_date`, `update_date`, `tokenAPI`, `rating`, `noti_help`) VALUES
(4601, 'demo@berded.in.th', '0b49cd0021b807ae734a3e1aa0b72045', 'S4373', 'Nammon', 9, 1, 2, 2, '', 'profile_photo/S4373_2021-11-09_114829.png', '', 'น้ำมนต์ เบอร์มงคล', 'มลฤดี', 'กาญจนสาร', '1329900623041', 'id_card_photo/S4373_id_231528972696002.jpg', 'เบอร์ดี เบอร์เด็ด', '0813599468', '@berded', 'https://www.facebook.com/berded', '', '', 'molrudee413@gmail.com', 'https://www.berded.in.th', 'โอนเงินเข้าบัญชี&lt;br&gt;ธ.กสิกรไทย&lt;br&gt;041-3-72057-5&lt;br&gt;ชื่อบัญชี นาง วิภา ทายะบวร (ออมทรัพย์) / หลังโอนเงิน ส่งรูปสลิปการโอนเงินมาทาง Line id : @berded', '1. ส่งฟรี ทางไปรษณีย์&lt;br&gt;\r2. หลังจากได้รับซิมการ์ดแล้ว ผู้ซื้อจะต้องทำการลงทะเบียนซิมด้วยตัวเองให้เรียบร้อยภายใน&lt;br&gt;\r3 วันทำการหลังจากที่ได้รับซิมการ์ด (หากเกิน 3 วันแล้วมีปัญหาเรื่องการลงทะเบียนซิม ทางเราจะไม่รับผิดชอบใดๆ)&lt;br&gt;\r3. เบอร์ที่ซื้อไปแล้ว ไม่รับเปลี่ยน-คืน', '2022-01-25', '12:15:11', '2022-01-07 00:04:23', 'บริษัท โค้ดโมบายส์ จำกัด 3761/104-105 ตรอกนอกเขต แขวงบางโคล่ เขตบางคอแหลม กรุงเทพมหานคร 10120 กรุงเทพมหานคร', 'กรุงเทพมหานคร', 'A', 'N', '06b44bf0610172a9851a9c78dd3daac4', 0, 'Y', '2021-12-27 16:16:26', 0, 0, 0, 0, 0, 'update_from_max', 30, 0, 0, 0, 0, '', '2017-04-25 13:44:53', '2021-12-30 08:52:44', '328b2650c61f35e6132cd80455cc46603d127519cdd61ea5fc0f05a3edb485ed', 0, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `username_login_seller`
--
ALTER TABLE `username_login_seller`
  ADD PRIMARY KEY (`seller_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `id` (`run_id`),
  ADD KEY `seller_id` (`seller_id`),
  ADD KEY `expired_date` (`expired_date`),
  ADD KEY `expired_time` (`expired_time`),
  ADD KEY `subdomain` (`subdomain`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `username_login_seller`
--
ALTER TABLE `username_login_seller`
  MODIFY `run_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10399;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
