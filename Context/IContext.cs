using System;
using System.Collections.ObjectModel;
using System.Data.Objects;

namespace AdmissionsInformationSystem.Context
{
	public interface IContext<T> : IDisposable where T : class
	{
		IObjectSet<T> Items { get; }

		void Save();
		T Create();
		ObservableCollection<T> Select();
		void Insert(T item);
		void Update(T item);
		void Delete(T item);
	}
}
