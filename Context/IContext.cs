using System;
using System.Data.Objects;

namespace AdmissionsInformationSystem.Context
{
	public interface IContext<T> : IDisposable where T : class
	{
		IObjectSet<T> Items { get; }

		void Save();
		T Create();
		void Insert(T item);
		void Update(T item);
		void Delete(T item);
	}
}
