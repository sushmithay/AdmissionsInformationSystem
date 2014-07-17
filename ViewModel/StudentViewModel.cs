using AdmissionsInformationSystem.Context;
using AdmissionsInformationSystem.Model;
using System;

namespace AdmissionsInformationSystem.ViewModel
{
	public class StudentViewModel : ViewModelBase
	{
		private IContext<Student> context;
		private Student student;
		public Student Model()
		{
			return student;
		}

		public StudentViewModel(Student student, IContext<Student> context)
		{
			if(student == null)
			{
				throw new ArgumentNullException("student");
			}

			if(context == null)
			{
				throw new ArgumentNullException("context");
			}

			this.context = context;
			this.student = student;
		}

		public override void Save()
		{
			context.Update(student);
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

		public string MiddleName
		{
			get
			{
				return student.MiddleName;
			}
			set
			{
				student.MiddleName = value;
				OnPropertyChanged("MiddleName");
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

		public string Address
		{
			get
			{
				return student.Address;
			}
			set
			{
				student.Address = value;
				OnPropertyChanged("Address");
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
	}
}
