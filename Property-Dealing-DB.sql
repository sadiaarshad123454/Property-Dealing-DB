

USE master;
GO
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'PropertyDealingDB')
    DROP DATABASE PropertyDealingDB;
GO
CREATE DATABASE PropertyDealingDB;
GO
USE PropertyDealingDB;
GO

CREATE TABLE PERSON (
    PersonID  INT          PRIMARY KEY,
    Name      VARCHAR(100) NOT NULL,
    Phone     VARCHAR(20),
    Email     VARCHAR(100)
);

CREATE TABLE BUYER (
    PersonID    INT            PRIMARY KEY,
    Budget      DECIMAL(15,2),
    BankDetails VARCHAR(200),
    FOREIGN KEY (PersonID) REFERENCES PERSON(PersonID)
);


CREATE TABLE SELLER (
    PersonID    INT            PRIMARY KEY,
    BankDetails VARCHAR(200),
    FOREIGN KEY (PersonID) REFERENCES PERSON(PersonID)
);


CREATE TABLE AGENT (
    PersonID   INT            PRIMARY KEY,
    LicenseNo  VARCHAR(50)    UNIQUE NOT NULL,
    Commission DECIMAL(5,2),
    FOREIGN KEY (PersonID) REFERENCES PERSON(PersonID)
);


CREATE TABLE PROPERTY (
    PropertyID INT            PRIMARY KEY,
    SellerID   INT            NOT NULL,
    AgentID    INT            NOT NULL,
    Location   VARCHAR(200),
    Price      DECIMAL(15,2),
    Size       VARCHAR(50),
    Status     VARCHAR(20)    CHECK (Status IN ('Available','Sold','Pending')),
    Type       VARCHAR(10)    CHECK (Type   IN ('House','Plot','Flat')),
    FOREIGN KEY (SellerID) REFERENCES SELLER(PersonID),
    FOREIGN KEY (AgentID)  REFERENCES AGENT(PersonID)
);


CREATE TABLE HOUSE (
    PropertyID INT PRIMARY KEY,
    Floors     INT,
    Bedrooms   INT,
    FOREIGN KEY (PropertyID) REFERENCES PROPERTY(PropertyID)
);


CREATE TABLE PLOT (
    PropertyID INT            PRIMARY KEY,
    AreaSqFt   DECIMAL(10,2),
    FOREIGN KEY (PropertyID) REFERENCES PROPERTY(PropertyID)
);


CREATE TABLE FLAT (
    PropertyID INT PRIMARY KEY,
    FloorLevel INT,
    FOREIGN KEY (PropertyID) REFERENCES PROPERTY(PropertyID)
);


CREATE TABLE DEAL (
    DealID     INT            PRIMARY KEY,
    BuyerID    INT            NOT NULL,
    SellerID   INT            NOT NULL,
    PropertyID INT            NOT NULL,
    AgentID    INT            NOT NULL,
    DealDate   DATE,
    Amount     DECIMAL(15,2),
    FOREIGN KEY (BuyerID)    REFERENCES BUYER(PersonID),
    FOREIGN KEY (SellerID)   REFERENCES SELLER(PersonID),
    FOREIGN KEY (PropertyID) REFERENCES PROPERTY(PropertyID),
    FOREIGN KEY (AgentID)    REFERENCES AGENT(PersonID)
);


CREATE TABLE CONTRACT (
    ContractID   INT            PRIMARY KEY,
    DealID       INT            UNIQUE NOT NULL,
    ContractDate DATE,
    Terms        VARCHAR(500),
    FOREIGN KEY (DealID) REFERENCES DEAL(DealID)
);


CREATE TABLE PAYMENT (
    PaymentID   INT            PRIMARY KEY,
    DealID      INT            NOT NULL,
    Method      VARCHAR(50),
    Amount      DECIMAL(15,2),
    PaymentDate DATE,
    FOREIGN KEY (DealID) REFERENCES DEAL(DealID)
);


CREATE TABLE APPOINTMENT (
    AppointmentID INT  PRIMARY KEY,
    BuyerID       INT  NOT NULL,
    AgentID       INT  NOT NULL,
    PropertyID    INT  NOT NULL,
    AppDate       DATE,
    AppTime       TIME,
    FOREIGN KEY (BuyerID)    REFERENCES BUYER(PersonID),
    FOREIGN KEY (AgentID)    REFERENCES AGENT(PersonID),
    FOREIGN KEY (PropertyID) REFERENCES PROPERTY(PropertyID)
);

