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
    state = 'nc';
   
 end if;
/* END CREATION OF USER IN USER TABLE AND STUDENT TABLE  AND THEIR MAPPING*/

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
	SELECT Last_Insert_id() AS UserName, RIGHT(IN_SSN, 4) AS UserPassword;

END $$

DELIMITER ;
