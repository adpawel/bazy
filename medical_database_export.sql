
-- Tabela pacjenci
CREATE TABLE pacjenci (
    id_pacjenta INTEGER PRIMARY KEY,
    nazwa VARCHAR(130) NOT NULL,
    data_urodzenia DATE NOT NULL,
    pesel CHARACTER(11) NOT NULL
);

-- Tabela lekarze
CREATE TABLE lekarze (
    id_lekarza INTEGER PRIMARY KEY,
    nazwa VARCHAR(130) NOT NULL,
    specjalizacje VARCHAR[] NOT NULL
);

-- Tabela konsultacje
CREATE TABLE konsultacje (
    id_konsultacji INTEGER PRIMARY KEY,
    id_lekarza INTEGER NOT NULL REFERENCES lekarze(id_lekarza),
    id_pacjenta INTEGER REFERENCES pacjenci(id_pacjenta),
    termin TIMESTAMP NOT NULL,
    specjalizacja VARCHAR(30) NOT NULL,
    cena NUMERIC(7,2) NOT NULL,
    zrealizowana BOOLEAN NOT NULL DEFAULT FALSE
);

-- Tabela badania
CREATE TABLE badania (
    id_badania INTEGER PRIMARY KEY,
    nazwa VARCHAR(50) NOT NULL,
    cena NUMERIC(7,2) NOT NULL,
    na_czczo BOOLEAN NOT NULL
);

-- Tabela zlecenia
CREATE TABLE zlecenia (
    id_zlecenia INTEGER PRIMARY KEY,
    id_pacjenta INTEGER NOT NULL REFERENCES pacjenci(id_pacjenta),
    id_lekarza INTEGER NOT NULL REFERENCES lekarze(id_lekarza),
    id_badania INTEGER NOT NULL REFERENCES badania(id_badania),
    data_wystawienia DATE NOT NULL,
    data_realizacji DATE
);

-- Wstawianie danych do pacjenci
INSERT INTO pacjenci (id_pacjenta, nazwa, data_urodzenia, pesel) VALUES
(1, 'Pacjent_1', '2001-11-07', '2212274869'),
(2, 'Pacjent_2', '1970-09-16', '7803054445'),
(3, 'Pacjent_3', '1976-12-27', '1311251190'),
(4, 'Pacjent_4', '1944-09-04', '8707216244'),
(5, 'Pacjent_5', '1952-01-12', '0906089783'),
(6, 'Pacjent_6', '1978-12-31', '5108259967'),
(7, 'Pacjent_7', '1958-05-17', '1309069835'),
(8, 'Pacjent_8', '1969-04-30', '4408157221'),
(9, 'Pacjent_9', '1976-02-04', '4505138699'),
(10, 'Pacjent_10', '1943-01-17', '3912205166'),
(11, 'Pacjent_11', '1940-08-01', '6703015610'),
(12, 'Pacjent_12', '1950-07-06', '1405224840'),
(13, 'Pacjent_13', '1988-07-09', '0602254269'),
(14, 'Pacjent_14', '1951-12-05', '0405163067'),
(15, 'Pacjent_15', '1950-10-26', '3305261687'),
(16, 'Pacjent_16', '1994-12-20', '7009141150'),
(17, 'Pacjent_17', '1993-11-01', '6003236848'),
(18, 'Pacjent_18', '2006-07-23', '2708031131'),
(19, 'Pacjent_19', '1961-07-09', '2906233297'),
(20, 'Pacjent_20', '1964-08-09', '1612095337'),
(21, 'Pacjent_21', '1967-11-11', '5710251099'),
(22, 'Pacjent_22', '1940-03-02', '0710145845'),
(23, 'Pacjent_23', '1997-03-19', '8412199442'),
(24, 'Pacjent_24', '1941-04-12', '5504122187'),
(25, 'Pacjent_25', '1942-09-13', '5006103214'),
(26, 'Pacjent_26', '1944-02-26', '2803012870'),
(27, 'Pacjent_27', '2002-10-26', '1903288177'),
(28, 'Pacjent_28', '2002-04-10', '6508017581'),
(29, 'Pacjent_29', '1949-09-08', '0407076475'),
(30, 'Pacjent_30', '1958-06-15', '4909081621'),
(31, 'Pacjent_31', '1999-10-28', '6411034853'),
(32, 'Pacjent_32', '1959-08-04', '1505218227'),
(33, 'Pacjent_33', '1957-01-26', '7510187721'),
(34, 'Pacjent_34', '2001-06-30', '4908202438'),
(35, 'Pacjent_35', '1992-08-19', '9810018107'),
(36, 'Pacjent_36', '1972-04-07', '1606198734'),
(37, 'Pacjent_37', '1952-10-11', '4302212986'),
(38, 'Pacjent_38', '1968-12-25', '0106073568'),
(39, 'Pacjent_39', '1987-05-21', '1211015455'),
(40, 'Pacjent_40', '1990-08-31', '0808141853'),
(41, 'Pacjent_41', '1947-10-19', '0205083270'),
(42, 'Pacjent_42', '1989-05-21', '1211067913'),
(43, 'Pacjent_43', '1968-02-16', '1712272725'),
(44, 'Pacjent_44', '1986-10-29', '0307033356'),
(45, 'Pacjent_45', '1996-12-26', '6005253035'),
(46, 'Pacjent_46', '1995-07-29', '1010175354'),
(47, 'Pacjent_47', '1969-04-19', '4001085697'),
(48, 'Pacjent_48', '1946-06-22', '3101066377'),
(49, 'Pacjent_49', '1972-10-02', '5605176675'),
(50, 'Pacjent_50', '2003-10-17', '6102133262'),
(51, 'Pacjent_51', '1943-12-05', '7908053695'),
(52, 'Pacjent_52', '1968-01-07', '5101144565'),
(53, 'Pacjent_53', '1977-12-08', '0712197307'),
(54, 'Pacjent_54', '2004-01-22', '3902146302'),
(55, 'Pacjent_55', '1986-12-18', '9206131710'),
(56, 'Pacjent_56', '1989-01-15', '2909105233'),
(57, 'Pacjent_57', '1962-06-07', '7911097686'),
(58, 'Pacjent_58', '1964-05-13', '2906209743'),
(59, 'Pacjent_59', '1954-09-27', '1212099312'),
(60, 'Pacjent_60', '1963-05-17', '2302068136'),
(61, 'Pacjent_61', '1987-04-26', '0304022936'),
(62, 'Pacjent_62', '1974-12-13', '2510103409'),
(63, 'Pacjent_63', '2005-02-14', '1007102545'),
(64, 'Pacjent_64', '1976-03-12', '7711283558'),
(65, 'Pacjent_65', '1991-08-18', '2607283031'),
(66, 'Pacjent_66', '1953-11-18', '6501033437'),
(67, 'Pacjent_67', '1980-05-10', '2512181514'),
(68, 'Pacjent_68', '2003-08-30', '2904192322'),
(69, 'Pacjent_69', '1998-10-21', '2310125633'),
(70, 'Pacjent_70', '1967-03-25', '1007229733'),
(71, 'Pacjent_71', '1982-04-22', '3203024428'),
(72, 'Pacjent_72', '1992-11-09', '4704047777'),
(73, 'Pacjent_73', '1995-11-07', '9303126506'),
(74, 'Pacjent_74', '1994-05-09', '0110155363'),
(75, 'Pacjent_75', '1970-07-13', '1703173276'),
(76, 'Pacjent_76', '1950-05-28', '1502202905'),
(77, 'Pacjent_77', '1968-09-15', '1503165021'),
(78, 'Pacjent_78', '2001-01-13', '0009173384'),
(79, 'Pacjent_79', '1971-12-31', '8601044971'),
(80, 'Pacjent_80', '1968-08-18', '2709107585'),
(81, 'Pacjent_81', '1941-11-29', '4704092359'),
(82, 'Pacjent_82', '1941-01-22', '1807106249'),
(83, 'Pacjent_83', '1951-03-16', '6201258274'),
(84, 'Pacjent_84', '1983-11-07', '0404176118'),
(85, 'Pacjent_85', '1994-09-25', '6606222463'),
(86, 'Pacjent_86', '1956-11-15', '1209061719'),
(87, 'Pacjent_87', '1960-06-18', '0312179931'),
(88, 'Pacjent_88', '1948-11-17', '3305052184'),
(89, 'Pacjent_89', '1957-10-21', '5008039129'),
(90, 'Pacjent_90', '1971-10-14', '4706139324'),
(91, 'Pacjent_91', '1988-03-31', '7009288368'),
(92, 'Pacjent_92', '1953-08-31', '0011045377'),
(93, 'Pacjent_93', '1997-06-13', '2208082749'),
(94, 'Pacjent_94', '1957-01-17', '6911141273'),
(95, 'Pacjent_95', '1944-12-13', '5507278740'),
(96, 'Pacjent_96', '2003-11-05', '1902017895'),
(97, 'Pacjent_97', '1991-10-28', '1811026514'),
(98, 'Pacjent_98', '1963-11-23', '0202044414'),
(99, 'Pacjent_99', '2003-10-20', '2908161853'),
(100, 'Pacjent_100', '1971-06-25', '0802142942');

