using AdmissionsInformationSystem.Context;
using System;
using System.Collections.ObjectModel;

namespace AdmissionsInformationSystem.ViewModel
{
	public class AdminWorkspaceViewModel : ViewModelBase
	{
		public ObservableCollection<ParameterViewModel> parameters { get; set; }
		public ObservableCollection<string> Terms { get; set; }

		private ParameterContext context;
		private ParameterViewModel currentParameter;
		public ParameterViewModel CurrentParameter
		{
			get
			{
				return currentParameter;
			}
			set
			{
				currentParameter = value;
				OnPropertyChanged("CurrentParameter");
			}
		}

		public AdminWorkspaceViewModel(ObservableCollection<ParameterViewModel> parameters, ParameterContext context)
		{
			if(context == null)
			{
				throw new ArgumentNullException("context");
			}

			if(parameters == null)
			{
				throw new ArgumentNullException("parameters");
			}

			this.context = context;
			this.parameters = parameters;

			if(parameters.Count > 0)
			{
				CurrentParameter = parameters[0];
			}
			else
			{
				CurrentParameter = new ParameterViewModel(context.Create(), context);
			}
		}

		public override void Save()
		{
			context.Update(currentParameter.Model());
		}
	}
}
