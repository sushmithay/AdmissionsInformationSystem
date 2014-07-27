DROP PROCEDURE IF EXISTS getLogin;

DELIMITER $$

/* create procedure getLogin */
CREATE PROCEDURE AIS.getLogin (
 IN IN_userID INT, 
 IN IN_passwd CHAR(4))

 

BEGIN

 /*Authenticate the user with userid and password then pick his roleID for further lookUp*/
select 
    tblRole_roleID
into @roleID from
    tblUser
where
    userID = IN_userID
        and password = IN_passwd;

   /*If Login successful roleID is 'not null' else return 'false' and come out of if*/
  if(ifnull(@roleID,false)) then

		/*lookup role table with current role ID */
		select 
			tr.roleName
		into @role from
			tblRole tr
		where
			tr.roleID = @roleID;

		/* if role name is either 'Admin','Administrator' return Admin details */
		if(@role in ('Admin','Administrator')) then
		 select * from tblAdmissionClerk where tblUser_userID = IN_userID;
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
			tbI.tblDegreeProgram_degreeName
		from
			tblStudent tbS,
			tblinquireapply tbI
		where
			tblUser_userID = IN_userID
        and tbS.SSN = tbI.tblStudent_SSN;
		  
		end if;

  else
   select 'User Login Failed';

 end if;

 
END $$

DELIMITER ; 