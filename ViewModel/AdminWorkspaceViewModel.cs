using AdmissionsInformationSystem.Context;
using AdmissionsInformationSystem.Data;
using AdmissionsInformationSystem.Model;
using System;
using System.Data.SqlClient;

namespace AdmissionsInformationSystem.ViewModel
{
	public class AdminWorkspaceViewModel : ViewModelBase
	{
		private IContext<Parameter> context;

		public AdminWorkspaceViewModel(IContext<Parameter> context)
		{
			if(context == null)
			{
				throw new ArgumentNullException("context");
			}

			this.context = context;
		}

		public override void Save()
		{
			Database.NonQuery("StoredProcName", new[]{
				new SqlParameter()
			});
		}
	}
}
