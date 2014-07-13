using AdmissionsInformationSystem.Data;
using AdmissionsInformationSystem.Model;
using System;
using System.Collections.Generic;
using System.Data.Objects;
using System.Data.SqlClient;

namespace AdmissionsInformationSystem.Context
{
	public class StudentContext : IStudentContext
	{
		public IObjectSet<Student> Students { get; private set; }

		public StudentContext()
		{
			Students = new FakeObjectSet<Student>();
		}

		public StudentContext(IEnumerable<Student> students)
		{
			if(students == null)
			{
				throw new ArgumentNullException("students");
			}

			Students = new FakeObjectSet<Student>(students);
		}

		public event EventHandler<EventArgs> SaveCalled;
		public event EventHandler<EventArgs> DisposeCalled;

		public T Create<T>() where T : class
		{
			return Activator.CreateInstance<T>();
		}

		public void Save()
		{
			if(SaveCalled != null)
			{
				SaveCalled(this, new EventArgs());
			}

			Database.NonQuery("StoredProcName", new[]{
				new SqlParameter()
			});
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
