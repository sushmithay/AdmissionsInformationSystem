using AdmissionsInformationSystem.Context;
using AdmissionsInformationSystem.Model;
using AdmissionsInformationSystem.Patterns;
using System;
using System.Collections.ObjectModel;
using System.Windows;
using System.Windows.Input;

namespace AdmissionsInformationSystem.ViewModel
{
	public class InquiryWorkspaceViewModel : ViewModelBase
	{
		public ObservableCollection<string> CollegeLife { get; set; }
		public ObservableCollection<string> DegreePrograms { get; set; }
		private IContext<Student> context;
		private StudentViewModel student;

		public InquiryWorkspaceViewModel(
			IContext<Student> context,
			ObservableCollection<string> collegeLife,
			ObservableCollection<string> degreePrograms)
		{
			if(context == null)
			{
				throw new ArgumentNullException("context");
			}

			if(collegeLife == null)
			{
				throw new ArgumentNullException("collegeLife");
			}

			if(degreePrograms == null)
			{
				throw new ArgumentNullException("degreePrograms");
			}

			CollegeLife = collegeLife;
			DegreePrograms = degreePrograms;
			this.context = context;

			student = new StudentViewModel(context.Create(), context);

			InquireCommand = new DelegateCommand(o => Inquire());
			ApplyCommand = new DelegateCommand(o => Apply());
		}

		public ICommand InquireCommand { get; private set; }
		public ICommand ApplyCommand { get; private set; }

		private void Inquire()
		{
			MessageBox.Show("Inquiry Email");
			Save();
		}

		private void Apply()
		{
			MessageBox.Show("Application Email");
			Save();
		}

		public override void Save()
		{
			student.Save();
		}
	}
}