CREATE TABLE REVIEW (
    ReviewID   INT           PRIMARY KEY,
    BuyerID    INT           NOT NULL,
    AgentID    INT,
    PropertyID INT,
    Rating     INT           CHECK (Rating BETWEEN 1 AND 5),
    Comment    VARCHAR(500),
    FOREIGN KEY (BuyerID)    REFERENCES BUYER(PersonID),
    FOREIGN KEY (AgentID)    REFERENCES AGENT(PersonID),
    FOREIGN KEY (PropertyID) REFERENCES PROPERTY(PropertyID)
);
GO



INSERT INTO PERSON (PersonID, Name, Phone, Email) VALUES

(1,  'Ahmed Khan',      '0300-1234567', 'ahmed.khan@gmail.com'),
(2,  'Fatima Malik',    '0301-2345678', 'fatima.malik@yahoo.com'),
(3,  'Ali Raza',        '0302-3456789', 'ali.raza@gmail.com'),
(4,  'Ayesha Tariq',    '0303-4567890', 'ayesha.tariq@hotmail.com'),
(5,  'Hassan Malik',    '0304-5678901', 'hassan.malik@gmail.com'),
(6,  'Sara Hussain',    '0305-6789012', 'sara.hussain@yahoo.com'),
(7,  'Usman Tariq',     '0306-7890123', 'usman.tariq@gmail.com'),
(8,  'Zara Ahmed',      '0307-8901234', 'zara.ahmed@hotmail.com'),
(9,  'Bilal Ahmed',     '0308-9012345', 'bilal.ahmed@gmail.com'),
(10, 'Hina Iqbal',      '0309-0123456', 'hina.iqbal@yahoo.com'),
(11, 'Omar Farooq',     '0310-1234567', 'omar.farooq@gmail.com'),
(12, 'Nadia Farooq',    '0311-2345678', 'nadia.farooq@hotmail.com'),
(13, 'Kamran Shah',     '0312-3456789', 'kamran.shah@gmail.com'),
(14, 'Saba Khan',       '0313-4567890', 'saba.khan@yahoo.com'),
(15, 'Shahid Iqbal',    '0314-5678901', 'shahid.iqbal@gmail.com'),
(16, 'Mariam Shah',     '0315-6789012', 'mariam.shah@hotmail.com'),
(17, 'Rizwan Abbasi',   '0316-7890123', 'rizwan.abbasi@gmail.com'),
(18, 'Asma Raza',       '0317-8901234', 'asma.raza@yahoo.com'),
(19, 'Imran Butt',      '0318-9012345', 'imran.butt@gmail.com'),
(20, 'Rabia Butt',      '0319-0123456', 'rabia.butt@hotmail.com'),
-- Sellers 21–35
(21, 'Tariq Mehmood',   '0320-1234567', 'tariq.mehmood@gmail.com'),
(22, 'Amna Chaudhry',   '0321-2345678', 'amna.chaudhry@yahoo.com'),
(23, 'Asim Chaudhry',   '0322-3456789', 'asim.chaudhry@gmail.com'),
(24, 'Iram Baig',       '0323-4567890', 'iram.baig@hotmail.com'),
(25, 'Zahid Hussain',   '0324-5678901', 'zahid.hussain@gmail.com'),
(26, 'Shazia Naqvi',    '0325-6789012', 'shazia.naqvi@yahoo.com'),
(27, 'Faisal Naqvi',    '0326-7890123', 'faisal.naqvi@gmail.com'),
(28, 'Lubna Mehmood',   '0327-8901234', 'lubna.mehmood@hotmail.com'),
(29, 'Nasir Javed',     '0328-9012345', 'nasir.javed@gmail.com'),
(30, 'Rida Abbasi',     '0329-0123456', 'rida.abbasi@yahoo.com'),
(31, 'Amir Sohail',     '0330-1234567', 'amir.sohail@gmail.com'),
(32, 'Waqar Younis',    '0331-2345678', 'waqar.younis@hotmail.com'),
(33, 'Irfan Qureshi',   '0332-3456789', 'irfan.qureshi@gmail.com'),
(34, 'Junaid Baig',     '0333-4567890', 'junaid.baig@yahoo.com'),
(35, 'Nadeem Akhtar',   '0334-5678901', 'nadeem.akhtar@gmail.com'),
-- Agents 36–50
(36, 'Salman Rao',      '0335-6789012', 'salman.rao@gmail.com'),
(37, 'Farrukh Ali',     '0336-7890123', 'farrukh.ali@yahoo.com'),
(38, 'Adnan Sheikh',    '0337-8901234', 'adnan.sheikh@gmail.com'),
(39, 'Kashif Nawaz',    '0338-9012345', 'kashif.nawaz@hotmail.com'),
(40, 'Saad Malik',      '0339-0123456', 'saad.malik@gmail.com'),
(41, 'Hamid Chaudhry',  '0340-1234567', 'hamid.chaudhry@yahoo.com'),
(42, 'Naveed Hassan',   '0341-2345678', 'naveed.hassan@gmail.com'),
(43, 'Waseem Akram',    '0342-3456789', 'waseem.akram@hotmail.com'),
(44, 'Khalid Aziz',     '0343-4567890', 'khalid.aziz@gmail.com'),
(45, 'Zubair Khan',     '0344-5678901', 'zubair.khan@yahoo.com'),
(46, 'Mudassar Ali',    '0345-6789012', 'mudassar.ali@gmail.com'),
(47, 'Asad Raza',       '0346-7890123', 'asad.raza@hotmail.com'),
(48, 'Tanveer Ahmad',   '0347-8901234', 'tanveer.ahmad@gmail.com'),
(49, 'Sohail Abbas',    '0348-9012345', 'sohail.abbas@yahoo.com'),
(50, 'Aamir Liaqat',    '0349-0123456', 'aamir.liaqat@gmail.com');


