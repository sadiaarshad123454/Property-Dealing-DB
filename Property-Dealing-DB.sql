DROP TABLE IF EXISTS Payment;
DROP TABLE IF EXISTS Contract;
DROP TABLE IF EXISTS Deal;
DROP TABLE IF EXISTS Appointment;
DROP TABLE IF EXISTS Review;
DROP TABLE IF EXISTS Property;
DROP TABLE IF EXISTS Buyer;
DROP TABLE IF EXISTS Seller;
DROP TABLE IF EXISTS Agent;
DROP TABLE IF EXISTS Person;
CREATE TABLE Person (
    PersonID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Phone VARCHAR(20) NOT NULL,
    Email VARCHAR(100) NOT NULL
);

CREATE TABLE Buyer (
    BuyerID INT PRIMARY KEY,
    Budget DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (BuyerID) REFERENCES Person(PersonID)
);

CREATE TABLE Seller (
    SellerID INT PRIMARY KEY,
    BankDetails VARCHAR(100) NOT NULL,
    FOREIGN KEY (SellerID) REFERENCES Person(PersonID)
);

CREATE TABLE Agent (
    AgentID INT PRIMARY KEY,
    LicenseNo VARCHAR(50) NOT NULL,
    Commission DECIMAL(5,2) NOT NULL,
    FOREIGN KEY (AgentID) REFERENCES Person(PersonID)
);

CREATE TABLE Property (
    PropertyID INT IDENTITY(1,1) PRIMARY KEY,
    SellerID INT NOT NULL,
    AgentID INT NOT NULL,
    Location VARCHAR(100) NOT NULL,
    Price DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (SellerID) REFERENCES Seller(SellerID),
    FOREIGN KEY (AgentID) REFERENCES Agent(AgentID)
);

CREATE TABLE Deal (
    DealID INT IDENTITY(1,1) PRIMARY KEY,
    BuyerID INT NOT NULL,
    SellerID INT NOT NULL,
    PropertyID INT NOT NULL UNIQUE,
    DealDate DATE NOT NULL,
    FOREIGN KEY (BuyerID) REFERENCES Buyer(BuyerID),
    FOREIGN KEY (SellerID) REFERENCES Seller(SellerID),
    FOREIGN KEY (PropertyID) REFERENCES Property(PropertyID)
);

CREATE TABLE Contract (
    ContractID INT IDENTITY(1,1) PRIMARY KEY,
    DealID INT NOT NULL UNIQUE,
    Terms VARCHAR(255) NOT NULL,
    FOREIGN KEY (DealID) REFERENCES Deal(DealID)
);

CREATE TABLE Payment (
    PaymentID INT IDENTITY(1,1) PRIMARY KEY,
    DealID INT NOT NULL,
    Amount DECIMAL(12,2) NOT NULL,
    PaymentDate DATE NOT NULL,
    FOREIGN KEY (DealID) REFERENCES Deal(DealID)
);

CREATE TABLE Appointment (
    AppointmentID INT IDENTITY(1,1) PRIMARY KEY,
    BuyerID INT NOT NULL,
    AgentID INT NOT NULL,
    PropertyID INT NOT NULL,
    VisitDate DATE NOT NULL,
    FOREIGN KEY (BuyerID) REFERENCES Buyer(BuyerID),
    FOREIGN KEY (AgentID) REFERENCES Agent(AgentID),
    FOREIGN KEY (PropertyID) REFERENCES Property(PropertyID)
);

