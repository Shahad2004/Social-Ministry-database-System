CREATE DATABASE Ministry_Final_System1;
use Ministry_Final_System1;
--Tables
CREATE TABLE Schedule(
Schedule_ID INT primary key NOT NULL,
Beneficary_ID INT NULL,
Trainer_ID INT NULL,
Organizer_ID INT NULL,
Start_Date DATE NOT NULL,       
Status VARCHAR(15) NOT NULL,
);

CREATE TABLE Trainer(
Trainer_ID INT primary key,
Course_ID INT NULL,
fname VARCHAR(50) NOT NULL,
lname VARCHAR(50) NOT NULL,
Expertise VARCHAR(50) NOT NULL,
);
ALTER TABLE Trainer ALTER COLUMN fname VARCHAR(20) NOT NULL;
ALTER TABLE Trainer ALTER COLUMN lname VARCHAR(20) NOT NULL;

CREATE TABLE Beneficary(
Beneficary_ID INT primary key,
fname VARCHAR(20),
midname VARCHAR(20),
lname VARCHAR(20),
UNIQUE(fname,midname,lname),
sex CHAR(1) CHECK( sex ='M' or sex = 'F' ) NOT NULL,
date_of_birth DATE NOT NULL,
dept VARCHAR(100) NOT NULL,
);
ALTER TABLE Beneficary ALTER COLUMN dept VARCHAR(50);
ALTER TABLE Beneficary DROP CONSTRAINT UQ__Benefica__514F3066AB88F179;
ALTER TABLE Beneficary ALTER COLUMN fname VARCHAR(20) NOT NULL;
ALTER TABLE Beneficary ALTER COLUMN midname VARCHAR(20) NOT NULL;
ALTER TABLE Beneficary ALTER COLUMN lname VARCHAR(20) NOT NULL;

ALTER TABLE Beneficary ADD CONSTRAINT UQ_Beneficary_FullName UNIQUE (fname, midname, lname);

CREATE TABLE Course (
Course_ID INT NOT NULL primary key,
Name VARCHAR(30) NOT NULL,
Credit_Hours INT NOT NULL,
Prerequisites VARCHAR(50) NULL,
Description TEXT NULL,
Delivery_Method VARCHAR(15) NOT NULL,
Enrollment_Capacity INT NOT NULL,
);


CREATE TABLE Program(
Program_ID INT primary key,
Name VARCHAR(20) NOT NULL UNIQUE,
Code VARCHAR(20) NOT NULL,
Level VARCHAR(15) NOT NULL DEFAULT ('intermediate')
);
ALTER TABLE Program DROP CONSTRAINT UQ__Program__737584F61EA6A87F;
ALTER TABLE Program ALTER COLUMN Name VARCHAR(50) NOT NULL ;
ALTER TABLE Program 
ADD CONSTRAINT program_unique_name UNIQUE (Name);
ALTER TABLE Program DROP COLUMN Code;
ALTER TABLE Program ALTER COLUMN Level VARCHAR(0);

CREATE TABLE Course_Program(
Course_ID INT,
Program_ID INT,
primary key(Course_ID,Program_ID),
);

CREATE TABLE Organizer(
Organizer_ID INT primary key,
fname VARCHAR(20) NOT NULL,
lname VARCHAR(20) NOT NULL,
UNIQUE(fname,lname),
starting_Date DATE NOT NULL,
salary DECIMAL(5,2),
date_Employeed DATE NOT NULL
);
SELECT * FROM  Organizer
SELECT * FROM Program
ALTER TABLE Organizer DROP CONSTRAINT UQ__Organize__A4D864AA4D550C35;

CREATE TABLE Beneficary_Addresses(
Beneficary_ID INT,
addresses VARCHAR(50) NOT NULL,
primary key(Beneficary_ID,addresses)
);

CREATE TABLE Beneficary_Emails(
Beneficary_ID INT ,
email VARCHAR(50) NOT NULL UNIQUE,
primary key(Beneficary_ID,email)
);

CREATE TABLE Beneficary_PhoneNumbers(
Beneficary_ID INT,
phone_number VARCHAR(15) NOT NULL UNIQUE,
primary key(Beneficary_ID,phone_number)
);
DROP TABLE IF EXISTS Course_Location;
CREATE TABLE Course_Location(
Course_ID INT NOT NULL,
location VARCHAR(255) NOT NULL,
primary key(Course_ID,location)
);

CREATE TABLE Trainer_PhoneNumbers(
Trainer_ID INT,
phone_number VARCHAR(15) NOT NULL UNIQUE,
primary key(Trainer_ID,phone_number)
);

CREATE TABLE Orgainzer_PhoneNumbers(
Organizer_ID INT,
phone_number VARCHAR(15) NOT NULL UNIQUE,
primary key(Organizer_ID,phone_number)
);

CREATE TABLE Program_Organizer(
Program_ID INT,
Organizer_ID INT,
primary key(Program_ID,Organizer_ID)
);

