using AdmissionsInformationSystem.Data;
using AdmissionsInformationSystem.Model;
using System.Data.SqlClient;

namespace AdmissionsInformationSystem.ViewModel
{
	public class InquiryWorkspaceViewModel : ViewModelBase
	{
		public override void Save()
		{
			Database.NonQuery("StoredProcName", new[]{
				new SqlParameter()
			});
		}
	}
}
