using AdmissionsInformationSystem.Model;
using System;

namespace AdmissionsInformationSystem.ViewModel
{
	public class AcceptDenyViewModel : ViewModelBase
	{
		private Approvals student;
		public Approvals Model()
		{
			return student;
		}

		public void UpdateModel(Approvals model)
		{
			student = model;
			OnPropertyChanged("SocialSecurityNumber");
			OnPropertyChanged("FirstName");
			OnPropertyChanged("LastName");
			OnPropertyChanged("GPA");
			OnPropertyChanged("SAT");
            OnPropertyChanged("DesirabilityMetric");
		}

		public AcceptDenyViewModel(Approvals student)
		{
			if(student == null)
			{
				throw new ArgumentNullException("student");
			}
			this.student = student;
		}

		public override void Save()
		{
			throw new NotImplementedException();
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

        public float DesirabilityMetric
        {
            get
            {
                return student.DesirabilityMetric;
            }
            set
            {
                student.DesirabilityMetric = value;
                OnPropertyChanged("DesirabilityMetric");
            }
        }

		public bool Selected { get; set; }
	}
}
