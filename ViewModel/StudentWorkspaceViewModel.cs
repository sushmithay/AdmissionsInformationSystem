using AdmissionsInformationSystem.Data;
using AdmissionsInformationSystem.Model;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace AdmissionsInformationSystem.ViewModel
{
	public class StudentWorkspaceViewModel : ViewModelBase
	{
		public List<Student> RankedStudents { get; set; }

		public override void Save()
		{
			Database.NonQuery("StoredProcName", new[]{
				new SqlParameter()
			});
		}
	}
}