INSERT INTO BUYER (PersonID, Budget, BankDetails) VALUES
(1,  5000000.00,  'HBL Account: 1234567890'),
(2,  8000000.00,  'UBL Account: 2345678901'),
(3,  3500000.00,  'MCB Account: 3456789012'),
(4,  12000000.00, 'Allied Bank: 4567890123'),
(5,  6000000.00,  'Meezan Bank: 5678901234'),
(6,  4500000.00,  'Bank Alfalah: 6789012345'),
(7,  9000000.00,  'Habib Metro: 7890123456'),
(8,  7500000.00,  'Standard Chartered: 8901234567'),
(9,  11000000.00, 'HBL Account: 9012345678'),
(10, 5500000.00,  'UBL Account: 0123456789'),
(11, 4000000.00,  'MCB Account: 1234509876'),
(12, 6500000.00,  'Allied Bank: 2345610987'),
(13, 8500000.00,  'Meezan Bank: 3456721098'),
(14, 3000000.00,  'Bank Alfalah: 4567832109'),
(15, 10000000.00, 'Habib Metro: 5678943210'),
(16, 7000000.00,  'Standard Chartered: 6789054321'),
(17, 5200000.00,  'HBL Account: 7890165432'),
(18, 9500000.00,  'UBL Account: 8901276543'),
(19, 4200000.00,  'MCB Account: 9012387654'),
(20, 6800000.00,  'Allied Bank: 0123498765');


INSERT INTO SELLER (PersonID, BankDetails) VALUES
(21, 'HBL Account: 5550000001'),
(22, 'UBL Account: 5550000002'),
(23, 'MCB Account: 5550000003'),
(24, 'Allied Bank: 5550000004'),
(25, 'Meezan Bank: 5550000005'),
(26, 'Bank Alfalah: 5550000006'),
(27, 'Habib Metro: 5550000007'),
(28, 'Standard Chartered: 5550000008'),
(29, 'HBL Account: 5550000009'),
(30, 'UBL Account: 5550000010'),
(31, 'MCB Account: 5550000011'),
(32, 'Allied Bank: 5550000012'),
(33, 'Meezan Bank: 5550000013'),
(34, 'Bank Alfalah: 5550000014'),
(35, 'Habib Metro: 5550000015');


INSERT INTO AGENT (PersonID, LicenseNo, Commission) VALUES
(36, 'LIC-KHI-001', 3.50),
(37, 'LIC-LHR-002', 4.00),
(38, 'LIC-ISB-003', 3.00),
(39, 'LIC-RWP-004', 3.75),
(40, 'LIC-PEW-005', 2.50),
(41, 'LIC-KHI-006', 4.50),
(42, 'LIC-LHR-007', 3.25),
(43, 'LIC-ISB-008', 3.80),
(44, 'LIC-MUL-009', 2.75),
(45, 'LIC-FSD-010', 4.25),
(46, 'LIC-HYD-011', 3.60),
(47, 'LIC-QTA-012', 2.90),
(48, 'LIC-SLK-013', 3.40),
(49, 'LIC-GUJ-014', 3.15),
(50, 'LIC-BAH-015', 2.80);