CREATE TABLE Course_Schedule(
Course_ID INT,
Schedule_ID INT,
Primary key(Course_ID,Schedule_ID),
);
CREATE TABLE Program_Beneficary(
Program_ID INT,
Beneficary_ID INT,
Primary key(Program_ID,Beneficary_ID),
);
ALTER TABLE Program ALTER COLUMN Level VARCHAR(15) NULL;
ALTER TABLE Program ALTER COLUMN Name VARCHAR(50);
--Deleted the ON UPDATE ON DELETE CASCAD to avoid multiple paths
ALTER TABLE Program_Organizer ADD FOREIGN KEY(Program_ID) REFERENCES Program(Program_ID)ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Program_Organizer ADD FOREIGN KEY(Organizer_ID) REFERENCES Organizer(Organizer_ID)ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Orgainzer_PhoneNumbers ADD FOREIGN KEY(Organizer_ID) REFERENCES Organizer(Organizer_ID)ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Trainer_PhoneNumbers ADD FOREIGN KEY(Trainer_ID) REFERENCES Trainer(Trainer_ID)ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Course_Location ADD FOREIGN KEY(Course_ID) REFERENCES Course(Course_ID)ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Beneficary_PhoneNumbers ADD FOREIGN KEY(Beneficary_ID) REFERENCES Beneficary(Beneficary_ID)ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Beneficary_Emails ADD FOREIGN KEY(Beneficary_ID) REFERENCES Beneficary(Beneficary_ID)ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Beneficary_Addresses ADD FOREIGN KEY(Beneficary_ID) REFERENCES Beneficary(Beneficary_ID)ON DELETE CASCADE ON UPDATE CASCADE ;
ALTER TABLE Schedule ADD FOREIGN KEY(Beneficary_ID) REFERENCES Beneficary(Beneficary_ID) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Schedule ADD FOREIGN KEY(Trainer_ID) REFERENCES Trainer(Trainer_ID) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Schedule ADD FOREIGN KEY(Organizer_ID) REFERENCES Organizer(Organizer_ID) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Trainer ADD FOREIGN KEY(Course_ID) REFERENCES Course(Course_ID) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Course_Schedule ADD FOREIGN KEY(Course_ID) REFERENCES Course(Course_ID) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Course_Schedule ADD FOREIGN KEY(Schedule_ID) REFERENCES Schedule(Schedule_ID);
ALTER TABLE Course_Program ADD FOREIGN KEY(Course_ID) REFERENCES Course(Course_ID)ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Course_Program ADD FOREIGN KEY(Program_ID) REFERENCES Program(Program_ID)ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Program_Beneficary ADD FOREIGN KEY(Program_ID) REFERENCES Program(Program_ID)ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Program_Beneficary ADD FOREIGN KEY(Beneficary_ID) REFERENCES Beneficary(Beneficary_ID)ON DELETE CASCADE ON UPDATE CASCADE;


--Insertion for the Beneficary
INSERT INTO Beneficary (Beneficary_ID, fname, midname, lname, sex, date_of_birth, dept)
VALUES
(1, 'Mohammed', 'Ahmed', 'Alzubi', 'M', '1990-01-15', 200),
(2, 'Ali', 'Hassan', 'Khaled', 'M', '1988-04-22', 250),
(3, 'Khaled', 'Mohammed', 'Alali', 'M', '1992-07-30', 300),
(4, 'Fatima', 'Ali', 'Alnaimi', 'F', '1985-11-05', 350),
(5, 'Sara', 'Ahmed', 'Alhashmi', 'F', '2000-02-14', 400),
(6, 'Aisha', 'Mohammed', 'Alansari', 'F', '1989-03-19', 450),
(7, 'Yousef', 'Abdullah', 'Alsaleh', 'M', '2001-05-21', 500),
(8, 'Hassan', 'Ali', 'Alfarsi', 'M', '1987-08-09', 550),
(9, 'Layla', 'Khaled', 'Alhaddad', 'F', '1994-10-11', 600),
(10, 'Omar', 'Yousef', 'Alomari', 'M', '1990-12-25', 650),
(11, 'Noura', 'Hassan', 'Alghamdi', 'F', '2002-06-18', 700),
(12, 'Salem', 'Mohammed', 'Alshamsi', 'M', '1992-09-03', 750),
(13, 'Huda', 'Ali', 'Alnajjar', 'F', '1984-07-27', 800),
(14, 'Rashid', 'Salem', 'Almazroui', 'M', '2002-01-09', 850),
(15, 'Mona', 'Omar', 'Almansoori', 'F', '1991-04-29', 900),
(16, 'Tariq', 'Hassan', 'Albalushi', 'M', '2003-02-23', 220),
(17, 'Amal', 'Rashid', 'Alzahrani', 'F', '1990-05-17', 330),
(18, 'Faisal', 'Tariq', 'Alqasim', 'M', '2003-11-13', 440),
(19, 'Reem', 'Khaled', 'Alsudani', 'F', '1989-06-08', 550),
(20, 'Naser', 'Salem', 'Almarri', 'M', '2004-03-14', 660);


ALTER TABLE Organizer ALTER COLUMN salary DECIMAL(6,2) not null;
--Insertion for the Organizer
INSERT INTO Organizer (Organizer_ID, fname, lname, starting_Date, salary, date_Employeed)
VALUES
(21, 'Hassan', 'farsi', '2020-01-01', 800.00, '2018-01-01'),
(22, 'Laila', 'haddad', '2021-05-01', 750.50, '2019-02-15'),
(23, 'Faisal', 'qasim', '2019-03-15', 800.75, '2017-03-10'),
(24, 'Reem', 'sudani', '2018-07-22', 800.20, '2016-08-20'),
(25, 'Naser', 'Almarri', '2020-12-01', 750.45, '2018-09-30'),
(26, 'Amal', 'zahrani', '2021-01-10', 800.35, '2019-11-15'),
(27, 'Tariq', 'balushi', '2019-06-25', 850.00, '2017-12-01'),
(28, 'Huda', 'najjar', '2020-04-18', 750.45, '2018-07-05'),
(29, 'Rashid', 'mazroui', '2021-09-30', 850.00, '2019-01-20'),
(30, 'Mona', 'mansoori', '2018-02-28', 800.10, '2016-05-15'),
(31, 'Yara', 'Saleh', '2018-02-28', 750.10, '2016-05-15');

