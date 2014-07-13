namespace AdmissionsInformationSystem.Model
{
	public class Student
	{
		public int Id { get; set; }
		public string SocialSecurityNumber { get; set; }
		public string Name { get; set; }
		public string Address { get; set; }
		public string Email { get; set; }
		public string PhoneNumber { get; set; }
		public float GPA { get; set; }
		public int SAT { get; set; }
	}
}
