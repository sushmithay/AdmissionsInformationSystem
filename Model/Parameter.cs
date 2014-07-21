using System;
using System.Data;
using System.Data.OleDb;
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
			GPAWeight = Convert.ToDecimal(row["GPAWeight"]);
			SATWeight = Convert.ToDecimal(row["SATWeight"]);
			GPAThreshold = Convert.ToDecimal(row["GPAThreshold"]);
			SATThreshold = Convert.ToInt32(row["SATThreshold"]);
			OutOfStateWeight = Convert.ToDecimal(row["outOfStateWeight"]);
		}

		public static implicit operator OleDbParameter[](Parameter parameter)
		{
			return new[] { 
				new OleDbParameter("GPAWeight", parameter.GPAWeight),
				new OleDbParameter("SATWeight", parameter.SATWeight),
				new OleDbParameter("GPAThreshold", parameter.GPAThreshold),
				new OleDbParameter("SATThreshold", parameter.SATThreshold),
				new OleDbParameter("outOfStateWeight", parameter.OutOfStateWeight),
				new OleDbParameter("term", parameter.Term),
			};
		}
	}
}