--Insertiion for the program
INSERT INTO Program (Program_ID, Name, Level)
VALUES
(1, 'HomeMade Cooking', null),
(2, 'Carpentry', 'Intermediate'),
(3, 'Multi-Languages Path', 'Advanced'),
(4, 'Information Technology Career', 'Intermediate'),
(5, 'Accounting', 'Beginner');
SELECT * FROM Program
-- For the Course
-- Insert statements for the Course table
--Prerequisites: courses, skills, or knowledge that a student must have completed or acquired before enrolling in a particular course
INSERT INTO Course (Course_ID, Name, Credit_Hours, Prerequisites, Description, Delivery_Method, Enrollment_Capacity)
VALUES
(1, 'Basic Cooking Techniques', 3, 'None', 'Learn fundamental cooking methods and techniques for homemade meals.', 'In-Person', 20),
(2, 'Advanced Baking Skills', 4, 'Basic Cooking Techniques', 'Master advanced baking recipes and techniques.', 'Online', 15);
(3, 'Introduction to Carpentry', 3, 'None', 'Basic skills and tools for carpentry projects.', 'In-Person', 25),
(4, 'Furniture Making', 4, 'Introduction to Carpentry', 'Learn to design and build furniture pieces.', 'In-Person', 20),
(5, 'Spanish for Beginners', 3, 'None', 'Introduction to the Spanish language and basic conversation skills.', 'Online', 30),
(6, 'Advanced French', 4, 'French for Beginners', 'Advanced level French language skills and conversation.', 'Online', 20),
(7, 'Introduction to IT', 3, 'None', 'Basic concepts and skills in Information Technology.', 'Hybrid', 25),
(8, 'Network Administration', 4, 'Introduction to IT', 'In-depth study of network management and administration.', 'In-Person', 20),
(9, 'Basic Accounting Principles', 3, 'None', 'Introduction to accounting principles and practices.', 'Online', 30),
(10,'Financial Statement Analysis', 4, 'Basic Accounting Principles', 'Advanced techniques for analyzing financial statements.', 'Hybrid', 25);
SELECT * FROM [dbo].[Course]
--Insertion for table Course_Schedule
INSERT INTO Course_Schedule(Course_ID, Schedule_ID)
VALUES
(1,1001),
(2,1001),
(3,1002),
(4,1002),
(5,1003),
(6,1003),
(7,1004),
(8,1004),
(9,1005),
(10,1005),
(1,2001),
(2,2001),
(3,2002),
(4,2002),
(5,2003),
(6,2003),
(7,2004),
(8,2004),
(9,2005),
(10,2005),
(1,3001),
(2,3002),
(3,3003),
(4,3004),
(5,3005),
(6,3006),
(7,3007),
(8,3008),
(9,3009);

--Insertion for table Program_Beneficary
INSERT INTO Program_Beneficary (Program_ID, Beneficary_ID)
VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(1,6),
(2,7),
(3,8),
(4,9),
(5,10),
(1,11),
(2,12),
(3,13),
(4,14),
(5,15);
--Insertion for table Schedule
INSERT INTO Schedule (Schedule_ID, Beneficary_ID, Trainer_ID, Organizer_ID, Start_Date, Status)
VALUES
(1001, 1, null, null, '2024-06-01', 'Scheduled'),
(1002, 2, null, null, '2024-06-15', 'Scheduled'),
(1003, 3, null, null, '2024-07-01', 'Scheduled'),
(1004, 4, null, null, '2024-07-15', 'Scheduled'),
(1005, 5, null, null, '2024-08-01', 'Scheduled'),
(1006, 6, null, null, '2024-08-15', 'Scheduled'),
(1007, 7, null, null, '2024-09-01', 'Scheduled'),
(1008, 8, null, null, '2024-09-15', 'Scheduled'),
(1009, 9, null, null, '2024-10-01', 'Scheduled'),
(2001, null, null , 21,'2024-06-01', 'Scheduled'),
(2002, null, null, 22,'2024-06-15', 'Scheduled'),
(2003, null, null, 23,'2024-07-01', 'Scheduled'),
(2004, null, null, 24 ,'2024-07-15', 'Scheduled'),
(2005, null, null, 25 ,'2024-08-01', 'Scheduled'),
(2006, null, null, 26 ,'2024-08-15', 'Scheduled'),
(2007, null, null, 27 ,'2024-09-01', 'Scheduled'),
(2008, null, null, 28,'2024-09-15', 'Scheduled'),
(2009, null, null, 29, '2024-10-01', 'Scheduled'),
(2010, null, null, 30, '2024-10-01', 'Scheduled'),
(3001, null, 32 , null,'2024-06-01', 'Scheduled'),
(3002, null, 33, null,'2024-06-15', 'Scheduled'),
(3003, null, 34, null,'2024-07-01', 'Scheduled'),
(3004, null, 35, null ,'2024-07-15', 'Scheduled'),
(3005, null, 36, null ,'2024-08-01', 'Scheduled'),
(3006, null, 37, null ,'2024-08-15', 'Scheduled'),
(3007, null, 38, null ,'2024-09-01', 'Scheduled'),
(3008, null, 39, null,'2024-09-15', 'Scheduled'),
(3009, null, 41, null, '2024-10-01', 'Scheduled');


--Insertion for the trainer table
INSERT INTO Trainer (Trainer_ID, Course_ID, fname, lname, Expertise) 
VALUES 
(32, 1, 'Tomes', 'Doe', 'Cooking Techniques'),
(33, 2, 'Jane', 'Smith', 'Baking'),
(34, 3, 'Yara', 'Johnson', 'Carpentry Basics'),
(35, 4, 'Emily', 'Davis', 'Furniture Design'),
(36, 5, 'Daniel', 'Wilson', 'Spanish Language'),
(37, 6, 'Laura', 'Martinez', 'French Language'),
(38, 7, 'Rama', 'Brown', 'Information Technology'),
(39, 8, 'Sarah', 'Melhem', 'Network Administration'),
(40, 9, 'James', 'Garcia', 'Accounting Principles'),
(41, 10, 'Patricia', 'Margerita', 'Financial Analysis'),
(42, NULL, 'Malak', 'Ahmad', 'Baking'),
(43, NULL, 'Abdallah', 'Alsalem', 'Financial Advanced'),
(44, 1, 'Jane', 'Smith', 'Baking');


