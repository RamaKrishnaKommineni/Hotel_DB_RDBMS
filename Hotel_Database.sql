create database Group4;
use Group4;

------------------------------------------- Create all tables -----------------------------------------------------------

--List_of_Cities

CREATE TABLE List_of_Cities(
City_ID int Identity not null primary key,
City_Name varchar(30) not null,
State varchar(30) not null,
Country varchar(30) not null);

--List_Of_Hotels
CREATE TABLE List_of_Hotels(
Hotel_ID int Identity not null primary key,
Hotel_Name varchar(30) not null,
Hotel_Address varchar(50) not null,
Hotel_PostalCode int not null,
City_ID int not null references List_of_Cities(City_ID),
Hotel_Website varchar(80) not null);

alter table List_of_Hotels alter column Hotel_website varchar(80) not null;
alter table List_of_Hotels alter column Hotel_Name varchar(80) not null;
alter table List_of_Hotels alter column Hotel_address varchar(80) not null;


-- List_of_Amenities
CREATE TABLE List_of_Amenities(
Ameniti_ID int identity not null primary key,
Ameniti_Name varchar(20) not null);
alter table List_of_Amenities alter column Ameniti_Name varchar(25) not null;

-- Hotel_Amenities
CREATE TABLE Hotel_Amenities(
Hotel_ID int not null references List_of_Hotels(Hotel_ID),
Ameniti_ID int not null references List_of_Amenities(Ameniti_ID)
	constraint primarykey1 primary key clustered (Hotel_ID,Ameniti_ID));

-- Room_Types
CREATE TABLE Room_Types(
Room_Category varchar(30) not null primary key,
Room_Capacity int not null);

--- Hotel_Rooms
CREATE TABLE Hotel_Rooms(
Room_Number int identity not null,
Hotel_ID int not null references List_of_Hotels(Hotel_ID),
Room_Category varchar(30) references Room_Types(Room_Category),
Room_Floor int
	constraint primarykey2 primary key clustered (Room_Number,Hotel_ID));

-- Seasonal_Pricing
CREATE TABLE Seasonal_Pricing(
Season_ID varchar(10) not null primary key,
Season_Starting_Month date not null,
Season_Ending_Month date not null);

alter table Seasonal_Pricing alter column Season_Starting_Month varchar(15) not null;
alter table Seasonal_Pricing alter column Season_Ending_Month varchar(15) not null;

-- Period_Room_Rates
CREATE TABLE Period_Room_Rates(
Room_Category varchar(30) references Room_Types(Room_Category),
Season_ID varchar(10) not null references Seasonal_Pricing(Season_ID),
Price int not null
	constraint primarykey3 primary key clustered (Room_Category,Season_ID));

-- Room_Selection
CREATE TABLE Room_Selection(
Selection_ID int Identity primary key,
Season_ID varchar(10) not null references Seasonal_Pricing(Season_ID),
Room_Category varchar(30) references Room_Types(Room_Category));

---- Customer_Details
Create table Customer_Details(
Customer_ID int Identity Primary key,
User_Name varchar(30) not null,
Password varchar(30) not null,
First_Name varchar(30) not null,
Last_Name varchar(30) not null,
Gender char(1) NOT NULL CHECK(Gender IN('M','F','N')),
Address varchar(30) not null,
Phone_No int);

alter table Customer_Details alter column Phone_No varchar(10);


-- Hotel_Rating
Create table Hotel_Rating(
Hotel_ID int not null references List_of_Hotels(Hotel_ID),
Customer_ID int references Customer_Details(Customer_ID),
Rating int not null, constraint rating check(Rating between 1 and 5),
constraint primarykey4 primary key clustered (Hotel_ID, Customer_ID));

-- Discount_Coupons
Create table Discount_Coupons(
Coupon_ID varchar(30) primary key,
Percentage_of_Discount int not null);


-- Payment_Details
Create table Payment_Details(
Payment_ID int identity not null primary key,
Coupon_ID VARCHAR(30) references Discount_Coupons(Coupon_ID),
Mode_of_Payment varchar(10) NOT NULL, constraint Mode_of_Payment check(Mode_of_Payment IN('Cash','Card','Check')));


-- Hotel_Booking
Create table Hotel_Booking(
Booking_ID int identity not null primary key,
Customer_ID int references Customer_Details(Customer_ID),
Selection_ID int references Room_Selection(Selection_ID),
Hotel_ID int references List_of_Hotels(Hotel_ID),
Payment_ID int references Payment_Details(Payment_ID),
Booking_Amount int not null
);

------------------------------------------- Create all tables -----------------------------------------------------------


------------------------------------------------------ ENTERING DATA -------------------------------------------------

-- 1. Cities
/* A list of cities are stored in an excel file and using Data Wizard tool cities are entered into List_of_Cities table */

-- 2. Hotels
/* A list of hotels are stored in an excel file and using Data Wizard tool cities are entered into List_of_Hotels table */

