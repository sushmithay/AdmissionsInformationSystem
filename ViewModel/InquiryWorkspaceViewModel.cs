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
		public ObservableCollection<CollegeLife> CollegeLife { get; set; }
		public ObservableCollection<DegreeProgram> DegreePrograms { get; set; }
		public ObservableCollection<Term> Terms { get; set; }
		public StudentViewModel Student;
		private IContext<Student> context;

		public InquiryWorkspaceViewModel(
			StudentContext context,
			ObservableCollection<CollegeLife> collegeLife,
			ObservableCollection<DegreeProgram> degreePrograms)
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

			Student = new StudentViewModel(context.Create(), context);

			InquireCommand = new DelegateCommand(o => Inquire());
			ApplyCommand = new DelegateCommand(o => Apply());
		}

		public ICommand InquireCommand { get; private set; }
		public ICommand ApplyCommand { get; private set; }

		private void Inquire()
		{
			MessageBox.Show("Thank you for inquiring.");
			Save();
		}

		private void Apply()
		{
			MessageBox.Show("Thank you for applying.");
			Save();
		}

		public override void Save()
		{
			Student.Save();
		}
	}
}
