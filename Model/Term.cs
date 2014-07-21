using System.Data;

namespace AdmissionsInformationSystem.Model
{
	public class Term
	{
		public string Name { get; set; }

		public Term()
		{

		}

		public Term(DataRow row)
		{
			Name = row["termName"].ToString();
		}
	}
}
