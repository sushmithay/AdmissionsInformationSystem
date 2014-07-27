using AdmissionsInformationSystem.Data;
using AdmissionsInformationSystem.Model;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Data.Objects;

namespace AdmissionsInformationSystem.Context
{
	public class ParameterContext : IContext<Parameter>
	{
		public IObjectSet<Parameter> Items { get; private set; }

		public ParameterContext()
		{
			Items = new MySqlObjectSet<Parameter>();
		}

		public ParameterContext(IEnumerable<Parameter> items)
		{
			if(items == null)
			{
				throw new ArgumentNullException("items");
			}

			Items = new MySqlObjectSet<Parameter>();
			foreach(Parameter item in items)
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

		public Parameter Create()
		{
			Parameter item = default(Parameter);

			return item;
		}

		public ObservableCollection<Parameter> Select()
		{
			throw new NotImplementedException();
		}

		public Parameter Select(string term)
		{
			return new Parameter(Database.Proc("getParameter", new[] {
				new MySqlParameter("term", term)
			}).Rows[0]);
		}

		public void Insert(Parameter item)
		{
			throw new NotImplementedException();
		}

		public void Update(Parameter item)
		{
			Database.Proc("setParameter", item);
		}

		public void Delete(Parameter item)
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
