using AdmissionsInformationSystem.Data;
using AdmissionsInformationSystem.Patterns;
using System;
using System.Collections.ObjectModel;
using System.Data.SqlClient;
using System.Windows.Input;

namespace AdmissionsInformationSystem.ViewModel
{
	public class StudentWorkspaceViewModel : ViewModelBase
	{
		public StudentWorkspaceViewModel(ObservableCollection<StudentViewModel> students)
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
		}

		public override void Save()
		{
			Database.NonQuery("StoredProcName", new[]{
				new SqlParameter()
			});
		}

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

		public ICommand Add { get; private set; }
		public ICommand Delete { get; private set; }

		private void AddStudent()
		{

		}

		private void DeleteStudent()
		{

		}
	}
}