-- 3. Amenities
/* A list of Amenities are stored in an excel file and using Data Wizard tool cities are entered into List_of_Amenities table */

-- 4. Hotel Amenities

insert Hotel_Amenities values(1,3),(2,4),(3,6),(4,9),(5,1),(6,11),(7,5),(8,8),(9,2),(10,5),(13,9),(12,7);
insert Hotel_Amenities values(1,4),(2,3),(3,9),(4,8),(5,10),(6,3),(7,9),(8,4),(9,1),(10,9),(13,4),(12,6);

-- 5. Room Types

insert Room_Types values('Single',1),
						('Double',2),
						('Triple',3),
						('Quad',4),
						('Suit',2),
						('Studio',4);

-- 6. Hotel Rooms

insert Hotel_Rooms values (1,'Single',3),(1,'Quad',2),
						  (2,'Triple',5),(2,'Suit',1),
						  (3,'Double',2),(3,'Studio',5),
						  (4,'Triple',3),(4,'Quad',4),
						  (5,'Single',3),(5,'Studio',7),
						  (6,'Double',8),(6,'Triple',9),
						  (7,'Suit',3),(7,'Double',4),
						  (8,'Single',5),(8,'Suit',7);

-- 7. Seasonal Pricing

insert Seasonal_Pricing values ('Spring','March','May'),
							   ('Summer','June','August'),
							   ('Fall','September','November'),
							   ('Winter','December','Febraury');


-- 8. Period Room Rates

insert Period_Room_Rates values ('Single','Spring',100),('Single','Summer',120),('Single','Fall',140),('Single','Winter',80),
                                ('Double','Spring',120),('Double','Summer',140),('Double','Fall',160),('Double','Winter',100),
								('Suit','Spring',150),('Suit','Summer',170),('Suit','Fall',190),('Suit','Winter',130),
								('Triple','Spring',140),('Triple','Summer',160),('Triple','Fall',180),('Triple','Winter',120),
								('Quad','Spring',160),('Quad','Summer',180),('Quad','Fall',200),('Quad','Winter',140),
								('Studio','Spring',180),('Studio','Summer',200),('Studio','Fall',220),('Studio','Winter',160);

-- 9. Room Selection 

insert Room_Selection(Room_Category,Season_ID) values ('Single','Spring'),('Single','Summer'),('Single','Fall'),('Single','Winter'),
                             ('Double','Spring'),('Double','Summer'),('Double','Fall'),('Double','Winter'),
							 ('Suit','Spring'),('Suit','Summer'),('Suit','Fall'),('Suit','Winter'),
							 ('Triple','Spring'),('Triple','Summer'),('Triple','Fall'),('Triple','Winter'),
							 ('Quad','Spring'),('Quad','Summer'),('Quad','Fall'),('Quad','Winter'),
							 ('Studio','Spring'),('Studio','Summer'),('Studio','Fall'),('Studio','Winter');

-- 10. Customer
/* A list of Customers are stored in an excel file and using Data Wizard tool cities are entered into Customer_Details table */

-- 11. Hotel Ratings

insert Hotel_Rating (Hotel_ID,Customer_ID,Rating) values (1,5,4),(1,2,5),(2,7,4),(2,8,2),(3,10,4),(3,7,3),(4,10,5),(4,3,5),(5,6,3),(5,4,2);
insert Hotel_Rating (Hotel_ID,Customer_ID,Rating) values (6,5,2),(6,2,4),(7,10,4),(7,8,2),(8,5,4),(8,6,3),(9,1,5),(9,10,5),(10,4,3),(10,9,2);
insert Hotel_Rating (Hotel_ID,Customer_ID,Rating) values (3,1,4),(7,5,4),(9,7,3),(10,8,5),(1,9,3),(1,10,4),(3,2,5),(3,3,4),(8,4,4),(9,4,5);

-- 12. Coupens
/* A list of Coupens are stored in an excel file and using Data Wizard tool cities are entered into Discount_Coupens table */

select * from Discount_Coupons;

-- 13. Payment details
INSERT Payment_Details VALUES ('SPRING','Card'),('EASTER','Check');

INSERT Payment_Details VALUES ('XMAS10','Card'),('HOLIDAY10','Cash'),('FALL15','Card'),
							  ('HALLOWEEN','Check'),('EASTER','Cash'),('FALL15','Card'),('SUMMER10','Card'),('SUMMER10','Cash');

INSERT Payment_Details VALUES (null,'Card');

INSERT Payment_Details VALUES (null,'Card'),('HOLIDAY10','Cash'),('FALL15','Card'),
							  ('HALLOWEEN','Check'),('EASTER','Cash'),(null,'Card'),('SUMMER10','Card'),(null,'Cash');

-- 14. Hotel booking

/* A list of Bookings are stored in an excel file and using Data Wizard tool cities are entered into Hotel_Booking table */

------------------------------------------------------ ENTERING DATA -------------------------------------------------

------------------------------------------------------ Encryption -----------------------------------------------------