--Insertion for the Beneficary_Addresses
INSERT INTO Beneficary_Addresses (Beneficary_ID, addresses) 
VALUES 
(1, '123 King Hussein St, Amman, Jordan'),
(2, '456 Queen Rania St, Irbid, Jordan'),
(3, '789 Petra St, Aqaba, Jordan'),
(4, '101 Rainbow St, Amman, Jordan'),
(5, '202 University St, Zarqa, Jordan'),
(6, '303 Jordan St, Salt, Jordan'),
(7, '404 Abdali Blvd, Amman, Jordan'),
(8, '505 Madaba St, Madaba, Jordan'),
(9, '606 Jerash St, Jerash, Jordan'),
(10, '707 Ajloun St, Ajloun, Jordan'),
(11, '808 Tafila St, Tafila, Jordan'),
(12, '909 Karak St, Karak, Jordan'),
(13, '100 Aqaba Blvd, Aqaba, Jordan'),
(14, '200 Maan St, Maan, Jordan'),
(15, '300 Fuheis St, Fuheis, Jordan'),
(16, '400 As-Salt St, As-Salt, Jordan'),
(17, '500 Al-Mafraq St, Mafraq, Jordan'),
(18, '600 Bayader St, Amman, Jordan'),
(19, '700 Sweileh St, Amman, Jordan'),
(20, '800 Jubeiha St, Amman, Jordan');

-- Insertion for Beneficary_Emails
INSERT INTO Beneficary_Emails (Beneficary_ID, email)
VALUES
(1, 'Mohammed.Alzubi@gmail.com'),
(2, 'Ali.Khaled@yahoo.com'),
(3, 'Khaled.Alali@outlook.com'),
(4, 'Fatima.Alnaimi@gmail.com'),
(5, 'Sara.Alhashmi@gmail.com'),
(6, 'Aisha.Alansari@gmail.com'),
(7, 'Yousef.Alsaleh@yahoo.com'),
(8, 'Hassan.Alfarsi@yahoo.com'),
(9, 'Layla.Alhaddad@outlook.com'),
(10, 'Omar.Alomari@outlook.com');


--Insertion for Beneficary_PhoneNumbers
INSERT INTO Beneficary_PhoneNumbers (Beneficary_ID, phone_number)
VALUES
(1, '0790883943'),
(2, '0789036782'),
(3, '0734729108'),
(4, '0789021392'),
(5, '0702839203'),
(6, '0789472727'),
(7, '0702839103'),
(8, '0792738110'),
(9, '0711029333'),
(10,'0711920192');



--Insertion for Course_Location
INSERT INTO Course_Location (Course_ID, Location) 
VALUES
(1, 'Kitchen Lab 101, Al Madina Al Munawara St, Amman, Jordan'),
(2, 'Online Platform'),
(3, 'Workshop Room A, King Abdullah II St, Irbid, Jordan'),
(4, 'Workshop Room B, Al-Quds St, Zarqa, Jordan'),
(5, 'Online Platform, Zoom'),
(6, 'Online Platform, Teams'),
(7, 'Computer Lab 201, University St, Amman, Jordan'),
(8, 'IT Building Room 301, Queen Rania St, Amman, Jordan'),
(9, 'Online Platform, Discord'),
(10, 'Business School Room 101, Al-Hussein Bin Talal St, Amman, Jordan');

--Insertion for Trainer_PhoneNumbers
INSERT INTO Trainer_PhoneNumbers (Trainer_ID, phone_number) VALUES
(32, '0791234567'),
(33, '0782345678'),
(34, '0773456789'),
(35, '0794567890'),
(36, '0785678901'),
(37, '0776789012'),
(38, '0797890123'),
(39, '0788901234'),
(40, '0779012345'),
(41, '0790123456');

--Insertion for Orgainzer_PhoneNumbers
INSERT INTO  Orgainzer_PhoneNumbers (Organizer_ID, phone_number) VALUES
(21, '0791234561'),
(22, '0782345672'),
(23, '0773456783'),
(24, '0794567894'),
(25, '0785678905'),
(26, '0776789016'),
(27, '0797890127'),
(28, '0788901238'),
(29, '0779012349'),
(30, '0790123450'),
(31, '0791123456');

--Insertion for the Program_Organizer
INSERT INTO Program_Organizer (Program_ID, Organizer_ID) VALUES
(1, 21),
(2, 22),
(3, 23),
(4, 24),
(5, 25),
(1, 26),
(2, 27),
(3, 28),
(4, 29),
(5, 30),
(1, 31),
(2, 21),
(3, 21);


INSERT INTO Course_Program(Course_ID,Program_ID) VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 2),
(5, 3),
(6, 3),
(7, 4),
(8, 4),
(9, 5),
(10, 5);
---------------------------------------------------------VIEWS-----------------------------------------------------------------------
---	View all organizers within the programs
Drop View IF EXISTS Head_Organizer_Access;
CREATE VIEW Head_Organizer_Access
AS
SELECT o.Organizer_ID,p.Program_ID , CONCAT(o.fname, ' ', o.lname) AS Organizer_FullName, 
o.salary, o.starting_Date, o.date_Employeed, p.Name AS Program_Name , p.Level AS Program_Level
FROM [dbo].[Program_Organizer] op
JOIN [dbo].[Organizer] o 
ON o.Organizer_ID = op.Organizer_ID
JOIN [dbo].[Program] p
ON p.Program_ID = op.Program_ID; 

