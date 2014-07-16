using AdmissionsInformationSystem.Data;
using AdmissionsInformationSystem.Model;
using System;
using System.Data.SqlClient;

namespace AdmissionsInformationSystem.ViewModel
{
	public class StudentViewModel : ViewModelBase
	{
		public Student Model { get; set; }

		public StudentViewModel(Student student)
		{
			if(student == null)
			{
				throw new ArgumentNullException("student");
			}

			Model = student;
		}

		public override void Save()
		{
			Database.NonQuery("StoredProcName", new[]{
				new SqlParameter()
			});
		}

		public string SocialSecurityNumber
		{
			get
			{
				return Model.SocialSecurityNumber;
			}
			set
			{
				Model.SocialSecurityNumber = value;
				OnPropertyChanged("SocialSecurityNumber");
			}
		}

		public string Name
		{
			get
			{
				return Model.Name;
			}
			set
			{
				Model.Name = value;
				OnPropertyChanged("Name");
			}
		}

		public string Address
		{
			get
			{
				return Model.Address;
			}
			set
			{
				Model.Address = value;
				OnPropertyChanged("Address");
			}
		}

		public string Email
		{
			get
			{
				return Model.Email;
			}
			set
			{
				Model.Email = value;
				OnPropertyChanged("Email");
			}
		}

		public string PhoneNumber
		{
			get
			{
				return Model.PhoneNumber;
			}
			set
			{
				Model.PhoneNumber = value;
				OnPropertyChanged("PhoneNumber");
			}
		}

		public float GPA
		{
			get
			{
				return Model.GPA;
			}
			set
			{
				Model.GPA = value;
				OnPropertyChanged("GPA");
			}
		}

		public int SAT
		{
			get
			{
				return Model.SAT;
			}
			set
			{
				Model.SAT = value;
				OnPropertyChanged("SAT");
			}
		}
	}
}
