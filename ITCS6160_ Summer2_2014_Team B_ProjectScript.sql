/************************************************************************************************************************
* ITCS6160 Team B Summer 2 2014 
* Project Description: 
* 
* Team Members: Daniel Scrogging, Arvind Bhat, Virginia Kern, Roxolana Buckle, Swetha Keerthi Metireddy, 
*				Pratibha Singh,	Phanindra Bonda, Sushmitha Yalla, Abhijeet Shedge, Shiva Tej Madapathi, 
* 				Chaitanya Kancharla, Manikantha Manchala 
* 
* 
* Sections: 
*			1. Create Schema and Tables 
* 			2. Populate the tables  
* 			3. Create the views
* 			4. Create the stored procedures 
*
*************************************************************************************************************************/




/************************************************************************************************************************
*  1. Create Schema and Tables  
*
*************************************************************************************************************************/

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=1;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=1;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema AIS
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `AIS` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `AIS` ;

-- -----------------------------------------------------
-- Table `AIS`.`tblRole` 
-- Role differenciates between a student and an admin
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AIS`.`tblRole` (
    `roleID` TINYINT NOT NULL AUTO_INCREMENT,
    `roleName` VARCHAR(25) NULL,
    `roleType` VARCHAR(25) NULL,
    PRIMARY KEY (`roleID`)
)  ENGINE=InnoDB;


-- -----------------------------------------------------
-- Table `AIS`.`tblUser` 
-- It holds userID and passwords of both users and admins
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AIS`.`tblUser` (
    `userID` INT NOT NULL AUTO_INCREMENT,
    `password` CHAR(4) NULL,
    `tblRole_roleID` TINYINT NOT NULL,
    PRIMARY KEY (`userID`),
    INDEX `fk_tblUser_tblRole_idx` (`tblRole_roleID` ASC),
    CONSTRAINT `fk_tblUser_tblRole` FOREIGN KEY (`tblRole_roleID`)
        REFERENCES `AIS`.`tblRole` (`roleID`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=InnoDB;


-- -----------------------------------------------------
-- Table `AIS`.`tblStudent` 
-- This holds all the personal information about the student 
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `AIS`.`tblStudent` (
    `SSN` CHAR(11) NOT NULL,
    `fName` VARCHAR(45) NULL,
    `mInitial` VARCHAR(1) NULL,
    `lName` VARCHAR(55) NULL,
    `strAddress` VARCHAR(100) NULL,
    `city` VARCHAR(45) NULL,
    `state` CHAR(2) NULL,
    `zip` CHAR(5) NULL,
    `inStateFlag` TINYINT(1) NULL,
    `email` VARCHAR(45) NULL,
    `phone` CHAR(12) NULL,
    `SAT` INT NULL,
    `GPA` DECIMAL(3 , 2 ) NULL,
    `tblUser_userID` INT NOT NULL,
    PRIMARY KEY (`SSN`),
    INDEX `fk_tblStudent_tblUser1_idx` (`tblUser_userID` ASC),
    CONSTRAINT `fk_tblStudent_tblUser1` FOREIGN KEY (`tblUser_userID`)
        REFERENCES `AIS`.`tblUser` (`userID`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=InnoDB;


-- -----------------------------------------------------
-- Table `AIS`.`tblTerm`
-- This houses all the terms available for the students to apply 
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AIS`.`tblTerm` (
    `termName` VARCHAR(15) NOT NULL,
    PRIMARY KEY (`termName`)
)  ENGINE=InnoDB;


-- -----------------------------------------------------
-- Table `AIS`.`tblParameter` 
-- Parameters are used to increase or decrease the thresholds. This table is used to manage parameters used in the admissions desirability metric.
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AIS`.`tblParameter` (
    `parameterID` INT NOT NULL AUTO_INCREMENT,
    `GPAWeight` TINYINT NULL,
    `SATWeight` TINYINT NULL,
    `OutOfStateWeight` TINYINT NULL,
    `SATThreshold` INT NULL,
    `GPAThreshold` DECIMAL(3 , 2 ) NULL,
    `tblTerm_termName` VARCHAR(15) NOT NULL,
    PRIMARY KEY (`parameterID` , `tblTerm_termName`),
    INDEX `fk_tblParameter_tblTerm1_idx` (`tblTerm_termName` ASC),
    CONSTRAINT `fk_tblParameter_tblTerm1` FOREIGN KEY (`tblTerm_termName`)
        REFERENCES `AIS`.`tblTerm` (`termName`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=InnoDB;


-- -----------------------------------------------------
-- Table `AIS`.`tblDegreeProgram`
-- This lists all the degree programs available
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AIS`.`tblDegreeProgram` (
    `degreeName` VARCHAR(100) NOT NULL,
    `InfoMessage` TEXT NULL,
    PRIMARY KEY (`degreeName`)
)  ENGINE=InnoDB;


-- -----------------------------------------------------
-- Table `AIS`.`tblCollegeLife` 
-- Lists all the college life offerings available for students
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AIS`.`tblCollegeLife` (
    `CollegeLifeName` VARCHAR(45) NOT NULL,
    `collegeLifeInfoMessage` TEXT NULL,
    PRIMARY KEY (`CollegeLifeName`)
)  ENGINE=InnoDB;


-- -----------------------------------------------------
-- Table `AIS`.`tblAdmissionClerk`
-- Basic information for the admissions staff
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AIS`.`tblAdmissionClerk` (
    `admissionClerkID` INT NOT NULL AUTO_INCREMENT,
    `fName` VARCHAR(45) NULL,
    `mInitial` VARCHAR(1) NULL,
    `lName` VARCHAR(45) NULL,
    `tblUser_userID` INT NOT NULL,
    PRIMARY KEY (`admissionClerkID` ),
    INDEX `fk_tblAdmissionClerk_tblUser1_idx` (`tblUser_userID` ASC),
    CONSTRAINT `fk_tblAdmissionClerk_tblUser1` FOREIGN KEY (`tblUser_userID`)
        REFERENCES `AIS`.`tblUser` (`userID`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=InnoDB;


-- -----------------------------------------------------
-- Table `AIS`.`tblInquireApply`
-- Houses the interaction between the student and the sytem
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AIS`.`tblInquireApply` (
    `applicationStatus` VARCHAR(6) NULL,
    `applyFlag` TINYINT(1) NULL,
    `inquireFlag` TINYINT(1) NULL,
    `tblStudent_SSN` CHAR(11) NOT NULL,
    `termApplied` VARCHAR(15) NULL,
    `tblDegreeProgram_degreeName` VARCHAR(100) NOT NULL,
    PRIMARY KEY (`tblStudent_SSN` , `termApplied` , `tblDegreeProgram_degreeName`),
    INDEX `fk_tblInquireApply_tblDegreeProgram1_idx` (`tblDegreeProgram_degreeName` ASC),
    CONSTRAINT `fk_tblInquireApply_tblStudent1` FOREIGN KEY (`tblStudent_SSN`)
        REFERENCES `AIS`.`tblStudent` (`SSN`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `fk_tblInquireApply_tblDegreeProgram1` FOREIGN KEY (`tblDegreeProgram_degreeName`)
        REFERENCES `AIS`.`tblDegreeProgram` (`degreeName`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=InnoDB;


-- -----------------------------------------------------
-- Table `AIS`.`tblSeatsAvailable` 
-- Shows seats available based on degree and term 
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AIS`.`tblSeatsAvailable` (
    `seatsAvailable` INT NULL,
    `tblDegreeProgram_degreeName` VARCHAR(45) NOT NULL,
    `tblTerm_termName` VARCHAR(15) NOT NULL,
    INDEX `fk_tblSeatsAvailable_tblTerm1_idx` (`tblTerm_termName` ASC),
    PRIMARY KEY (`tblDegreeProgram_degreeName` , `tblTerm_termName`),
    CONSTRAINT `fk_tblSeatsAvailable_tblDegreeProgram1` FOREIGN KEY (`tblDegreeProgram_degreeName`)
        REFERENCES `AIS`.`tblDegreeProgram` (`degreeName`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `fk_tblSeatsAvailable_tblTerm1` FOREIGN KEY (`tblTerm_termName`)
        REFERENCES `AIS`.`tblTerm` (`termName`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;




/************************************************************************************************************************
*  2. Populate the tables  
*
*************************************************************************************************************************/

use ais; 

insert into `AIS`.`tblRole` (roleName,roleType) values ("Admin","View");
insert into `AIS`.`tblRole` (roleName,roleType) values ("Administrator","Edit");
insert into `AIS`.`tblRole` (roleName,roleType) values ("Student","View and Edit");


insert into `AIS`.`tblUser` (password,tblRole_roleID) values("101",1);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("102",2);


insert into `AIS`.`tblUser` (password,tblRole_roleID) values("3",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("4",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("5",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("6",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("7",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("8",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("9",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("10",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("11",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("12",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("13",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("14",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("15",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("16",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("17",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("18",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("19",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("20",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("21",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("22",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("23",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("24",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("25",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("26",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("27",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("28",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("29",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("30",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("31",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("32",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("33",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("34",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("35",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("36",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("37",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("38",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("39",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("40",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("41",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("42",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("43",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("44",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("45",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("46",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("47",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("48",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("49",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("50",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("51",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("52",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("53",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("54",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("55",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("56",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("57",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("58",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("59",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("60",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("61",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("62",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("63",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("64",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("65",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("66",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("67",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("68",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("69",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("70",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("71",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("72",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("73",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("74",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("75",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("76",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("77",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("78",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("79",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("80",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("81",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("82",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("83",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("84",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("85",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("86",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("87",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("88",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("89",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("90",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("91",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("92",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("93",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("94",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("95",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("96",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("97",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("98",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("99",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("100",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("101",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("102",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("103",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("104",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("105",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("106",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("107",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("108",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("109",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("110",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("111",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("112",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("113",3);
insert into `AIS`.`tblUser` (password,tblRole_roleID) values("114",3);


insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("704-381-801","Phani","Bonda","N","Albmarle road","Charlotte","NC",28262,"phani@uncc.edu","704-381-8012",2.50,1500,0,3);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("704-763-829","Daniel","Hero","K","Jhon Krik dr","Atlanta","GA",28275,"daniel@uncc.edu","704-763-8291",2.76,1640,1,4);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("704-989-538","Roxolona","Buckle","Q","Wt Harris Blvd","Alabama","SC",29362,"roxo@uncc.edu","704-989-5381",3.0,1780,1,5);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("704-654-772","Kern","Ginger","P","JW Clay Road","Charlotte","NC",24562,"kern@uncc.edu","790-585-5769",3.27,1920,0,6);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("618-303-971","Swetha","Metireddy","K","Milton Road","Los Angles","CA",38262,"swetha@uncc.edu","676-686-4859",3.55,2060,1,7);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("704-626-899","Sushmita","Yalla","P","Sharone Emity Dr","Cary","NC",24262,"sylla@uncc.edu","575-906-5859",3.76,2200,0,8);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("704-858-585","Krishna","Chaitanya","L","Clories Road","Clevland","OH",38943,"chaitanya@uncc.edu","454-465-8499",2.75,2340,1,9);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("904-381-801","Arvind","Bhatt","G","Albmarle road","Charlotte","NC",28262,"Arvind@uncc.edu","565-575-9483",2.60,1520,0,10);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("904-763-829","Ashok","Arumugan","K","Jhon Krik dr","Atlanta","GA",28275,"Ashok@uncc.edu","456-984-0983",2.86,1660,1,11);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("904-989-538","Sumanth","Krishnan","t","Wt Harris Blvd","Alabama","SC",29362,"Sumanth@uncc.edu","567-957-9584",3.10,1800,1,12);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("904-654-772","Messi","leona","r","JW Clay Road","Charlotte","NC",24562,"Messi@uncc.edu","675-688-6869",3.30,1940,0,13);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("983-039-731","Ronaldo","Cristiano","D","Milton Road","Los Angles","CA",38262,"Ronaldo@uncc.edu","567-098-0457",3.65,2080,1,14);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("904-626-899","devi","sri","p","Sharone Emity Dr","Cary","NC",24262,"devi@uncc.edu","908-098-4532",3.85,2200,0,15);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("904-858-585","Steven","jobs","p","Clories Road","Clevland","OH",38943,"Steven@uncc.edu","849-094-4846",3.00,2360,1,16);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("804-381-801","William","Gates","H","Albmarle road","Charlotte","NC",28262,"William@uncc.edu","464-937-4849",2.70,1540,0,17);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("304-858-585","Ehrich","Weiss","H","Clories Road","Clevland","OH",38943,"Ehrich@uncc.edu","784-039-0293",4.00,2000,1,18);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("804-763-829","Mukesh","Ambani","D","Jhon Krik dr","Atlanta","GA",28275,"Mukesh@uncc.edu","484-949-0293",2.96,1680,1,19);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("804-989-538","Anil","Ambani","k","Wt Harris Blvd","Alabama","SC",29362,"Anil@uncc.edu","786-393-3034",3.20,1820,1,20);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("804-654-772","Kitrick","Thomas","w","JW Clay Road","Charlotte","NC",24562,"Kitrick@uncc.edu","945-505-2345",3.40,1960,0,21);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("818-303-973","John","Lucas","H","Milton Road","Los Angles","CA",38262,"John@uncc.edu","786-930-5674",3.75,2100,1,22);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("804-626-899","Henry","Thoro","D","Sharone Emity Dr","Cary","NC",24262,"Henry@uncc.edu","897-903-8765",3.95,2240,0,23);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("804-858-585","Obama","Barack","H","Clories Road","Clevland","OH",38943,"Obama@uncc.edu","786-033-0934",3.25,1500,"1",24);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("604-381-801","George","Herbert","B","Albmarle road","Charlotte","NC",28262,"George@uncc.edu","996-027-5803",2.55,1560,0,25);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("604-763-829","Prathiba","patel","S","Jhon Krik dr","Atlanta","GA",28275,"Prathiba@uncc.edu","848-893-9043",2.79,1700,1,26);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("604-989-538","Kamal","Kannan","K","Wt Harris Blvd","Alabama","SC",29362,"Kamal@uncc.edu","565-585-0383",3.05,1840,1,27);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("604-654-772","Kranthi","Tiyyagura","K","JW Clay Road","Charlotte","NC",24562,"Kranthi@uncc.edu","567-099-0933",3.40,1980,0,28);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("618-303-973","Sesha","Ventrapragada","S","Milton Road","Los Angles","CA",38262,"Sesha@uncc.edu","783-039-0392",3.50,2120,1,29);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("604-626-899","Sushmita","Yalla","P","Sharone Emity Dr","Cary","NC",24262,"sylla@uncc.edu","234-039-0282",3.80,2260,0,30);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("604-858-585","Einstein","Albert","E","Clories Road","Clevland","OH",38943,"Einstein@uncc.edu","980-254-0883",3.50,1700,1,31);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("504-381-801","Portia","Rossi","D","Albmarle road","Charlotte","NC",28262,"Portia@uncc.edu","768-393-0292",2.65,1580,0,32);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("504-763-829","George","Michel","K","Jhon Krik dr","Atlanta","GA",28275,"George@uncc.edu","980-029-9282",2.89,1720,1,33);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("504-989-538","Yemma","Watson","H","Wt Harris Blvd","Alabama","SC",29362,"Yemma@uncc.edu","982-029-0929",3.15,1860,1,34);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("504-654-772","Kern","Ginger","P","JW Clay Road","Charlotte","NC",24562,"kern@uncc.edu","876-939-9382",3.50,2000,0,35);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("518-303-973","Rayn","Gosling","J","Milton Road","Los Angles","CA",38262,"Rayn@uncc.edu","872-923-9378",3.60,2140,1,36);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("504-626-899","Tom","Cruise","L","Sharone Emity Dr","Cary","NC",24262,"Tom@uncc.edu","873-928-8370",3.90,2280,0,37);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("504-858-585","Kate","Winslet","H","Clories Road","Clevland","OH",38943,"Kate@uncc.edu","783-038-0392",3.75,1800,1,38);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("404-381-801","Nomar","Garciaparra","G","Albmarle road","Charlotte","NC",28262,"Nomar@uncc.edu","863-938-9022",2.75,1600,0,39);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("404-763-829","Garth","Garth","L","Jhon Krik dr","Atlanta","GA",28275,"Garth@uncc.edu","793-937-9029",2.99,1740,1,40);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("404-989-538","Arnold","Schwar","Z","Wt Harris Blvd","Alabama","SC",29362,"Arnold@uncc.edu","783-923-0292",3.25,1880,1,41);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("404-654-772","Vin","Diesel","P","JW Clay Road","Charlotte","NC",24562,"Vin@uncc.edu","899-938-9229",3.49,2020,0,42);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("418-303-973","Donnie ","Walberg","J","Milton Road","Los Angles","CA",38262,"Donnie@uncc.edu","983-048-0239",3.70,2160,1,43);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("404-626-899","Cassandra","Peter","S","Sharone Emity Dr","Cary","NC",24262,"Cassandra@uncc.edu","980-029-0283",3.82,2300,0,44);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("404-858-585","Elizabeth","Pantaleoni","P","Clories Road","Clevland","OH",38943,"Elizabeth@uncc.edu","765-049-9493",4.00,1900,1,45);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("304-381-801","Ilyena","lydia","V","Albmarle road","Charlotte","NC",28262,"Ilyena@uncc.edu","675-029-9284",2.59,1620,0,46);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("304-763-829","Julie","smith","M","Jhon Krik dr","Atlanta","GA",28275,"Julie@uncc.edu","784-933-0948",2.83,1760,1,47);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("304-626-899","Norma","Jean","M","Sharone Emity Dr","Cary","NC",24262,"Norma@uncc.edu","894-038-0389",3.92,2320,0,48);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("304-989-538","Steveland","judkins","W","Wt Harris Blvd","Alabama","SC",29362,"Steveland@uncc.edu","784-029-0283",3.22,2040,1,49);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("304-654-772","Stephen","Hackins","K","JW Clay Road","Charlotte","NC",24562,"Stephen@uncc.edu","765-029-0298",3.33,1400,0,50);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("897-029-029","jack","Feber","P","HillGuest Road","Columbus","OH",78632,"feber@uncc.edu","987-938-8372",3.00,2100,1,51);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("786-029-020","iggy","Eleses","L","Farsing Street","ingleert","ND",89212,"iggy@uncc.edu","908-937-0382",3.95,1900,1,52);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("783-826-287","Lamer","Ross","I","Sidroek Blvd.","Atlanta","GA",90823,"lamer@uncc.edu","908-721-920",2.09,1700,1,53);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("552-365-698","Gary","Fedrick","H","krocks street","SanJose","CA",76573,"Gary@uncc.edu","784-039-0293",3.20,2300,1,54);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("215-968-635","jack","Fruit","S","Silent Canyon","Pie Town","IO",12564,"jack@uncc.edu","459-695-3265",3.00,1900,1,55);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("201-639-325","Grant","Hanson","Q","Little Cedar Chase","Burnt Ranch","IN",25489,"grant@uncc.edu","458-487-9995",3.79,2000,1,56);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("012-635-968","Gail","curtis","E","Shady bluff parkway","Du Point","MN",51571,"curtis@uncc.edu","124-965-3265",3.56,2000,1,57);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("012-698-635","Anita","Parsins","P","Clear Bay","Flea Hill","MI",25622,"parsins@uncc.edu","896-654-3652",3.69,2200,1,58);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("254-986-632","Lorenzo","Mitchell","O","Velvet Hollow","Ticaboo","MD",52475,"mitchell@uncc.edu","124-965-3265",3.89,2000,1,59);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("128-965-325","Robin","Peter","P","Cotton Circle","St. Gregor","MD",28262,"peter@uncc.edu","236-214-6325",2.89,2000,1,60);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("124-639-587","Pat","Gregory","H","Quiet Towers","kragter","OH",85974,"pat@uncc.edu","225-968-6521",3.90,2300,1,61);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("365-784-254","Emily","Scandoval","H","Clories Road","Clevland","OH",89562,"emily@uncc.edu","229-665-8754",3.69,2100,1,62);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("128-635-587","Martha","Hale","H","Clories Escatawapia Road","Maine","ME",36598,"halem@uncc.edu","125-698-6953",3.69,2010,1,63);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("968-652-971","Veronica","Nichols","H","Foggy Log Place","Speedsville","MD",25687,"veronica@uncc.edu","125-698-6523",4.00,2200,1,64);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("564-698-352","Roger","Hicks","H","Fallen Boulvard","Boos","AK",98756,"hicks@uncc.edu","326-695-6325",3.68,2300,1,65);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("369-865-478","Woodrow","Wilkins","H","Honey Sky Gate","Pabst","WA",69456,"wilkins@uncc.edu","126-695-6945",3.26,2150,1,66);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("124-698-352","Bradley","Gordon","H","Emerald","Forty Fort","SC",69841,"gordon@uncc.edu","784-039-029",4.00,2250,1,67);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("784-968-324","Doyle","Lawrence","H","Gentle treasure trail","Gays Mills","SD",56987,"doyle@uncc.edu","458-958-6325",2.75,2600,1,68);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("123-968-658","Bradly","Kim","H","Heather Mountain Street","Four States","TX",12458,"kimb@uncc.edu","125-968-3265",4.00,2350,1,69);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("487-698-325","Edgar","Jackson","H","GrandRoad","Odyssey","NF",38943,"edger@uncc.edu","124-652-9685",3.78,2100,1,70);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("365-968-241","Dwayne","lloyd","H","Pleasant Oak Green","Great Good Place","NF",36589,"dwayne@uncc.edu","154-968-9652",3.69,1800,1,71);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("332-987-325","Lowell","Medina","H","High Glen","King Willam","SD",14652,"lowell@uncc.edu","125-632-9856",2.65,900,1,72);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("264-962-986","Bethany","Ross","H","Rustic Swale","life","OR",98546,"bethany@uncc.edu","145-632-9856",3.68,2050,1,73);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("655-986-214","Estelle","Carr","H","Lost Autumn Townline","Cumming","CL",35594,"estelle@uncc.edu","152-632-9568",3.21,2080,1,74);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("251-985-632","Lynette","Ellis","H","Wishing Manor","Prosper","MN",24983,"lynette@uncc.edu","154-326-8597",3.21,2090,1,75);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("514-365-985","Andres","Hill","H","Quaking Panda Avenue","Stettler","OH",84596,"hill@uncc.edu","458-965-3265",4.00,2190,1,76);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("325-964-120","Douglas","Duncan","H","Old Passage","Devils Slide","TX",54896,"duncan@uncc.edu","784-965-7849",4.00,2260,1,77);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("989-515-695","Norman","Carroll","H","Umber Grove","Ice Mine","OR",25498,"norman@uncc.edu","102-658-9652",3.26,2350,1,78);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("124-695-985","Pete","Sanchez","H","Colonial Maze","Grand Bay-Westfield","DE",12486,"pete@uncc.edu","784-695-6325",3.89,2120,1,79);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("125-698-365","Edwin","Daniels","H","Iron Brook Trace","Noon","PA",98125,"edwin@uncc.edu","125-632-6985",3.90,2000,1,80);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("145-365-985","Elbert","Guzman","H","Sleepy Nector Street","Clevland","OH",38943,"elbert@uncc.edu","125-632-6398",4.00,2000,1,81);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("145-968-517","Amelia","Brooks","H","Clotyr Road","Rome","LO",78956,"amelia@uncc.edu","102-698-6523",3.23,2000,1,82);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("582-963-147","Margarita","Freeman","H","CRed Robin Blvd.","Clevland","OH",12489,"freemanm@uncc.edu","784-698-6325",3.96,2000,1,83);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("318-303-973","Archibald","Alexander","L","Milton Road","Los Angles","CA",38262,"Archibald@uncc.edu","894-039-0458",3.75,2180,1,84);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("304-626-889","Nothern","Forth","B","Sharone Emity Dr","Cary","NC",24262,"Norma@uncc.edu","894-038-0389",3.92,2320,0,85);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("304-888-585","Eric","Sony","W","Clories Road","Clevland","OH",38943,"Ehrich@uncc.edu","784-039-0293",4.00,2000,1,86);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("021-986-695","leo","Dicaprio","S","SunHeat Street","West California","CA",87634,"leo@uncc.edu","807-902-9082",3.00,2100,1,87);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("313-785-139","Samantha","Kenwald","T","Iron Fox Glade", "Stettler", "Ar", 72093," Tsamantha@unnc.edu ","727-971-2911",3.23,2013,1,88);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("722-410-236","madison","Kemeco","U","Umber Island Swale", "Roddy", "Oh", 43444,"Umadison@unnc.edu ","371-948-7485",3.34,1956,1,89);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("477-982-552","Jane","Smith","H","Rocky Isle", "Lizard", "SC", 29515,"Hjane@unnc.edu  ","247-227-1312",3.45,2012,1,90);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("277-890-469","Kerry","Lee","D","Emerald Blossom Nook", "Kitts Hummock", "MI", 39374,"Dkerry@unnc.edu","449-428-4791",3.67,2109,1,91);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("879-851-950","Kathy","lesly","A","Stony Boulevard", "Lone Star", "SC", 29262,"Akathy@unnc.edu","547-922-2821",3.89,2301,1,92);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("348-517-410","Jason","Daniels","C","Merry Private", "Jot Em Down Store", "LO", 70726,"Cjason@unnc.edu","282-209-2390",3.65,2106,1,93);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("282-209-239","Kenny","wald","W","Bright Valley"," Normalville", "WV", 25578,"Wkenny@unnc.edu","348-517-4109",3.67,1601,1,94);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("547-922-282","Jenny","stone","S","Lazy Elk Hill", "Purdytown", "AK", 72725,"Sjenny@unnc.edu","879-851-9502",3.78,2301,1,95);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("449-428-479","Michelle","han","Z","Round Expressway", "Mile Point", "RI", 02816,"Zmichelle@unnc.edu","277-890-4699",3.34,2301,1,96);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("247-227-131","Grace","Genny","B","Gentle Beacon Forest", "Pennsylvania", "WS", 15927,"Bgrace@unnc.edu","477-982-5528",3.56,1901,1,97);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("371-948-748","Rachel","McCarthy","H","Misty Via"," Mudtown", "HA", 96862,"Hrachel@unnc.edu","722-410-2366",3.23,2100,1,98);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("627-971-291","Kathleen","Kelly","I","Quiet Promenade", "The Bottle", "CT", 06150,"Ikathleen@unnc.edu","313-785-1396",3.34,2210,1,99);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("107-570-135","Katie","norton","K","Velvet Thicket", "Regina Beach", "TE", 37647,"Kkatie@unnc.edu","998-174-1517",3.45,2300,1,100);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("683-640-817","Sherline","joans","S","Grand Robin Diversion"," Punnichy", "NM", 87535,"Ssherline@unnc.edu","848-679-9591",3.78,1892,1,101);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("535-428-939","Kathy","jonas","H","Cotton Lookout", "Quidnick", "HA", 96868,"Dkathy@unnc.edu","647-902-2830",3.02,1111,1,102);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("135-343-646","Hannah","Stuert","D","Easy Orchard", "Swan Hills","NM", 87162,"Ehannah@unnc.edu","252-523-5742",3.23,2300,1,103);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("920-590-585","Penny","marino","E", "Green Pond Circuit", "Loafers Corner", "NU", 78624,"Epenny@unnc.edu","762-771-4930",3.34,2250,1,104);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("425-270-739","lisa","hanson","E","Dewy Stead", "Rush Run", "WV", 25118,"Elisa@unnc.edu","592-637-9120",3.56,2210,1,105);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("262-771-493","poojitha","reddy","C","Cinder Rise By-pass", "Missionary","TE", 37812,"Ceenna@unnc.edu","925-590-5858",3.20,2103,1,106);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("352-523-574","harsha","ari","S","Silent Anchor Highway", "Cheeseville", "WV", 25873,"Semily@unnc.edu","857-343-6465",3.60,1960,1,107);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("647-902-283","varun","singh","F","Foggy Square","Cocked Hat","NC", 27564,"Fkerli@unnc.edu","853-428-9397",3.02,1340,1,108);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("848-679-959","Gemma","Jaywald","G","Honey Willow Link","Trickum","GA", 39968,"Ggemma@unnc.edu","883-640-8177",3.03,1780,1,109);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("998-174-151","Emma","Genkins","W","Jagged Hills Villas"," Buffalo","NM", 88214,"Wemma@unnc.edu","807-570-1358",3.13,1903,1,110);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("592-637-912","Sofia","ross","A","Sunny Heights", "Coats", "MA", 02780,"Asofia@unnc.edu","425-270-7398",3.30,2056,1,111);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("762-771-493","Jenna","Doh","C","Cinder Rise By-pass", "Missionary","TR", 37812,"Jenna@unnc.edu","920-590-5858",3.20,2103,1,112);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("252-523-574","Emily","saks","S","Silent Anchor Highway", "Cheeseville", "WV", 25873,"emily@unnc.edu","835-343-6465",3.60,1960,1,113);
insert into tblStudent (SSN,fName,lName,mInitial,strAddress,city,state,zip,email,phone,GPA,SAT,inStateFlag,tblUser_userID) values("647-902-288","Kerli","wilson","F","Foggy Square","Cocked Hat","NC", 27564,"kerli@unnc.edu","835-428-9397",3.02,1340,1,114);


insert into tblTerm(termName) values("Spring 2014");
insert into tblTerm(termName) values("Fall 2014");
insert into tblTerm(termName) values("Spring 2015");
insert into tblTerm(termName) values("Fall 2015");
insert into tblTerm(termName) values("Spring 2016");
insert into tblTerm(termName) values("Fall 2016");
insert into tblTerm(termName) values("Spring 2017");
insert into tblTerm(termName) values("Fall 2017");
insert into tblTerm(termName) values("Spring 2018");
insert into tblTerm(termName) values("Fall 2018");


insert into tblParameter(GPAWeight,SATWeight,GPAThreshold,SATThreshold,OutOfStateWeight,tblTerm_termName) values(40,40,2.75,1500,20,"Spring 2014");
insert into tblParameter(GPAWeight,SATWeight,GPAThreshold,SATThreshold,OutOfStateWeight,tblTerm_termName) values(30,40,3.00,1700,30,"Fall 2014");
insert into tblParameter(GPAWeight,SATWeight,GPAThreshold,SATThreshold,OutOfStateWeight,tblTerm_termName) values(40,50,3.25,1800,10,"Spring 2015");
insert into tblParameter(GPAWeight,SATWeight,GPAThreshold,SATThreshold,OutOfStateWeight,tblTerm_termName) values(30,40,3.00,1700,30,"Fall 2015");
insert into tblParameter(GPAWeight,SATWeight,GPAThreshold,SATThreshold,OutOfStateWeight,tblTerm_termName) values(40,50,3.25,1800,10,"Spring 2016");
insert into tblParameter(GPAWeight,SATWeight,GPAThreshold,SATThreshold,OutOfStateWeight,tblTerm_termName) values(30,40,3.50,1700,30,"Fall 2016");
insert into tblParameter(GPAWeight,SATWeight,GPAThreshold,SATThreshold,OutOfStateWeight,tblTerm_termName) values(40,50,3.75,1800,10,"Spring 2017");
insert into tblParameter(GPAWeight,SATWeight,GPAThreshold,SATThreshold,OutOfStateWeight,tblTerm_termName) values(30,40,3.00,1700,30,"Fall 2017");
insert into tblParameter(GPAWeight,SATWeight,GPAThreshold,SATThreshold,OutOfStateWeight,tblTerm_termName) values(40,50,3.25,1800,10,"Spring 2018");
insert into tblParameter(GPAWeight,SATWeight,GPAThreshold,SATThreshold,OutOfStateWeight,tblTerm_termName) values(30,40,3.00,1700,30,"Fall 2018");


insert into tblDegreeProgram(degreeName,InfoMessage) values("Bioinformatics","The Department of Bioinformatics and Genomics was established within the College of Computing and Informatics in 2009 to foster research and education in Bioinformatics and Computational Biology.  Located in the Bioinformatics Building on UNC Charlotte’s CRI Campus, the Department offers a Ph.D. in Bioinformatics and Computational Biology, a Professional Science Master’s in Bioinformatics, Graduate Certificates in Bioinformatics, and an undergraduate Minor in Bioinformatics and Genomics. The building has both wet and dry laboratories, and includes core facilities for molecular biology, genomics, and high-performance computing.  Currently, the Department has 17 full-time faculty, 24 Ph.D. students, 29 Master’s students, 13 certificates, 23 minors, and a professional staff of 12.");
insert into tblDegreeProgram(degreeName,InfoMessage) values("ComputerScience","CS now offers a path through the Computer Science M.S. degree program by taking only evening classes (5 pm or later). At least twelve courses will be offered in the evening on a three-year rotation schedule such that it is possible to satisfy the program requirements and graduate within three years by taking a suitable selection of ten of these evening classes. This program should be of particular interest to working professionals.");
insert into tblDegreeProgram(degreeName,InfoMessage) values("SIS","The Software and Information Systems Department is a pioneer in Information Technology research and education emphasizing on designing and deploying integrated, secure, reliable, and easy-to-use IT solutions. We offer a wide selection of courses in Information Technology, Information Security and Privacy, Human Computer Interaction, Web Development, and Software Engineering. Our security and Privacy program is recognized by the National Security Agency as a National Center of Academic Excellence in Information Assurance Education and Research. ");
insert into tblDegreeProgram(degreeName,InfoMessage) values("HealthInformatics","Health Informatics is an expanding career field that is evolving on almost a daily basis. There is a strong demand across the region for trained professionals in health analytics and data science, individuals who understand both the language of healthcare and of “Big Data.” It is clear that a revolution is taking place within the healthcare sector with unprecedented amounts of data streaming to providers, payers, and research organizations everyday. The challenge lies in identifying professionals who are capable of managing and securing the massive flow of data, as well as analyzing and finding insight withinin the data.");
insert into tblDegreeProgram(degreeName,InfoMessage) values("EngineeringTechnology","The Engineering Technology and Construction Management programs at UNC Charlotte provides multiple paths to earning the Bachelor of Science in Engineering Technology (B.S.E.T.) or the Bachelor of Science in Construction Management (B.S.C.M.) degree.  Students may enroll at UNC Charlotte as freshmen, transfer into the upper division of our 2+2 program after completing their first two years of engineering technology study (earning an AAS degree) at a community college, or transfer with less than two years of college credit as a general transfer student. The Department of Engineering Technology at UNC Charlotte has offered baccalaureate degree programs in several disciplines since 1970. Prior to 1991, the department conferred the Bachelor of Engineering Technology degree.  The BET degrees in Civil, Electrical and Mechanical received initial accreditation from ABET in 1974.  In 1991, the department began conferring the Bachelor of Science in Engineering Technology degree in those disciplines and has since added additional major of study in fire safety and the Bachelor of Science in Construction Management degree. Currently, the Department offers the following disciplinary areas:");
insert into tblDegreeProgram(degreeName,InfoMessage) values("EnergyProduction","The Energy Production and Infrastructure Center (EPIC) is home to the Department of Civil and Environmental Engineering at UNC Charlotte.  EPIC was built in response to the need from industry to supply highly trained engineers who will be qualified to meet the demands of the energy industry- through both traditional and continuing education- as well as provide sustainable support to the North Carolina energy industry by increasing capacity and support for applied research.  The 200,000 SQ FT building, which has earned LEED-Gold standard certification, is host to state-of-the-art classrooms, lecture halls, conference rooms and research laboratories.  Among these are the High-Bay Structures Laboratory, the Pavement Materials Performance Laboratory, Water Resources Research Lab, and the Geosynthetics Research Laboratory to name a few.");
insert into tblDegreeProgram(degreeName,InfoMessage) values("Civil and Environmental Engineering","The Energy Production and Infrastructure Center (EPIC) is home to the Department of Civil and Environmental Engineering at UNC Charlotte.  EPIC was built in response to the need from industry to supply highly trained engineers who will be qualified to meet the demands of the energy industry- through both traditional and continuing education- as well as provide sustainable support to the North Carolina energy industry by increasing capacity and support for applied research.  The 200,000 SQ FT building, which has earned LEED-Gold standard certification, is host to state-of-the-art classrooms, lecture halls, conference rooms and research laboratories.  Among these are the High-Bay Structures Laboratory, the Pavement Materials Performance Laboratory, Water Resources Research Lab, and the Geosynthetics Research Laboratory to name a few.");
insert into tblDegreeProgram(degreeName,InfoMessage) values("Anthropology","The Department of Anthropology at UNC Charlotte was inaugurated in July 2007, after more than thirty years as part of the Department of Sociology and Anthropology. Anthropology is located on the second floor of the Barnard building.  The faculty include specialists in cultural anthropology, biological anthropology, archaeology, and linguistic anthropology.  The Department offers a B.A. in Anthropology, a B.A. in Anthropology with a concentration in Applied Anthropology, and an M.A. in Anthropology.");
insert into tblDegreeProgram(degreeName,InfoMessage) values("Biological Sciences","The Department of Biological Sciences is an academic community of scientists and students engaged in advancing the discovery, dissemination, and application of knowledge in biological sciences. The Department is guided by the pursuit of excellence in research and education, by a creative and collaborative approach, and by an awareness of the global context in which the Department exists.");
insert into tblDegreeProgram(degreeName,InfoMessage) values("Chemistry","The Department of Chemistry at UNC Charlotte provides opportunities for graduate research in all traditional chemical disciplines, while maintaining strong ties to interdisciplinary programs in nanoscale science, biotechnology and bio-medicine, optical science, and electrical and mechanical engineering. The department maintains an impressive array of chemical instrumentation, most of which is available for hands-on use by any research student that needs it. ");
insert into tblDegreeProgram(degreeName,InfoMessage) values("Communication Studies","Welcome to the Communication Studies Graduate Program website! On behalf of our graduate faculty and students, I would like to thank you for your interest in our program and I look forward to speaking with you further if this site does not sufficiently answer your questions.This website is a work in progress as we are constantly adding new features to make this a one-stop informational portal. Please continue to check back for updates and information about our visionary Graduate Program and particularly, our section to learn about upcoming events that you are welcome to attend. ");
insert into tblDegreeProgram(degreeName,InfoMessage) values("Criminal Justice","Criminal Justice and Criminology are two interrelated areas of study with a rich interdisciplinary academic tradition. Criminology is the study of the etiology and nature of crime and delinquency, and theoretical explanations conceived to explain these behaviors. Criminal Justice is the study of agencies’ responses to criminal and delinquent behavior, the relationship among these agencies, and policies that impact the process through which justice is administered.");


insert into tblCollegeLife(CollegeLifeName,collegeLifeInfoMessage) values("Campus Events","The Campus Events website is your resource for hundreds of activities and events held at UNC Charlotte throughout the year. Search this online calendar by date or event categories such as speakers, arts, entertainment, recreation, career, and more. Promote your own campus department or student organization's activities by submitting your campus events online.");
insert into tblCollegeLife(CollegeLifeName,collegeLifeInfoMessage) values("Student Involvement","Getting involved at UNC Charlotte means discovering new interests, learning skills, and making contributions to your campus community. It’s also about having fun and meeting friends, whether you are planning events and activities, participating in leadership or diversity programs, or joining one of over 325 UNC Charlotte student organizations.");
insert into tblCollegeLife(CollegeLifeName,collegeLifeInfoMessage) values("Recreation","UNC Charlotte has plenty of opportunities for you to get active. We offer a variety of sport clubs, intramurals, fitness programs, and special events ranging from competitive to recreational. Our facilities include a fitness center, aerobics studio, indoor climbing wall, swimming pool, and recreational courts free of charge for students. Our Fitness Program provides services and fitness classes for all interests and skill levels year round.");
insert into tblCollegeLife(CollegeLifeName,collegeLifeInfoMessage) values("Health","We provide affordable, confidential, on-campus health care for students through the Student Health Center. Our Counseling Center offers free and confidential counseling for students dealing with emotional, relationship, or personal concerns as well as workshops and consultations. A bevy of services are available to help you get healthy and stay healthy while you're in school.");
insert into tblCollegeLife(CollegeLifeName,collegeLifeInfoMessage) values("Housing","You don’t have to trade comfort for the convenience of on-campus living. The list of housing options for freshmen and upper-classmen keeps growing, and so does the list of on-campus housing amenities. Find out whether living on campus is right for you.");
insert into tblCollegeLife(CollegeLifeName,collegeLifeInfoMessage) values("Dining","UNC Charlotte offers a variety of dining options, including cafeteria-style dining in several residence halls, the Library Café and the Fretwell Café, and the Student Union, which houses Crown Commons dining hall, Union Square, Starbucks Coffee, and Bistro 49. The Student Union also hosts retailers including Barnes & Noble at UNC Charlotte, The Campus Salon, NinerTech Computer Store, and others.");
insert into tblCollegeLife(CollegeLifeName,collegeLifeInfoMessage) values("Diversity","Our students come to UNC Charlotte from diverse backgrounds and cultural traditions. We are committed to creating a dynamic, equitable and respectful campus environment and seek to promote diversity through recruitment, enrollment and hiring practices");
insert into tblCollegeLife(CollegeLifeName,collegeLifeInfoMessage) values("Student Computing","Student Computing provides technical support to students through the IT Service Desk. Get help with your NinerNET account, 49er Express, Moodle and other applications. Visit the Student Computing website to find out more about labs, software downloads, wireless access and tips on safe computing.");
insert into tblCollegeLife(CollegeLifeName,collegeLifeInfoMessage) values("Student Affairs","As a vibrant educational institution that emphasizes the development of the individual and the betterment of the community, UNC Charlotte offers students many services and opportunities for personal and professional development. The Division of Student Affairs oversees a number of these services, which are available to help students achieve their educational and personal goals");
insert into tblCollegeLife(CollegeLifeName,collegeLifeInfoMessage) values("Police & Public Safety","UNC Charlotte police officers are on duty 24 hours a day, seven days a week. Officers are assigned to protect the campus in cars, on bicycles, and on foot. The Police and Public Safety team periodically offers self-defense and other safety courses to faculty, staff and students.");
insert into tblCollegeLife(CollegeLifeName,collegeLifeInfoMessage) values("Scholarships", "There are several categories of scholarships available to UNCC students.  Please visit the school’s Scholarship Website for detailed information.  The Levine Scholarship Program provides full tuition, room and board, a grant to implement a service project and four summers of experience.  Scholarships for Merit are awarded to incoming freshmen.  Applicants must receive a nomination from their high school counselor.  Athletic Scholarships are awarded by the coaches of the particular athletic program.  Department Scholarships are awarded by academic departments.  Private Scholarships are also awarded by civic, social and religious organizations.  Students must seek out and apply for private scholarships on their own.");
insert into tblCollegeLife(CollegeLifeName,collegeLifeInfoMessage) values("Financial Aid", "There are 4 steps to Applying for Financial Aid:  Step 1: Apply for financial aid:  Submit the FAFSA (Free Application for Federal Student Aid). Be sure to enter our school code: 002975.  The priority filing date is March 1st.  All students must reapply every year for financial aid.  Step 2: Review and accept your financial aid award:  View your award in 49er Express.Make sure you don't have any outstanding requirements.  Step 3: Receive your financial aid:  Some refunds will go out the first week of class.  Grants and scholarships may not disburse until after the drop/add period ends.  Step 4:  Maintain financial aid eligibility: A FAFSA needs to be completed annually.  Maintain Satisfactory Academic Progress (SAP).");




insert into `AIS`.`tblAdmissionClerk`(fName,mInitial,lName,tblUser_userID) values("Lei","T","Shang",1);
insert into `AIS`.`tblAdmissionClerk`(fName,mInitial,lName,tblUser_userID) values("Yu","Z","Liang",2);


insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",0,1,"704-381-801","Spring 2014","ComputerScience");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",1,0,"704-763-829","Spring 2014","ComputerScience");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",1,1,"704-989-538","Spring 2014","ComputerScience");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Accept",1,0,"704-654-772","Spring 2014","ComputerScience");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Deny",1,1,"618-303-973","Spring 2014","ComputerScience");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",0,1,"704-626-899","Fall 2014","ComputerScience");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",1,0,"704-858-585","Fall 2014","ComputerScience");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",1,1,"904-381-801","Fall 2014","ComputerScience");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Accept",1,0,"904-763-829","Fall 2014","ComputerScience");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Deny",1,1,"904-989-538","Fall 2014","ComputerScience");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",1,1,"704-989-538","Spring 2014","Bioinformatics");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",1,1,"704-989-538","Spring 2014","SIS");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Deny",1,1,"704-654-772","Spring 2014","Bioinformatics");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Deny",1,1,"704-654-772","Spring 2014","SIS");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Deny",1,1,"618-303-973","Spring 2014","Bioinformatics");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Deny",1,1,"618-303-973","Spring 2014","SIS");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",1,1,"604-858-585","Spring 2014","EngineeringTechnology");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",1,1,"604-858-585","Spring 2014","EnergyProduction");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Deny",1,1,"504-381-801","Spring 2014","EngineeringTechnology");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Deny",1,1,"504-381-801","Spring 2014","EnergyProduction");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Deny",1,1,"504-763-829","Spring 2014","EngineeringTechnology");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Deny",1,1,"504-763-829","Spring 2014","EnergyProduction");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",1,1,"128-635-587","Spring 2014","Biological Sciences");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Deny",1,1,"968-652-971","Spring 2014","Biological Sciences");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Deny",1,1,"564-698-352","Spring 2014","Biological Sciences");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",1,1,"277-890-469","Spring 2014","Criminal Justice");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Deny",1,1,"879-851-950","Spring 2014","Criminal Justice");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Deny",1,1,"348-517-410","Spring 2014","Criminal Justice");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",0,1,"904-654-772","Spring 2014","Bioinformatics");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",1,0,"983-039-731","Spring 2014","Bioinformatics");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",1,1,"904-626-899","Spring 2014","Bioinformatics");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Accept",1,0,"904-858-585","Spring 2014","Bioinformatics");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Deny",1,1,"804-381-801","Spring 2014","Bioinformatics");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",0,1,"804-763-829","Fall 2014","Bioinformatics");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",1,0,"804-989-538","Fall 2014","Bioinformatics");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",1,1,"804-654-772","Fall 2014","Bioinformatics");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Accept",1,0,"818-303-973","Fall 2014","Bioinformatics");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Deny",1,1,"804-626-899","Fall 2014","Bioinformatics");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",0,1,"804-858-585","Spring 2014","SIS");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",1,0,"604-381-801","Spring 2014","SIS");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",1,1,"604-763-829","Spring 2014","SIS");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Accept",1,0,"604-989-538","Spring 2014","SIS");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Deny",1,1,"604-654-772","Spring 2014","SIS");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",0,1,"504-989-538","Fall 2014","SIS");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",1,0,"504-654-772","Fall 2014","SIS");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",1,1,"518-303-973","Fall 2014","SIS");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Accept",1,0,"504-626-899","Fall 2014","SIS");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Deny",1,1,"504-858-585","Fall 2014","SIS");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",0,1,"618-303-971","Spring 2014","HealthInformatics");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",1,0,"604-626-899","Spring 2014","HealthInformatics");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",1,1,"604-858-585","Spring 2014","HealthInformatics");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Accept",1,0,"504-381-801","Spring 2014","HealthInformatics");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Deny",1,1,"504-763-829","Spring 2014","HealthInformatics");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",0,1,"404-381-801","Fall 2014","HealthInformatics");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",1,0,"404-763-829","Fall 2014","HealthInformatics");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",1,1,"404-989-538","Fall 2014","HealthInformatics");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Accept",1,0,"404-654-772","Fall 2014","HealthInformatics");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Deny",1,1,"418-303-973","Fall 2014","HealthInformatics");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",0,1,"404-626-899","Spring 2014","EngineeringTechnology");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",1,0,"404-858-585","Spring 2014","EngineeringTechnology");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",1,1,"304-381-801","Spring 2014","EngineeringTechnology");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Accept",1,0,"304-763-829","Spring 2014","EngineeringTechnology");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Deny",1,1,"304-989-538","Spring 2014","EngineeringTechnology");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",0,1,"304-654-772","Spring 2014","EnergyProduction");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",1,0,"318-303-973","Spring 2014","EnergyProduction");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",1,1,"304-626-899","Spring 2014","EnergyProduction");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Accept",1,0,"304-858-585","Spring 2014","EnergyProduction");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Deny",1,1,"897-029-029","Spring 2014","EnergyProduction");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",0,0,"786-029-020","Fall 2014","EngineeringTechnology");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",1,0,"783-826-287","Fall 2014","EngineeringTechnology");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",1,1,"552-365-698","Fall 2014","EngineeringTechnology");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Accept",1,0,"021-986-695","Fall 2014","EngineeringTechnology");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Deny",1,1,"215-968-635","Fall 2014","EngineeringTechnology");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",0,1,"201-639-325","Fall 2014","EnergyProduction");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",1,0,"012-635-968","Fall 2014","EnergyProduction");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",1,1,"012-698-635","Fall 2014","EnergyProduction");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Accept",1,0,"254-986-632","Fall 2014","EnergyProduction");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Deny",1,1,"128-965-325","Fall 2014","EnergyProduction");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",0,1,"124-639-587","Spring 2014","Anthropology");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",1,0,"365-784-254","Spring 2014","Anthropology");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",1,1,"128-635-587","Spring 2014","Anthropology");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Accept",1,0,"968-652-971","Spring 2014","Anthropology");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Deny",1,1,"564-698-352","Spring 2014","Anthropology");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",0,1,"369-865-478","Fall 2014","Anthropology");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",1,0,"124-698-352","Fall 2014","Anthropology");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",1,1,"784-968-324","Fall 2014","Anthropology");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Accept",1,0,"123-968-658","Fall 2014","Anthropology");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Deny",1,1,"487-698-325","Fall 2014","Anthropology");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",0,1,"365-968-241","Spring 2014","Biological Sciences");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",1,0,"332-987-325","Spring 2014","Biological Sciences");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",1,0,"264-962-986","Spring 2014","Biological Sciences");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Accept",1,0,"655-986-214","Spring 2014","Biological Sciences");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Deny",1,1,"251-985-632","Spring 2014","Biological Sciences");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",0,1,"514-365-985","Fall 2014","Biological Sciences");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",1,0,"325-964-120","Fall 2014","Biological Sciences");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",1,1,"989-515-695","Fall 2014","Biological Sciences");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Accept",1,0,"124-695-985","Fall 2014","Biological Sciences");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Deny",1,1,"125-698-365","Fall 2014","Biological Sciences");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",0,1,"145-365-985","Spring 2014","Chemistry");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",1,0,"145-968-517","Spring 2014","Chemistry");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",1,1,"582-963-147","Spring 2014","Chemistry");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Accept",1,0,"592-637-912","Spring 2014","Chemistry");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Deny",1,1,"762-771-493","Spring 2014","Chemistry");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",0,1,"252-523-574","Fall 2014","Chemistry");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",1,0,"647-902-283","Fall 2014","Chemistry");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",1,1,"848-679-959","Fall 2014","Chemistry");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Accept",1,0,"998-174-151","Fall 2014","Chemistry");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Deny",1,1,"313-785-139","Fall 2014","Chemistry");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",0,1,"722-410-236","Spring 2014","Communication Studies");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",1,0,"477-982-552","Spring 2014","Communication Studies");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",1,0,"277-890-469","Spring 2014","Communication Studies");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Accept",1,0,"879-851-950","Spring 2014","Communication Studies");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Deny",1,1,"348-517-410","Spring 2014","Communication Studies");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",0,1,"282-209-239","Fall 2014","Communication Studies");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",1,0,"547-922-282","Fall 2014","Communication Studies");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",1,1,"449-428-479","Fall 2014","Communication Studies");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Accept",1,0,"247-227-131","Fall 2014","Communication Studies");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Deny",1,1,"371-948-748","Fall 2014","Communication Studies");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",0,1,"627-971-291","Spring 2014","Criminal Justice");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",1,0,"107-570-135","Spring 2014","Criminal Justice");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",1,1,"683-640-817","Spring 2014","Criminal Justice");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Accept",1,0,"535-428-939","Spring 2014","Criminal Justice");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Deny",1,1,"135-343-646","Spring 2014","Criminal Justice");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",0,1,"920-590-585","Fall 2014","Criminal Justice");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",1,0,"425-270-739","Fall 2014","Criminal Justice");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("null",1,1,"262-771-493","Fall 2014","Criminal Justice");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Accept",1,0,"352-523-574","Fall 2014","Criminal Justice");
insert into tblInquireApply(applicationStatus,applyFlag,inquireFlag,tblStudent_SSN,termApplied,tblDegreeProgram_degreeName) values("Deny",1,1,"647-902-283","Fall 2014","Criminal Justice");


insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Bioinformatics","Spring 2014");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Bioinformatics","Fall 2014");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Bioinformatics","Spring 2015");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Bioinformatics","Fall 2015");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Bioinformatics","Spring 2016");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Bioinformatics","Fall 2016");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Bioinformatics","Spring 2017");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Bioinformatics","Fall 2017");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Bioinformatics","Spring 2018");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Bioinformatics","Fall 2018");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"ComputerScience","Spring 2014");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"ComputerScience","Fall 2014");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"ComputerScience","Spring 2015");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"ComputerScience","Fall 2015");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"ComputerScience","Spring 2016");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"ComputerScience","Fall 2016");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"ComputerScience","Spring 2017");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"ComputerScience","Fall 2017");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"ComputerScience","Spring 2018");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"ComputerScience","Fall 2018");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"SIS","Spring 2014");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"SIS","Fall 2014");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"SIS","Spring 2015");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"SIS","Fall 2015");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"SIS","Spring 2016");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"SIS","Fall 2016");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"SIS","Spring 2017");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"SIS","Fall 2017");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"SIS","Spring 2018");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"SIS","Fall 2018");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"HealthInformatics","Spring 2014");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"HealthInformatics","Fall 2014");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"HealthInformatics","Spring 2015");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"HealthInformatics","Fall 2015");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"HealthInformatics","Spring 2016");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"HealthInformatics","Fall 2016");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"HealthInformatics","Spring 2017");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"HealthInformatics","Fall 2017");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"HealthInformatics","Spring 2018");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"HealthInformatics","Fall 2018");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"EngineeringTechnology","Spring 2014");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"EngineeringTechnology","Fall 2014");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"EngineeringTechnology","Spring 2015");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"EngineeringTechnology","Fall 2015");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"EngineeringTechnology","Spring 2016");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"EngineeringTechnology","Fall 2016");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"EngineeringTechnology","Spring 2017");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"EngineeringTechnology","Fall 2017");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"EngineeringTechnology","Spring 2018");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"EngineeringTechnology","Fall 2018");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"EnergyProduction","Spring 2014");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"EnergyProduction","Fall 2014");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"EnergyProduction","Spring 2015");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"EnergyProduction","Fall 2015");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"EnergyProduction","Spring 2016");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"EnergyProduction","Fall 2016");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"EnergyProduction","Spring 2017");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"EnergyProduction","Fall 2017");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"EnergyProduction","Spring 2018");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"EnergyProduction","Fall 2018");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Anthropology","Spring 2014");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Anthropology","Fall 2014");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Anthropology","Spring 2015");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Anthropology","Fall 2015");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Anthropology","Spring 2016");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Anthropology","Fall 2016");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Anthropology","Spring 2017");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Anthropology","Fall 2017");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Anthropology","Spring 2018");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Anthropology","Fall 2018");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Biological Sciences","Spring 2014");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Biological Sciences","Fall 2014");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Biological Sciences","Spring 2015");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Biological Sciences","Fall 2015");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Biological Sciences","Spring 2016");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Biological Sciences","Fall 2016");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Biological Sciences","Spring 2017");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Biological Sciences","Fall 2017");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Biological Sciences","Spring 2018");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Biological Sciences","Fall 2018");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Chemistry","Spring 2014");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Chemistry","Fall 2014");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Chemistry","Spring 2015");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Chemistry","Fall 2015");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Chemistry","Spring 2016");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Chemistry","Fall 2016");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Chemistry","Spring 2017");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Chemistry","Fall 2017");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Chemistry","Spring 2018");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Chemistry","Fall 2018");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Communication Studies","Spring 2014");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Communication Studies","Fall 2014");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Communication Studies","Spring 2015");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Communication Studies","Fall 2015");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Communication Studies","Spring 2016");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Communication Studies","Fall 2016");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Communication Studies","Spring 2017");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Communication Studies","Fall 2017");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Communication Studies","Spring 2018");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Communication Studies","Fall 2018");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Criminal Justice","Spring 2014");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Criminal Justice","Fall 2014");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Criminal Justice","Spring 2015");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Criminal Justice","Fall 2015");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Criminal Justice","Spring 2016");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Criminal Justice","Fall 2016");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Criminal Justice","Spring 2017");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Criminal Justice","Fall 2017");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Criminal Justice","Spring 2018");
insert into tblSeatsAvailable(seatsAvailable,tblDegreeProgram_degreeName,tblTerm_termName) values(100,"Criminal Justice","Fall 2018");



/************************************************************************************************************************
*  3. Create the views
*
*************************************************************************************************************************/

-- -----------------------------------------------------
-- View `AIS`.`vUser`
-- -----------------------------------------------------
DROP view IF EXISTS `AIS`.`vUser`;

USE `AIS`;
CREATE OR REPLACE VIEW `vUser` AS
    select 
        ac.fName,
        ac.mInitial,
        ac.lName,
        u.password,
        r.roleName,
        r.roleType
    from
        AIS.tblAdmissionClerk as ac
            inner join
        AIS.tblUser as u ON ac.tblUser_userID = u.userID
            inner join
        AIS.tblRole as r ON u.tblRole_roleID = r.roleID;


-- -----------------------------------------------------
-- View `AIS`.`vCollegeLife`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `AIS`.`vCollegeLife` ;

USE `AIS`;
CREATE OR REPLACE VIEW `vCollegeLife` AS
    select 
        cl.CollegeLifeName, cl.collegeLifeInfoMessage
    from
        AIS.tblCollegeLife as cl;


-- -----------------------------------------------------
-- View `AIS`.`vStudent`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `AIS`.`vStudent` ;

USE `AIS`;
CREATE OR REPLACE VIEW `vStudent` AS
    select 
        s.SSN,
        s.tblUser_userID,
        s.fName,
        s.mInitial,
        s.lName,
        s.strAddress,
        s.city,
        s.state,
        s.zip,
        s.email,
        s.phone,
        s.GPA,
        s.SAT,
        s.inStateFlag
    from
        AIS.tblStudent as s;

-- -----------------------------------------------------
-- View `AIS`.`vTerm`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `AIS`.`vTerm` ;

USE `AIS`;
CREATE OR REPLACE VIEW `vTerm` AS
    select 
        t.termName 
    from
        AIS.tblTerm as t; 


-- -----------------------------------------------------
-- View `AIS`.`vDegreeProgram`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `AIS`.`vDegreeProgram` ;

USE `AIS`;
CREATE OR REPLACE VIEW `vDegreeProgram` AS
    select 
        dp.degreeName,
        dp.InfoMessage 
    from
        AIS.tblDegreeProgram as dp; 


-- -----------------------------------------------------
-- View `AIS`.`vSeatsAvailable`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `AIS`.`vSeatsAvailable` ;

USE `AIS`;
CREATE OR REPLACE VIEW `vSeatsAvailable` AS
    select 
        sa.seatsAvailable,
        sa.tblDegreeProgram_degreeName,
        sa.tblTerm_termName
    from
        AIS.tblSeatsAvailable as sa; 


-- -----------------------------------------------------
-- View `AIS`.`vInquireApply`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `AIS`.`vInquireApply` ;

USE `AIS`;
CREATE OR REPLACE VIEW `vInquireApply` AS
    select 
        s.SSN,
        s.fName,
        s.mInitial,
        s.lName,
        s.strAddress,
        s.city,
        s.state,
        s.zip,
        s.email,
        s.phone,
        s.GPA,
        s.SAT,
        s.inStateFlag,
        ia.applicationStatus,
        ia.applyFlag,
        ia.inquireFlag,
        ia.termApplied,
        dp.degreeName
    from
        AIS.tblInquireApply as ia
            inner join
        AIS.tblDegreeProgram as dp ON ia.tblDegreeProgram_degreeName = dp.degreeName
            inner join
        AIS.tblStudent as s ON ia.tblStudent_SSN = s.SSN;


-- -----------------------------------------------------
-- View `AIS`.`vParameter`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `AIS`.`vParameter` ;

USE `AIS`;
CREATE OR REPLACE VIEW `vParameter` AS
    select 
        tp.parameterID,
        tp.GPAWeight,
        tp.SATWeight,
        tp.OutOfStateWeight,
        tp.SATThreshold,
        tp.GPAThreshold,
        tp.tblTerm_termName
    from
        AIS.tblParameter as tp; 



/************************************************************************************************************************
*  4. Create the stored procedures 
*
*************************************************************************************************************************/


/***************************************************************************
* Name:		getDegreePrograms
* Purpose: 	This procedure gets the degree names available 
* Inputs:	None
* Usage: 	call ais.getDegreePrograms; 

***************************************************************************/

DROP PROCEDURE IF EXISTS AIS.getDegreePrograms;


DELIMITER ||

/* create getDegreePrograms  to fetch all the available degree programs */

CREATE PROCEDURE AIS.getDegreePrograms()

BEGIN

select distinct degreeName from AIS.vDegreeProgram;

END
||


DELIMITER ;

-- ----------------------

/***************************************************************************
* Name:		getParameter
* Purpose: 	This procedure gets the parameter list  
* Inputs:	termapplied
* Usage: 	call ais.getParameter('Fall 2015'); 

***************************************************************************/
DROP PROCEDURE IF EXISTS getParameter;


DELIMITER $$

/* create procedure getParameter */
CREATE PROCEDURE AIS.getParameter  (IN termapplied VARCHAR(15))
BEGIN
SELECT 
    GPAWeight,
    SATWeight,
    OutOfStateWeight,
    SATThreshold,
    GPAThreshold
FROM
    AIS.tblParameter
WHERE
    tblTerm_termName = termapplied;
END $$

DELIMITER ;

-- -----------------------

/***************************************************************************
* Name:		getPersonalInterest
* Purpose: 	To get the list of items that can be of interest to a student
* Inputs:	None
* Usage: 	call ais.getPersonalInterest(); 

***************************************************************************/

DROP PROCEDURE IF EXISTS ais.getPersonalInterest;

DELIMITER ||

/* create getPersonalInterest to fetch all the available college life names */

CREATE PROCEDURE AIS.getPersonalInterest()

BEGIN

select distinct
    CollegeLifeName
from
    AIS.vCollegeLife;

END||

DELIMITER ;


/***************************************************************************
* Name:		getStudentInfo
* Purpose: 	To get the details of a student displayed in the report for Admissions 
* 			Although the front end for this is in future work, the database supports the search functionality
* Inputs:	None - optional
* Usage: 	call ais.getStudentInfo(null,null,null,null,null,null,null); 

***************************************************************************/



DROP PROCEDURE IF EXISTS AIS.getStudentInfo;

DELIMITER ||



CREATE PROCEDURE AIS.getStudentInfo  (
                      IN spterm VARCHAR(15),
				      IN spdegree VARCHAR(100), 
				      IN spcity VARCHAR(45),
                      IN spstate CHAR(2) , 
				      IN spzip CHAR(5),
				      IN spSAT int(11),
				      IN spGPA decimal(3,2))
BEGIN
  
         IF 
              spterm is null 
          AND spdegree is null 
          AND spcity is null 
          AND spstate is null 
          AND spzip is null
          AND spSAT is null
          AND spGPA is null

      THEN /* Fetch all student records*/
           Select SSN,fName,mInitial,lName,city,state,zip,inStateFlag,email,phone,SAT,GPA,termApplied,degreeName FROM AIS.vInquireApply  ;

     ELSE /* Fetch student records for the input parameter */
           Select SSN,fName,mInitial,lName,city,state,zip,inStateFlag,email,phone,SAT,GPA,termApplied,degreeName FROM AIS.vInquireApply 
                WHERE 
                       termApplied = spterm
      	AND degreeName = spdegree 
      	AND city = spcity 
      	AND state = spstate
      	AND zip = spzip
     	 AND SAT = spSAT
      	AND GPA = spGPA;
    END IF;


END||


DELIMITER ;


-- -----------------------------------------

/***************************************************************************
* Name:		getTerm
* Purpose: 	To get the details of Terms available 
* Inputs:	None
* Usage: 	call ais.getTerm(); 

***************************************************************************/


DELIMITER ||

/* create getTerm to fetch all the available term names */

CREATE PROCEDURE AIS.getTerm()

BEGIN

select distinct
    termName
from
    AIS.vTerm;

END
||


DELIMITER ; 

-- ------------------------------- 

/***************************************************************************
* Name:		setInquire2
* Purpose: 	To provide inquire functionality  for students
*
* Inputs:	termapplied,firstname,midinitial,lastname,
* 			socialnumb,emailid,phonenumb,streetaddr,
* 			ct,st,zipcode,gpa,sat,degree,interest
*
* Usage: 	call ais.setInquire2 ('Fall2015', 'Swetha', 'K', 'Reddy', '987-65-4321', 'swetha@gmail.com', 
			'618-303-9865', 'stella drive', 'charlotte', 'al', '28262', 3.00, 2289, 'ComputerScience', 'Dining'); 
***************************************************************************/


DROP PROCEDURE IF EXISTS setInquire2;

DELIMITER $$

/* create procedure setInquire2 */
CREATE PROCEDURE AIS.setInquire2 (
 IN termapplied VARCHAR(15), 
 IN firstname VARCHAR(45), 
 IN midinitial VARCHAR(1), 
 IN lastname VARCHAR(55), 
 IN socialnumb CHAR(11),
 IN emailid VARCHAR(45), 
 IN phonenumb CHAR(12), 
 IN streetaddr VARCHAR(100), 
 IN ct VARCHAR(45), 
 IN st VARCHAR(2), 
 IN zipcode CHAR(5), 
 IN gpa DECIMAL(3,2), 
 IN sat INT, 
 IN degree VARCHAR(100), 
 IN interest VARCHAR(45))

BEGIN


/* For inquire tab functionality:  SSN doesnot exist - new user */

 if socialnumb not in (select SSN from tblStudent) then 

   INSERT INTO tblUser (password,tblRole_roleID) VALUES(0000,3); 

   insert into tblStudent (SSN, fName, mInitial, lName, strAddress, city, state, zip, email, phone, SAT, GPA, tblUser_userID)
   values (socialnumb, firstname , midinitial, lastname, streetaddr, ct, st, zipcode, emailid, phonenumb, sat, gpa, Last_Insert_id()) ;

   UPDATE tblUser SET password=(SELECT RIGHT(SSN,4) from tblStudent where tblUser_userID = Last_Insert_id()) WHERE userID=Last_Insert_id();

   update tblStudent set inStateFlag = 0 where state = 'NC';


end if;


/* For Inquire tab functionaltiy: SSN exists (Existing user) and new user  */
	select distinct
		Last_Insert_id() as userID
	from
		ais.tblUser;

	SELECT 
		SSN,
		fName,
		mInitial,
		lName,
		strAddress,
		city,
		state,
		zip,
		email,
		phone,
		SAT,
		GPA
	FROM
		tblStudent
	WHERE
		SSN = socialnumb;

   REPLACE INTO ais.tblInquireApply (inquireFlag, tblStudent_SSN, termApplied, tblDegreeProgram_degreeName) 
	VALUES (1, socialnumb, termapplied, degree);

	SELECT 
		degreeName, InfoMessage
	FROM
		ais.tblDegreeProgram
	WHERE
		degreeName = degree 
	UNION SELECT 
		CollegeLifeName, collegeLifeInfoMessage
	FROM
		ais.tblCollegeLife
	WHERE
		CollegeLifeName = interest;
  
END $$

DELIMITER ;


-- -------------------------------------

/***************************************************************************
* Name:		setParameter
* Purpose: 	To set the parameters for each term by the admin
* Inputs:	termapplied,gpaweight,satweight,outofstateweight,gpathreshold,satthreshold.
* Usage: 	CALL AIS.setParameter ('Spring 2014', 20, 20, 20, 4.00, 1800);
***************************************************************************/


DELIMITER $$

/* create procedure setParameter */
CREATE procedure AIS.setParameter  (
  IN termapplied VARCHAR(15), 
  IN gpaweight TINYINT, 
  IN satweight TINYINT, 
  IN outofstateweight TINYINT, 
  IN gpathreshold DECIMAL(3,2), 
  IN satthreshold INT)
BEGIN
 UPDATE AIS.tblParameter SET GPAWeight = gpaweight, SATWeight = satweight, 
 OutOfStateWeight = outofstateweight, SATThreshold = satthreshold, GPAThreshold = gpathreshold
 where tblTerm_termName = termapplied;
END $$

DELIMITER ;

-- --------------------------------------- 

/***************************************************************************
* Name:		setAccept
* Purpose: 	To provide with functionality to accept students 
* Inputs:	SSN, term, degreeName
* Usage: 	CALL AIS.setAccept ('365-968-241','Spring 2014','Biological Sciences');
***************************************************************************/

use ais;


drop procedure if exists setAccept;

DELIMITER $$

create procedure setAccept (in SSN char(11), term varchar(15), degreeName varchar(100))
begin 

-- update tblinquireapply set applicationstatus 
update tblinquireapply as ia 
set 
    ia.applicationStatus = 'Accept'
where ia.tblStudent_SSN = SSN
        and ia.tblDegreeProgram_degreeName =  degreeName; 

END $$

DELIMITER ;

-- ---------------------------------------------
/***************************************************************************
* Name:		setDeny
* Purpose: 	To provide with functionality for students to deny
* Inputs:	SSN, term, degreeName
* Usage: 	CALL AIS.setAccept ('365-968-241','Spring 2014','Biological Sciences');
***************************************************************************/

drop procedure if exists setDeny;

DELIMITER $$

create procedure setDeny (in SSN char(11), term varchar(15), degreeName varchar(100))
begin 

-- update tblinquireapply set applicationstatus 
update tblinquireapply as ia  
set 
    ia.applicationStatus = 'Denied'
where
    ia.tblStudent_SSN = SSN
        and ia.tblDegreeProgram_degreeName = degreeName; 

END $$

DELIMITER ; 


-- ---------------------------------------------
/***************************************************************************
* Name:		getStudentDetail
* Purpose: 	To provide with functionality for students to deny
* Inputs:	SSN, term, degreeName
* Usage: 	CALL AIS.getStudentDetail ('Spring 2015','Anthropology');
***************************************************************************/

drop procedure if exists getStudentDetail;

DELIMITER $$
create procedure getStudentDetail (term varchar(15), degreeName varchar(15)) 
begin 


-- Create a temp table for applied students with ApplyFlg = yes and ApplicationStatus = Null 
--  and the matching availableDegreeProgramsID 
create temporary table if not exists 
	tempapplied 
engine=myISAM as 
(select 
    via.SSN,
    via.fName,
    via.lName,
    via.strAddress,
    via.city,
    via.state,
    via.zip,
    via.applicationStatus,
    via.applyFlag,
    via.inquireFlag,
    via.termApplied,
    via.degreeName,
    vs.GPA,
    vs.SAT,
    vs.inStateFlag,
    sa.seatsAvailable
from
    vinquireapply as via
        inner join
    vstudent as vs ON via.SSN = vs.SSN
        inner join
    vseatsavailable as sa ON sa.tblDegreeProgram_degreeName = via.degreeName
        and sa.tblTerm_termName = via.termApplied
where
    via.applyFlag = 1 
        and via.applicationStatus is null
        and via.degreeName = degreeName); 


-- Check if there is room in each Program / Term.  Count of current should not be more than the max seats available 
create temporary table if not exists 
	tempfull
engine=myISAM as 
(select 
    count(distinct SSN) as countStudents,
    seatsAvailable,
    termApplied,
    degreeName
from tempapplied 
where applicationStatus = 'Accept'
group by seatsAvailable,
		 termApplied,
		 degreeName
having count(distinct SSN) >= seatsAvailable );


-- output 
select 
    ta.SSN,
    ta.fName,
    ta.lName,
    ta.GPA,
    ta.SAT,
    ta.inStateFlag,
    (vp.GPAWeight * ta.GPA) + (vp.SATWeight * ta.SAT) + (vp.OutOfStateWeight * ta.inStateFlag) as desirabilitymetric
from
    vparameter as vp
        inner join
    tempapplied as ta ON vp.tblTerm_termName = ta.termApplied 
	left join tempfull as tf on tf.termApplied = ta.termApplied 
							and tf.degreeName = ta.degreeName 
where
    ta.GPA >= vp.GPAThreshold
        and ta.SAT >= vp.SATThreshold
		and tf.countStudents <= tf.seatsAvailable; 



END $$ 

DELIMITER ; 

-- ------------------------------------

/***************************************************************************
* Name:		getLogin
* Purpose: 	To provide with functionality for students login application
* Inputs:	IN_userID, IN_passwd 
* Usage: 	call ais.getLogin (2, '-111');
***************************************************************************/

DROP PROCEDURE IF EXISTS getLogin;


/*Alter table tblUser CHANGE password passwd CHAR(4);*/

DELIMITER $$

/* create procedure getLogin */
CREATE PROCEDURE AIS.getLogin (
 IN IN_userID INT, 
 IN IN_passwd CHAR(4))

 

BEGIN

 /*Authenticate the user with userid and password then pick his roleID for further lookUp*/
 select count(tblRole_roleID) into @roleID  from tblUser where userID = IN_userID and passwd = IN_passwd;

     /*If Login successful roleID is 'not null' else return 'false' and come out of if*/
  if(@roleID = 1) then

		select tblRole_roleID into @roleID  from tblUser where userID = IN_userID and passwd = IN_passwd;
		/*lookup role table with current role ID */
		select tr.roleName into @role  from tblRole tr where tr.roleID = @roleID;

		SELECT @role;

		/* if role name is either 'Admin','Administrator' return Admin details */
		if(@role in ('Admin','Administrator')) then
		 select 
				'null' as fName,
				'null' as mInitial,
				'null' as lName,
				'null' as strAddress,
				'null' as city,
				'null' as state,
				'null' as zip,
				'null' as inStateFlag,
				'null' as email,
				'null' as phone,
				'null' as tblUser_userID,
				'null' as SSN,
				'null' as SAT,
				'null' as GPA,
				'null' as termApplied,
				'null' as tblDegreeProgram_degreeName,
				'true' as isAdminFlag;
		else
		/* if role is 'Student' then return student details including his degree and term from EnquireApplyTable*/
		 select 
				fName,
				mInitial,
				lName,
				strAddress,
				city,
				state,
				zip,
				inStateFlag,
				email,
				phone,
				tblUser_userID,
				SSN,
				SAT,
				GPA,
				tbI.termApplied,
				tbI.tblDegreeProgram_degreeName,
				'false' as isAdminFlag
		from 
				tblStudent tbS,tblinquireapply tbI 
		where 
				tblUser_userID = IN_userID 
				and 
				tbS.SSN = tbI.tblStudent_SSN;
		  
		end if;

  else
   select 'User Login Failed';

 end if;

 
END $$

DELIMITER ;

-- ------------------------------- 
/***************************************************************************
* Name:		setApply
* Purpose: 	To provide with functionality for students to apply
* Inputs:	IN_SSN,IN_fName,IN_mInitial,IN_lName,IN_strAddr,IN_City,IN_State,IN_zip,IN_email,
*			IN_phoneNum,IN_SAT,IN_GPA,IN_collegeLifeName,IN_termName,IN_degreeName
* Usage: 	call ais.setApply ('111-111-777', 'Krishna', 'L', 'Chaitanya', 'Clories Road', 'Clevland', 'OH', '38943', 
			'chaitanya@uncc.edu', '454-465-8499', 2340, 2.75,'Health','Spring 2014','Computer Science');

***************************************************************************/

DROP PROCEDURE IF EXISTS setApply;



DELIMITER $$

/* create procedure setApply */
CREATE PROCEDURE AIS.setApply (
 IN IN_SSN CHAR(11),
 IN IN_fName VARCHAR(45), 
 IN IN_mInitial VARCHAR(1), 
 IN IN_lName VARCHAR(55), 
 IN IN_strAddr VARCHAR(100),
 IN IN_City VARCHAR(45), 
 IN IN_State VARCHAR(2), 
 IN IN_zip CHAR(5),  
 IN IN_email VARCHAR(45), 
 IN IN_phoneNum CHAR(12), 
 IN IN_SAT int(11),
 IN IN_GPA DECIMAL(3,2),   
 IN IN_collegeLifeName VARCHAR(45), 
 IN IN_termName VARCHAR(15),
 IN IN_degreeName VARCHAR(100)
)

 

BEGIN

/* USER APPLIES FIRST TIME WITHOUT ENQUIRE OR LOGIN */
if IN_SSN not in (select SSN from tblStudent) then

   insert into tblUser (password,tblRole_roleID) values (0000,3);
   insert into ais.tblStudent (SSN, fName, mInitial, lName, strAddress, city, state, zip, email, phone, SAT, GPA, tblUser_userID)
   values (IN_SSN, IN_fName , IN_mInitial, IN_lName, IN_strAddr, IN_City, IN_State, IN_zip, IN_email, IN_phoneNum, IN_SAT, IN_GPA, Last_Insert_id());

UPDATE tblUser 
SET 
    password = (SELECT 
            RIGHT(SSN, 4)
        from
            tblStudent
        where
            tblUser_userID = Last_Insert_id())
WHERE
    userID = Last_Insert_id();

update tblStudent 
set 
    inStateFlag = 1
where
    state = 'NC';
   
 end if;
/* END CREATION OF USER IN USER TABLE AND STUDENT TABLE  AND THEIR MAPPING*/


SELECT 
    SSN,
    fName,
    mInitial,
    lName,
    strAddress,
    city,
    state,
    zip,
    email,
    phone,
    SAT,
    GPA,
    tblUser_userID
FROM
    ais.tblStudent
WHERE
    SSN = IN_SSN;
  
/* IF THERE EXISTS A USER WHO HAS ALREADY APPLIED FOR THE DEGREE AND TERM COMBINATION */
	select 
    count(*)
into @isApplied from
    tblInquireApply
where
    tblStudent_SSN = IN_SSN
        and tblDegreeProgram_degreeName = IN_degreeName
        and termApplied = IN_termName
        and applyFlag = 1;

	
	if(@isApplied = 1) then
		
	select "already applied";
					
	else
	/* INSERT OR UPDATE IF USER HAS NOT APPLIED ALREADY */
		REPLACE INTO ais.tblInquireApply (applyFlag, tblStudent_SSN, termApplied, tblDegreeProgram_degreeName) VALUES (1, IN_SSN, IN_termName, IN_degreeName);

	end if;

    /* SELECT THE OTHER DETAILS REQUIRED FOR OUTPUT ON SCREEN */
	SELECT 
    degreeName, InfoMessage
FROM
    ais.tblDegreeProgram
WHERE
    degreeName = IN_degreeName 
UNION SELECT 
    CollegeLifeName, collegeLifeInfoMessage
FROM
    ais.tblCollegeLife
WHERE
    CollegeLifeName = IN_collegeLifeName;		

 
END $$

DELIMITER ;