SELECT * FROM [dbo].[Head_Organizer_Access]

---	View all beneficiary information within all programs he/she oversee.
DROP VIEW IF EXISTS Head_Organizer_Beneficiary_Info;
CREATE VIEW Head_Organizer_Beneficiary_Info AS
SELECT 
   p.Program_ID,p.Name AS Program_Name, p.Level AS Program_Level, b.Beneficary_ID ,
   CONCAT(b.fname, ' ', b.midname, ' ', b.lname) AS Beneficary_FullName, b.date_of_birth,
   b.sex,bp.phone_number AS Beneficary_PhoneNumber,ba.addresses AS Beneficary_Address, b.dept
FROM [dbo].[Program_Beneficary] pb
JOIN [dbo].[Beneficary] b
ON pb.Beneficary_ID = b.Beneficary_ID
JOIN [dbo].[Program] p
ON pb.Program_ID = p.Program_ID
JOIN [dbo].[Beneficary_PhoneNumbers] bp
ON bp.Beneficary_ID = pb.Beneficary_ID
JOIN [dbo].[Beneficary_Addresses] ba
ON ba.Beneficary_ID = pb.Beneficary_ID;
SELECT * FROM Head_Organizer_Beneficiary_Info;
-------------------------------------------------------------------------------------------------------------------

--Access detailed information about the courses they are assigned to
DROP VIEW IF EXISTS View_Trainer_Jane_Smith_Schedule;
CREATE VIEW View_Trainer_Jane_Smith_Schedule AS
SELECT 
s.Schedule_ID,
t.Trainer_ID, c.Course_ID, c.Name as Course_Name, c.Credit_Hours,c.Description as course_description, c.Prerequisites,
c.Delivery_Method,c.Enrollment_Capacity,cl.location AS Course_Loaction,
s.Status as schedule_status, s.Start_Date as schedule_start_date
FROM [dbo].[Trainer] t
JOIN [dbo].[Course] c ON t.Course_ID = c.Course_ID
JOIN [dbo].[Course_Location] cl ON cl.Course_ID = c.Course_ID
JOIN [dbo].[Schedule] s ON s.Trainer_ID = t.Trainer_ID
WHERE t.Trainer_ID = 33;
SELECT * FROM View_Trainer_Jane_Smith_Schedule
------------------------------------------------------------------------------------------------------------------------
---	View their schedule of enrolled courses and associated program details
DROP VIEW IF EXISTS View_Beneficary_Khaled_Mohammed_Schedule;
CREATE VIEW View_Beneficary_Khaled_Mohammed_Schedule AS
SELECT 
s.Schedule_ID, b.Beneficary_ID, CONCAT(b.fname, ' ', b.midname, ' ', b.lname) AS Beneficary_FullName,
p.Program_ID, p.Name AS Program_Name,
c.Course_ID, c.Name AS Course_Name, c.Credit_Hours, c.Description AS Course_Description, c.Delivery_Method AS Course_Delivery_Method,
cl.location AS Course_Loaction,
CONCAT(t.fname, ' ', t.lname) AS Trainer_Of_The_Course, t.Expertise,
s.Status AS Schedule_Status, s.Start_Date
FROM Program_Beneficary pb
JOIN Beneficary b ON b.Beneficary_ID = pb.Beneficary_ID
JOIN Program p ON p.Program_ID = pb.Program_ID
JOIN Course_Program cp ON cp.Program_ID = p.Program_ID
JOIN Course c ON c.Course_ID = cp.Course_ID
JOIN Schedule s ON s.Beneficary_ID = pb.Beneficary_ID
JOIN Trainer t ON t.Course_ID = c.Course_ID
JOIN [dbo].[Course_Location] cl ON cl.Course_ID = c.Course_ID
WHERE b.Beneficary_ID = 3;
SELECT * FROM [dbo].[View_Beneficary_Khaled_Mohammed_Schedule]
----------------------------
--Views all courses specific info for beneficary's
DROP VIEW IF EXISTS View_Courses_To_Beneficary;
CREATE VIEW View_Courses_To_Beneficary AS
SELECT 
p.Program_ID, p.Name AS Program_Name, c.Course_ID, c.Name AS Course_Name, c.Credit_Hours, c.Description AS Course_Description,
c.Delivery_Method AS Course_Delivery_Method, c.Prerequisites, cl.location AS Course_Location,
CONCAT(t.fname, ' ', t.lname) AS Trainer_Of_The_Course, t.Expertise
FROM  [dbo].[Program] p
JOIN Course_Program cp ON cp.Program_ID = p.Program_ID
JOIN Course c ON c.Course_ID = cp.Course_ID
JOIN Trainer t ON t.Course_ID = c.Course_ID
JOIN [dbo].[Course_Location] cl ON cl.Course_ID = c.Course_ID;
SELECT * FROM View_Courses_To_Beneficary

--------------------
--Views the organzier schedule where he is able to view his assigned program and its courses 
DROP VIEW IF EXISTS View_Trainer_Organizer_Hassan_farsi_Schedule;
CREATE VIEW View_Organizer_Hassan_farsi_Schedule AS
SELECT 
s.Schedule_ID,  CONCAT(o.fname, ' ', o.lname) AS Organizer_FullName,
p.Program_ID, p.Name AS Program_Name, p.Level,
c.Course_ID, c.Name AS Course_Name, c.Credit_Hours, c.Description AS Course_Description, c.Delivery_Method AS Course_Delivery_Method,
s.Status AS Schedule_Status, s.Start_Date
FROM [dbo].[Program_Organizer] po
JOIN [dbo].[Organizer] o ON o.Organizer_ID = po.Organizer_ID
JOIN Program p ON p.Program_ID = po.Program_ID
JOIN Course_Program cp ON cp.Program_ID = p.Program_ID
JOIN Course c ON c.Course_ID = cp.Course_ID
JOIN Schedule s ON s.Organizer_ID = po.Organizer_ID
WHERE o.Organizer_ID = 21;
SELECT * FROM View_Organizer_Hassan_farsi_Schedule