INSERT INTO PROPERTY (PropertyID, SellerID, AgentID, Location, Price, Size, Status, Type) VALUES
(1,  21, 36, 'DHA Phase 5, Karachi',            8500000.00,  '5 Marla',  'Available', 'House'),
(2,  21, 36, 'Gulshan-e-Iqbal, Karachi',         5500000.00,  '3 Marla',  'Sold',      'House'),
(3,  21, 36, 'North Nazimabad, Karachi',          4200000.00,  '4 Marla',  'Available', 'House'),
(4,  21, 36, 'Clifton Block 9, Karachi',          15000000.00, '10 Marla', 'Pending',   'House'),
(5,  22, 36, 'Bahria Town Phase 4, Lahore',       6500000.00,  '5 Marla',  'Available', 'House'),
(6,  22, 37, 'Gulberg III, Lahore',               11000000.00, '8 Marla',  'Sold',      'House'),
(7,  22, 37, 'DHA Phase 6, Lahore',               9500000.00,  '7 Marla',  'Available', 'House'),
(8,  22, 37, 'Model Town, Lahore',                7800000.00,  '6 Marla',  'Pending',   'House'),
(9,  23, 37, 'F-7/2, Islamabad',                 25000000.00, '1 Kanal',  'Available', 'Plot'),
(10, 23, 37, 'G-11 Markaz, Islamabad',            12000000.00, '10 Marla', 'Sold',      'Plot'),
(11, 23, 38, 'Bahria Town Phase 1, Rawalpindi',   3500000.00,  '5 Marla',  'Available', 'Plot'),
(12, 23, 38, 'Satellite Town, Rawalpindi',         2800000.00,  '4 Marla',  'Available', 'Plot'),
(13, 24, 38, 'Hayatabad Phase 3, Peshawar',       4000000.00,  '5 Marla',  'Pending',   'Plot'),
(14, 24, 38, 'Warsak Road, Peshawar',             2500000.00,  '3 Marla',  'Available', 'Plot'),
(15, 24, 38, 'Gulberg, Peshawar',                 3200000.00,  '4 Marla',  'Sold',      'Flat'),
(16, 24, 39, 'Jinnah Town, Quetta',               2000000.00,  '2 Marla',  'Available', 'Flat'),
(17, 25, 39, 'Garden Town, Multan',               3800000.00,  '3 Marla',  'Pending',   'Flat'),
(18, 25, 39, 'Gulgasht Colony, Multan',           2900000.00,  '3 Marla',  'Available', 'Flat'),
(19, 25, 39, 'Peoples Colony, Faisalabad',        2400000.00,  '2 Marla',  'Sold',      'Flat'),
(20, 25, 39, 'Madina Town, Faisalabad',           3100000.00,  '3 Marla',  'Available', 'Flat');

INSERT INTO HOUSE (PropertyID, Floors, Bedrooms) VALUES
(1, 2, 4),
(2, 2, 3),
(3, 1, 3),
(4, 3, 5),
(5, 2, 4),
(6, 3, 5),
(7, 3, 4),
(8, 2, 4);


INSERT INTO PLOT (PropertyID, AreaSqFt) VALUES
(9,  43560.00),
(10, 27225.00),
(11, 13612.50),
(12, 10890.00),
(13, 13612.50),
(14, 12250.00);


INSERT INTO FLAT (PropertyID, FloorLevel) VALUES
(15, 3),
(16, 2),
(17, 5),
(18, 4),
(19, 7),
(20, 6);