CREATE TABLE Review (
    ReviewID INT IDENTITY(1,1) PRIMARY KEY,
    BuyerID INT NOT NULL,
    PropertyID INT NULL,
    AgentID INT NULL,
    Rating INT NOT NULL,
    FOREIGN KEY (BuyerID) REFERENCES Buyer(BuyerID),
    FOREIGN KEY (PropertyID) REFERENCES Property(PropertyID),
    FOREIGN KEY (AgentID) REFERENCES Agent(AgentID)
);
INSERT INTO Person (Name, Phone, Email) VALUES
('Ali','0300','ali@gmail.com'),
('Ahmed','0301','ahmed@gmail.com'),
('Sara','0302','sara@gmail.com'),
('Zain','0303','zain@gmail.com'),
('Hina','0304','hina@gmail.com'),
('Usman','0305','usman@gmail.com'),
('Ayesha','0306','ayesha@gmail.com'),
('Bilal','0307','bilal@gmail.com'),
('Noor','0308','noor@gmail.com'),
('Hamza','0309','hamza@gmail.com'),
('Fatima','0310','fatima@gmail.com'),
('Daniyal','0311','dan@gmail.com'),
('Mariam','0312','mariam@gmail.com'),
('Omar','0313','omar@gmail.com'),
('Saad','0314','saad@gmail.com'),
('Tariq','0315','tariq@gmail.com'),
('Iqra','0316','iqra@gmail.com'),
('Rehan','0317','rehan@gmail.com'),
('Kiran','0318','kiran@gmail.com'),
('Farhan','0319','farhan@gmail.com');
INSERT INTO Buyer (BuyerID, Budget) VALUES
(1,5000000),(2,4000000),(3,6000000),(4,3000000),(5,7000000),
(6,3500000),(7,4500000),(8,5500000),(9,6500000),(10,2500000),
(11,2700000),(12,2800000),(13,2900000),(14,3100000),(15,3200000),
(16,3300000),(17,3400000),(18,3600000),(19,3700000),(20,3800000);
INSERT INTO Seller (SellerID, BankDetails) VALUES
(1,'Bank1'),(2,'Bank2'),(3,'Bank3'),(4,'Bank4'),(5,'Bank5'),
(6,'Bank6'),(7,'Bank7'),(8,'Bank8'),(9,'Bank9'),(10,'Bank10'),
(11,'Bank11'),(12,'Bank12'),(13,'Bank13'),(14,'Bank14'),(15,'Bank15'),
(16,'Bank16'),(17,'Bank17'),(18,'Bank18'),(19,'Bank19'),(20,'Bank20');
INSERT INTO Agent (AgentID, LicenseNo, Commission) VALUES
(1,'L1',5),(2,'L2',6),(3,'L3',5),(4,'L4',4),(5,'L5',6),
(6,'L6',5),(7,'L7',7),(8,'L8',5),(9,'L9',6),(10,'L10',5),
(11,'L11',4),(12,'L12',6),(13,'L13',5),(14,'L14',7),(15,'L15',5),
(16,'L16',6),(17,'L17',5),(18,'L18',4),(19,'L19',6),(20,'L20',5);
INSERT INTO Property (SellerID, AgentID, Location, Price) VALUES
(1,1,'Lahore',5000000),(2,2,'Karachi',6000000),
(3,3,'Islamabad',7000000),(4,4,'Rawalpindi',4500000),
(5,5,'Multan',3000000),(6,6,'Faisalabad',3500000),
(7,7,'Peshawar',2800000),(8,8,'Quetta',2500000),
(9,9,'Sialkot',3200000),(10,10,'Gujranwala',3300000),
(11,11,'Bahawalpur',2700000),(12,12,'Sargodha',2900000),
(13,13,'Hyderabad',3100000),(14,14,'Abbottabad',3600000),
(15,15,'Gwadar',4000000),(16,16,'Chiniot',2200000),
(17,17,'Jhelum',2600000),(18,18,'Okara',2400000),
(19,19,'Kasur',2300000),(20,20,'Mardan',2800000);
INSERT INTO Deal (BuyerID, SellerID, PropertyID, DealDate) VALUES
(1,1,1,'2025-01-01'),(2,2,2,'2025-01-02'),
(3,3,3,'2025-01-03'),(4,4,4,'2025-01-04'),
(5,5,5,'2025-01-05'),(6,6,6,'2025-01-06'),
(7,7,7,'2025-01-07'),(8,8,8,'2025-01-08'),
(9,9,9,'2025-01-09'),(10,10,10,'2025-01-10'),
(11,11,11,'2025-01-11'),(12,12,12,'2025-01-12'),
(13,13,13,'2025-01-13'),(14,14,14,'2025-01-14'),
(15,15,15,'2025-01-15'),(16,16,16,'2025-01-16'),
(17,17,17,'2025-01-17'),(18,18,18,'2025-01-18'),
(19,19,19,'2025-01-19'),(20,20,20,'2025-01-20');
INSERT INTO Payment (DealID, Amount, PaymentDate) VALUES
(1,1000000,'2025-02-01'),
(1,2000000,'2025-02-02'),
(2,1500000,'2025-02-03'),
(3,2000000,'2025-02-04'),
(4,1200000,'2025-02-05'),
(5,1100000,'2025-02-06'),
(6,1300000,'2025-02-07'),
(7,1400000,'2025-02-08'),
(8,900000,'2025-02-09'),
(9,800000,'2025-02-10'),
(10,700000,'2025-02-11'),
(11,600000,'2025-02-12'),
(12,500000,'2025-02-13'),
(13,400000,'2025-02-14'),
(14,300000,'2025-02-15'),
(15,200000,'2025-02-16'),
(16,100000,'2025-02-17'),
(17,900000,'2025-02-18'),
(18,800000,'2025-02-19'),
(19,700000,'2025-02-20');
INSERT INTO Contract (DealID, Terms) VALUES
(1,'Full payment within 30 days'),
(2,'Installment plan 6 months'),
(3,'Immediate transfer after payment'),
(4,'10% advance required'),
(5,'Bank verified transaction only'),
(6,'Ownership transfer in 15 days'),
(7,'Installments over 1 year'),
(8,'Cash payment preferred'),
(9,'Legal verification required'),
(10,'No delay allowed in payment'),
(11,'Partial payment allowed'),
(12,'Full settlement in 2 weeks'),
(13,'Advance + remaining in 3 months'),
(14,'Agreement via bank escrow'),
(15,'No refund policy applies'),
(16,'Transfer after final payment'),
(17,'Monthly installment plan'),
(18,'Immediate possession after deal'),
(19,'Legal documentation mandatory'),
(20,'All taxes paid by buyer');
INSERT INTO Appointment (BuyerID, AgentID, PropertyID, VisitDate) VALUES
(1,1,1,'2025-01-05'),
(2,2,2,'2025-01-06'),
(3,3,3,'2025-01-07'),
(4,4,4,'2025-01-08'),
(5,5,5,'2025-01-09'),
(6,6,6,'2025-01-10'),
(7,7,7,'2025-01-11'),
(8,8,8,'2025-01-12'),
(9,9,9,'2025-01-13'),
(10,10,10,'2025-01-14'),
(11,11,11,'2025-01-15'),
(12,12,12,'2025-01-16'),
(13,13,13,'2025-01-17'),
(14,14,14,'2025-01-18'),
(15,15,15,'2025-01-19'),
(16,16,16,'2025-01-20'),
(17,17,17,'2025-01-21'),
(18,18,18,'2025-01-22'),
(19,19,19,'2025-01-23'),
(20,20,20,'2025-01-24');
INSERT INTO Review (BuyerID, PropertyID, AgentID, Rating) VALUES
(1,1,1,5),
(2,2,2,4),
(3,3,3,5),
(4,4,4,3),
(5,5,5,4),
(6,6,6,5),
(7,7,7,4),
(8,8,8,3),
(9,9,9,5),
(10,10,10,4),
(11,11,11,3),
(12,12,12,5),
(13,13,13,4),
(14,14,14,5),
(15,15,15,3),
(16,16,16,4),
(17,17,17,5),
(18,18,18,3),
(19,19,19,4),
(20,20,20,5);
SELECT 
    B.BuyerID,
    P.Name,
    D.DealID,
    Pr.Location,
    Pr.Price
