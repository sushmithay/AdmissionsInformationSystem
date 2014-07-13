using AdmissionsInformationSystem.Model;
using System;
using System.Collections.Generic;
using System.Data.Objects;

namespace AdmissionsInformationSystem.Context
{
	public class FakeStudentContext : IStudentContext
	{
		public IObjectSet<Student> Students { get; private set; }

		public FakeStudentContext()
		{
			Students = new FakeObjectSet<Student>();
		}

		public FakeStudentContext(IEnumerable<Student> students)
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