create table EncryptCustomers(
Customer_ID int primary key,
User_Name varchar(30) not null,
Encrypted_Password varbinary(250),
First_Name varchar(30) not null,
Encrypted_Last_Name varbinary(250),
);
drop table EncryptCustomers;
-- Create DMK
CREATE MASTER KEY
ENCRYPTION BY PASSWORD = 'EncrYptioNGrouP4';

-- Create certificate to protect symmetric key
CREATE CERTIFICATE EncryptionCertificate
WITH SUBJECT = 'Group4 Project Certificate',
EXPIRY_DATE = '2026-10-31';

-- Create symmetric key to encrypt data
CREATE SYMMETRIC KEY Group4Key
WITH ALGORITHM = AES_128
ENCRYPTION BY CERTIFICATE EncryptionCertificate;

-- Open symmetric key
OPEN SYMMETRIC KEY Group4Key
DECRYPTION BY CERTIFICATE EncryptionCertificate;

--Populate table with 10 customers encrypted values
Insert 	EncryptCustomers(Customer_ID,User_Name,Encrypted_Password,First_Name,Encrypted_Last_Name)
										select top(10) Customer_ID,User_Name,
										ENCRYPTBYKEY(KEY_GUID(N'Group4Key'),convert(varbinary,Password)),
										First_Name,
										ENCRYPTBYKEY(KEY_GUID(N'Group4Key'),convert(varbinary,Last_Name)) 
										from Customer_Details order by Customer_ID;

-- Show the results
select * from EncryptCustomers;

-- Close the symmetric key
CLOSE SYMMETRIC KEY Group4Key;

-- Drop the symmetric key
DROP SYMMETRIC KEY Group4Key;

-- Drop the certificate
DROP CERTIFICATE EncryptionCertificate;

--Drop the DMK
DROP MASTER KEY;

------------------------------------------------------ Encryption -----------------------------------------------------

------------------------------------------------------ Table level constratint ----------------------------------------

create table BehaviorIssues (
Cust_ID int,
BehaviorType varchar(30),
BehaviorDate date,
constraint BehaviorType check(BehaviorType IN('Good','Bad'))
);
drop table BehaviorIssues;
-- Create a function to check whether a customer has ever had bad behavior
-- Function will return a number greater than 0 if a customer has had bad behavior before

CREATE FUNCTION CheckBehavior (@Cust_ID int)
RETURNS smallint
AS
BEGIN
   DECLARE @Count smallint=0;
   SELECT @Count = COUNT(Cust_ID) 
          FROM BehaviorIssues
          WHERE Cust_ID = @Cust_ID
          AND BehaviorType = 'Bad';
   RETURN @Count;
END;


-- Add table-level CHECK constraint based on the new function for the Hotel_Booking table
ALTER TABLE Hotel_Booking ADD CONSTRAINT BanBadBehavior CHECK (dbo.CheckBehavior(Customer_ID) = 0);

-- Put some data in the new tables
INSERT INTO BehaviorIssues (Cust_ID, BehaviorType, BehaviorDate)
VALUES (5, 'Bad', '08-10-2018'),
	   (10, 'Bad', '08-14-2018'),
       (3, 'Good', '4-13-2018');

----------- WHEN TRYING TO INSERT A GOOD CUSTOMER---------
INSERT Hotel_Booking VALUES(3,15,6,16,200);

----------- WHEN TRYING TO INSERT A BAD BEHAVIOR CUSTOMER---------
INSERT Hotel_Booking VALUES(5,10,11,17,220);

------------------------------------------------------ Table level constratint ----------------------------------------

------------------------------------------------------ VIEW -----------------------------------------------------------
CREATE VIEW HOTELDETAILS AS
SELECT H.Hotel_ID,H.Hotel_Name,(SELECT COUNT(Booking_ID) FROM Hotel_Booking WHERE Hotel_ID=H.Hotel_ID) NO_OF_BOOKINGS,
CAST(AVG(Rating) AS decimal(5,2)) AVGRATING 
FROM List_of_Hotels H JOIN Hotel_Booking B 
ON H.Hotel_ID=B.Hotel_ID
JOIN Hotel_Rating R 
ON H.Hotel_ID=R.Hotel_ID
GROUP BY H.Hotel_ID,H.Hotel_Name;

SELECT * FROM HOTELDETAILS;

------------------------------------------------------ VIEW -----------------------------------------------------------
CREATE VIEW CUSTOMERBOOKINGS AS
SELECT DISTINCT C.Customer_ID,User_Name,STUFF((SELECT  ', '+RTRIM(CAST(Hotel_ID as char))  
       FROM Hotel_Booking 
       WHERE Customer_ID = C.Customer_ID
       ORDER BY Customer_ID
       FOR XML PATH('')) , 1, 2, '') AS IDS_OF_HOTELS_BOOKED
FROM Customer_Details C JOIN Hotel_Booking B 
ON C.Customer_ID = B.Customer_ID;

SELECT * FROM CUSTOMERBOOKINGS;