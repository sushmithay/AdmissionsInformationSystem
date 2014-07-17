using AdmissionsInformationSystem.Context;
using AdmissionsInformationSystem.Model;
using AdmissionsInformationSystem.Patterns;
using System;
using System.Collections.ObjectModel;
using System.Windows;
using System.Windows.Input;

namespace AdmissionsInformationSystem.ViewModel
{
	public class MainWindowViewModel : ViewModelBase
	{
		public InquiryWorkspaceViewModel InquiryWorkspace { get; private set; }
		public StudentWorkspaceViewModel StudentWorkspace { get; private set; }
		public AdminWorkspaceViewModel AdminWorkspace { get; private set; }

		private IContext<Student> Students;
		private IContext<Parameter> Parameters;
		private IContext<CollegeLife> CollegeLife;
		private IContext<DegreeProgram> DegreePrograms;

		public MainWindowViewModel(
			IContext<Student> studentContext,
			IContext<Parameter> adminContext,
			IContext<CollegeLife> collegeLife,
			IContext<DegreeProgram> degreePrograms)
		{
			if(studentContext == null)
			{
				throw new ArgumentNullException("studentContext");
			}

			if(adminContext == null)
			{
				throw new ArgumentNullException("adminContext");
			}

			if(collegeLife == null)
			{
				throw new ArgumentNullException("collegeLife");
			}

			if(degreePrograms == null)
			{
				throw new ArgumentNullException("degreePrograms");
			}

			Students = studentContext;
			Parameters = adminContext;
			CollegeLife = collegeLife;
			DegreePrograms = degreePrograms;

			ObservableCollection<StudentViewModel> students = new ObservableCollection<StudentViewModel>();
			foreach(Student student in studentContext.Items)
			{
				students.Add(new StudentViewModel(student, studentContext));
			}

			ObservableCollection<ParameterViewModel> parameters = new ObservableCollection<ParameterViewModel>();
			foreach(Parameter parameter in adminContext.Items)
			{
				parameters.Add(new ParameterViewModel(parameter, adminContext));
			}

			ObservableCollection<string> interests = new ObservableCollection<string>();
			foreach(CollegeLife life in collegeLife.Items)
			{
				interests.Add(life.Name);
			}

			ObservableCollection<string> degrees = new ObservableCollection<string>();
			foreach(DegreeProgram degree in degreePrograms.Items)
			{
				degrees.Add(degree.Name);
			}

			InquiryWorkspace = new InquiryWorkspaceViewModel(studentContext, interests, degrees);
			StudentWorkspace = new StudentWorkspaceViewModel(students, studentContext);
			AdminWorkspace = new AdminWorkspaceViewModel(parameters, adminContext);

			SaveCommand = new DelegateCommand(o => Save());
			LoginCommand = new DelegateCommand(o => Login());
		}

		public ICommand SaveCommand { get; private set; }
		public ICommand LoginCommand { get; private set; }

		public override void Save()
		{
			Students.Save();
			MessageBox.Show("Data saved successfully.");
		}

		public void Login()
		{
			MessageBox.Show("Login dialog");
		}
	}
}
