using AdmissionsInformationSystem.Context;
using AdmissionsInformationSystem.Data;
using AdmissionsInformationSystem.Model;
using AdmissionsInformationSystem.Patterns;
using MySql.Data.MySqlClient;
using System;
using System.Collections.ObjectModel;
using System.Data;
using System.Linq;
using System.Windows;
using System.Windows.Input;

namespace AdmissionsInformationSystem.ViewModel
{
	public class AdminWorkspaceViewModel : ViewModelBase
	{
		public ObservableCollection<ParameterViewModel> parameters { get; set; }
		public ObservableCollection<Term> Terms { get; set; }

		private int selectedTerm;
		public int SelectedTerm
		{
			get
			{
				return selectedTerm;
			}
			set
			{
				selectedTerm = value;
				UpdateParameter();
			}
		}

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

		public AdminWorkspaceViewModel(
			ObservableCollection<ParameterViewModel> parameters,
			ParameterContext context,
			ObservableCollection<Term> terms)
		{
			if(context == null)
			{
				throw new ArgumentNullException("context");
			}

			if(parameters == null)
			{
				throw new ArgumentNullException("parameters");
			}

			if(terms == null)
			{
				throw new ArgumentNullException("terms");
			}

			Terms = terms;
			this.context = context;
			this.parameters = parameters;

			//if(parameters.Count > 0)
			//{
			//	CurrentParameter = parameters[0];
			//}
			//else
			//{
			//	CurrentParameter = new ParameterViewModel(context.Create(), context);
			//}

			UpdateParameter();
			SaveCommand = new DelegateCommand(o => Save());
		}

		private void UpdateParameter()
		{
			CurrentParameter = new ParameterViewModel(
				(from DataRow row in Database.Proc("getParameter", new[]{
					new MySqlParameter("termapplied", Terms[SelectedTerm].Name) }).Rows
				 select new Parameter(row)).FirstOrDefault(), context);
			CurrentParameter.SetTerm(Terms[SelectedTerm].Name);
		}

		public ICommand SaveCommand { get; private set; }

		public override void Save()
		{
			context.Update(currentParameter.Model());
			MessageBox.Show("Parameters successfully saved.");
		}
	}
}
