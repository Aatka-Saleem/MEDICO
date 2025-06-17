-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 17, 2025 at 10:20 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hospital_management`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `admin_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`admin_id`, `username`, `password`, `email`, `first_name`, `last_name`, `created_at`, `updated_at`) VALUES
(3, 'manager', 'scrypt:32768:8:1$zuMTJ8lFTrtIjonl$d4d0632672b15c536f6f771130ff338c06df0c53b0128bd3f125d10c698f5bc23b29497350d60d4cb45fe77c2ac4362e64c158b100f807d0f56ee0127d9c1e62', 'manager@gmail.com', 'manager', 'hun ', '2025-04-29 11:10:36', '2025-04-29 11:10:36'),
(4, 'admin', 'scrypt:32768:8:1$QUwqu1sdAafdooUs$f0bdc09e41c5560b206b57e13ceadf065a882e07de281139ecd4621be00dfb6ba37d36d4bec49be00c472c28754a03eb4dd0e93386d684a11426be9278c7e6ff', 'admin@gmail.com', 'Admin', 'hun main', '2025-04-30 06:04:37', '2025-04-30 06:04:37'),
(5, 'neil', 'scrypt:32768:8:1$JJaS7sNxlHCHwDUO$4dd5955fd6f12478c7340be385234505639edd134afa0591e2be216cd9e4fb3e93e9852edbec7e6e7981509a83e62eb58facc485b87464a673af327d5c97f5d2', 'neil@gmail.com', 'neil', 'ghor', '2025-05-01 10:47:05', '2025-05-01 10:47:05');

-- --------------------------------------------------------

--
-- Table structure for table `appointments`
--