INSERT INTO DEAL (DealID, BuyerID, SellerID, PropertyID, AgentID, DealDate, Amount) VALUES
(1,  1,  21, 1,  36, '2024-01-15', 8200000.00),
(2,  2,  22, 6,  37, '2024-01-20', 10500000.00),
(3,  3,  23, 10, 37, '2024-02-05', 11500000.00),
(4,  4,  24, 15, 38, '2024-02-10', 3100000.00),
(5,  5,  25, 19, 39, '2024-02-20', 2300000.00),
(6,  6,  21, 2,  36, '2024-03-01', 5300000.00),
(7,  7,  23, 11, 38, '2024-03-10', 3400000.00),
(8,  8,  24, 16, 39, '2024-03-15', 1900000.00),
(9,  9,  22, 5,  36, '2024-04-01', 6300000.00),
(10, 10, 25, 20, 39, '2024-04-05', 3000000.00),
(11, 11, 21, 3,  36, '2024-04-12', 4100000.00),
(12, 12, 22, 7,  37, '2024-04-20', 9200000.00),
(13, 13, 23, 12, 38, '2024-05-01', 2700000.00),
(14, 14, 24, 13, 38, '2024-05-10', 3900000.00),
(15, 15, 25, 17, 39, '2024-05-15', 3700000.00),
(16, 16, 21, 4,  36, '2024-06-01', 14500000.00),
(17, 17, 22, 8,  37, '2024-06-10', 7600000.00),
(18, 18, 24, 14, 38, '2024-06-15', 2400000.00),
(19, 19, 25, 18, 39, '2024-07-01', 2800000.00),
(20, 20, 23, 9,  37, '2024-07-05', 24000000.00);


INSERT INTO CONTRACT (ContractID, DealID, ContractDate, Terms) VALUES
(1,  1,  '2024-01-17', 'Property transferred upon full payment. No disputes allowed.'),
(2,  2,  '2024-01-22', 'Ownership transferred after verification of all documents.'),
(3,  3,  '2024-02-07', 'Registry to be completed within 30 days of signing.'),
(4,  4,  '2024-02-12', 'Flat handed over after NOC received from society.'),
(5,  5,  '2024-02-22', 'Plot transferred upon payment clearance and demarcation.'),
(6,  6,  '2024-03-03', 'All previous dues cleared by seller before transfer.'),
(7,  7,  '2024-03-12', 'Buyer to arrange demarcation within 60 days of contract.'),
(8,  8,  '2024-03-17', 'Flat keys handed over upon confirmation of full payment.'),
(9,  9,  '2024-04-03', 'Registry under process at sub-registrar office Lahore.'),
(10, 10, '2024-04-07', 'Flat to be vacated by previous occupant within 15 days.'),
(11, 11, '2024-04-14', 'Registry and mutation completed at KBCA successfully.'),
(12, 12, '2024-04-22', 'House possession given upon 50% advance payment received.'),
(13, 13, '2024-05-03', 'Plot boundary wall to be built by society within 90 days.'),
(14, 14, '2024-05-12', 'Plot conversion from residential to commercial agreed.'),
(15, 15, '2024-05-17', 'Flat maintenance charges included in total deal amount.'),
(16, 16, '2024-06-03', 'Property sold as-is. No renovation claims acceptable.'),
(17, 17, '2024-06-12', 'House includes all fixtures and fittings as viewed.'),
(18, 18, '2024-06-17', 'Plot map approved by CDA. Transfer deed in process.'),
(19, 19, '2024-07-03', 'Flat society membership transferred to buyer name.'),
(20, 20, '2024-07-07', 'Plot registration under buyer name within 45 days agreed.');


INSERT INTO PAYMENT (PaymentID, DealID, Method, Amount, PaymentDate) VALUES
(1,  1,  'Bank Transfer', 8200000.00,  '2024-01-16'),
(2,  2,  'Cheque',        10500000.00, '2024-01-21'),
(3,  3,  'Bank Transfer', 11500000.00, '2024-02-06'),
(4,  4,  'Cash',          3100000.00,  '2024-02-11'),
(5,  5,  'Bank Transfer', 2300000.00,  '2024-02-21'),
(6,  6,  'Cheque',        5300000.00,  '2024-03-02'),
(7,  7,  'Bank Transfer', 3400000.00,  '2024-03-11'),
(8,  8,  'Cash',          1900000.00,  '2024-03-16'),
(9,  9,  'Bank Transfer', 6300000.00,  '2024-04-02'),
(10, 10, 'Cheque',        3000000.00,  '2024-04-06'),
(11, 11, 'Bank Transfer', 4100000.00,  '2024-04-13'),
(12, 12, 'Bank Transfer', 9200000.00,  '2024-04-21'),
(13, 13, 'Cash',          2700000.00,  '2024-05-02'),
(14, 14, 'Cheque',        3900000.00,  '2024-05-11'),
(15, 15, 'Bank Transfer', 3700000.00,  '2024-05-16'),
(16, 16, 'Bank Transfer', 14500000.00, '2024-06-02'),
(17, 17, 'Cheque',        7600000.00,  '2024-06-11'),
(18, 18, 'Cash',          2400000.00,  '2024-06-16'),
(19, 19, 'Bank Transfer', 2800000.00,  '2024-07-02'),
(20, 20, 'Bank Transfer', 24000000.00, '2024-07-06');


