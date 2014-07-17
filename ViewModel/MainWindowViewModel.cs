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

		public MainWindowViewModel(IContext<Student> studentContext, IContext<Parameter> adminContext)
		{
			if(studentContext == null)
			{
				throw new ArgumentNullException("studentContext");
			}

			if(adminContext == null)
			{
				throw new ArgumentNullException("adminContext");
			}

			Students = studentContext;
			Parameters = adminContext;

			ObservableCollection<StudentViewModel> students = new ObservableCollection<StudentViewModel>();
			foreach(Student student in studentContext.Items)
			{
				students.Add(new StudentViewModel(student, studentContext));
			}

			InquiryWorkspace = new InquiryWorkspaceViewModel(studentContext);
			StudentWorkspace = new StudentWorkspaceViewModel(students, studentContext);
			AdminWorkspace = new AdminWorkspaceViewModel(adminContext);

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