------------------------------------------------------------procedures----------------------------------------------------------
drop PROCEDURE IF EXISTS [dbo].[Organizer_InsertNewProgram]
CREATE PROCEDURE Organizer_InsertNewProgram
    @Program_ID INT,
    @Program_Name VARCHAR(50),
    @Program_Level VARCHAR(30),
    @Organizer_ID INT
AS
BEGIN
-- Insert the new program details into the Program table
INSERT INTO Program (Program_ID, Name, Level)
VALUES (@Program_ID, @Program_Name, @Program_Level);

-- Insert the program-organizer relationship into the Program_Organizer table
INSERT INTO Program_Organizer (Program_ID, Organizer_ID)
VALUES (@Program_ID, @Organizer_ID);
END;
EXEC Organizer_InsertNewProgram
    @Program_ID = 6,               
    @Program_Name = 'Agriculture', 
    @Program_Level = 'Intermidate',  
    @Organizer_ID = 31;     

	SELECT * FROM [dbo].[Program_Organizer]
	SELECT * FROM [dbo].[Program]
---------------------------------
--Procedure that updates only authorized program for the entered organizer ID and checks it from the organzier_program table
CREATE PROCEDURE Organizer_UpdateProgram
    @Program_ID INT,
    @Program_Name VARCHAR(50),
    @Program_Level VARCHAR(30),
    @Organizer_ID INT
AS
BEGIN
IF EXISTS (
SELECT 1 FROM Program_Organizer WHERE Program_ID = @Program_ID 
AND Organizer_ID = @Organizer_ID)
BEGIN
UPDATE Program
SET Name = @Program_Name,
Level = @Program_Level
WHERE Program_ID = @Program_ID;
PRINT 'Program updated successfully.';
END
ELSE
BEGIN
PRINT 'Not allowed to update the program.';
END
END;
EXEC Organizer_UpdateProgram
    @Program_ID = 1,               
    @Program_Name = 'Agriculture1', 
    @Program_Level = 'Intermidate1',  
    @Organizer_ID = 22; 
	SELECT * FROM [dbo].[Program]
---------------------------------
--	Assign the inserted course to its program after checking the organizer authorization on the program then assigns the program to the inserted course
drop PROCEDURE IF EXISTS [dbo].[Organizer_AssignCourseToProgram]
CREATE PROCEDURE Organizer_AssignCourseToProgram
    @Course_ID INT,
    @Program_ID INT,
	@Organizer_ID INT,
	@Name VARCHAR(30),
    @Credit_Hours INT,
    @Prerequisites VARCHAR(50),
    @Description TEXT,
    @Delivery_Method VARCHAR(15),
    @Enrollment_Capacity INT
AS
BEGIN
IF EXISTS ( SELECT * FROM Program_Organizer 
WHERE Program_ID = @Program_ID AND Organizer_ID = @Organizer_ID)
BEGIN
INSERT INTO Course (Course_ID,Name,Credit_Hours,Prerequisites,Description,Delivery_Method,Enrollment_Capacity)
VALUES (@Course_ID,@Name,@Credit_Hours,@Prerequisites,@Description,@Delivery_Method,@Enrollment_Capacity)

INSERT INTO Course_Program (Course_ID, Program_ID) VALUES (@Course_ID, @Program_ID);
PRINT 'Course inserted to the program successfully';
END
ELSE
BEGIN
PRINT 'Not allowed to insert the course.';
END
END;
EXEC [dbo].[Organizer_AssignCourseToProgram]
    @Course_ID = 11,
    @Program_ID = 1,
	@Organizer_ID = 32,
	@Name = 'pastries course',
    @Credit_Hours = 3,
    @Prerequisites = 'None',
    @Description = 'Learn how to make professrional pastries',
    @Delivery_Method = 'In-Person',
    @Enrollment_Capacity = 30
	SELECT * FROM [dbo].[Course]
	SELECT * FROM [dbo].[Course_Program]
----------------------------
--Organizer updating the course info where the course should be assigned to a program the organier has access to.
CREATE PROCEDURE Organizer_UpdateCourseInfo
    @Program_ID INT, 
    @Organizer_ID INT,
    @Course_ID INT,
    @Name VARCHAR(30),
    @Credit_Hours INT,
    @Prerequisites VARCHAR(50),
    @Description TEXT,
    @Delivery_Method VARCHAR(15),
    @Enrollment_Capacity INT
AS
BEGIN
IF EXISTS (SELECT 1 FROM Program_Organizer po
JOIN [dbo].[Course_Program] cp ON po.Program_ID = cp.Program_ID
WHERE po.Program_ID = @Program_ID AND po.Organizer_ID = @Organizer_ID AND cp.Course_ID = @Course_ID)
BEGIN
UPDATE Course
SET Name = @Name,
Credit_Hours = @Credit_Hours,
Prerequisites = @Prerequisites,
Description = @Description,
Delivery_Method = @Delivery_Method,
Enrollment_Capacity = @Enrollment_Capacity
WHERE Course_ID = @Course_ID;
END
ELSE
BEGIN
PRINT 'Not allowed to update the course.';
END
END;
EXEC Organizer_UpdateCourseInfo
@Course_ID = 11,
@Program_ID = 1,
@Organizer_ID = 31,
@Name = 'pastries1 course',
@Credit_Hours = 4,
@Prerequisites = 'None',
@Description = 'Learn how to make professrional pastries1',
@Delivery_Method = 'In-Person',
@Enrollment_Capacity = 30
SELECT * FROM [dbo].[Course]
--------------------------
--Trainer updating courses they have acces to
CREATE PROCEDURE Trainer_UpdateCourseInfo 
    @Trainer_ID INT,
    @Course_ID INT,
    @Name VARCHAR(30),
    @Credit_Hours INT,
    @Prerequisites VARCHAR(50),
    @Description TEXT,
    @Delivery_Method VARCHAR(15),
    @Enrollment_Capacity INT
