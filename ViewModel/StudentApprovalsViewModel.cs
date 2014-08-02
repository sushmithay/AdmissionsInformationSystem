using AdmissionsInformationSystem.Data;
using AdmissionsInformationSystem.Model;
using AdmissionsInformationSystem.Patterns;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Data;
using System.Windows;
using System.Windows.Input;

namespace AdmissionsInformationSystem.ViewModel
{
	public class StudentApprovalsViewModel : ViewModelBase
	{
		public ObservableCollection<DegreeProgram> DegreePrograms { get; private set; }
		public List<StudentViewModel> Students { get; private set; }
		public ObservableCollection<AcceptDenyViewModel> appliedStudents { get; private set; }
		public ObservableCollection<Term> Terms { get; set; }

		public int SelectedTerm { get; set; }
		public int SelectedProgram { get; set; }
		public int SelectedStudents { get; set; }

		public StudentApprovalsViewModel(
			ObservableCollection<DegreeProgram> degreePrograms,
			List<StudentViewModel> students,
			ObservableCollection<Term> terms)
		{
			if(degreePrograms == null)
			{
				throw new ArgumentNullException("degreePrograms");
			}

			if(terms == null)
			{
				throw new ArgumentNullException("terms");
			}
			Terms = terms;
			Students = students;
			DegreePrograms = degreePrograms;
			GenerateCommand = new DelegateCommand(o => Generate());
			AcceptCommand = new DelegateCommand(o => Accept());
			DenyCommand = new DelegateCommand(o => Deny());

			SelectedTerm = 0;
			SelectedProgram = 0;
			SelectedStudents = 0;
		}

		public ICommand GenerateCommand { get; private set; }

		private void Generate()
		{
			returnStudentList();
			OnPropertyChanged("appliedStudents");
		}
		public ICommand AcceptCommand { get; private set; }

		private void Accept()
		{
			foreach(AcceptDenyViewModel student in appliedStudents)
			{
				Database.Proc("setAccept", (new[] {new MySqlParameter("SSN", student.SocialSecurityNumber),new MySqlParameter("term", Terms[SelectedTerm]),
					new MySqlParameter("degreeName", DegreePrograms[SelectedProgram])}));				
			}

			returnStudentList();
			OnPropertyChanged("appliedStudents");
			MessageBox.Show("Selected Student applications accepted");
		}

		public ICommand DenyCommand { get; private set; }

		private void Deny()
		{
			foreach(AcceptDenyViewModel student in appliedStudents)
			{
				Database.Proc("setDeny", (new[] {new MySqlParameter("SSN", student.SocialSecurityNumber),new MySqlParameter("term", Terms[SelectedTerm]),
				new MySqlParameter("degreeName", DegreePrograms[SelectedProgram])}));
			}

			returnStudentList();
			OnPropertyChanged("appliedStudents");
			MessageBox.Show("Selected Student applications denied");
		}

		public override void Save()
		{
			throw new NotImplementedException(); //add term
		}

		private void returnStudentList()
		{
			appliedStudents = new ObservableCollection<AcceptDenyViewModel>();
			DataTable result = Database.Proc("getStudentDetail", (new[] {new MySqlParameter("term", Terms[SelectedTerm].Name),
					new MySqlParameter("degreeName", DegreePrograms[SelectedProgram].Name)}));

			if(result != null && result.Rows.Count > 0)
			{
				for(int i = 0; i < result.Rows.Count; i++)
				{
					DataRow user = result.Rows[i];
					Approvals student = new Approvals(user);
					appliedStudents.Add(new AcceptDenyViewModel(student));
				}
			}
		}
	}
}