INSERT INTO APPOINTMENT (AppointmentID, BuyerID, AgentID, PropertyID, AppDate, AppTime) VALUES
(1,  1,  36, 1,  '2024-01-10', '10:00:00'),
(2,  2,  37, 6,  '2024-01-15', '11:00:00'),
(3,  3,  37, 10, '2024-01-30', '14:00:00'),
(4,  4,  38, 15, '2024-02-05', '09:00:00'),
(5,  5,  39, 19, '2024-02-15', '15:00:00'),
(6,  6,  36, 2,  '2024-02-25', '10:30:00'),
(7,  7,  38, 11, '2024-03-05', '11:30:00'),
(8,  8,  39, 16, '2024-03-10', '13:00:00'),
(9,  9,  36, 5,  '2024-03-25', '09:30:00'),
(10, 10, 39, 20, '2024-04-01', '14:30:00'),
(11, 11, 36, 3,  '2024-04-08', '10:00:00'),
(12, 12, 37, 7,  '2024-04-15', '11:00:00'),
(13, 13, 38, 12, '2024-04-25', '15:30:00'),
(14, 14, 38, 13, '2024-05-05', '10:00:00'),
(15, 15, 39, 17, '2024-05-10', '11:30:00'),
(16, 16, 36, 4,  '2024-05-25', '14:00:00'),
(17, 17, 37, 8,  '2024-06-05', '09:00:00'),
(18, 18, 38, 14, '2024-06-10', '13:30:00'),
(19, 19, 39, 18, '2024-06-25', '16:00:00'),
(20, 20, 37, 9,  '2024-06-30', '10:00:00');


INSERT INTO REVIEW (ReviewID, BuyerID, AgentID, PropertyID, Rating, Comment) VALUES
(1,  1,  36, 1,  5, 'Excellent service. Agent was very professional and helpful.'),
(2,  2,  37, 6,  4, 'Good agent. Helped us find the perfect home in Lahore.'),
(3,  3,  37, 10, 4, 'Plot was as described. Transaction was smooth and fast.'),
(4,  4,  38, 15, 3, 'Flat was okay. Some minor issues with maintenance.'),
(5,  5,  39, 19, 5, 'Very happy with the purchase. Great location in Faisalabad!'),
(6,  6,  36, 2,  4, 'Agent communicated well throughout the entire process.'),
(7,  7,  38, 11, 3, 'Average experience. Plot slightly smaller than expected.'),
(8,  8,  39, 16, 5, 'Flat was in great condition. Loved the view from 2nd floor!'),
(9,  9,  36, 5,  4, 'Good house. Agent arranged site visit very quickly.'),
(10, 10, 39, 20, 4, 'Decent flat. Agent helped with all the paperwork.'),
(11, 11, 36, 3,  5, 'Highly recommend this agent. Very honest and trustworthy.'),
(12, 12, 37, 7,  4, 'House was spacious and well maintained. Happy with deal.'),
(13, 13, 38, 12, 2, 'Plot boundaries were not clearly marked. Very disappointing.'),
(14, 14, 38, 13, 3, 'Average experience. Paperwork took longer than expected.'),
(15, 15, 39, 17, 5, 'Wonderful flat with great amenities. Highly satisfied!'),
(16, 16, 36, 4,  5, 'Premium property in excellent Clifton location. 10/10!'),
(17, 17, 37, 8,  4, 'House was well maintained. Agent was very helpful.'),
(18, 18, 38, 14, 3, 'Plot was okay. Agent could have communicated better.'),
(19, 19, 39, 18, 4, 'Nice flat. Good value for money in Multan area.'),
(20, 20, 37, 9,  5, 'Prime F-7 Islamabad plot. Best investment ever!');

GO






SELECT
    P.Name           AS BuyerName,
    PR.Location      AS PropertyLocation,
    PR.Type          AS PropertyType,
    D.Amount         AS DealAmount,
    D.DealDate
FROM DEAL D
JOIN PERSON   P  ON D.BuyerID    = P.PersonID
JOIN PROPERTY PR ON D.PropertyID = PR.PropertyID
ORDER BY D.DealDate;




