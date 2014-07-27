using AdmissionsInformationSystem.Context;
using AdmissionsInformationSystem.Model;
using AdmissionsInformationSystem.Patterns;
using System;
using System.Collections.ObjectModel;
using System.Linq;
using System.Windows;
using System.Windows.Input;

namespace AdmissionsInformationSystem.ViewModel
{
	public class MainWindowViewModel : ViewModelBase
	{
		public InquiryWorkspaceViewModel InquiryWorkspace { get; private set; }
		public StudentWorkspaceViewModel StudentWorkspace { get; private set; }
		public AdminWorkspaceViewModel AdminWorkspace { get; private set; }
		public StudentApprovalsViewModel ApprovalsWorkspace { get; private set; }

		private string welcome;
		public string Welcome
		{
			get
			{
				return welcome;
			}
			set
			{
				welcome = value;
				OnPropertyChanged("Welcome");
			}
		}

		private StudentContext Students;
		private ParameterContext Parameters;
		private ObservableCollection<CollegeLife> CollegeLife;
		private ObservableCollection<DegreeProgram> DegreePrograms;
		private ObservableCollection<Term> Terms;

		public MainWindowViewModel(
			StudentContext studentContext,
			ParameterContext adminContext,
			ObservableCollection<CollegeLife> collegeLife,
			ObservableCollection<DegreeProgram> degreePrograms,
			ObservableCollection<Term> terms)
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

			if(terms == null)
			{
				throw new ArgumentNullException("terms");
			}

			Students = studentContext;
			Parameters = adminContext;
			CollegeLife = collegeLife;
			DegreePrograms = degreePrograms;
			Terms = terms;

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

			InquiryWorkspace = new InquiryWorkspaceViewModel(studentContext, collegeLife, degreePrograms, terms);
			StudentWorkspace = new StudentWorkspaceViewModel(students, studentContext);
			AdminWorkspace = new AdminWorkspaceViewModel(parameters, adminContext, terms);
			ApprovalsWorkspace = new StudentApprovalsViewModel(degreePrograms, students.ToList<StudentViewModel>(), terms);

			SaveCommand = new DelegateCommand(o => Save());
		}

		public ICommand SaveCommand { get; private set; }

		public override void Save()
		{
			Students.Save();
			MessageBox.Show("Data saved successfully.");
		}
	}
}
