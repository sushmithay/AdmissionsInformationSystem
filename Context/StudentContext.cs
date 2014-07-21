using AdmissionsInformationSystem.Data;
using AdmissionsInformationSystem.Model;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Data;
using System.Data.Objects;
using System.Data.OleDb;
using System.Linq;

namespace AdmissionsInformationSystem.Context
{
	public class StudentContext : IContext<Student>
	{
		public IObjectSet<Student> Items { get; private set; }

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
			throw new NotImplementedException();
		}

		public void Update(Student item, string term)
		{
			Database.Proc("setApply", (item as IEnumerable<OleDbParameter>).Concat(new[] {
				new OleDbParameter("term", term)
			}).ToArray());
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
