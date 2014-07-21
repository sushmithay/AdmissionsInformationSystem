using System.Data;

namespace AdmissionsInformationSystem.Model
{
	public class CollegeLife
	{
		public string Name { get; set; }
		public string Description { get; set; }

		public CollegeLife()
		{

		}

		public CollegeLife(DataRow row)
		{
			Name = row["collegeLifeName"].ToString();
		}

		public override string ToString()
		{
			return Name;
		}
	}
}