-- Wstawianie danych do lekarze
INSERT INTO lekarze (id_lekarza, nazwa, specjalizacje) VALUES
(1, 'Lekarz_1', '{neurolog, chirurg}'),
(2, 'Lekarz_2', '{chirurg, kardiolog, dermatolog}'),
(3, 'Lekarz_3', '{kardiolog, okulista, dermatolog}'),
(4, 'Lekarz_4', '{dermatolog, kardiolog, chirurg}'),
(5, 'Lekarz_5', '{neurolog}'),
(6, 'Lekarz_6', '{kardiolog, okulista, neurolog}'),
(7, 'Lekarz_7', '{dermatolog}'),
(8, 'Lekarz_8', '{kardiolog, chirurg}'),
(9, 'Lekarz_9', '{dermatolog}'),
(10, 'Lekarz_10', '{kardiolog, okulista, chirurg}'),
(11, 'Lekarz_11', '{dermatolog, kardiolog}'),
(12, 'Lekarz_12', '{neurolog, okulista, chirurg}'),
(13, 'Lekarz_13', '{kardiolog}'),
(14, 'Lekarz_14', '{neurolog, chirurg}'),
(15, 'Lekarz_15', '{chirurg, dermatolog, neurolog}'),
(16, 'Lekarz_16', '{kardiolog, neurolog}'),
(17, 'Lekarz_17', '{kardiolog}'),
(18, 'Lekarz_18', '{neurolog}'),
(19, 'Lekarz_19', '{kardiolog}'),
(20, 'Lekarz_20', '{dermatolog, okulista}');

-- Wstawianie danych do badania
INSERT INTO badania (id_badania, nazwa, cena, na_czczo) VALUES
(1, 'Morfologia', 20.00, TRUE),
(2, 'CRP', 30.00, TRUE),
(3, 'Rezonans Magnetyczny', 500.00, FALSE),
(4, 'Glukoza', 15.00, TRUE),
(5, '�elazo', 25.00, TRUE);

