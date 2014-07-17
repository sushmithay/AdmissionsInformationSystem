using System.Collections.Generic;

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
		public string Address { get; set; }
		public string InState { get; set; }
		public string Email { get; set; }
		public string PhoneNumber { get; set; }
		public float GPA { get; set; }
		public int SAT { get; set; }
		public List<CollegeLife> Interests { get; set; }
	}
}
