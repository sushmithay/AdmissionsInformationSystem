using AdmissionsInformationSystem.Model;
using System;
using System.Data.Objects;

namespace AdmissionsInformationSystem.Context
{
	public interface IStudentContext : IDisposable
	{
		IObjectSet<Student> Students { get; }

		void Save();

		T Create<T>() where T : class;
	}
}
