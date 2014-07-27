using MySql.Data.MySqlClient;
using System;
using System.Data;

namespace AdmissionsInformationSystem.Model
{
	public class Parameter
	{
		public decimal GPAThreshold { get; set; }
		public int SATThreshold { get; set; }
		public decimal GPAWeight { get; set; }
		public decimal SATWeight { get; set; }
		public decimal OutOfStateWeight { get; set; }
		public string Term { get; set; }

		public Parameter()
		{

		}

		public Parameter(DataRow row)
		{
			GPAWeight = Convert.ToDecimal(row["GPAWeight"]) / 100;
			SATWeight = Convert.ToDecimal(row["SATWeight"]) / 100;
			GPAThreshold = Convert.ToDecimal(row["GPAThreshold"]);
			SATThreshold = Convert.ToInt32(row["SATThreshold"]);
			OutOfStateWeight = Convert.ToDecimal(row["outOfStateWeight"]) / 100;
		}

		public static implicit operator MySqlParameter[](Parameter parameter)
		{
			return new[] { 
				new MySqlParameter("gpaweight", parameter.GPAWeight * 100),
				new MySqlParameter("satweight", parameter.SATWeight * 100),
				new MySqlParameter("gpathreshold", parameter.GPAThreshold),
				new MySqlParameter("satthreshold", parameter.SATThreshold),
				new MySqlParameter("outofstateweight", parameter.OutOfStateWeight * 100),
				new MySqlParameter("termapplied", parameter.Term),
			};
		}
	}
}
