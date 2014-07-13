using System;
using System.Collections;
using System.Collections.Generic;
using System.Data.Objects;
using System.Linq;
using System.Linq.Expressions;

namespace AdmissionsInformationSystem.Context
{
	public sealed class FakeObjectSet<T> : IObjectSet<T> where T : class
	{
		private HashSet<T> data;
		private IQueryable query;

		public FakeObjectSet()
		{
			data = new HashSet<T>();
			query = data.AsQueryable();
		}

		public FakeObjectSet(IEnumerable<T> data)
		{
			if(data == null)
			{
				throw new ArgumentNullException("data");
			}

			this.data = new HashSet<T>(data);
			query = data.AsQueryable();
		}

		public void AddObject(T entity)
		{
			if(entity == null)
			{
				throw new ArgumentNullException("entity");
			}

			data.Add(entity);
		}

		public void Attach(T entity)
		{
			AddObject(entity);
		}

		public void DeleteObject(T entity)
		{
			if(entity == null)
			{
				throw new ArgumentNullException("entity");
			}

			data.Remove(entity);
		}

		public void Detach(T entity)
		{
			DeleteObject(entity);
		}

		public IEnumerator<T> GetEnumerator()
		{
			return data.GetEnumerator();
		}

		IEnumerator IEnumerable.GetEnumerator()
		{
			return data.GetEnumerator();
		}

		public Type ElementType
		{
			get { return query.ElementType; }
		}

		public Expression Expression
		{
			get { return query.Expression; }
		}

		public IQueryProvider Provider
		{
			get { return query.Provider; }
		}
	}
}
