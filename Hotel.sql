DROP DATABASE HotelDatabase;
CREATE DATABASE HotelDatabase;
USE HotelDatabase;


DROP TABLE IF EXISTS Hotel;
CREATE TABLE Hotel (
HotelID int NOT NULL AUTO_INCREMENT,
Street varchar(30) NOT NULL,
City varchar(30) NOT NULL,
State varchar(30) NOT NULL,
Country varchar(50) NOT NULL,
ZIP int NOT NULL,
Primary Key(HotelID)
);

DROP TABLE IF EXISTS HotelPhones;

CREATE TABLE HotelPhones(
	PhoneId int NOT NULL AUTO_INCREMENT,
	PhoneNumber varchar(12) NOT NULL,
	HotelID int NOT NULL,
	Primary Key(PhoneId, HotelID),
	Foreign Key(HotelID) references Hotel(HotelID)
);

DROP TABLE IF EXISTS ROOM;

CREATE TABLE Room(
RoomNumber int NOT NULL,
HotelID int NOT NULL,
Price float NOT NULL,
Capacity int NOT NULL,
FloorNumber int NOT NULL,
Description varchar(50) NOT NULL,
RoomType varchar(50) NOT NULL,
StartDate DATE,
EndDate DATE,
Discount float,
Primary Key(RoomNumber, HotelID),
Foreign Key(HotelID) references Hotel(HotelID)
);


DROP TABLE IF EXISTS Breakfast;

CREATE TABLE Breakfast(
BreakfastType varchar(50) NOT NULL DEFAULT '0',
BreakfastDescription varchar(50),
BreakfastPrice int,
HotelID int NOT NULL,
Primary Key(BreakfastType, HotelID),
Foreign Key(HotelID) references Hotel(HotelID)
);


DROP TABLE IF EXISTS Service;

CREATE TABLE Service(
ServiceType varchar(50) NOT NULL DEFAULT '0',
ServicePrice int,
HotelID int NOT NULL,
Primary Key(ServiceType, HotelID),
Foreign Key(HotelID) references Hotel(HotelID)
);

DROP TABLE IF EXISTS CreditCard;

CREATE TABLE CreditCard(
CardNumber varchar(16) NOT NULL,
BillingAddress varchar(50) NOT NULL,
Name varchar(20) NOT NULL,
SecurityCode int NOT NULL,
Type varchar(20) NOT NULL,
ExpirationDate DATE NOT NULL,
Primary Key(CardNumber)
);

DROP TABLE IF EXISTS Customer;

CREATE TABLE Customer(
CustomerID int NOT NULL AUTO_INCREMENT,
Email varchar(50) NOT NULL,
Address varchar(50) NOT NULL,
PhoneNumber varchar(20) NOT NULL,
`Password` varchar(20) NOT NULL,
`Name` varchar(25) NOT NULL,
Primary Key(CustomerID)
);

DROP TABLE IF EXISTS Reservation;

CREATE TABLE Reservation(
InvoiceNumber int NOT NULL AUTO_INCREMENT,
ReservationDate DATE NOT NULL,
TotalAmount float NOT NULL,
CardNumber varchar(16) NOT NULL,
CustomerID int NOT NULL,
Primary Key(InvoiceNumber),
Foreign Key(CardNumber) references CreditCard(CardNumber),
Foreign Key(CustomerID) references Customer(CustomerID)
);

DROP TABLE IF EXISTS Reserves;

CREATE TABLE Reserves(
OutDate date NOT NULL,
InDate date NOT NULL,
NoOfDays int NOT NULL,
InvoiceNumber int Not NULL,
RoomNumber int NOT NULL,
HotelID int NOT NULL,
Primary Key(InvoiceNumber, RoomNumber, HotelID),
Foreign Key(InvoiceNumber) references Reservation(InvoiceNumber),
Foreign Key(RoomNumber, HotelID) references Room(RoomNumber, HotelID)
);

DROP TABLE IF EXISTS Includes;

CREATE TABLE Includes(
BreakfastType varchar(50),
HotelID int NOT NULL,
InvoiceNumber int NOT NULL,
Primary Key(BreakfastType, HotelID, InvoiceNumber),
Foreign Key(InvoiceNumber) references Reservation(InvoiceNumber),
Foreign Key(BreakfastType, HotelID) references Breakfast(BreakfastType, HotelID)
);

DROP TABLE IF EXISTS `Contains`;

CREATE TABLE `Contains`(
ServiceType varchar(50),
HotelID int NOT NULL,
InvoiceNumber int NOT NULL,
Primary Key(ServiceType, HotelID, InvoiceNumber),
Foreign Key(InvoiceNumber) references Reservation(InvoiceNumber),
Foreign Key(ServiceType, HotelID) references Service(ServiceType, HotelID)
); 


DROP TABLE IF EXISTS RoomReview; 

CREATE TABLE RoomReview(
ReviewID int NOT NULL AUTO_INCREMENT,
RoomNumber int NOT NULL,
HotelID int Not NULL,
Rating float NOT NULL,
TextComment varchar(100),
CHECK (Rating < 11),
CHECK (Rating >= 0),
CustomerID int NOT NULL,
Primary Key(ReviewID, RoomNumber, HotelID),
Foreign Key(CustomerID) references Customer(CustomerID),
Foreign Key(RoomNumber, HotelID) references Room(RoomNumber, HotelID)
);

DROP TABLE IF EXISTS BreakfastReview;

CREATE TABLE BreakfastReview(
ReviewID int NOT NULL AUTO_INCREMENT,
BreakfastType varchar(50) NOT NULL,
HotelID int Not NULL,
Rating float NOT NULL,
TextComment varchar(100),
CHECK (Rating < 11),
CHECK (Rating >= 0),
CustomerID int NOT NULL,
Primary Key(ReviewID, BreakfastType, HotelID),
Foreign Key(CustomerID) references Customer(CustomerID),
Foreign Key(BreakfastType, HotelID) references Breakfast(BreakfastType, HotelID)
);

DROP TABLE IF EXISTS ServiceReview;

CREATE TABLE ServiceReview(
ReviewID int NOT NULL AUTO_INCREMENT,
ServiceType varchar(50) NOT NULL,
HotelID int Not NULL,
Rating float NOT NULL,
TextComment varchar(100),
CHECK (Rating < 11),
CHECK (Rating >= 0),
CustomerID int NOT NULL,
Primary Key(ReviewID, ServiceType, HotelID),
Foreign Key(CustomerID) references Customer(CustomerID),
Foreign Key(ServiceType, HotelID) references Service(ServiceType, HotelID)
);
