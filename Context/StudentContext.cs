using AdmissionsInformationSystem.Data;
using AdmissionsInformationSystem.Model;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Data;
using System.Data.Objects;
using System.Linq;

namespace AdmissionsInformationSystem.Context
{
	public class StudentContext : IContext<Student>
	{
		public IObjectSet<Student> Items { get; private set; }
		public Term Term { get; set; }
		public CollegeLife Interest { get; set; }
		public DegreeProgram Program { get; set; }

		public StudentContext()
		{
			Items = new MySqlObjectSet<Student>();
		}

		public StudentContext(IEnumerable<Student> items)
		{
			if(items == null)
			{
				throw new ArgumentNullException("items");
			}

			Items = new MySqlObjectSet<Student>();
			foreach(Student item in items)
			{
				Items.AddObject(item);
			}
		}

		public event EventHandler<EventArgs> SaveCalled;
		public event EventHandler<EventArgs> DisposeCalled;

		public void Save()
		{
			if(SaveCalled != null)
			{
				SaveCalled(this, new EventArgs());
			}
		}

		public Student Create()
		{
			Student item = Activator.CreateInstance<Student>();

			return item;
		}

		public ObservableCollection<Student> Select()
		{
			return new ObservableCollection<Student>(
				from DataRow row in Database.Proc("getStudentInfo").Rows
				select new Student(row));
		}

		public void Insert(Student item)
		{
			throw new NotImplementedException();
		}

		public void Update(Student item)
		{
			Database.Proc("setApply", (new[] {
				new MySqlParameter("IN_SSN", item.SocialSecurityNumber),
				new MySqlParameter("IN_fName", item.FirstName),
				new MySqlParameter("IN_mInitial", item.MiddleInitial ?? "a"),
				new MySqlParameter("IN_lName", item.LastName),
				new MySqlParameter("IN_strAddr", item.StreetAddress ?? "a"),
				new MySqlParameter("IN_City", item.City ?? "a"),
				new MySqlParameter("IN_State", item.State ?? "a"),
				new MySqlParameter("IN_zip", item.Zip ?? "a"),
				new MySqlParameter("IN_email", item.Email),
				new MySqlParameter("IN_phoneNum", item.PhoneNumber ?? "a"),
				new MySqlParameter("IN_SAT", item.SAT),
				new MySqlParameter("IN_GPA", item.GPA),
				new MySqlParameter("IN_collegeLifeName", Interest.Name),
				new MySqlParameter("IN_termName", Term.Name),
				new MySqlParameter("IN_degreeName", Program.Name)
			}));
		}

		public void Delete(Student item)
		{

		}

		public void Dispose()
		{
			if(DisposeCalled != null)
			{
				DisposeCalled(this, new EventArgs());
			}
		}
	}
}