FROM Buyer B
JOIN Person P ON B.BuyerID = P.PersonID
JOIN Deal D ON B.BuyerID = D.BuyerID
JOIN Property Pr ON D.PropertyID = Pr.PropertyID;
/*π BuyerID, Name, DealID, Location, Price
(
    ((Buyer ⨝ Buyer.BuyerID = Person.PersonID Person)
    ⨝ Buyer.BuyerID = Deal.BuyerID Deal)
    ⨝ Deal.PropertyID = Property.PropertyID Property
)*/
SELECT 
    S.SellerID,
    Pr.PropertyID,
    Pr.Location,
    A.AgentID,
    A.Commission
FROM Seller S
JOIN Property Pr ON S.SellerID = Pr.SellerID
JOIN Agent A ON Pr.AgentID = A.AgentID;
/*π SellerID, PropertyID, Location, AgentID, Commission
(
    (Seller ⨝ Seller.SellerID = Property.SellerID Property)
    ⨝ Property.AgentID = Agent.AgentID Agent
)*/
SELECT 
    Ap.AppointmentID,
    B.BuyerID,
    A.AgentID,
    Pr.Location,
    Ap.VisitDate
FROM Appointment Ap
JOIN Buyer B ON Ap.BuyerID = B.BuyerID
JOIN Agent A ON Ap.AgentID = A.AgentID
JOIN Property Pr ON Ap.PropertyID = Pr.PropertyID;
/*
π AppointmentID, BuyerID, AgentID, Location, VisitDate
(
    ((Appointment ⨝ Appointment.BuyerID = Buyer.BuyerID Buyer)
    ⨝ Appointment.AgentID = Agent.AgentID Agent)
    ⨝ Appointment.PropertyID = Property.PropertyID Property
)*/
