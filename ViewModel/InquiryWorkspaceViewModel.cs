using AdmissionsInformationSystem.Context;
using AdmissionsInformationSystem.Data;
using AdmissionsInformationSystem.Model;
using AdmissionsInformationSystem.Patterns;
using MySql.Data.MySqlClient;
using System;
using System.Collections.ObjectModel;
using System.Data;
using System.Windows;
using System.Windows.Input;

namespace AdmissionsInformationSystem.ViewModel
{
	public class InquiryWorkspaceViewModel : ViewModelBase
	{
		public ObservableCollection<CollegeLife> CollegeLife { get; set; }
		public ObservableCollection<DegreeProgram> DegreePrograms { get; set; }
		public ObservableCollection<Term> Terms { get; set; }

		public int SelectedTerm { get; set; }
		public int SelectedProgram { get; set; }
		public int SelectedInterest { get; set; }

		private StudentViewModel student;
		public StudentViewModel Student
		{
			get
			{
				return student;
			}
			set
			{
				student = value;
				OnPropertyChanged("Student");
			}
		}

		private IContext<Student> context;

		public InquiryWorkspaceViewModel(
			StudentContext context,
			ObservableCollection<CollegeLife> collegeLife,
			ObservableCollection<DegreeProgram> degreePrograms,
			ObservableCollection<Term> terms)
		{
			if(context == null)
			{
				throw new ArgumentNullException("context");
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

			Terms = terms;
			CollegeLife = collegeLife;
			DegreePrograms = degreePrograms;
			this.context = context;

			SelectedTerm = 0;
			SelectedProgram = 0;
			SelectedInterest = 0;

			Student = new StudentViewModel(context.Create(), context);
			InquireCommand = new DelegateCommand(o => Inquire());
			ApplyCommand = new DelegateCommand(o => Apply());
		}

		public ICommand InquireCommand { get; private set; }
		public ICommand ApplyCommand { get; private set; }

		private void Inquire()
		{
			if(Validate())
			{
				DataTable result = Database.Proc("setInquire2", (new[] {
					new MySqlParameter("socialnumb", Student.SocialSecurityNumber),
					new MySqlParameter("firstname", Student.FirstName),
					new MySqlParameter("midinitial", Student.MiddleInitial ?? "a"),
					new MySqlParameter("lastname", Student.LastName),
					new MySqlParameter("streetaddr", Student.StreetAddress ?? "a"),
					new MySqlParameter("ct", Student.City ?? "a"),
					new MySqlParameter("st", Student.State ?? "a"),
					new MySqlParameter("zipcode", Student.Zip ?? "a"),
					new MySqlParameter("emailid", Student.Email),
					new MySqlParameter("phonenumb", Student.PhoneNumber ?? "a"),
					new MySqlParameter("sat", Student.SAT),
					new MySqlParameter("gpa", Student.GPA),
					new MySqlParameter("interest", CollegeLife[SelectedInterest]),
					new MySqlParameter("termapplied", Terms[SelectedTerm]),
					new MySqlParameter("degree", DegreePrograms[SelectedProgram])
				}));

				string program = Database.Query("SELECT InfoMessage from tbldegreeprogram where degreeName = '" +
					DegreePrograms[SelectedProgram] + "'").Rows[0]["InfoMessage"].ToString();

				string interest = Database.Query("SELECT collegeLifeInfoMessage from tblcollegelife where CollegeLifeName = '" +
					CollegeLife[SelectedInterest] + "'").Rows[0]["collegeLifeInfoMessage"].ToString();

				string collegeLife = "\n\nCollege Life Information\n===================================\n" + interest;
				string degreePrograms = "\n\nDegree Program Information\n===================================\n" + program;
				MessageBox.Show("Thank you for inquiring. Here is some information related to your request." + collegeLife + degreePrograms);
			}
		}

		private void Apply()
		{
			if(Validate())
			{
				DataTable result = Database.Proc("setApply", (new[] {
					new MySqlParameter("IN_SSN", Student.SocialSecurityNumber),
					new MySqlParameter("IN_fName", Student.FirstName),
					new MySqlParameter("IN_mInitial", Student.MiddleInitial ?? ""),
					new MySqlParameter("IN_lName", Student.LastName),
					new MySqlParameter("IN_strAddr", Student.StreetAddress ?? ""),
					new MySqlParameter("IN_City", Student.City ?? ""),
					new MySqlParameter("IN_State", Student.State ?? ""),
					new MySqlParameter("IN_zip", Student.Zip ?? ""),
					new MySqlParameter("IN_email", Student.Email),
					new MySqlParameter("IN_phoneNum", Student.PhoneNumber ?? ""),
					new MySqlParameter("IN_SAT", Student.SAT),
					new MySqlParameter("IN_GPA", Student.GPA),
					new MySqlParameter("IN_collegeLifeName", CollegeLife[SelectedInterest]),
					new MySqlParameter("IN_termName", Terms[SelectedTerm]),
					new MySqlParameter("IN_degreeName", DegreePrograms[SelectedProgram])
				}));
				MessageBox.Show("Thank you for applying. Your application has been sent to the student records administration office for processing.");
			}
		}

		public override void Save()
		{
			if(Validate())
			{
				Student.Save();
			}
		}

		private bool Validate()
		{
			Student.Set(Terms[SelectedTerm], CollegeLife[SelectedInterest], DegreePrograms[SelectedProgram]);

			if(Student.SocialSecurityNumber == null
				|| Student.FirstName == null
				|| Student.LastName == null
				|| Student.Email == null)
			{
				MessageBox.Show("Please fill out all the required fields.");
				return false;
			}
			return true;

			//if(Student.StreetAddress == null)
			//	MessageBox.Show("Please enter a street address");
			//if(Student.City == null)
			//	MessageBox.Show("Please enter a city");
			//if(Student.State == null)
			//	MessageBox.Show("Please enter a state");
			//if(Student.Zip == null)
			//	MessageBox.Show("Please enter a zip code");
			//if(Student.PhoneNumber == null)
			//	MessageBox.Show("Please enter a phone number");
		}
	}
}
