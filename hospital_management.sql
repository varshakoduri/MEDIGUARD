-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 02, 2024 at 02:33 PM
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
-- Database: `hospital_management`
--

-- --------------------------------------------------------

--
-- Table structure for table `doctor`
--

CREATE TABLE `doctor` (
  `DoctorID` varchar(255) NOT NULL,
  `DoctorName` varchar(255) DEFAULT NULL,
  `DoctorPhoneNo` bigint(20) DEFAULT NULL,
  `AboutMe` text DEFAULT NULL,
  `DoctorPic` blob DEFAULT NULL,
  `Password` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `doctor`
--

INSERT INTO `doctor` (`DoctorID`, `DoctorName`, `DoctorPhoneNo`, `AboutMe`, `DoctorPic`, `Password`) VALUES
('doc1@example.com', 'Dr. Alice Johnson', 1234567890, 'Cardiologist with 10 years of experience.', NULL, 'password123'),
('doc2@example.com', 'Dr. Bob Smith', 9876543210, 'Pediatrician specializing in child healthcare.', NULL, 'password456');

-- --------------------------------------------------------

--
-- Table structure for table `doctornotes`
--

CREATE TABLE `doctornotes` (
  `NoteID` int(11) NOT NULL,
  `DoctorID` varchar(255) DEFAULT NULL,
  `NurseID` varchar(255) DEFAULT NULL,
  `PatientID` varchar(255) DEFAULT NULL,
  `Note` text DEFAULT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `doctornotes`
--

INSERT INTO `doctornotes` (`NoteID`, `DoctorID`, `NurseID`, `PatientID`, `Note`, `Timestamp`) VALUES
(1, 'doc1@example.com', 'nurse1@example.com', 'pat1@example.com', 'Prescribed medication for patient.', '2024-06-02 10:55:48'),
(2, 'doc1@example.com', 'nurse1@example.com', 'pat1@example.com', 'Scheduled follow-up appointment for patient.', '2024-06-02 10:55:48'),
(3, 'doc1@example.com', 'nurse1@example.com', 'pat1@example.com', 'Provided counseling to patient.', '2024-06-02 10:55:48');

-- --------------------------------------------------------

--
-- Table structure for table `nurse`
--

CREATE TABLE `nurse` (
  `NurseID` varchar(255) NOT NULL,
  `NurseName` varchar(255) DEFAULT NULL,
  `NursePhoneNo` bigint(20) DEFAULT NULL,
  `AboutMe` text DEFAULT NULL,
  `NursePic` blob DEFAULT NULL,
  `Password` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `nurse`
--

INSERT INTO `nurse` (`NurseID`, `NurseName`, `NursePhoneNo`, `AboutMe`, `NursePic`, `Password`) VALUES
('nurse1@example.com', 'Nurse Emily Davis', 8888888888, 'Experienced cardiac nurse.', NULL, 'password789'),
('nurse2@example.com', 'Nurse Frank Miller', 9999999999, 'Specializes in hypertension cases.', NULL, 'password101'),
('nurse3@example.com', 'Nurse Grace Lee', 1010101010, 'Pediatric nurse.', NULL, 'password112'),
('nurse4@example.com', 'Nurse Henry Wilson', 2020202020, 'Experienced in managing diabetes.', NULL, 'password131');

-- --------------------------------------------------------

--
-- Table structure for table `nursenotes`
--

CREATE TABLE `nursenotes` (
  `NoteID` int(11) NOT NULL,
  `NurseID` varchar(255) DEFAULT NULL,
  `DoctorID` varchar(255) DEFAULT NULL,
  `PatientID` varchar(255) DEFAULT NULL,
  `Note` text DEFAULT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `nursenotes`
--

INSERT INTO `nursenotes` (`NoteID`, `NurseID`, `DoctorID`, `PatientID`, `Note`, `Timestamp`) VALUES
(1, 'nurse1@example.com', 'doc1@example.com', 'pat1@example.com', 'Patient shows improvement in condition.', '2024-06-02 10:55:48'),
(2, 'nurse1@example.com', 'doc1@example.com', 'pat1@example.com', 'Ordered additional tests for patient.', '2024-06-02 10:55:48'),
(3, 'nurse1@example.com', 'doc1@example.com', 'pat1@example.com', 'Patient discharged from hospital.', '2024-06-02 10:55:48');

-- --------------------------------------------------------

--
-- Table structure for table `patient`
--

CREATE TABLE `patient` (
  `PatientID` varchar(255) NOT NULL,
  `DoctorID` varchar(255) NOT NULL,
  `NurseID` varchar(255) DEFAULT NULL,
  `PatientDisease` text DEFAULT NULL,
  `PhoneNumber` bigint(20) DEFAULT NULL,
  `Password` varchar(255) DEFAULT NULL,
  `PatientName` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patient`
--

INSERT INTO `patient` (`PatientID`, `DoctorID`, `NurseID`, `PatientDisease`, `PhoneNumber`, `Password`, `PatientName`) VALUES
('pat1@example.com', 'doc1@example.com', 'nurse1@example.com', 'Heart Disease', 1111111111, 'password214', 'John Doe'),
('pat2@example.com', 'doc1@example.com', 'nurse1@example.com', 'Hypertension', 2222222222, 'password315', 'Jane Smith'),
('pat3@example.com', 'doc1@example.com', 'nurse2@example.com', 'Arrhythmia', 3333333333, 'password416', 'Michael Johnson'),
('pat4@example.com', 'doc2@example.com', 'nurse3@example.com', 'Asthma', 4444444444, 'password517', 'Emily Brown'),
('pat5@example.com', 'doc2@example.com', 'nurse3@example.com', 'Diabetes', 5555555555, 'password618', 'William Davis'),
('pat6@example.com', 'doc2@example.com', 'nurse4@example.com', 'Chickenpox', 6666666666, 'password719', 'Emma Wilson'),
('pat7@example.com', 'doc2@example.com', 'nurse4@example.com', 'Measles', 7777777777, 'password820', 'James Taylor');

-- --------------------------------------------------------

--
-- Table structure for table `pill`
--

CREATE TABLE `pill` (
  `PillID` int(11) NOT NULL,
  `PatientID` varchar(255) DEFAULT NULL,
  `NumberOfPills` int(11) DEFAULT NULL,
  `PillName` varchar(255) DEFAULT NULL,
  `PillTime` time DEFAULT NULL,
  `PillDuration` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pill`
--

INSERT INTO `pill` (`PillID`, `PatientID`, `NumberOfPills`, `PillName`, `PillTime`, `PillDuration`) VALUES
(1, 'pat1@example.com', 250, 'Aspirin', '08:00:00', '30 days'),
(2, 'pat1@example.com', 400, 'Ibuprofen', '12:00:00', '45 days'),
(3, 'pat1@example.com', 150, 'Metformin', '18:00:00', '60 days'),
(4, 'pat1@example.com', 200, 'Atorvastatin', '20:00:00', '90 days'),
(5, 'pat1@example.com', 100, 'Omeprazole', '22:00:00', '30 days'),
(6, 'pat2@example.com', 500, 'Paracetamol', '08:00:00', '30 days'),
(7, 'pat2@example.com', 100, 'Amlodipine', '12:00:00', '60 days'),
(8, 'pat2@example.com', 200, 'Losartan', '18:00:00', '90 days'),
(9, 'pat2@example.com', 150, 'Lisinopril', '20:00:00', '30 days'),
(10, 'pat2@example.com', 250, 'Clopidogrel', '22:00:00', '45 days'),
(11, 'pat3@example.com', 50, 'Metoprolol', '08:00:00', '90 days'),
(12, 'pat3@example.com', 75, 'Simvastatin', '12:00:00', '30 days'),
(13, 'pat3@example.com', 100, 'Furosemide', '18:00:00', '45 days'),
(14, 'pat3@example.com', 120, 'Digoxin', '20:00:00', '60 days'),
(15, 'pat3@example.com', 200, 'Warfarin', '22:00:00', '90 days'),
(16, 'pat4@example.com', 3, 'Salbutamol', '08:00:00', '30 days'),
(17, 'pat4@example.com', 100, 'Theophylline', '12:00:00', '45 days'),
(18, 'pat4@example.com', 250, 'Amoxicillin', '18:00:00', '60 days'),
(19, 'pat4@example.com', 300, 'Ciprofloxacin', '20:00:00', '90 days'),
(20, 'pat4@example.com', 400, 'Doxycycline', '22:00:00', '30 days'),
(21, 'pat5@example.com', 100, 'Levothyroxine', '08:00:00', '30 days'),
(22, 'pat5@example.com', 200, 'Methimazole', '12:00:00', '45 days'),
(23, 'pat5@example.com', 300, 'Metronidazole', '18:00:00', '60 days'),
(24, 'pat5@example.com', 400, 'Prednisone', '20:00:00', '90 days'),
(25, 'pat5@example.com', 500, 'Hydrochlorothiazide', '22:00:00', '30 days'),
(26, 'pat6@example.com', 150, 'Gabapentin', '08:00:00', '30 days'),
(27, 'pat6@example.com', 250, 'Pregabalin', '12:00:00', '45 days'),
(28, 'pat6@example.com', 300, 'Sertraline', '18:00:00', '60 days'),
(29, 'pat6@example.com', 350, 'Fluoxetine', '20:00:00', '90 days'),
(30, 'pat6@example.com', 400, 'Citalopram', '22:00:00', '30 days'),
(31, 'pat7@example.com', 500, 'Bupropion', '08:00:00', '30 days'),
(32, 'pat7@example.com', 600, 'Venlafaxine', '12:00:00', '45 days'),
(33, 'pat7@example.com', 700, 'Duloxetine', '18:00:00', '60 days'),
(34, 'pat7@example.com', 800, 'Mirtazapine', '20:00:00', '90 days'),
(35, 'pat7@example.com', 900, 'Aripiprazole', '22:00:00', '30 days'),
(36, 'pat1@example.com', NULL, 'aspirin', '08:52:00', '23'),
(37, 'pat1@example.com', 250, 'aspirin', '09:29:00', '2'),
(38, 'pat1@example.com', 250, 'pill1', '09:30:00', '27 days'),
(39, 'pat1@example.com', 250, 'pill2', '15:41:00', '27 days'),
(40, 'pat1@example.com', 250, 'pill3', '17:37:00', '27 days'),
(41, 'pat1@example.com', 250, 'thyronorm', '17:00:00', '30 days');

-- --------------------------------------------------------

--
-- Table structure for table `track`
--

CREATE TABLE `track` (
  `Date` date NOT NULL,
  `PillID` int(11) NOT NULL,
  `PatientID` varchar(255) NOT NULL,
  `Time` time DEFAULT NULL,
  `PillTakenOrNot` tinyint(1) DEFAULT NULL,
  `Image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `track`
--

INSERT INTO `track` (`Date`, `PillID`, `PatientID`, `Time`, `PillTakenOrNot`, `Image`) VALUES
('2024-06-02', 1, 'pat1@example.com', '13:07:12', 1, '/static/sample_image.jpg'),
('2024-06-02', 2, 'pat1@example.com', '17:40:09', 1, NULL),
('2024-06-02', 3, 'pat1@example.com', '17:56:33', 1, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `doctor`
--
ALTER TABLE `doctor`
  ADD PRIMARY KEY (`DoctorID`);

--
-- Indexes for table `doctornotes`
--
ALTER TABLE `doctornotes`
  ADD PRIMARY KEY (`NoteID`),
  ADD KEY `DoctorID` (`DoctorID`),
  ADD KEY `NurseID` (`NurseID`),
  ADD KEY `PatientID` (`PatientID`);

--
-- Indexes for table `nurse`
--
ALTER TABLE `nurse`
  ADD PRIMARY KEY (`NurseID`);

--
-- Indexes for table `nursenotes`
--
ALTER TABLE `nursenotes`
  ADD PRIMARY KEY (`NoteID`),
  ADD KEY `NurseID` (`NurseID`),
  ADD KEY `DoctorID` (`DoctorID`),
  ADD KEY `PatientID` (`PatientID`);

--
-- Indexes for table `patient`
--
ALTER TABLE `patient`
  ADD PRIMARY KEY (`PatientID`,`DoctorID`),
  ADD KEY `DoctorID` (`DoctorID`),
  ADD KEY `NurseID` (`NurseID`);

--
-- Indexes for table `pill`
--
ALTER TABLE `pill`
  ADD PRIMARY KEY (`PillID`),
  ADD KEY `PatientID` (`PatientID`);

--
-- Indexes for table `track`
--
ALTER TABLE `track`
  ADD PRIMARY KEY (`Date`,`PillID`,`PatientID`),
  ADD KEY `PillID` (`PillID`),
  ADD KEY `PatientID` (`PatientID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `doctornotes`
--
ALTER TABLE `doctornotes`
  MODIFY `NoteID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `nursenotes`
--
ALTER TABLE `nursenotes`
  MODIFY `NoteID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `pill`
--
ALTER TABLE `pill`
  MODIFY `PillID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `doctornotes`
--
ALTER TABLE `doctornotes`
  ADD CONSTRAINT `doctornotes_ibfk_1` FOREIGN KEY (`DoctorID`) REFERENCES `doctor` (`DoctorID`),
  ADD CONSTRAINT `doctornotes_ibfk_2` FOREIGN KEY (`NurseID`) REFERENCES `nurse` (`NurseID`),
  ADD CONSTRAINT `doctornotes_ibfk_3` FOREIGN KEY (`PatientID`) REFERENCES `patient` (`PatientID`);

--
-- Constraints for table `nursenotes`
--
ALTER TABLE `nursenotes`
  ADD CONSTRAINT `nursenotes_ibfk_1` FOREIGN KEY (`NurseID`) REFERENCES `nurse` (`NurseID`),
  ADD CONSTRAINT `nursenotes_ibfk_2` FOREIGN KEY (`DoctorID`) REFERENCES `doctor` (`DoctorID`),
  ADD CONSTRAINT `nursenotes_ibfk_3` FOREIGN KEY (`PatientID`) REFERENCES `patient` (`PatientID`);

--
-- Constraints for table `patient`
--
ALTER TABLE `patient`
  ADD CONSTRAINT `patient_ibfk_1` FOREIGN KEY (`DoctorID`) REFERENCES `doctor` (`DoctorID`),
  ADD CONSTRAINT `patient_ibfk_2` FOREIGN KEY (`NurseID`) REFERENCES `nurse` (`NurseID`);

--
-- Constraints for table `pill`
--
ALTER TABLE `pill`
  ADD CONSTRAINT `pill_ibfk_1` FOREIGN KEY (`PatientID`) REFERENCES `patient` (`PatientID`);

--
-- Constraints for table `track`
--
ALTER TABLE `track`
  ADD CONSTRAINT `track_ibfk_1` FOREIGN KEY (`PillID`) REFERENCES `pill` (`PillID`),
  ADD CONSTRAINT `track_ibfk_2` FOREIGN KEY (`PatientID`) REFERENCES `patient` (`PatientID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
