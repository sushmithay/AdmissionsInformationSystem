using AdmissionsInformationSystem.Model;
using AdmissionsInformationSystem.Patterns;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Windows;
using System.Windows.Input;

namespace AdmissionsInformationSystem.ViewModel
{
	public class StudentApprovalsViewModel : ViewModelBase
	{
		public ObservableCollection<DegreeProgram> DegreePrograms { get; private set; }
		public List<StudentViewModel> Students { get; private set; }
		public ObservableCollection<StudentViewModel> appliedStudents { get; private set; }
		public ObservableCollection<Term> Terms { get; set; }

		public int SelectedTerm { get; set; }
		public int SelectedProgram { get; set; }

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
		}

		public ICommand GenerateCommand { get; private set; }

		private void Generate()
		{
			appliedStudents = new ObservableCollection<StudentViewModel>(
				from student in Students
				//where
				select student);

			OnPropertyChanged("appliedStudents");
		}
		public ICommand AcceptCommand { get; private set; }

		private void Accept()
		{
			MessageBox.Show("Selected Student applications accepted");
		}

		public ICommand DenyCommand { get; private set; }

		private void Deny()
		{
			MessageBox.Show("Selected Student applications denied");
		}

		public override void Save()
		{
			throw new NotImplementedException(); //add term
		}
	}
}
