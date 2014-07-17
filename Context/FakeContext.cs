using System;
using System.Collections.Generic;
using System.Data.Objects;

namespace AdmissionsInformationSystem.Context
{
	public class FakeContext<T> : IContext<T> where T : class
	{
		public IObjectSet<T> Items { get; private set; }

		public FakeContext()
		{
			Items = new FakeObjectSet<T>();
		}

		public FakeContext(IEnumerable<T> items)
		{
			if(items == null)
			{
				throw new ArgumentNullException("items");
			}

			Items = new FakeObjectSet<T>(items);
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

		public T Create()
		{
			return Activator.CreateInstance<T>();
		}

		public void Insert(T item)
		{
			Items.AddObject(item);
		}

		public void Update(T item)
		{

		}

		public void Delete(T item)
		{
			Items.DeleteObject(item);
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
