using AdmissionsInformationSystem.Context;
using AdmissionsInformationSystem.Model;
using AdmissionsInformationSystem.Patterns;
using System;
using System.Collections.ObjectModel;
using System.Windows.Input;

namespace AdmissionsInformationSystem.ViewModel
{
	public class AdminWorkspaceViewModel : ViewModelBase
	{
		private IContext<Parameter> context;
		private ObservableCollection<ParameterViewModel> parameters;
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

		public AdminWorkspaceViewModel(ObservableCollection<ParameterViewModel> parameters, IContext<Parameter> context)
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