CREATE TABLE `appointments` (
  `appointment_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `doctor_id` int(11) NOT NULL,
  `appointment_datetime` datetime NOT NULL,
  `reason` text DEFAULT NULL,
  `status` enum('pending','scheduled','completed','cancelled') DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `appointments`
--

INSERT INTO `appointments` (`appointment_id`, `patient_id`, `doctor_id`, `appointment_datetime`, `reason`, `status`, `created_at`, `updated_at`) VALUES
(24, 25, 26, '2025-05-11 16:05:00', 'very critical condition', 'completed', '2025-05-01 11:02:42', '2025-05-01 11:03:38'),
(25, 26, 21, '2025-05-02 23:36:00', 'Hypertension', 'completed', '2025-05-02 13:58:26', '2025-05-02 13:59:47'),
(26, 28, 13, '2025-05-19 16:50:00', 'i am suffering from cancer', 'completed', '2025-05-11 11:41:43', '2025-05-11 11:47:18'),
(27, 25, 26, '2025-05-21 20:20:00', 'Brain is not Braining', 'scheduled', '2025-05-18 10:17:16', '2025-05-18 10:19:45'),
(28, 29, 14, '2025-05-06 11:30:00', 'high fever', 'pending', '2025-05-20 03:28:12', NULL),
(29, 29, 14, '2025-05-30 00:28:00', 'HIGH FEVER', 'completed', '2025-05-20 03:29:04', '2025-05-20 03:29:55'),
(30, 30, 12, '2000-11-20 21:11:00', 'DEEP CHOT IN DIMAG', 'pending', '2025-05-20 16:12:02', NULL),
(31, 30, 12, '2020-07-20 21:12:00', 'brain ma ghari chot', 'pending', '2025-05-20 16:12:56', NULL),
(32, 30, 13, '2025-04-30 12:15:00', 'last stage cancer\r\n', 'pending', '2025-05-20 16:15:32', NULL),
(33, 30, 17, '2025-05-29 21:19:00', 'high fever\r\n', 'completed', '2025-05-20 16:20:04', '2025-05-20 16:21:36'),
(34, 31, 29, '2025-05-22 12:30:00', 'Diagnosis of cancer in some part of their body.', 'completed', '2025-05-20 16:31:13', '2025-05-20 16:31:35'),
(35, 20, 13, '2025-06-17 17:30:00', 'cemo section', 'completed', '2025-06-16 18:32:07', '2025-06-16 18:33:40'),
(36, 32, 25, '2025-06-17 10:50:00', 'HIGH FEVER\r\n', 'completed', '2025-06-16 18:41:25', '2025-06-16 19:11:02');

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `department_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`department_id`, `name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Cardiology.', 'Specializes in the  diagnosis and treatment of heart and vascular condition.', '2025-04-29 10:40:04', '2025-06-17 06:06:05'),
(2, 'neurology', 'The Neurology department focuses on disorders of the nervous system, including the brain, spinal cord, nerves, and muscles. Neurologists diagnose and treat conditions such as stroke, epilepsy, multiple sclerosis, Parkinson\'s disease, and Alzheimer\'s disease.', '2025-04-29 11:20:51', '2025-04-30 06:55:24'),
(3, 'Oncology', 'This department is dedicated to the care of patients with cancer. Oncologists use various treatment modalities, including chemotherapy, radiation therapy, immunotherapy, and surgical oncology, to manage different types and stages of cancer. They also provide pain management and palliative care.', '2025-04-30 06:55:08', '2025-04-30 06:55:08'),
(4, 'Pediatrics', ' The Pediatrics department provides comprehensive medical care for infants, children, and adolescents. Pediatricians manage a wide range of health issues, from common childhood illnesses to chronic conditions and developmental problems. They also focus on preventive care, vaccinations, and promoting healthy growth.', '2025-04-30 06:56:16', '2025-04-30 06:56:16'),
(5, 'Radiology', 'The Radiology Department uses medical imaging technologies to diagnose and treat diseases. Radiologists interpret images from X-rays, CT scans, MRIs, and ultrasounds to help physicians in other departments make accurate diagnoses. They also perform interventional procedures, such as biopsies and drainages, using imaging guidance.\r\n\r\n', '2025-04-30 06:57:57', '2025-04-30 06:57:57'),
(7, 'Psychiatry', 'The Psychiatry Department specializes in the diagnosis, treatment, and prevention of mental health disorders. Psychiatrists, along with psychologists and other mental health professionals, provide a range of services, including psychotherapy, medication management, and crisis intervention, to address conditions like depression, anxiety, schizophrenia, and bipolar disorder.\r\n\r\n', '2025-04-30 06:59:12', '2025-05-01 06:39:09'),
(9, 'Pulmonology', 'Focuses on lung and respiratory system diseases.', '2025-05-01 06:43:26', '2025-05-01 06:43:26'),
(11, 'urology', 'Focuses on urinary and male reproductive systems.', '2025-05-01 10:42:07', '2025-05-01 10:42:07'),
(12, 'Ophthalmology', 'Eye diseases and vision problems (e.g., cataracts, glaucoma, eye infections).', '2025-05-17 07:16:35', '2025-05-17 07:16:35');

-- --------------------------------------------------------

--
-- Table structure for table `doctors`
--

CREATE TABLE `doctors` (
  `doctor_id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `specialization` varchar(100) DEFAULT NULL,
  `department_id` int(11) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `contact_number` varchar(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `doctors`
--

INSERT INTO `doctors` (`doctor_id`, `first_name`, `last_name`, `specialization`, `department_id`, `email`, `contact_number`, `created_at`, `updated_at`) VALUES
(12, 'Afra', 'Khurrum', 'Brain expert,surgeon', 2, 'Afra@gmail.com', '0316789062', '2025-04-30 05:56:23', '2025-06-16 18:28:53'),
(13, 'Areeba', 'Shakeel', 'Cancer expert', 3, 'areeba@gmail.com', '03452671902', '2025-04-30 07:02:04', '2025-04-30 07:02:04'),
(14, 'Aneeqa', 'Fatima', 'MBBS', 4, 'aneeqa@gmail.com', '9876543211', '2025-04-30 07:03:16', '2025-04-30 07:03:16'),
(15, 'kholah', 'Rehan', 'MBBS', 4, 'khola@gmail.com', '9876543212', '2025-04-30 07:04:00', '2025-04-30 07:04:00'),
(16, 'Naveera', 'Sharif', 'MBBS', 4, 'navera@gmail.com', '03452671902', '2025-04-30 07:05:02', '2025-04-30 07:05:02'),
(17, 'Aatka', 'Aatka', 'MBBS', 5, 'aatkasaleem@gmail.com', '03452671902', '2025-04-30 07:05:39', '2025-04-30 07:05:39'),
(20, 'sitwat', 'samara', 'Stroke, epilepsy, multiple sclerosis', 2, 'samara@gmail.com', '09876543212', '2025-05-01 06:46:48', '2025-05-01 10:48:16'),
(21, 'jung', 'kok', 'Mood disorders, addiction, psychotherapy, child psychiatry', 7, 'jung@gmail.com', '09876543212', '2025-05-01 07:28:17', '2025-05-01 07:28:17'),
(22, 'jin', 'jimin', 'Mood disorders, addiction, psychotherapy, child psychiatry', 7, 'jimin@gmail.com', '09876543212', '2025-05-01 07:57:15', '2025-05-01 07:57:15'),
(24, 'hala', 'suleman', 'sicatrist', 7, 'hala@gmail.com', '9876543212', '2025-05-01 10:23:30', '2025-05-01 10:23:30'),
(25, 'mux', 'demux', 'MBBS', 5, 'musk@gmail.com', '09876543211', '2025-05-01 10:26:41', '2025-05-01 10:27:07'),
(26, 'de', 'coder', 'neuron surgeon', 2, 'decoder@gmail.com', '03452671902', '2025-05-01 10:28:14', '2025-05-01 10:28:14'),
(27, 'mult', 'plier', 'Heart failure, arrhythmia, interventional cardiology', 1, 'mult@gmail.com', '03452671902', '2025-05-01 10:46:01', '2025-05-01 10:46:01'),
(28, 'max', 'well', 'Heart failure, arrhythmia, interventional cardiology', 1, 'max@gmail.com', '03452671902', '2025-05-17 10:11:01', '2025-05-17 10:11:01'),
(29, 'abhira', 'sharma', 'oncologist', 3, 'abhira@gmail.com', '03452671902', '2025-05-20 16:28:08', '2025-05-20 16:28:08');

-- --------------------------------------------------------

--
-- Table structure for table `medicalrecords`
--

CREATE TABLE `medicalrecords` (
  `record_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `doctor_id` int(11) NOT NULL,
  `record_datetime` timestamp NOT NULL DEFAULT current_timestamp(),
  `diagnosis` text DEFAULT NULL,
  `treatment` text DEFAULT NULL,
  `medications` text DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `medicalrecords`
--

INSERT INTO `medicalrecords` (`record_id`, `patient_id`, `doctor_id`, `record_datetime`, `diagnosis`, `treatment`, `medications`, `notes`, `created_at`, `updated_at`) VALUES
(7, 25, 26, '2025-05-01 11:06:45', 'Brain tumors (benign or malignant)', 'Brain or spinal surgeries (tumor removal, decompression, repair)', 'Anti-seizure drugs (e.g., levetiracetam, phenytoin)', 'Chief complaint (reason for visit, e.g., headaches, weakness)', '2025-05-01 11:06:45', '2025-05-01 11:06:45'),
(8, 26, 21, '2025-05-02 14:01:19', 'hypertension', 'meditation', 'Bed rest', 'you have to relax yourself and kindly take no tension', '2025-05-02 14:01:19', '2025-05-02 14:01:19'),
(9, 28, 13, '2025-05-11 11:49:12', 'CANCER LAST STAGE', 'ADMITTED FOR OPERATION', 'DRIPS,INJECTION', 'NEVER LOSE HOPE WE TRY OUR BEST TO RECOVER YOU FROM CANCER LAST STAGE.', '2025-05-11 11:49:12', '2025-05-11 11:49:12'),
(10, 29, 14, '2025-05-20 03:31:19', 'high fever', 'INJECTION', 'PANADOL', 'TWO DAY BED REST', '2025-05-20 03:31:19', '2025-05-20 03:31:19'),
(11, 30, 17, '2025-05-20 16:22:35', 'high fever', 'injection\r\n', 'panadol', 'two days bed rest', '2025-05-20 16:22:35', '2025-05-20 16:22:35'),
(12, 30, 12, '2025-05-20 16:25:48', 'cancer', 'continue', 'kimo', 'admitted', '2025-05-20 16:25:48', '2025-05-20 16:25:48'),
(13, 31, 29, '2025-05-20 16:34:00', 'Diagnosis of cancer in some part of their body.', 'Chemotherapy\r\nPurpose: Kills or slows the growth of cancer cells.\r\n', ' Common drugs: Cyclophosphamide Doxorubicin Cisplatin Paclitaxel', 'Hair loss, nausea, low blood counts, fatigue.', '2025-05-20 16:34:00', '2025-05-20 16:34:00'),
(14, 28, 13, '2025-06-16 18:34:41', 'cancer patient', 'cemo', 'azinoswuysu', 'bed rest', '2025-06-16 18:34:41', '2025-06-16 18:34:41'),
(15, 32, 25, '2025-06-16 18:44:58', 'High Fever', 'Injection', 'panadol', 'rest two days and you will be fine.', '2025-06-16 18:44:58', '2025-06-16 18:44:58'),
(16, 32, 25, '2025-06-16 19:11:50', 'HIGH FEVER', 'DRIP ', 'PANADOL', 'BED REST FOR TWO DAYS TAKE PROPER MEDICINE THANKS!', '2025-06-16 19:11:50', '2025-06-16 19:11:50');

-- --------------------------------------------------------

--
-- Table structure for table `patients`
--

CREATE TABLE `patients` (
  `patient_id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `date_of_birth` date DEFAULT NULL,
  `gender` enum('male','female','other') DEFAULT NULL,
  `contact_number` varchar(20) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patients`
--

INSERT INTO `patients` (`patient_id`, `first_name`, `last_name`, `date_of_birth`, `gender`, `contact_number`, `address`, `email`, `created_at`, `updated_at`) VALUES
(10, 'qasim', 'suleman', '2025-04-26', 'male', '09876543212', 'house no 789', 'qasim@gmail.com', '2025-04-26 11:23:03', '2025-04-26 11:23:03'),
(11, 'mini', 'mino', '2025-04-26', 'female', '09876543212', 'house no 7890', 'moni@gmail.com', '2025-04-26 11:28:05', '2025-04-26 11:28:05'),
(12, 'fiza', 'naz', '2025-03-31', 'female', '09876543211', 'house no 7890', 'fiza@gmail.com', '2025-04-26 13:49:54', '2025-04-26 13:49:54'),
(13, 'muskan', 'alam', '2025-04-16', 'female', '09876543211', 'house no 7890', 'muskan@gmail.com', '2025-04-26 14:00:04', '2025-04-26 14:00:04'),
(14, 'javed', 'shah', '2025-04-07', 'male', '09876543211', 'house no 7890', 'ja@gmail.com', '2025-04-26 14:11:04', '2025-04-26 14:11:04'),
(15, 'bs', 'bhae', '2025-04-26', 'male', '09786543221', 'house no 7890', 'bhae@gmail.com', '2025-04-26 18:52:22', '2025-04-26 18:52:22'),
(16, 'yar', 'bs', '2025-04-27', 'female', '09876543211', 'house no 789', 'yar@gmail.com', '2025-04-27 08:47:49', '2025-04-27 08:47:49'),
(17, 'bin', 'qasim', '2025-05-10', 'male', '09876543211', 'house no 7890', 'bin@gmail.com', '2025-04-27 08:51:34', '2025-04-27 08:51:34'),
(18, 'mirza', 'muzamil', '2025-04-25', 'male', '09876543211', 'house no 7890', 'mirza@gmail.com', '2025-04-28 05:31:48', '2025-04-28 05:31:48'),
(19, 'filzah', 'aqeel', '2025-04-28', 'female', '8219839238238', 'zubair town', 'filah@gmail.com', '2025-04-28 11:01:17', '2025-04-28 11:01:17'),
(20, 'addison', 'smith', '2004-02-28', 'male', '09876543211', 'house no 789', 'addison@gmail.com', '2025-04-28 18:35:19', '2025-04-28 18:35:19'),
(21, 'hel', 'lo', '2025-04-24', 'other', '2738217872', 'milti universe', 'hel@mail.com', '2025-04-29 09:00:51', '2025-04-29 09:00:51'),
(22, 'kpop', 'army', '2008-04-07', 'male', '09876543212', 'house no 7890', 'kpop@gmail.com', '2025-04-29 13:46:04', '2025-04-29 13:46:04'),
(23, 'neural', 'ninja', '2025-05-16', 'female', '', 'house no 7890', 'ninja@gmail.com', '2025-05-01 06:33:14', '2025-05-01 06:33:14'),
(24, 'ninja', 'neural', '2006-02-01', 'male', '03452671902', 'house no 7890', 'neural@gmail.com', '2025-05-01 06:36:33', '2025-05-01 06:36:33'),
(25, 'johr', 'nawaz', '2001-07-01', 'male', '09876543211', 'house no 789', 'johr@gmail.com', '2025-05-01 11:01:48', '2025-05-01 11:01:48'),
(26, 'Amna', 'siddique', '2010-06-02', 'female', '09876543212', 'house no 7890', 'amna@gmail.com', '2025-05-02 13:57:23', '2025-05-02 13:57:23'),
(27, 'John', 'nick', '2025-05-05', 'male', '09876543212', 'house no 7890', 'nick@gmail.com', '2025-05-10 10:35:20', '2025-05-10 10:35:20'),
(28, 'edin', 'jonson', '2007-06-11', 'male', '09876543211', 'house no 789', 'edin@gmail.com', '2025-05-11 11:39:53', '2025-05-11 11:39:53'),
(29, 'humayu', 'saeed', '1992-02-20', 'male', '09876543211', 'house no 987', 'humayu@gmail.com', '2025-05-20 03:27:11', '2025-05-20 03:27:11'),
(30, 'kurlus', 'osman', '2005-10-20', 'male', '09876543211', 'house no 678', 'kurlus@gmail.com', '2025-05-20 16:10:52', '2025-05-20 16:10:52'),
(31, 'arman', 'baloch', '2004-02-20', 'male', '09876543211', 'house no 789', 'baloch@gmail.com', '2025-05-20 16:29:38', '2025-05-20 16:29:38'),
(32, 'AATKA', 'AATKA', '2006-02-16', 'female', '09876543234', 'house no 7890', 'AA@gmail.com', '2025-06-16 18:39:43', '2025-06-16 18:39:43');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','doctor','patient') NOT NULL,
  `admin_id_fk` int(11) DEFAULT NULL,
  `doctor_id_fk` int(11) DEFAULT NULL,
  `patient_id_fk` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `password`, `role`, `admin_id_fk`, `doctor_id_fk`, `patient_id_fk`, `created_at`, `updated_at`) VALUES
(10, 'Malaika', 'scrypt:32768:8:1$FfeE5qMAockjVSrK$f5eba81839d5ef013ec7bedc727251aa96d9c9073f5bbe9996e433fc488f63f152d7883d063a419de3f84f2f92c1293877d6232ab67ce55a3443e47aa9542b37', 'patient', NULL, NULL, NULL, '2025-04-25 17:39:26', '2025-04-25 17:39:26'),
(11, 'khadija', 'scrypt:32768:8:1$wPfJ6Q07ndnxv8IB$73b2a5422b29e39a2478eae7672ba61b15d910f500211896537f01725835e289f39f80d2e914baafe641eb99ab361415412caefa76f865c800b8b95892e5ef7b', 'patient', NULL, NULL, NULL, '2025-04-25 17:42:23', '2025-04-25 17:42:23'),
(12, 'kainat', 'scrypt:32768:8:1$9qgHekbq530JZ9s1$f683b91241d53e1871e8595d72680fc931fba1d51511c51a6da1658216579accc31bc68de6ccbb0392bf6315c60dc739b17eeaa3dce4e0d8490b5cd16489b5eb', 'patient', NULL, NULL, NULL, '2025-04-25 17:55:36', '2025-04-25 17:55:36'),
(13, 'Malka', 'scrypt:32768:8:1$KfJOwb3JfrZFL0lM$c8ae9b035db973d4b25ddf12b356a41032193e6f9dcb63452b459095c68c5b928551f779fc7444650bbac937c10d4456773713cd978079d3de67ff9a5a8b61c5', 'patient', NULL, NULL, NULL, '2025-04-25 17:59:26', '2025-04-25 17:59:26'),
(22, 'qasim', 'scrypt:32768:8:1$9vtcguamhEuZ19Vb$c3447874a83768fd872270d49e3eea56a8956e22dfc8aa16be09e3ba8e77e59ecadee9d0e08ea4dba5319c725b5413b264615b7973e99baa35947dfa76c67124', 'patient', NULL, NULL, 10, '2025-04-26 11:22:20', '2025-04-26 11:23:03'),
(23, 'mini', 'scrypt:32768:8:1$45y2yKklUCTYhsG0$3cdfbe643fd0806fed8321e0c9be9adbf8d67f318b07f137b955ad83742eac5c6eb7f82f9eed674f311b1bfbe17a74e98ce325b9950b322f30ea25894026111c', 'patient', NULL, NULL, 11, '2025-04-26 11:27:36', '2025-04-26 11:28:05'),
(24, 'sana', 'scrypt:32768:8:1$VeGP9YN1HNrA67Ey$0fefe7e9b9c11e8c9e6c99ad424440baa694d8ce23a0ede57063440a895c35174c9674e4d2d92a96e09bdd44ed5d2f9808172ece1c64ed18143ebe9f7bf490dd', 'patient', NULL, NULL, NULL, '2025-04-26 13:12:07', '2025-04-26 13:12:07'),
(25, 'sanam', 'scrypt:32768:8:1$ITCNEboz9DMODePf$5adb29c27a1050b1c5adb10f37a2f7c9345d299a94dde04e9b77339562ccd4e928021050c9be1eec4f36d0bc94f2efb546129cb004713802968b6eba83f0b2fd', 'patient', NULL, NULL, NULL, '2025-04-26 13:15:56', '2025-04-26 13:15:56'),
(26, 'fiza', 'scrypt:32768:8:1$7nltzNQie93cygat$a45ed5debd457d5a52297d68536c7aaad7cb774897974c83723ce9b39b35c5e6d745661c9a5ef94f2e957b6f96ab2eedd81ec0c01ef61d1a64a7937d39e3f37b', 'patient', NULL, NULL, 12, '2025-04-26 13:49:26', '2025-04-26 13:49:54'),
(27, 'muskan', 'scrypt:32768:8:1$AJgV6n5Wwr8X5SzT$1e9ba9ccd92c3df72107059e324f65f6d046e4333c4a3348d70b7fcf079575aef2a7e95824df0b042b6d0cadf3f003796566542c2c1ba3b25673d641e3b6bd7a', 'patient', NULL, NULL, 13, '2025-04-26 13:59:36', '2025-04-26 14:00:04'),
(28, 'javed', 'scrypt:32768:8:1$Pp0uTNGY1mBqjBdM$56c18bbdd447a737a0d890171229a1bcb3dc597f6b498bc1708fd87dbf5b4c4654223326365f3576d8c3def76938c79ee4316d069c9edf630d7acf84d5ce0081', 'patient', NULL, NULL, 14, '2025-04-26 14:10:35', '2025-04-26 14:11:04'),
(29, 'bs', 'scrypt:32768:8:1$oSjbdTiBCUpq0YuB$ee5e63abe42b5637876448142742baf4c2c70d08151377863f14743c1f7237b5eb375dfd5fb6004da6f7a20ca32efa8c1f25c56698d8a27cb396452b683855a4', 'patient', NULL, NULL, 15, '2025-04-26 18:51:45', '2025-04-26 18:52:22'),
(32, 'yar', 'scrypt:32768:8:1$F9NoblwwlrLFoUIU$231c8f2e7cebff0ae71e4d4131bbb5e3a5b14e68dc41a98b7790bfc3c6430331db09a8cea7e8247b0ff6ed505014055d8170518089565d22d274ccb5bd714519', 'patient', NULL, NULL, 16, '2025-04-27 08:47:24', '2025-04-27 08:47:49'),
(33, 'bin', 'scrypt:32768:8:1$ciedXNotbe8KatYr$a2b6de9f271b9b693c3378e7523eb43e39ae257f1afd5f35be031a31c5fa6c08861d6e1390f82bfeda6e253ff469c3618bc4b993444d6915f5e92c1848960d5a', 'patient', NULL, NULL, 17, '2025-04-27 08:51:05', '2025-04-27 08:51:34'),
(35, 'mirza', 'scrypt:32768:8:1$Nq9tci99eCYBLEWp$b45b24dbf46c3d0f092dfb32841af9d9ca85528186963975fd0182f59383b83d9a7d10859b98b29faf92ac8feb2a299f4c13ce868407958315b2767326ae0499', 'patient', NULL, NULL, 18, '2025-04-28 05:31:08', '2025-04-28 05:31:48'),
(36, 'filzah', 'scrypt:32768:8:1$vVlZvlB2mzq6ldGM$4e7a664736c12c719d94303bcf80f743969959a4e679bbe3caa4fbc6e445152cd6d57f9bc320d885a1353e7786989fc2f8f17b0f300fbf7b58677fce948af821', 'patient', NULL, NULL, 19, '2025-04-28 11:00:25', '2025-04-28 11:01:17'),
(37, 'addison', 'scrypt:32768:8:1$FtEcXOUPp7hKPt5y$d869f08dcf54488330bc6082f41ec88424c523b36742d84bc4a9010289338936ca21d0f1df3fd518b10904a43adf1b3d6f5fa6c16474296be027d282cc66eb71', 'patient', NULL, NULL, 20, '2025-04-28 18:34:21', '2025-04-28 18:35:19'),
(38, 'boss', 'scrypt:32768:8:1$0HRnpHVezsaQYjXD$f4c04627f74c391740d34c1ff08fcc3c325c6c819672eb4d1b0ab9e0f3c90d37c4467923009e3e663bc834514c3a51b7a4abaca478d711dd0709df8dae4ad360', 'admin', NULL, NULL, NULL, '2025-04-29 06:19:53', '2025-04-29 06:19:53'),
(39, 'bilal', 'scrypt:32768:8:1$cqI9yttg4BDnsgo6$be9149f373fe4d49cc2919d3f487a7d5004e6b59c986efebd9482e305ab6d04c026197674ba769e8037721ed3f058d834226b5b9b3a20fdbc600f4ffe90c665c', 'patient', NULL, NULL, NULL, '2025-04-29 07:56:55', '2025-04-29 07:56:55'),
(40, 'hel', 'scrypt:32768:8:1$EZylcev4dz7obHaS$d1da12423b78b7d9f86399d3993a610bd72c3c8247c7f3afc43ac5b802f3375861288c8b774e3cee7bdd2914f329a1957ccb0b1c77c913bd6031ca355dd9c9b2', 'patient', NULL, NULL, 21, '2025-04-29 08:59:53', '2025-04-29 09:00:51'),
(42, 'manager', 'scrypt:32768:8:1$wnH6eDF1loYQzteo$02c7732a2cfef02bb48c6f2960fa66e42245bf4ec6cad490ceda9e0aa14d0c310de4d4c7b7d6fcf4f5c5e46b7109aff2282cffe9dcd6e6ff6b63a9ee644bf4a6', 'admin', 3, NULL, NULL, '2025-04-29 11:10:36', '2025-04-29 11:10:36'),
(43, 'kpop', 'scrypt:32768:8:1$imIS3JlaMhdYr0QL$c04b79eb3545758f1b2d9128d0e56af92a2d2d6d0598c02bf28a4ca4c8f8d1f3ba588fd5521c936ee6d0986294c4fdf30ede56e3352ee91ec1d99290f9d7d71b', 'patient', NULL, NULL, 22, '2025-04-29 13:44:50', '2025-04-29 13:46:04'),
(44, 'emaan', 'scrypt:32768:8:1$tCkTlHksrbioB2R1$a2eab7c26f6a4b2b2d0c8252f7d790933a5d190d53ccec8695c4341032c17fc98e7aed7b2ab63a54015351930f6f6619bcbd84f81200741719a4aafceea0e993', 'patient', NULL, NULL, NULL, '2025-04-30 05:34:01', '2025-04-30 05:34:01'),
(46, 'afra', 'scrypt:32768:8:1$ukdaAs70vsiGR8cP$584685f2a0f7b0d228dc4aa68cd23bc81a9d28f9e71b43b6a164389acf04fd604302f27c363973549c2efab38f7a410ea6379420b07305f3becdbcff5564b801', 'doctor', NULL, 12, NULL, '2025-04-30 05:56:23', '2025-04-30 05:56:23'),
(47, 'admin', 'scrypt:32768:8:1$bX7dpyzHW07yCBRr$e3c414d29422fca584f35f671f4aebb3b47499ab72bbc2a45a0d94c0e2451d4af12aacdd4a087f2e99caa8c9e5e1d08fc3c02e7547b7e5d3619a43b97ddc719f', 'admin', 4, NULL, NULL, '2025-04-30 06:04:37', '2025-04-30 06:04:37'),
(48, 'areeba', 'scrypt:32768:8:1$4c8WJsE35PC2I1Vk$d85cc374a22f9633a7a4813ce3b27292f337a3361833ca3b51688d3dfa623401cd37d871f7027e98d9aa7982eac950b9eae7513e94d04d948407ad8f64767e6a', 'doctor', NULL, 13, NULL, '2025-04-30 07:02:04', '2025-04-30 07:02:04'),
(49, 'aneeqa', 'scrypt:32768:8:1$EkMcdeNqI3wZOMr1$ae666fdbfe9cca14082b0ae292f07ac7f666e065abfd485e085c75b450d86e84657aa58f380398708b54df106440b5f1f893241b8e2a1ff85f46154d89e1669d', 'doctor', NULL, 14, NULL, '2025-04-30 07:03:16', '2025-04-30 07:03:16'),
(50, 'khola', 'scrypt:32768:8:1$tzjIH8LFvTOhO4ri$7a667f287d6e47c4fd09efb7d17e2576ce7055e9730853c65dd838ba5476669739d1a162e33223c1b7ec008d1314bc141548e11ee53bfd45fa46c35389b499ec', 'doctor', NULL, 15, NULL, '2025-04-30 07:04:00', '2025-04-30 07:04:00'),
(51, 'Naveera', 'scrypt:32768:8:1$Y7KyBBRqL0RitrcV$54ecfeb0f02f97193c1ff887b2d85643b3bf85f099efaf94cd7d5aa65405356700decb118156a385e8b4b23352bc2857e9341e404d55d647853cf3c61c0d401e', 'doctor', NULL, 16, NULL, '2025-04-30 07:05:02', '2025-04-30 07:05:02'),
(52, 'atka', 'scrypt:32768:8:1$uu3geTyYTzKMCchm$9a5b2fb8c1fa20918fda299a02812fe894efbc48cd7a7d90758e7972595795fc7a8dec0a78e01062b5b8838111fe4043746245b73c614a706208425fbf90cee5', 'doctor', NULL, 17, NULL, '2025-04-30 07:05:39', '2025-04-30 07:05:39'),
(54, 'zoha', 'scrypt:32768:8:1$mBgpDbYVvuH7XJhS$1f401cba4a14f28931d6c1e040034be438cd53d2cc26b8786ca121e39859700ece96d5a14cd4418014d9b455a25fdb8ec5a15cecf2b2f145f4138d7c9942dcb4', 'doctor', NULL, NULL, NULL, '2025-04-30 07:10:01', '2025-05-18 06:48:35'),
(55, 'neural', 'scrypt:32768:8:1$dtOvbt0VLfdY3a8X$bb77b9b8acd3973d0d06f0b35836d59965977d34de2f5754f0b73850d89772bae91670f638c7f257677e2c891135da85f2074c1501d935f726fd4b61e682e885', 'patient', NULL, NULL, 23, '2025-05-01 06:32:16', '2025-05-01 06:33:14'),
(56, 'ninja', 'scrypt:32768:8:1$7WTcSiFXOvJyjBmE$8e6a8c949fe7d09b24d338fdedbb4c34f555e93a838f7092af49b78d48d3544ef3302af318b98e1158288200931365b5de0ffaa50bbd385ade854145c3b70c48', 'patient', NULL, NULL, 24, '2025-05-01 06:35:51', '2025-05-01 06:36:33'),
(57, 'ss', 'scrypt:32768:8:1$QwN3IYZ6Sz9JvmKu$cd3c692674f0e44cbe20301e36853686ca6cd6e3b976873aea28466186754f1516ec328517b9ba5210e73ed9aca3ef68bee4cbb71956d56f4606b7ff74ed869d', 'doctor', NULL, 20, NULL, '2025-05-01 06:46:48', '2025-05-01 06:46:48'),
(58, 'jungkok', 'scrypt:32768:8:1$OP1mpHyntSqPFwmM$47d03eb0c543f6209008224a008c8637ab97d4bbd42f169099a6598f984d92ffab0f1a02b9a01794146a795fc682d949f3cc100c936e214cc02f2eb71c340fb7', 'doctor', NULL, 21, NULL, '2025-05-01 07:28:17', '2025-05-01 07:28:17'),
(59, 'jimin', 'scrypt:32768:8:1$MO3MQh4SdP3haV4C$966266d244e6f50f0bb5fcaade23bb902ced2b43eb0864ddcda07888951b9ed893bbeb836b2e96a0ae0668e959d54453d2c49f81bd6cda3d3b2cefeda3286409', 'doctor', NULL, 22, NULL, '2025-05-01 07:57:15', '2025-05-01 07:57:15'),
(60, 'jehan', 'scrypt:32768:8:1$OON3tPkUsRiwNOLi$b02b5b21bb2f4d90d0017db2794c674bc71fb3c917657517e3432323b16bedadb624f0e7e442f6f174c745766e7e4a9b5b832dcc44cd7a988e3100950c45f836', 'doctor', NULL, NULL, NULL, '2025-05-01 10:22:11', '2025-05-01 10:22:18'),
(61, 'hala', 'scrypt:32768:8:1$cJfan3iV6u5MxWPO$5f0a937232c88e4d67d90ab84fc2b52fbdb376574b0984d4eca369884671bb1af3226d978a67eea463cf7124435baa9c16ec3865aaed5160571ad91d12d31d1f', 'doctor', NULL, 24, NULL, '2025-05-01 10:23:30', '2025-05-01 10:23:30'),
(62, 'mux', 'scrypt:32768:8:1$h9Rrj2Znnd1CSvqR$dca748cad703543a89bf1438c7ee87d3624362273b7e328d5c4d1a30d2528d6bd407c5a73764195ab21a23cbb06300cfaa63b7d0ae9e17c41282f4fbce0b0813', 'doctor', NULL, 25, NULL, '2025-05-01 10:26:41', '2025-05-01 10:26:41'),
(63, 'decoder', 'scrypt:32768:8:1$KVsA2TvAONGQbuLk$031ad66d3062b32de888bef3e320e5395c83296e1604f02537ca81e59feb926c572396bbc27f19fab2282411ee1b865c355cae646dbce6ae73782d65d64caf71', 'doctor', NULL, 26, NULL, '2025-05-01 10:28:14', '2025-05-01 10:28:14'),
(64, 'mutilplier', 'scrypt:32768:8:1$PoytyR6Rl6TCzTHS$b8d0f762cd75534b543d1dca86866137aa3285c51e093759b3e00d63a0e1f92d2917dd333eba6be1bdc5da6fb9973849d5284614bd3bd3ab371ae41f44f8d2dc', 'doctor', NULL, 27, NULL, '2025-05-01 10:46:01', '2025-05-01 10:46:01'),
(65, 'neil', 'scrypt:32768:8:1$GJZ2AhunBpEquPch$2a7518aa9a0e87f7c03a2b3e8c5616300ec9d5571fb7a42df94d1174c9a39acf7e36170b40c10c118d8ccfaeae1a7adf52e236b0b00fc0edc864252c264a4f98', 'admin', 5, NULL, NULL, '2025-05-01 10:47:05', '2025-05-01 10:47:05'),
(66, 'johr', 'scrypt:32768:8:1$LapmnWzyuwiHs0G6$626241f3339c4c30e5a30d9dfc05ae314388bbecc4d1d11c9851a4d1d4a4db959826cdc84f45b527c92c61cff4f165c048888f8a2c0208a938221ce1ff5da9f5', 'patient', NULL, NULL, 25, '2025-05-01 11:00:39', '2025-05-01 11:01:48'),
(67, 'Amna', 'scrypt:32768:8:1$hqQnrvME8Y7kcEHu$b9ae3e6d5afd43a1a0178ceec70c716a94ad2194ace38ce59cf67b772aa3da46e453a93a8cc9630315471416be09986a02303f36d19a4cc0b47c3a11f9855a7d', 'patient', NULL, NULL, 26, '2025-05-02 13:56:14', '2025-05-02 13:57:23'),
(68, 'NICK', 'scrypt:32768:8:1$wFsyIHbvTJ5yuVr8$ffe09ae6a236cbc19c9b76106ddfaccdaaa5c8b22e3f792e6870de03fbe1e4a0ebef7499239d43ffde105f007940ee9d2f29ca26115df924855dbe189b9f7713', 'patient', NULL, NULL, 27, '2025-05-10 10:34:52', '2025-05-10 10:35:20'),
(69, 'Edin', 'scrypt:32768:8:1$b8PFjnV1GAX1n8O5$0cf5873f2c62d2dd400ff7be9d3abb26fda9d7563433bad8763e5675358b832dbe23b010a25d6fada33390ed3a08a1f8fb5678a49a84562a6462477b29a4676d', 'patient', NULL, NULL, 28, '2025-05-11 11:38:35', '2025-05-11 11:39:53'),
(70, 'Max', 'scrypt:32768:8:1$2bVKbzCFhSVBdzyE$9da816ace3cafdfe824f17a37ef0ed9523c6d9fa11e3fc7ee66bddede7a4631a4e9276be73571a47af9eab9162e3e2b02ad1e7cdb65442f902fe00f14b39690f', 'doctor', NULL, 28, NULL, '2025-05-17 10:11:01', '2025-05-17 10:11:01'),
(71, 'humayu', 'scrypt:32768:8:1$CkqjcXenGqImrWla$bb5d733a2e264c061484b4a7d00993347ea876cdcfaad29d36b049d36ce6a05b889d9a45c60304d915bf53d8802ba65f8dcfebf9eaf4a8aeb6f0c3b7db3f9824', 'patient', NULL, NULL, 29, '2025-05-20 03:26:02', '2025-05-20 03:27:11'),
(72, 'kurlus', 'scrypt:32768:8:1$NddyJDuAY5KXHFpH$3a0ccf70a0ff0335261d1664739681e435e2afa8548d756dc0fb7245f6831da20e3bf79730bfd2b9ca9dc3856367474b4b38c5968627610ac50e18bb764be573', 'patient', NULL, NULL, 30, '2025-05-20 16:09:58', '2025-05-20 16:10:52'),
(73, 'abhira', 'scrypt:32768:8:1$nPyuLw5bRiEGQoGn$fa5298800d54007d6a7845e9d0ac163b8f274ae79352615d779f0919212f8fd89089c1a9a7b45988e4866abc70dd92312715094db375ad40552885a2571136f9', 'doctor', NULL, 29, NULL, '2025-05-20 16:28:08', '2025-05-20 16:28:08'),
(74, 'arman', 'scrypt:32768:8:1$uy3P10wkDJjUktPQ$bfb25f500c967249ca838195fea45cd00b42feecf687a7e178565d208e678821863a22829ded309a30f7a9eeb807bcab67cc05ea72fadedf1d628a591ba8242f', 'patient', NULL, NULL, 31, '2025-05-20 16:28:53', '2025-05-20 16:29:38'),
(75, 'AATKA', 'scrypt:32768:8:1$pXYGTw14kRTq7Fjf$a5a0423d208d9409c0858369982d10ffbdc14add87440ad46898ebc307b54f44e461cab78bc8994cf0a0219567cdb801457d7c18321c683a81c69d33d3363bb0', 'patient', NULL, NULL, 32, '2025-06-16 18:38:31', '2025-06-16 18:39:43'),
(76, 'Malhan', 'scrypt:32768:8:1$ITOsgrKIYHQ3AOqI$8f0d270fa3f2a9ffeb3b1b8856cefe2ae33a854ceee3d860c21403d7d331557220d011307fa028a6f876ad3c058b78446ab5687e6b6dab4b694e381e3a347117', 'doctor', NULL, NULL, NULL, '2025-06-17 06:07:39', '2025-06-17 06:07:51');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`admin_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `appointments`
--
ALTER TABLE `appointments`
  ADD PRIMARY KEY (`appointment_id`),
  ADD KEY `patient_id` (`patient_id`),
  ADD KEY `doctor_id` (`doctor_id`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`department_id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `doctors`
--
ALTER TABLE `doctors`
  ADD PRIMARY KEY (`doctor_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `medicalrecords`
--
ALTER TABLE `medicalrecords`
  ADD PRIMARY KEY (`record_id`),
  ADD KEY `patient_id` (`patient_id`),
  ADD KEY `doctor_id` (`doctor_id`);

--
-- Indexes for table `patients`
--
ALTER TABLE `patients`
  ADD PRIMARY KEY (`patient_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `admin_id_fk` (`admin_id_fk`),
  ADD KEY `doctor_id_fk` (`doctor_id_fk`),
  ADD KEY `patient_id_fk` (`patient_id_fk`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `appointments`
--
ALTER TABLE `appointments`
  MODIFY `appointment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `department_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `doctors`
--
ALTER TABLE `doctors`
  MODIFY `doctor_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `medicalrecords`
--
ALTER TABLE `medicalrecords`
  MODIFY `record_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `patients`
--
ALTER TABLE `patients`
  MODIFY `patient_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appointments`
--
ALTER TABLE `appointments`
  ADD CONSTRAINT `appointments_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`),
  ADD CONSTRAINT `appointments_ibfk_2` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`doctor_id`);

--
-- Constraints for table `medicalrecords`
--
ALTER TABLE `medicalrecords`
  ADD CONSTRAINT `medicalrecords_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `medicalrecords_ibfk_2` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`doctor_id`) ON DELETE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`admin_id_fk`) REFERENCES `admins` (`admin_id`),
  ADD CONSTRAINT `users_ibfk_2` FOREIGN KEY (`doctor_id_fk`) REFERENCES `doctors` (`doctor_id`),
  ADD CONSTRAINT `users_ibfk_3` FOREIGN KEY (`patient_id_fk`) REFERENCES `patients` (`patient_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
