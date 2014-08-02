using MySql.Data.MySqlClient;
using System;
using System.Data;

namespace AdmissionsInformationSystem.Model
{
	public class Approvals
	{
		public string SocialSecurityNumber { get; set; }
		public string FirstName { get; set; }
		public string LastName { get; set; }
		public string InState { get; set; }
		public float GPA { get; set; }
		public int SAT { get; set; }
		public bool Selected { get; set; }

		public Approvals()
		{

		}

		public Approvals(DataRow row)
		{
			SocialSecurityNumber = row["SSN"].ToString();
			FirstName = row["fName"].ToString();
			LastName = row["lName"].ToString();
			InState = row["inStateFlag"].ToString();
			GPA = Convert.ToSingle(row["GPA"]);
			SAT = Convert.ToInt32(row["SAT"]);
		}

		public static implicit operator MySqlParameter[](Approvals student)
		{
			return new[] { 
				new MySqlParameter("SSN", student.SocialSecurityNumber),
				new MySqlParameter("fName", student.FirstName),				
				new MySqlParameter("lName", student.LastName),				
				new MySqlParameter("inStateFlag", student.InState),				
				new MySqlParameter("SAT", student.SAT),
				new MySqlParameter("GPA", student.GPA)				
			};
		}
	}
}