AS
BEGIN
IF EXISTS (SELECT 1 FROM [dbo].[Trainer] t
JOIN [dbo].[Course] c ON c.Course_ID = t.Course_ID
WHERE t.Trainer_ID =  @Trainer_ID AND c.Course_ID = @Course_ID )
BEGIN
UPDATE Course
SET Name = @Name,
Credit_Hours = @Credit_Hours,
Prerequisites = @Prerequisites,
Description = @Description,
Delivery_Method = @Delivery_Method,
Enrollment_Capacity = @Enrollment_Capacity
WHERE Course_ID = @Course_ID;
END
ELSE
BEGIN
PRINT 'Not allowed to update the course.';
END
END;
--Before(2, 'Advanced Baking Skills', 4, 'Basic Cooking Techniques', 'Master advanced baking recipes and techniques.', 'Online', 15),
EXEC Trainer_UpdateCourseInfo 
@Course_ID = 2,
@Trainer_ID = 33,
@Name = 'Advanced Baking Skills',
@Credit_Hours = 5,
@Prerequisites = 'Basic Cooking Techniques',
@Description = 'Master advanced baking recipes and techniques.',
@Delivery_Method = 'In-Person',
@Enrollment_Capacity = 40
select * from [dbo].[Course]
-------------------------Security------------------------
create login Head_Organizer
with password ='head1234';
create user Head_Organizer
for login Head_Organizer
GRANT SELECT ,INSERT, DELETE, UPDATE ON [dbo].[Head_Organizer_Access] TO Head_Organizer; -- View all organizers within the programs
GRANT SELECT, INSERT, DELETE, UPDATE ON [dbo].[Head_Organizer_Beneficiary_Info] TO Head_Organizer; -- View all beneficiary information within all programs he/she oversees.
GRANT SELECT, INSERT, DELETE, UPDATE ON [dbo].[Organizer] TO Head_Organizer; --They should have access to monitor the activities and performance of organizers within the program
GRANT SELECT, INSERT, DELETE, UPDATE ON [dbo].[Beneficary] TO Head_Organizer;
GRANT SELECT ON [dbo].[Program] TO Head_Organizer;
GRANT SELECT ON [dbo].[Course] TO Head_Organizer;
-----------------------
create login Organizer_Hassan_farsi
with password = 'hassan1234';
create user Organizer_Hassan_farsi
for login Organizer_Hassan_farsi
--
grant execute on [dbo].[Organizer_AssignCourseToProgram] TO Organizer_Hassan_farsi;
grant execute on [dbo].[Organizer_InsertNewProgram] TO Organizer_Hassan_farsi;
grant execute on [dbo].[Organizer_UpdateProgram] to Organizer_Hassan_farsi;
grant execute on [dbo].[Organizer_UpdateCourseInfo] to Organizer_Hassan_farsi;
grant select, update, delete, insert on [dbo].[Course] to Organizer_Hassan_farsi;
grant select, update, insert on [dbo].[Program] to Organizer_Hassan_farsi;
grant select, insert, update, delete on [dbo].[Course_Program] to Organizer_Hassan_farsi;
grant select on [dbo].[Program_Organizer] to Organizer_Hassan_farsi;
grant select on [dbo].[View_Organizer_Hassan_farsi_Schedule] to Organizer_Hassan_farsi;
grant select, insert, update, delete on [dbo].[Program_Beneficary] to Organizer_Hassan_farsi;

----------------------
create login Trainer_Jane_Smith
with password = 'jane1234';
create user Trainer_Jane_Smith
for login Trainer_Jane_Smith
grant select on [dbo].[View_Trainer_Jane_Smith_Schedule] to Trainer_Jane_Smith;
grant select on [dbo].[Course]to Trainer_Jane_Smith;
grant execute on [dbo].[Trainer_UpdateCourseInfo] to Trainer_Jane_Smith;
grant exec on [dbo].[Trainer_UpdateCourseInfo] to Trainer_Jane_Smith;

-------------------------
create login Beneficary_Khaled_Mohammed
with password = 'khaled1234';
create user Beneficary_Khaled_Mohammed
for login Beneficary_Khaled_Mohammed
grant select on [dbo].[View_Beneficary_Khaled_Mohammed_Schedule] to Beneficary_Khaled_Mohammed;
grant select on [dbo].[View_Courses_To_Beneficary] to Beneficary_Khaled_Mohammed;
--·Backup and Restore

BACKUP DATABASE Ministry_Final_System1
	TO DISK = 'C:\DataBaseFinal\Ministry_Final_System1.full';

RESTORE DATABASE Final_DataBase
    FROM DISK = 'C:\DataBaseFinal\Ministry_Final_System1.full'
    WITH REPLACE;
-------------------------Data Violation 
--(24, 'Reem', 'sudani', '2018-07-22', 800.20, '2016-08-20'),
INSERT INTO [dbo].[Organizer] (fname,lname,starting_Date,salary,date_Employeed)
VALUES
('huda', 'sudani', '2018-07-22', 800.20, '2016-08-20');

INSERT INTO Trainer (Trainer_ID,Course_ID,fname,lname,Expertise)
VALUES
(45, 13, 'huda', 'sudani', 'Cooking')