-- Wstawianie danych do konsultacje
INSERT INTO konsultacje (id_konsultacji, id_lekarza, id_pacjenta, termin, specjalizacja, cena, zrealizowana) VALUES
(1, 10, 91, '2025-02-12 15:45:18', 'dermatolog', 111.14, TRUE),
(2, 5, 53, '2024-05-02 06:48:42', 'neurolog', 108.46, FALSE),
(3, 9, 14, '2025-05-30 07:41:26', 'chirurg', 213.98, TRUE),
(4, 12, NULL, '2025-09-25 14:08:23', 'okulista', 220.31, FALSE),
(5, 10, NULL, '2024-02-05 09:48:20', 'kardiolog', 205.61, FALSE),
(6, 7, NULL, '2025-01-26 09:42:59', 'okulista', 108.51, FALSE),
(7, 15, NULL, '2024-02-05 07:00:34', 'kardiolog', 190.72, FALSE),
(8, 19, NULL, '2024-07-27 08:15:00', 'kardiolog', 194.09, FALSE),
(9, 7, 11, '2024-08-18 06:48:15', 'dermatolog', 285.84, FALSE),
(10, 12, NULL, '2025-09-28 10:30:10', 'neurolog', 267.6, TRUE),
(11, 11, 57, '2025-01-04 12:46:28', 'okulista', 251.14, TRUE),
(12, 3, NULL, '2025-03-29 20:34:14', 'chirurg', 156.16, FALSE),
(13, 12, NULL, '2024-12-26 07:58:42', 'kardiolog', 249.88, TRUE),
(14, 10, NULL, '2025-09-07 23:58:59', 'kardiolog', 235.4, TRUE),
(15, 13, 56, '2025-06-25 00:18:48', 'neurolog', 233.94, FALSE),
(16, 20, 20, '2024-04-04 06:55:59', 'chirurg', 218.15, TRUE),
(17, 18, NULL, '2024-06-03 05:04:45', 'neurolog', 176.79, TRUE),
(18, 7, 78, '2025-01-02 01:53:36', 'neurolog', 185.29, TRUE),
(19, 6, NULL, '2024-02-27 08:19:53', 'kardiolog', 211.87, FALSE),
(20, 5, NULL, '2024-08-19 17:51:15', 'neurolog', 230.83, FALSE),
(21, 16, 21, '2024-04-13 09:00:56', 'kardiolog', 198.95, TRUE),
(22, 16, 23, '2025-08-13 16:04:36', 'kardiolog', 143.65, TRUE),
(23, 19, NULL, '2024-02-20 17:10:56', 'chirurg', 286.42, FALSE),
(24, 11, 61, '2025-12-18 20:48:37', 'neurolog', 181.93, FALSE),
(25, 1, 52, '2024-10-05 19:37:26', 'neurolog', 240.2, TRUE),
(26, 14, NULL, '2024-10-15 23:21:30', 'neurolog', 218.58, TRUE),
(27, 8, 14, '2025-01-26 00:47:43', 'okulista', 211.57, TRUE),
(28, 12, 42, '2025-03-20 08:21:43', 'neurolog', 117.33, TRUE),
(29, 5, NULL, '2024-11-14 11:47:55', 'dermatolog', 240.97, FALSE),
(30, 1, NULL, '2025-05-01 21:57:16', 'neurolog', 106.29, TRUE),
(31, 1, 15, '2024-07-06 05:47:27', 'neurolog', 105.68, TRUE),
(32, 1, 58, '2025-12-17 10:04:23', 'chirurg', 186.76, FALSE),
(33, 3, NULL, '2024-07-21 23:37:37', 'dermatolog', 113.68, FALSE),
(34, 1, NULL, '2024-08-09 09:02:51', 'neurolog', 110.92, FALSE),
(35, 9, NULL, '2024-03-29 13:53:52', 'okulista', 249.04, FALSE),
(36, 13, NULL, '2025-07-02 20:49:13', 'chirurg', 119.06, TRUE),
(37, 18, NULL, '2024-02-02 15:42:52', 'okulista', 247.33, FALSE),
(38, 6, 14, '2025-06-28 07:16:26', 'neurolog', 280.31, TRUE),
(39, 19, 9, '2024-11-13 18:54:10', 'kardiolog', 104.66, FALSE),
(40, 8, 66, '2025-01-17 21:35:44', 'dermatolog', 192.66, FALSE),
(41, 8, 62, '2025-06-19 16:07:03', 'kardiolog', 208.09, FALSE),
(42, 12, NULL, '2024-06-23 04:55:21', 'dermatolog', 260.44, FALSE),
(43, 14, 12, '2024-07-08 02:45:56', 'neurolog', 139.3, FALSE),
(44, 18, 99, '2025-06-04 22:46:57', 'chirurg', 238.26, FALSE),
(45, 3, NULL, '2025-02-01 16:55:48', 'dermatolog', 153.83, TRUE),
(46, 18, 10, '2024-04-23 16:03:15', 'okulista', 147.1, FALSE),
(47, 19, NULL, '2024-12-11 08:24:29', 'neurolog', 146.21, TRUE),
(48, 6, NULL, '2024-08-29 23:18:26', 'neurolog', 218.05, FALSE),
(49, 3, NULL, '2025-12-09 04:01:40', 'dermatolog', 147.99, FALSE),
(50, 1, 95, '2024-07-05 02:57:28', 'kardiolog', 182.68, FALSE),
(51, 14, NULL, '2024-09-23 08:30:33', 'chirurg', 233.97, TRUE),
(52, 6, NULL, '2024-05-26 11:42:34', 'dermatolog', 229.48, FALSE),
(53, 16, 13, '2025-07-07 22:53:10', 'chirurg', 127.37, FALSE),
(54, 15, NULL, '2025-08-16 11:27:08', 'dermatolog', 239.95, TRUE),
(55, 11, 66, '2025-02-26 02:53:21', 'okulista', 140.28, FALSE),
(56, 11, 13, '2024-01-20 12:09:43', 'kardiolog', 277.38, TRUE),
(57, 2, 93, '2024-04-04 07:16:21', 'kardiolog', 241.38, FALSE),
(58, 19, NULL, '2025-02-23 06:35:21', 'okulista', 199.77, TRUE),
(59, 10, 100, '2024-12-23 18:26:01', 'dermatolog', 278.22, TRUE),
(60, 5, 3, '2025-11-06 19:11:40', 'kardiolog', 253.74, TRUE),
(61, 1, NULL, '2024-12-24 01:45:18', 'kardiolog', 133.54, TRUE),
(62, 14, NULL, '2025-08-01 20:43:24', 'chirurg', 293.62, TRUE),
(63, 1, 93, '2025-03-12 05:46:02', 'kardiolog', 232.39, TRUE),
(64, 8, 40, '2024-01-24 13:18:32', 'dermatolog', 240.92, TRUE),
(65, 20, 34, '2024-02-23 23:33:44', 'kardiolog', 269.12, TRUE),
(66, 14, 38, '2024-03-27 22:25:30', 'okulista', 212.25, TRUE),
(67, 5, NULL, '2025-11-03 05:49:44', 'dermatolog', 288.6, FALSE),
(68, 17, NULL, '2024-09-10 10:03:33', 'dermatolog', 212.52, FALSE),
(69, 18, 54, '2024-06-26 20:26:46', 'kardiolog', 108.19, TRUE),
(70, 15, NULL, '2025-01-02 01:40:38', 'okulista', 152.48, FALSE),
(71, 8, NULL, '2025-11-25 10:22:27', 'kardiolog', 193.78, TRUE),
(72, 14, 80, '2024-01-07 14:44:09', 'neurolog', 199.84, TRUE),
(73, 11, 36, '2025-05-15 22:30:11', 'kardiolog', 248.66, TRUE),
(74, 1, NULL, '2024-03-04 20:10:18', 'chirurg', 253.0, FALSE),
(75, 17, 78, '2025-08-09 16:19:53', 'kardiolog', 277.98, TRUE),
(76, 4, 79, '2024-12-31 23:05:30', 'dermatolog', 247.49, TRUE),
(77, 3, NULL, '2025-01-14 02:31:06', 'okulista', 197.42, FALSE),
(78, 5, 20, '2024-01-18 20:49:07', 'okulista', 257.33, TRUE),
(79, 7, 66, '2024-07-20 02:30:20', 'neurolog', 297.88, TRUE),
(80, 6, 47, '2025-08-06 17:57:19', 'neurolog', 178.5, TRUE),
(81, 20, 99, '2024-02-05 01:14:15', 'okulista', 173.45, TRUE),
(82, 18, 96, '2024-11-03 08:28:14', 'okulista', 290.07, TRUE),
(83, 13, 25, '2025-11-10 07:13:48', 'kardiolog', 210.22, TRUE),
(84, 20, NULL, '2024-10-11 07:51:28', 'chirurg', 286.88, FALSE),
(85, 14, 83, '2025-02-03 06:50:10', 'okulista', 217.17, TRUE),
(86, 16, NULL, '2024-07-04 00:29:21', 'neurolog', 194.28, FALSE),
(87, 20, 12, '2025-10-21 15:36:12', 'kardiolog', 207.9, TRUE),
(88, 7, 17, '2024-10-27 07:51:36', 'okulista', 231.06, TRUE),
(89, 13, NULL, '2025-02-01 14:16:36', 'kardiolog', 167.09, TRUE),
(90, 3, NULL, '2024-10-12 11:29:01', 'dermatolog', 273.88, TRUE),
(91, 3, NULL, '2024-12-09 18:57:31', 'okulista', 246.24, TRUE),
(92, 14, NULL, '2024-08-16 03:21:15', 'chirurg', 116.92, TRUE),
(93, 4, NULL, '2025-07-06 06:30:26', 'neurolog', 272.65, TRUE),
(94, 2, 79, '2025-08-17 21:12:54', 'kardiolog', 197.48, FALSE),
(95, 2, 1, '2025-02-24 13:02:22', 'dermatolog', 214.32, FALSE),
(96, 14, NULL, '2025-08-23 15:21:53', 'okulista', 258.79, FALSE),
(97, 3, 2, '2025-09-11 18:12:10', 'okulista', 299.52, TRUE),
(98, 10, NULL, '2024-04-07 22:09:51', 'neurolog', 163.36, FALSE),
(99, 18, NULL, '2025-03-28 21:34:00', 'okulista', 282.94, TRUE),
(100, 12, 35, '2025-03-30 01:56:02', 'kardiolog', 298.73, TRUE),
(101, 8, NULL, '2025-12-21 21:51:32', 'dermatolog', 136.52, FALSE),
(102, 1, 71, '2024-10-16 15:41:49', 'chirurg', 231.33, TRUE),
(103, 12, 100, '2024-05-23 09:19:55', 'dermatolog', 251.34, TRUE),
(104, 19, NULL, '2024-08-16 22:23:34', 'chirurg', 176.9, FALSE),
(105, 20, 74, '2024-08-30 00:27:33', 'chirurg', 174.06, TRUE),
(106, 17, NULL, '2025-03-02 12:57:44', 'dermatolog', 212.43, FALSE),
(107, 10, 90, '2024-04-20 11:26:23', 'chirurg', 133.67, FALSE),
(108, 4, 69, '2024-04-30 13:20:04', 'neurolog', 292.97, TRUE),
(109, 8, 97, '2025-10-07 14:21:26', 'dermatolog', 153.92, TRUE),
(110, 1, NULL, '2025-07-14 19:09:44', 'kardiolog', 247.54, FALSE),
(111, 14, 93, '2025-05-05 01:58:00', 'kardiolog', 165.82, FALSE),
(112, 5, NULL, '2024-10-11 20:45:13', 'kardiolog', 192.28, FALSE),
(113, 9, NULL, '2025-06-22 05:12:37', 'dermatolog', 191.7, FALSE),
(114, 20, 44, '2024-02-29 17:20:06', 'okulista', 266.54, FALSE),
(115, 17, NULL, '2024-07-14 03:53:24', 'chirurg', 251.16, FALSE),
(116, 5, NULL, '2025-04-20 07:41:53', 'okulista', 245.84, TRUE),
(117, 4, 57, '2025-11-08 04:16:00', 'kardiolog', 140.54, TRUE),
(118, 10, NULL, '2024-03-16 18:40:58', 'chirurg', 160.48, TRUE),
(119, 12, NULL, '2024-04-19 18:41:51', 'chirurg', 255.48, TRUE),
(120, 1, 63, '2024-10-19 09:44:48', 'neurolog', 199.12, TRUE),
(121, 9, 68, '2025-10-09 23:45:38', 'okulista', 108.89, TRUE),
(122, 5, 46, '2024-05-04 13:49:54', 'chirurg', 150.36, TRUE),
(123, 16, 62, '2025-10-20 22:08:07', 'chirurg', 276.93, TRUE),
(124, 14, NULL, '2025-11-20 03:48:48', 'chirurg', 274.12, TRUE),
(125, 3, NULL, '2024-02-12 16:54:52', 'okulista', 207.9, FALSE),
(126, 20, 40, '2025-09-12 09:59:41', 'neurolog', 244.41, TRUE),
(127, 19, 9, '2024-11-04 10:43:44', 'chirurg', 215.81, FALSE),
(128, 14, 31, '2025-03-29 18:08:26', 'chirurg', 184.15, FALSE),
(129, 13, NULL, '2024-08-25 15:59:03', 'dermatolog', 246.35, FALSE),
(130, 10, NULL, '2024-05-27 10:06:12', 'kardiolog', 259.5, FALSE),
(131, 10, NULL, '2024-10-16 22:28:50', 'dermatolog', 210.49, TRUE),
(132, 10, 25, '2025-10-27 12:33:19', 'kardiolog', 162.36, FALSE),
(133, 9, 71, '2024-11-26 11:36:23', 'dermatolog', 278.2, TRUE),
(134, 1, 38, '2025-09-07 21:53:56', 'kardiolog', 129.06, FALSE),
(135, 8, 21, '2025-02-19 07:13:54', 'neurolog', 157.87, TRUE),
(136, 2, NULL, '2024-07-19 06:36:02', 'dermatolog', 242.99, FALSE),
(137, 2, NULL, '2024-08-27 23:31:01', 'okulista', 129.69, FALSE),
(138, 13, NULL, '2025-06-10 22:55:08', 'dermatolog', 290.05, FALSE),
(139, 11, NULL, '2024-01-30 09:30:02', 'neurolog', 227.92, TRUE),
(140, 4, NULL, '2025-05-12 10:18:44', 'chirurg', 115.0, TRUE),
(141, 17, 29, '2025-09-28 06:11:23', 'chirurg', 142.68, FALSE),
(142, 19, NULL, '2024-06-29 22:43:48', 'okulista', 241.09, TRUE),
(143, 12, NULL, '2025-01-20 20:23:01', 'neurolog', 299.16, TRUE),
(144, 18, 85, '2025-03-09 13:37:19', 'chirurg', 103.5, FALSE),
(145, 14, NULL, '2024-12-08 10:53:02', 'neurolog', 100.24, FALSE),
(146, 12, NULL, '2025-11-14 04:48:00', 'dermatolog', 117.96, FALSE),
(147, 5, NULL, '2025-03-11 16:39:16', 'neurolog', 237.74, TRUE),
(148, 15, 58, '2024-08-20 16:41:48', 'okulista', 133.02, FALSE),
(149, 9, 49, '2024-05-02 11:50:16', 'neurolog', 180.94, TRUE),
(150, 20, 89, '2024-09-13 13:47:41', 'dermatolog', 141.5, TRUE),
(151, 13, NULL, '2024-08-24 16:43:07', 'okulista', 108.86, TRUE),
(152, 19, 61, '2025-12-25 05:54:55', 'kardiolog', 160.29, FALSE),
(153, 6, 12, '2025-01-17 19:09:48', 'dermatolog', 202.55, TRUE),
(154, 10, 30, '2024-10-05 22:20:00', 'neurolog', 166.23, FALSE),
(155, 8, 18, '2024-11-05 09:16:28', 'kardiolog', 115.94, TRUE),
(156, 12, NULL, '2025-09-27 07:23:47', 'chirurg', 122.71, FALSE),
(157, 10, 8, '2024-12-30 04:36:03', 'dermatolog', 174.03, TRUE),
(158, 18, NULL, '2025-04-07 12:46:03', 'okulista', 236.39, TRUE),
(159, 12, 82, '2024-01-21 06:23:39', 'kardiolog', 122.61, TRUE),
(160, 15, NULL, '2024-08-25 11:12:18', 'kardiolog', 150.83, TRUE),
(161, 20, NULL, '2024-09-20 08:06:53', 'okulista', 171.7, FALSE),
(162, 6, 15, '2024-03-05 17:28:33', 'neurolog', 127.59, TRUE),
(163, 10, NULL, '2024-09-02 02:23:42', 'okulista', 248.49, TRUE),
(164, 1, NULL, '2024-01-25 22:27:37', 'kardiolog', 203.6, TRUE),
(165, 9, NULL, '2025-09-07 08:53:29', 'okulista', 224.62, TRUE),
(166, 3, NULL, '2025-07-01 14:11:24', 'dermatolog', 101.87, FALSE),
(167, 2, 4, '2025-07-09 14:44:02', 'kardiolog', 114.26, TRUE),
(168, 4, 20, '2025-10-27 16:56:58', 'dermatolog', 152.32, TRUE),
(169, 2, NULL, '2024-12-01 08:25:10', 'kardiolog', 107.45, TRUE),
(170, 20, 52, '2025-12-23 07:08:55', 'okulista', 211.88, FALSE),
(171, 18, NULL, '2025-05-05 15:38:14', 'neurolog', 124.89, TRUE),
(172, 8, NULL, '2025-12-25 06:17:44', 'okulista', 195.56, TRUE),
(173, 10, 85, '2025-05-22 20:22:27', 'dermatolog', 177.42, TRUE),
(174, 8, NULL, '2024-09-08 13:09:07', 'dermatolog', 273.22, FALSE),
(175, 15, NULL, '2025-11-14 12:19:59', 'dermatolog', 181.82, TRUE),
(176, 4, NULL, '2025-02-19 18:19:12', 'neurolog', 129.45, TRUE),
(177, 14, 52, '2024-06-23 12:10:03', 'chirurg', 279.15, TRUE),
(178, 13, 10, '2024-04-05 20:23:53', 'dermatolog', 235.86, TRUE),
(179, 7, 15, '2025-08-29 03:26:48', 'kardiolog', 194.66, TRUE),
(180, 18, NULL, '2025-05-22 07:33:04', 'dermatolog', 171.47, FALSE),
(181, 9, NULL, '2025-08-20 20:23:32', 'dermatolog', 134.41, FALSE),
(182, 9, 45, '2024-10-23 22:58:08', 'okulista', 195.32, TRUE),
(183, 18, 59, '2025-09-12 07:23:05', 'dermatolog', 196.66, FALSE),
(184, 1, 69, '2025-11-24 17:33:41', 'okulista', 260.45, FALSE),
(185, 14, 89, '2025-10-19 18:40:18', 'okulista', 116.95, FALSE),
(186, 3, 78, '2024-02-27 17:11:02', 'neurolog', 262.85, TRUE),
(187, 12, 73, '2024-01-25 08:48:03', 'dermatolog', 256.26, FALSE),
(188, 15, 10, '2025-12-04 23:58:31', 'dermatolog', 233.47, FALSE),
(189, 3, NULL, '2025-10-15 15:54:49', 'neurolog', 145.27, FALSE),
(190, 17, 43, '2025-01-27 13:42:22', 'neurolog', 229.67, FALSE),
(191, 2, NULL, '2024-06-11 21:03:03', 'chirurg', 280.58, FALSE),
(192, 18, 27, '2025-05-25 18:16:31', 'dermatolog', 108.02, FALSE),
(193, 14, NULL, '2025-04-20 21:16:47', 'chirurg', 192.28, FALSE),
(194, 2, 34, '2025-01-21 20:05:32', 'neurolog', 222.75, FALSE),
(195, 5, 90, '2024-12-06 13:07:46', 'chirurg', 111.82, FALSE),
(196, 18, NULL, '2025-01-21 17:32:13', 'kardiolog', 250.32, FALSE),
(197, 19, 52, '2024-03-20 01:37:12', 'chirurg', 137.5, TRUE),
(198, 15, 62, '2024-05-17 13:41:09', 'neurolog', 111.09, TRUE),
(199, 17, NULL, '2025-02-09 11:10:36', 'neurolog', 139.81, FALSE),
(200, 5, NULL, '2025-04-04 02:32:31', 'kardiolog', 188.36, FALSE);

