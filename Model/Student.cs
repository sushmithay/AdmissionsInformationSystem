using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;

namespace AdmissionsInformationSystem.Model
{
	public class Student
	{
		public int Id { get; set; }
		public int Desirability { get; set; }
		public string SocialSecurityNumber { get; set; }
		public string FirstName { get; set; }
		public string MiddleInitial { get; set; }
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
			SocialSecurityNumber = row["SSN"].ToString();
			FirstName = row["fName"].ToString();
			MiddleInitial = row["mInitial"].ToString();
			LastName = row["lName"].ToString();
			StreetAddress = row["strAddress"].ToString();
			City = row["city"].ToString();
			State = row["state"].ToString();
			Zip = row["zip"].ToString();
			Email = row["email"].ToString();
			InState = row["inStateFlag"].ToString();
			PhoneNumber = row["phone"].ToString();
			GPA = Convert.ToSingle(row["GPA"]);
			SAT = Convert.ToInt32(row["SAT"]);
		}

		public static implicit operator MySqlParameter[](Student student)
		{
			return new[] { 
				new MySqlParameter("SSN", student.SocialSecurityNumber),
				new MySqlParameter("fName", student.FirstName),
				new MySqlParameter("mInitial", student.MiddleInitial),
				new MySqlParameter("lName", student.LastName),
				new MySqlParameter("city", student.City),
				new MySqlParameter("state", student.State),
				new MySqlParameter("zip", student.Zip),
				new MySqlParameter("inStateFlag", student.InState),
				new MySqlParameter("email", student.Email),
				new MySqlParameter("phone", student.PhoneNumber),
				new MySqlParameter("SAT", student.SAT),
				new MySqlParameter("GPA", student.GPA)				
			};
		}
	}
}
