using AdmissionsInformationSystem.Data;
using System;
using System.Collections.Generic;
using System.Data.Objects;
using System.Data.SqlClient;

namespace AdmissionsInformationSystem.Context
{
	public class Context<T> : IContext<T> where T : class
	{
		public IObjectSet<T> Items { get; private set; }

		public Context()
		{
			Items = new MySqlObjectSet<T>();
		}

		public Context(IEnumerable<T> items)
		{
			if(items == null)
			{
				throw new ArgumentNullException("items");
			}

			Items = new MySqlObjectSet<T>();
			foreach(T item in items)
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

			Database.NonQuery("StoredProcName", new[]{
				new SqlParameter()
			});
		}

		public T Create()
		{
			T item = default(T);
			Database.NonQuery("StoredProcName", new[]{
				new SqlParameter()
			});
			return item;
		}

		public void Insert(T item)
		{
			Database.NonQuery("StoredProcName", new[]{
				new SqlParameter()
			});
		}

		public void Update(T item)
		{
			Database.NonQuery("StoredProcName", new[]{
				new SqlParameter()
			});
		}

		public void Delete(T item)
		{
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