SELECT
    B.Name           AS BuyerName,
    S.Name           AS SellerName,
    A.Name           AS AgentName,
    PR.Location      AS PropertyLocation,
    PR.Type          AS PropertyType,
    D.Amount         AS DealAmount,
    D.DealDate
FROM DEAL D
JOIN PERSON   B  ON D.BuyerID    = B.PersonID
JOIN PERSON   S  ON D.SellerID   = S.PersonID
JOIN PERSON   A  ON D.AgentID    = A.PersonID
JOIN PROPERTY PR ON D.PropertyID = PR.PropertyID
ORDER BY D.DealDate;




SELECT
    B.Name           AS BuyerName,
    A.Name           AS AgentName,
    PR.Location      AS PropertyLocation,
    PR.Type          AS PropertyType,
    AP.AppDate       AS AppointmentDate,
    AP.AppTime       AS AppointmentTime
FROM APPOINTMENT AP
JOIN PERSON   B  ON AP.BuyerID    = B.PersonID
JOIN PERSON   A  ON AP.AgentID    = A.PersonID
JOIN PROPERTY PR ON AP.PropertyID = PR.PropertyID
ORDER BY AP.AppDate;




SELECT
    B.Name           AS BuyerName,
    S.Name           AS SellerName,
    PR.Location      AS PropertyLocation,
    D.Amount         AS DealAmount,
    C.ContractDate,
    PY.Method        AS PaymentMethod,
    PY.PaymentDate
FROM CONTRACT C
JOIN DEAL     D  ON C.DealID      = D.DealID
JOIN PERSON   B  ON D.BuyerID     = B.PersonID
JOIN PERSON   S  ON D.SellerID    = S.PersonID
JOIN PROPERTY PR ON D.PropertyID  = PR.PropertyID
JOIN PAYMENT  PY ON D.DealID      = PY.DealID
ORDER BY C.ContractDate;




SELECT
    B.Name           AS BuyerName,
    A.Name           AS AgentName,
    PR.Location      AS PropertyLocation,
    R.Rating,
    R.Comment
FROM REVIEW R
JOIN PERSON   B  ON R.BuyerID    = B.PersonID
JOIN PERSON   A  ON R.AgentID    = A.PersonID
JOIN PROPERTY PR ON R.PropertyID = PR.PropertyID
ORDER BY R.Rating DESC;



SELECT
    P.Name               AS AgentName,
    AG.LicenseNo,
    COUNT(PR.PropertyID) AS TotalPropertiesManaged
FROM AGENT AG
JOIN PERSON   P  ON AG.PersonID  = P.PersonID
JOIN PROPERTY PR ON AG.PersonID  = PR.AgentID
GROUP BY P.Name, AG.LicenseNo
ORDER BY TotalPropertiesManaged DESC;




SELECT
    P.Name           AS SellerName,
    COUNT(D.DealID)  AS TotalDeals,
    SUM(D.Amount)    AS TotalRevenue
FROM DEAL D
JOIN PERSON P ON D.SellerID = P.PersonID
GROUP BY P.Name
ORDER BY TotalRevenue DESC;



SELECT
    P.Name                                         AS AgentName,
    AG.Commission                                  AS CommissionPercent,
    COUNT(D.DealID)                                AS TotalDeals,
    AVG(D.Amount)                                  AS AvgDealAmount,
    SUM(D.Amount) * AG.Commission / 100            AS TotalCommissionEarned
FROM DEAL D
JOIN PERSON P ON D.AgentID  = P.PersonID
JOIN AGENT AG ON D.AgentID  = AG.PersonID
GROUP BY P.Name, AG.Commission
ORDER BY TotalCommissionEarned DESC;



SELECT
    P.Name                           AS AgentName,
    COUNT(R.ReviewID)                AS TotalReviews,
    AVG(CAST(R.Rating AS FLOAT))     AS AverageRating
FROM REVIEW R
JOIN PERSON P ON R.AgentID = P.PersonID
GROUP BY P.Name
HAVING AVG(CAST(R.Rating AS FLOAT)) >= 3
ORDER BY AverageRating DESC;



SELECT
    Type             AS PropertyType,
    Status,
    COUNT(*)         AS TotalCount,
    AVG(Price)       AS AvgPrice,
    SUM(Price)       AS TotalValue
FROM PROPERTY
GROUP BY Type, Status
ORDER BY Type, Status;

GO

