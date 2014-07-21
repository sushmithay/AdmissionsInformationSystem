using AdmissionsInformationSystem.Context;
using AdmissionsInformationSystem.Model;
using AdmissionsInformationSystem.Patterns;
using System;
using System.Collections.ObjectModel;
using System.Windows;
using System.Windows.Input;

namespace AdmissionsInformationSystem.ViewModel
{
	public class StudentWorkspaceViewModel : ViewModelBase
	{
		public ObservableCollection<StudentViewModel> Students { get; set; }

		public StudentViewModel currentStudent { get; set; }
		public StudentViewModel CurrentStudent
		{
			get
			{
				return currentStudent;
			}
			set
			{
				currentStudent = value;
				OnPropertyChanged("CurrentStudent");
			}
		}

		public StudentWorkspaceViewModel(ObservableCollection<StudentViewModel> students, StudentContext context)
		{
			if(students == null)
			{
				throw new ArgumentNullException("students");
			}

			Students = students;
			Students.CollectionChanged += (s, o) => {
				if(o.OldItems != null && o.OldItems.Contains(CurrentStudent))
				{
					CurrentStudent = null;
				}
			};

			CurrentStudent = students.Count > 0 ? students[0] : null;

			Add = new DelegateCommand(o => AddStudent());
			Delete = new DelegateCommand(o => DeleteStudent());
			Accept = new DelegateCommand(o => AcceptStudent());
			Deny = new DelegateCommand(o => DenyStudent());
			this.context = context;
		}

		public override void Save()
		{
			throw new NotImplementedException(); //add term
			context.Update(currentStudent.Model(), "term");
		}

		public ICommand Add { get; private set; }
		public ICommand Delete { get; private set; }
		public ICommand Accept { get; private set; }
		public ICommand Deny { get; private set; }

		private StudentContext context;

		private void AddStudent()
		{
			Student student = new Student();
			context.Insert(student);
			CurrentStudent = new StudentViewModel(student, context);
			Students.Add(CurrentStudent);
		}

		private void DeleteStudent()
		{
			if(CurrentStudent != null)
			{
				context.Delete(CurrentStudent.Model());
				Students.Remove(CurrentStudent);
				CurrentStudent = null;
			}
		}

		private void AcceptStudent()
		{
			MessageBox.Show("Student Accepted");
		}

		private void DenyStudent()
		{
			MessageBox.Show("Student Denied");
		}
	}
}
