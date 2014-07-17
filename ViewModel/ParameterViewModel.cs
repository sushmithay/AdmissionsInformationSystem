using AdmissionsInformationSystem.Context;
using AdmissionsInformationSystem.Model;
using System;

namespace AdmissionsInformationSystem.ViewModel
{
	public class ParameterViewModel : ViewModelBase
	{
		private IContext<Parameter> context;
		private Parameter parameter;
		public Parameter Model()
		{
			return parameter;
		}

		public ParameterViewModel(Parameter parameter, IContext<Parameter> context)
		{
			if(parameter == null)
			{
				throw new ArgumentNullException("parameter");
			}

			if(context == null)
			{
				throw new ArgumentNullException("context");
			}

			this.context = context;
			this.parameter = parameter;
		}

		public override void Save()
		{
			context.Update(parameter);
		}

		public float GPAThreshold
		{
			get
			{
				return parameter.GPAThreshold;
			}
			set
			{
				parameter.GPAThreshold = value;
				OnPropertyChanged("GPAThreshold");
			}
		}

		public int SATThreshold
		{
			get
			{
				return parameter.SATThreshold;
			}
			set
			{
				parameter.SATThreshold = value;
				OnPropertyChanged("SATThreshold");
			}
		}

		public float GPAWeight
		{
			get
			{
				return parameter.GPAWeight;
			}
			set
			{
				parameter.GPAWeight = value;
				OnPropertyChanged("GPAWeight");
			}
		}

		public float SATWeight
		{
			get
			{
				return parameter.SATWeight;
			}
			set
			{
				parameter.SATWeight = value;
				OnPropertyChanged("SATWeight");
			}

		}

		public bool PreferInState
		{
			get
			{
				return parameter.PreferInState;
			}
			set
			{
				parameter.PreferInState = value;
				OnPropertyChanged("PreferInState");
			}
		}

		public string InquiryResponse
		{
			get
			{
				return parameter.InquiryResponse;
			}
			set
			{
				parameter.InquiryResponse = value;
				OnPropertyChanged("InquiryResponse");
			}
		}

		public string ApplicationResponse
		{
			get
			{
				return parameter.ApplicationResponse;
			}
			set
			{
				parameter.ApplicationResponse = value;
				OnPropertyChanged("ApplicationResponse");
			}
		}
	}
}
