using AdmissionsInformationSystem.Context;
using AdmissionsInformationSystem.Model;
using System;

namespace AdmissionsInformationSystem.ViewModel
{
	public class StudentViewModel : ViewModelBase
	{
		private StudentContext Context;
		private Student student;
		public Student Model()
		{
			return student;
		}

		public void UpdateModel(Student model)
		{
			student = model;
			OnPropertyChanged("SocialSecurityNumber");
			OnPropertyChanged("FirstName");
			OnPropertyChanged("MiddleInitial");
			OnPropertyChanged("LastName");
			OnPropertyChanged("StreetAddress");
			OnPropertyChanged("City");
			OnPropertyChanged("State");
			OnPropertyChanged("Zip");
			OnPropertyChanged("Email");
			OnPropertyChanged("PhoneNumber");
			OnPropertyChanged("GPA");
			OnPropertyChanged("SAT");
		}

		public StudentViewModel(Student student, StudentContext context)
		{
			if(student == null)
			{
				throw new ArgumentNullException("student");
			}

			if(context == null)
			{
				throw new ArgumentNullException("context");
			}

			this.Context = context;
			this.student = student;
		}

		public override void Save()
		{
			Context.Update(student);
		}

		public string SocialSecurityNumber
		{
			get
			{
				return student.SocialSecurityNumber;
			}
			set
			{
				student.SocialSecurityNumber = value;
				OnPropertyChanged("SocialSecurityNumber");
			}
		}

		public string FirstName
		{
			get
			{
				return student.FirstName;
			}
			set
			{
				student.FirstName = value;
				OnPropertyChanged("FirstName");
			}
		}

		public string MiddleInitial
		{
			get
			{
				return student.MiddleInitial;
			}
			set
			{
				student.MiddleInitial = value;
				OnPropertyChanged("MiddleInitial");
			}
		}

		public string LastName
		{
			get
			{
				return student.LastName;
			}
			set
			{
				student.LastName = value;
				OnPropertyChanged("LastName");
			}
		}

		public string StreetAddress
		{
			get
			{
				return student.StreetAddress;
			}
			set
			{
				student.StreetAddress = value;
				OnPropertyChanged("StreetAddress");
			}
		}

		public string City
		{
			get
			{
				return student.City;
			}
			set
			{
				student.City = value;
				OnPropertyChanged("City");
			}
		}

		public string State
		{
			get
			{
				return student.State;
			}
			set
			{
				student.State = value;
				OnPropertyChanged("State");
			}
		}

		public string Zip
		{
			get
			{
				return student.Zip;
			}
			set
			{
				student.Zip = value;
				OnPropertyChanged("Zip");
			}
		}

		public string Email
		{
			get
			{
				return student.Email;
			}
			set
			{
				student.Email = value;
				OnPropertyChanged("Email");
			}
		}

		public string PhoneNumber
		{
			get
			{
				return student.PhoneNumber;
			}
			set
			{
				student.PhoneNumber = value;
				OnPropertyChanged("PhoneNumber");
			}
		}

		public float GPA
		{
			get
			{
				return student.GPA;
			}
			set
			{
				student.GPA = value;
				OnPropertyChanged("GPA");
			}
		}

		public int SAT
		{
			get
			{
				return student.SAT;
			}
			set
			{
				student.SAT = value;
				OnPropertyChanged("SAT");
			}
		}

		public void Set(Term Term, CollegeLife Interest, DegreeProgram Program)
		{
			Context.Term = Term;
			Context.Interest = Interest;
			Context.Program = Program;
		}
	}
}
