using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;

namespace AdmissionsInformationSystem.Model
{
	public class Student
	{
		public int Id { get; set; }
		public int Desirability { get; set; }
		public string SocialSecurityNumber { get; set; }
		public string FirstName { get; set; }
		public string MiddleName { get; set; }
		public string LastName { get; set; }
		public string StreetAddress { get; set; }
		public string City { get; set; }
		public string State { get; set; }
		public string Zip { get; set; }
		public string Email { get; set; }
		public string PhoneNumber { get; set; }
		public string InState { get; set; }
		public float GPA { get; set; }
		public int SAT { get; set; }
		public List<CollegeLife> Interests { get; set; }

		public Student()
		{

		}

		public Student(DataRow row)
		{
			//Id = Convert.ToDecimal(row[""]);
			//Desirability = Convert.ToDecimal(row[""]);
			SocialSecurityNumber = row["SSN"].ToString();
			FirstName = row["fName"].ToString();
			MiddleName = row["mInitial"].ToString();
			LastName = row["lName"].ToString();
			StreetAddress = row["streetAddress"].ToString();
			City = row["city"].ToString();
			State = row["state"].ToString();
			Zip = row["zip"].ToString();
			Email = row["email"].ToString();
			InState = row["inStateFlag"].ToString();
			PhoneNumber = row["phone"].ToString();
			GPA = Convert.ToSingle(row["GPA"]);
			SAT = Convert.ToInt32(row["SAT"]);
		}

		public static implicit operator OleDbParameter[](Student student)
		{
			return new[] { 
				new OleDbParameter("SSN", student.SocialSecurityNumber),
				new OleDbParameter("fName", student.FirstName),
				new OleDbParameter("mInitial", student.MiddleName),
				new OleDbParameter("lName", student.LastName),
				new OleDbParameter("city", student.City),
				new OleDbParameter("state", student.State),
				new OleDbParameter("zip", student.Zip),
				new OleDbParameter("inStateFlag", student.InState),
				new OleDbParameter("email", student.Email),
				new OleDbParameter("phone", student.PhoneNumber),
				new OleDbParameter("SAT", student.SAT),
				new OleDbParameter("GPA", student.GPA)				
			};
		}
	}
}
