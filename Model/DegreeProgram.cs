using System.Data;

namespace AdmissionsInformationSystem.Model
{
	public class DegreeProgram
	{
		public string Name { get; set; }
		public string Description { get; set; }

		public DegreeProgram()
		{

		}

		public DegreeProgram(DataRow row)
		{
			Name = row["degreeName"].ToString();
		}

		public override string ToString()
		{
			return Name;
		}
	}
}