-- Wstawianie danych do zlecenia
INSERT INTO zlecenia (id_zlecenia, id_pacjenta, id_lekarza, id_badania, data_wystawienia, data_realizacji) VALUES
(1, 27, 8, 3, '2024-08-25', '2025-11-24'),
(2, 40, 20, 2, '2024-02-12', '2025-05-08'),
(3, 45, 3, 3, '2025-08-15', NULL),
(4, 83, 15, 4, '2024-01-27', '2024-10-29'),
(5, 10, 10, 2, '2025-02-21', NULL),
(6, 88, 18, 1, '2024-07-14', '2025-01-11'),
(7, 96, 12, 2, '2025-02-09', '2025-07-07'),
(8, 36, 1, 1, '2025-09-23', NULL),
(9, 12, 20, 4, '2024-09-08', '2025-02-14'),
(10, 95, 2, 5, '2024-08-25', NULL),
(11, 44, 4, 5, '2025-01-15', '2025-09-16'),
(12, 95, 9, 5, '2024-06-16', '2025-12-02'),
(13, 74, 16, 3, '2024-10-26', NULL),
(14, 42, 20, 4, '2024-09-18', '2025-07-28'),
(15, 92, 10, 2, '2025-02-19', '2025-04-20'),
(16, 96, 1, 5, '2025-01-09', '2025-04-20'),
(17, 27, 15, 5, '2024-06-04', NULL),
(18, 82, 5, 4, '2024-06-24', NULL),
(19, 47, 3, 5, '2025-03-16', NULL),
(20, 68, 17, 1, '2025-04-06', NULL),
(21, 78, 3, 5, '2024-04-20', '2025-03-23'),
(22, 39, 5, 2, '2024-07-17', '2025-07-14'),
(23, 9, 10, 5, '2024-02-01', '2024-09-15'),
(24, 95, 3, 5, '2025-09-08', '2025-10-20'),
(25, 56, 8, 3, '2025-04-24', '2025-09-12'),
(26, 10, 13, 3, '2025-09-29', NULL),
(27, 100, 2, 5, '2025-01-22', '2025-05-14'),
(28, 52, 13, 2, '2025-05-03', '2025-07-24'),
(29, 78, 15, 4, '2025-03-23', '2025-07-06'),
(30, 33, 9, 1, '2025-05-29', '2025-09-23'),
(31, 6, 15, 4, '2025-11-21', NULL),
(32, 77, 10, 2, '2024-10-18', NULL),
(33, 39, 3, 1, '2024-08-31', NULL),
(34, 87, 3, 2, '2024-12-04', NULL),
(35, 62, 12, 4, '2025-01-22', NULL),
(36, 39, 20, 2, '2025-11-08', '2025-12-05'),
(37, 5, 20, 5, '2025-04-12', NULL),
(38, 40, 6, 2, '2024-08-10', NULL),
(39, 22, 18, 3, '2024-05-03', '2024-07-21'),
(40, 50, 17, 2, '2025-01-14', NULL),
(41, 83, 15, 2, '2025-09-24', '2025-11-12'),
(42, 64, 18, 5, '2025-09-28', NULL),
(43, 94, 17, 2, '2024-01-19', '2024-04-12'),
(44, 98, 18, 4, '2024-07-21', NULL),
(45, 74, 9, 1, '2025-08-20', '2025-11-15'),
(46, 2, 17, 2, '2025-11-09', '2025-12-13'),
(47, 74, 15, 1, '2025-06-11', '2025-11-12'),
(48, 73, 9, 1, '2024-08-21', '2025-01-09'),
(49, 80, 16, 5, '2025-08-25', '2025-10-06'),
(50, 30, 13, 4, '2024-07-01', '2025-10-01'),
(51, 38, 5, 1, '2025-05-07', '2025-09-06'),
(52, 1, 12, 2, '2024-08-01', '2025-10-06'),
(53, 99, 2, 3, '2025-02-16', NULL),
(54, 39, 17, 5, '2024-12-12', '2025-01-24'),
(55, 81, 7, 3, '2025-03-13', NULL),
(56, 38, 20, 1, '2024-10-28', NULL),
(57, 56, 1, 3, '2025-03-06', NULL),
(58, 36, 18, 2, '2024-07-19', NULL),
(59, 72, 15, 2, '2025-01-23', NULL),
(60, 37, 19, 3, '2025-12-25', '2025-12-27'),
(61, 100, 9, 5, '2024-05-25', NULL),
(62, 54, 14, 2, '2024-01-06', NULL),
(63, 46, 13, 1, '2025-06-15', NULL),
(64, 53, 11, 5, '2025-09-09', NULL),
(65, 47, 7, 1, '2024-09-08', '2025-11-08'),
(66, 68, 11, 4, '2024-08-25', '2025-07-17'),
(67, 67, 12, 5, '2025-08-11', NULL),
(68, 33, 2, 5, '2024-03-14', NULL),
(69, 75, 11, 1, '2025-08-22', NULL),
(70, 23, 20, 3, '2024-08-28', NULL),
(71, 18, 10, 3, '2024-03-16', NULL),
(72, 83, 14, 3, '2024-06-21', NULL),
(73, 4, 7, 1, '2025-10-17', NULL),
(74, 44, 8, 3, '2024-05-09', NULL),
(75, 22, 4, 5, '2025-12-06', NULL),
(76, 99, 10, 5, '2025-01-26', '2025-05-13'),
(77, 12, 17, 1, '2024-08-01', '2024-08-15'),
(78, 32, 3, 2, '2024-08-10', '2025-07-30'),
(79, 97, 6, 2, '2025-11-03', '2025-11-21'),
(80, 69, 10, 3, '2025-04-30', '2025-08-01'),
(81, 25, 7, 3, '2025-11-13', '2025-12-02'),
(82, 35, 12, 2, '2025-08-03', NULL),
(83, 45, 14, 3, '2024-05-19', NULL),
(84, 34, 8, 2, '2024-07-21', NULL),
(85, 79, 15, 1, '2024-12-17', '2025-03-03'),
(86, 33, 10, 1, '2025-07-06', '2025-08-07'),
(87, 3, 3, 3, '2025-01-02', '2025-12-09'),
(88, 49, 6, 2, '2024-01-28', NULL),
(89, 26, 16, 3, '2024-10-21', NULL),
(90, 100, 8, 3, '2025-03-02', '2025-11-26'),
(91, 77, 13, 1, '2025-06-22', NULL),
(92, 1, 7, 3, '2024-04-25', NULL),
(93, 18, 14, 4, '2025-07-07', '2025-11-04'),
(94, 76, 1, 3, '2025-03-04', '2025-07-08'),
(95, 5, 19, 1, '2024-08-31', NULL),
(96, 94, 9, 1, '2025-12-06', '2025-12-23'),
(97, 11, 8, 5, '2024-10-20', '2025-02-28'),
(98, 55, 3, 2, '2025-10-14', NULL),
(99, 65, 13, 3, '2025-01-14', NULL),
(100, 59, 5, 5, '2025-05-06', '2025-09-07'),
(101, 46, 7, 5, '2025-12-09', NULL),
(102, 6, 11, 3, '2025-07-09', '2025-09-01'),
(103, 23, 5, 1, '2024-04-03', NULL),
(104, 5, 6, 1, '2024-07-13', '2024-11-28'),
(105, 57, 7, 5, '2024-06-22', NULL),
(106, 24, 2, 5, '2025-12-19', '2025-12-25'),
(107, 43, 16, 3, '2025-11-29', NULL),
(108, 6, 10, 1, '2024-10-24', NULL),
(109, 68, 18, 3, '2024-01-05', '2024-05-18'),
(110, 2, 16, 4, '2024-02-21', NULL),
(111, 96, 9, 2, '2024-11-02', '2025-04-05'),
(112, 1, 10, 5, '2025-06-15', NULL),
(113, 16, 6, 2, '2024-09-15', NULL),
(114, 82, 10, 5, '2024-10-06', NULL),
(115, 99, 10, 4, '2025-11-25', '2025-12-14'),
(116, 35, 9, 1, '2025-10-15', NULL),
(117, 16, 5, 2, '2025-04-03', '2025-05-18'),
(118, 19, 14, 2, '2025-11-19', NULL),
(119, 52, 10, 2, '2024-11-27', '2025-02-24'),
(120, 84, 3, 3, '2024-08-21', '2024-10-07'),
(121, 20, 15, 1, '2025-09-15', '2025-11-04'),
(122, 58, 12, 5, '2024-06-24', '2024-11-08'),
(123, 25, 17, 3, '2024-06-08', NULL),
(124, 55, 8, 1, '2024-07-23', NULL),
(125, 62, 15, 4, '2024-09-20', '2025-09-04'),
(126, 24, 13, 2, '2025-08-22', NULL),
(127, 1, 8, 1, '2025-04-07', NULL),
(128, 36, 1, 2, '2025-05-29', NULL),
(129, 35, 15, 1, '2024-07-08', NULL),
(130, 63, 10, 5, '2025-05-17', '2025-08-14'),
(131, 11, 7, 2, '2024-06-11', NULL),
(132, 30, 10, 3, '2024-03-18', '2025-09-29'),
(133, 61, 2, 4, '2025-08-06', NULL),
(134, 30, 17, 1, '2025-02-27', '2025-12-10'),
(135, 94, 19, 5, '2024-09-19', '2025-12-26'),
(136, 21, 5, 4, '2024-04-28', NULL),
(137, 35, 8, 1, '2025-02-20', '2025-08-22'),
(138, 47, 9, 4, '2024-04-30', '2024-10-23'),
(139, 40, 19, 2, '2025-03-06', NULL),
(140, 69, 1, 3, '2025-05-03', NULL),
(141, 21, 15, 1, '2024-04-20', '2024-12-17'),
(142, 42, 2, 1, '2024-03-06', NULL),
(143, 11, 8, 5, '2024-11-29', '2025-01-18'),
(144, 58, 16, 1, '2024-03-26', NULL),
(145, 72, 2, 4, '2025-10-01', NULL),
(146, 58, 8, 2, '2025-11-08', NULL),
(147, 83, 14, 5, '2025-03-09', NULL),
(148, 84, 6, 3, '2025-11-07', NULL),
(149, 68, 15, 3, '2025-08-07', NULL),
(150, 73, 11, 3, '2025-11-19', NULL),
(151, 36, 11, 2, '2024-06-19', NULL),
(152, 74, 16, 3, '2025-04-01', '2025-10-02'),
(153, 82, 2, 1, '2025-07-25', '2025-09-14'),
(154, 10, 18, 2, '2024-01-05', '2025-04-11'),
(155, 18, 15, 2, '2024-02-04', NULL),
(156, 62, 16, 2, '2025-07-17', NULL),
(157, 23, 3, 3, '2025-12-14', NULL),
(158, 85, 3, 4, '2025-04-03', '2025-06-28'),
(159, 46, 14, 2, '2025-01-01', NULL),
(160, 89, 3, 1, '2025-07-17', '2025-12-07'),
(161, 38, 3, 3, '2025-03-31', '2025-11-01'),
(162, 52, 11, 2, '2024-02-17', '2024-02-21'),
(163, 93, 11, 1, '2024-11-25', '2025-01-15'),
(164, 11, 20, 1, '2024-03-05', NULL),
(165, 36, 14, 3, '2024-06-08', NULL),
(166, 53, 9, 2, '2025-03-26', NULL),
(167, 30, 7, 5, '2025-03-24', '2025-09-16'),
(168, 79, 20, 5, '2025-02-11', NULL),
(169, 32, 19, 4, '2024-10-31', NULL),
(170, 49, 1, 1, '2024-08-21', NULL),
(171, 97, 8, 4, '2024-12-04', NULL),
(172, 20, 2, 4, '2025-05-29', '2025-07-17'),
(173, 6, 3, 1, '2025-01-17', '2025-01-17'),
(174, 82, 12, 1, '2025-08-23', NULL),
(175, 42, 17, 4, '2025-11-14', NULL),
(176, 4, 10, 2, '2024-09-28', '2025-06-08'),
(177, 12, 8, 1, '2024-09-20', '2024-12-05'),
(178, 19, 14, 4, '2025-06-28', NULL),
(179, 3, 20, 5, '2024-11-21', '2025-01-26'),
(180, 34, 20, 3, '2025-01-23', '2025-03-16'),
(181, 76, 9, 4, '2025-02-19', NULL),
(182, 77, 1, 4, '2024-03-29', '2025-06-28'),
(183, 2, 18, 3, '2024-12-25', '2025-07-11'),
(184, 25, 14, 3, '2025-07-25', '2025-09-05'),
(185, 90, 6, 4, '2024-09-17', '2025-12-26'),
(186, 43, 6, 1, '2024-08-18', NULL),
(187, 75, 13, 2, '2024-04-12', NULL),
(188, 80, 2, 5, '2025-08-05', '2025-09-18'),
(189, 39, 5, 3, '2025-06-14', NULL),
(190, 81, 15, 2, '2024-12-06', '2025-05-20'),
(191, 75, 17, 2, '2025-03-02', NULL),
(192, 92, 5, 5, '2024-02-29', '2025-08-01'),
(193, 57, 4, 5, '2024-01-23', '2025-11-24'),
(194, 57, 9, 4, '2025-05-14', '2025-11-20'),
(195, 9, 13, 1, '2024-11-08', NULL),
(196, 25, 9, 4, '2025-10-08', NULL),
(197, 47, 3, 4, '2024-12-01', '2025-03-20'),
(198, 55, 9, 4, '2025-07-05', NULL),
(199, 67, 18, 3, '2024-11-08', NULL),
(200, 27, 15, 1, '2024-07-07', NULL),
(201, 19, 4, 4, '2025-03-05', NULL),
(202, 89, 10, 5, '2024-05-23', NULL),
(203, 16, 1, 5, '2024-01-07', '2025-08-27'),
(204, 53, 7, 4, '2024-05-30', NULL),
(205, 99, 4, 3, '2024-04-01', '2024-12-25'),
(206, 97, 19, 4, '2025-12-19', '2025-12-28'),
(207, 98, 14, 4, '2025-09-28', NULL),
(208, 52, 12, 4, '2024-12-20', '2025-02-24'),
(209, 99, 12, 4, '2024-08-15', NULL),
(210, 46, 4, 2, '2024-06-03', NULL),
(211, 23, 5, 1, '2024-11-01', '2024-12-04'),
(212, 69, 16, 1, '2024-11-08', NULL),
(213, 62, 15, 3, '2025-09-25', '2025-11-05'),
(214, 26, 16, 2, '2024-05-05', '2024-11-11'),
(215, 88, 13, 2, '2024-06-04', NULL),
(216, 1, 12, 5, '2025-03-25', '2025-08-04'),
(217, 14, 10, 3, '2025-01-12', '2025-01-13'),
(218, 100, 9, 2, '2025-10-15', '2025-11-19'),
(219, 98, 11, 4, '2024-12-10', NULL),
(220, 77, 16, 1, '2024-06-22', NULL),
(221, 42, 16, 3, '2025-04-12', NULL),
(222, 72, 7, 5, '2024-08-16', NULL),
(223, 21, 8, 3, '2024-10-23', NULL),
(224, 21, 11, 2, '2025-10-22', NULL),
(225, 77, 15, 2, '2024-12-24', '2025-02-13'),
(226, 29, 6, 4, '2024-06-06', NULL),
(227, 81, 12, 3, '2025-03-09', NULL),
(228, 45, 10, 3, '2025-01-21', '2025-11-01'),
(229, 67, 1, 5, '2024-10-28', '2025-05-28'),
(230, 48, 8, 1, '2024-04-08', '2024-04-30'),
(231, 19, 8, 5, '2024-06-12', '2024-10-04'),
(232, 64, 3, 1, '2025-10-03', NULL),
(233, 89, 19, 5, '2025-04-13', '2025-07-19'),
(234, 71, 20, 2, '2024-01-07', '2025-12-11'),
(235, 20, 3, 3, '2025-09-16', NULL),
(236, 98, 11, 2, '2024-05-13', '2025-04-19'),
(237, 44, 14, 1, '2024-11-09', '2025-03-06'),
(238, 18, 1, 2, '2024-04-27', NULL),
(239, 92, 20, 2, '2025-08-22', NULL),
(240, 96, 15, 2, '2024-03-08', NULL),
(241, 41, 14, 2, '2024-08-06', NULL),
(242, 66, 9, 5, '2024-09-16', NULL),
(243, 51, 17, 1, '2025-12-23', '2025-12-27'),
(244, 81, 5, 4, '2024-02-19', '2024-04-29'),
(245, 48, 15, 4, '2025-01-06', NULL),
(246, 57, 14, 5, '2024-01-17', '2024-06-06'),
(247, 77, 11, 4, '2024-05-08', NULL),
(248, 18, 10, 2, '2025-08-15', NULL),
(249, 5, 14, 1, '2024-01-28', '2024-05-07'),
(250, 73, 2, 1, '2025-02-15', NULL),
(251, 56, 17, 1, '2024-08-09', NULL),
(252, 8, 17, 4, '2025-01-11', '2025-11-02'),
(253, 43, 12, 5, '2024-07-22', '2024-07-23'),
(254, 36, 6, 5, '2024-12-03', NULL),
(255, 67, 16, 4, '2024-09-11', '2024-12-11'),
(256, 13, 20, 2, '2024-07-23', NULL),
(257, 75, 1, 5, '2025-03-03', '2025-07-28'),
(258, 98, 14, 1, '2024-08-20', '2024-11-16'),
(259, 22, 4, 3, '2024-04-02', NULL),
(260, 5, 19, 1, '2024-07-01', NULL),
(261, 46, 7, 2, '2024-09-13', '2024-10-16'),
(262, 58, 1, 1, '2024-03-25', '2025-11-12'),
(263, 87, 4, 4, '2024-09-06', NULL),
(264, 20, 4, 3, '2024-12-28', NULL),
(265, 92, 19, 3, '2024-03-05', NULL),
(266, 24, 10, 5, '2024-01-31', '2025-11-13'),
(267, 59, 12, 3, '2024-01-30', '2024-04-03'),
(268, 80, 1, 5, '2024-06-23', '2024-08-12'),
(269, 22, 15, 4, '2024-09-23', '2025-03-04'),
(270, 7, 7, 2, '2024-03-10', '2025-10-26'),
(271, 2, 13, 5, '2024-08-30', NULL),
(272, 67, 15, 5, '2024-05-21', '2025-06-29'),
(273, 47, 1, 2, '2025-09-06', '2025-10-24'),
(274, 49, 12, 1, '2025-04-11', NULL),
(275, 54, 17, 4, '2024-04-30', '2025-11-04'),
(276, 14, 2, 5, '2024-01-28', NULL),
(277, 62, 18, 5, '2024-10-07', '2025-03-08'),
(278, 39, 19, 4, '2024-01-24', '2025-02-26'),
(279, 38, 9, 2, '2025-04-17', NULL),
(280, 92, 8, 3, '2025-10-29', NULL),
(281, 42, 6, 5, '2025-08-10', NULL),
(282, 27, 10, 2, '2024-01-11', NULL),
(283, 18, 11, 4, '2024-06-07', NULL),
(284, 91, 4, 2, '2024-08-12', NULL),
(285, 97, 5, 1, '2024-08-21', '2024-09-07'),
(286, 79, 14, 2, '2025-12-26', NULL),
(287, 21, 17, 4, '2025-08-14', NULL),
(288, 23, 20, 1, '2025-02-18', '2025-12-21'),
(289, 74, 7, 2, '2024-04-08', '2024-07-04'),
(290, 9, 16, 3, '2024-01-15', NULL),
(291, 38, 14, 1, '2025-09-17', '2025-10-03'),
(292, 44, 15, 3, '2024-07-18', '2025-03-20'),
(293, 76, 5, 5, '2024-10-13', '2025-09-03'),
(294, 67, 4, 5, '2025-03-30', '2025-05-14'),
(295, 48, 16, 4, '2025-05-04', NULL),
(296, 31, 1, 3, '2025-12-23', '2025-12-24'),
(297, 92, 10, 3, '2024-10-17', NULL),
(298, 32, 19, 2, '2024-03-15', '2025-04-11'),
(299, 26, 4, 1, '2025-04-13', NULL),
(300, 54, 3, 5, '2025-11-12', NULL);
