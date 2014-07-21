using AdmissionsInformationSystem.Context;
using AdmissionsInformationSystem.Model;
using System;

namespace AdmissionsInformationSystem.ViewModel
{
	public class ParameterViewModel : ViewModelBase
	{
		private ParameterContext context;
		private Parameter parameter;
		public Parameter Model()
		{
			return parameter;
		}

		public ParameterViewModel(Parameter parameter, ParameterContext context)
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

		public decimal GPAThreshold
		{
			get
			{
				return decimal.Round(parameter.GPAThreshold, 3);
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

		public decimal GPAWeight
		{
			get
			{
				return decimal.Round(parameter.GPAWeight, 3);
			}
			set
			{
				parameter.GPAWeight = value;
				OnPropertyChanged("GPAWeight");
			}
		}

		public decimal SATWeight
		{
			get
			{
				return decimal.Round(parameter.SATWeight, 3);
			}
			set
			{
				parameter.SATWeight = value;
				OnPropertyChanged("SATWeight");
			}

		}

		public decimal OutOfStateWeight
		{
			get
			{
				return decimal.Round(parameter.OutOfStateWeight, 3);
			}
			set
			{
				parameter.OutOfStateWeight = value;
				OnPropertyChanged("OutOfStateWeight");
			}
		}
	}
}