SELECT * FROM Trainer
DELETE FROM Trainer
WHERE Trainer_ID = 43;
SELECT * FROM Trainer

ALTER TABLE Trainer DROP CONSTRAINT Course_ID;

ALTER TABLE Trainer ADD constraint Course_ID FOREIGN KEY (Course_ID)
REFERENCES  Course(Course_ID) ON DELETE NO ACTION 

SELECT * FROM Course
SELECT * FROM Trainer
DELETE FROM Course
WHERE Course_ID = 14;
SELECT * FROM Course
SELECT * FROM Trainer



------ Attempt to insert a duplicate entry
INSERT INTO Beneficary (Beneficary_ID, fname, midname, lname, sex, date_of_birth, dept)
VALUES
(21, 'Mohammed', 'Ahmed', 'Alzubi', 'M', '1985-01-01', '300');

INSERT INTO Beneficary (Beneficary_ID, fname, midname, lname, sex, date_of_birth, dept)
VALUES
(21, 'John', 'Doe', 'Smith', NULL, '1985-01-01', '300');

INSERT INTO Program (Program_ID, Name)
VALUES (7, 'Data Science');

SELECT * FROM Program;

----------------------------------------Output Validation-------------------------------------------
SELECT 
P.Name AS Program_Name, MAX(o.salary) AS Max_Salary, MIN(o.salary) AS Min_Salary
FROM Organizer o
JOIN  Program_Organizer PO ON o.Organizer_ID = PO.Organizer_ID
JOIN  Program P ON PO.Program_ID = P.Program_ID
GROUP BY  p.Name;

SELECT * FROM Program_Organizer
SELECT * FROM Organizer

SELECT 
P.Name AS Program_Name,  CONCAT(O.fname, ' ', O.lname) AS Organizer_FullName,
O.salary AS Organizer_Salary, O.date_Employeed AS Date_Employed
FROM Program P
JOIN Program_Organizer PO ON P.Program_ID = PO.Program_ID
JOIN Organizer O ON PO.Organizer_ID = O.Organizer_ID
WHERE O.date_Employeed = (
SELECT MIN(O2.date_Employeed)
FROM Program_Organizer PO2
JOIN Organizer O2 ON PO2.Organizer_ID = O2.Organizer_ID
WHERE PO2.Program_ID = P.Program_ID );


INSERT INTO Beneficary_PhoneNumbers (Beneficary_ID,phone_number)
VALUES
(1,0712129847);

SELECT 
o.Organizer_ID,CONCAT(o.fname, ' ', o.lname) AS Organizer_FullName,
o.salary, O.date_Employeed,P.Name AS Program_Name
FROM  Organizer o
JOIN  Program_Organizer PO ON o.Organizer_ID = PO.Organizer_ID
JOIN  Program P ON PO.Program_ID = P.Program_ID
ORDER BY o.date_Employeed ASC;

SELECT * FROM Organizer

SELECT s.Schedule_ID, s.Status, b.Beneficary_ID,CONCAT(b.fname , ' ',b.midname,' ',b.lname),
b.date_of_birth, b.sex FROM Beneficary b
JOIN Schedule s ON s.Beneficary_ID = b.Beneficary_ID


SELECT p.Name AS Program_Name, b.Beneficary_ID, CONCAT(b.fname , ' ',b.midname,' ',b.lname) AS Beneficary_FullName,
b.date_of_birth as beneficary_Date_of_birth, b.sex
FROM Program_Beneficary pb
JOIN Program p ON p.Program_ID= pb.Program_ID
JOIN Beneficary b ON b.Beneficary_ID=pb.Beneficary_ID


SELECT * FROM Trainer
SELECT t.Trainer_ID,CONCAT(t.fname , ' ',t.lname) AS Trainer_FullName, t.Expertise,
s.Schedule_ID,s.Status AS Schedule_Status,
c.Course_ID, c.Name AS course_Name
FROM Trainer t
JOIN Schedule s ON s.Trainer_ID = s.Trainer_ID
JOIN Course c ON c.Course_ID = t.Course_ID
WHERE s.Trainer_ID = t.Trainer_ID

SELECT t.Trainer_ID, CONCAT(t.fname , ' ',t.lname) AS Trainer_FullName,tb.phone_number  FROM Trainer t
JOIN Trainer_PhoneNumbers tb ON tb.Trainer_ID =  t.Trainer_ID


SELECT * FROM [dbo].[Organizer]


SELECT * FROM Beneficary_Emails
INSERT INTO Beneficary_Emails (Beneficary_ID,email)
VALUES (1,'mohammad_email2@gmail.com')

SELECT * FROM Beneficary_Addresses

UPDATE Beneficary_Addresses
SET addresses = 'al-hussein thecnical university'
WHERE addresses = 'mohammad_email2@gmail.com';


SELECT p.Program_ID, p.Name as program_name, p.Level as program_level,
o.Organizer_ID, CONCAT(o.fname , ' ',o.lname) AS Organizer_FullName, o.starting_Date,o.salary,o.date_Employeed,
s.Schedule_ID, s.Status,s.Start_Date
FROM Organizer o
JOIN Schedule s  ON s.Organizer_ID = o.Organizer_ID
JOIN Program_Organizer po ON po.Organizer_ID = o.Organizer_ID
JOIN Program p ON p.Program_ID = po.Program_ID
WHERE s.Organizer_ID = o.Organizer_ID 
ORDER BY p.Program_ID ASC

INSERT INTO Beneficary_Addresses (Beneficary_ID,addresses)
VALUES (2,'479 al-madina manwera street')

DELETE FROM Beneficary_Emails 
WHERE email = '479 al-madina manwera street';

