using System;
using System.Data;
using System.Data.OleDb;

namespace AdmissionsInformationSystem.Data
{
	public static class Database
	{
		public static string ConnectionString { get; set; }

		public static DataTable Query(string prodedure, params OleDbParameter[] parameters)
		{
			return Execute<DataTable>(command => {
				using(OleDbDataAdapter adapter = new OleDbDataAdapter(command))
				{
					DataTable table = new DataTable();
					adapter.Fill(table);
					return table;
				}
			}, parameters);
		}

		public static DataTable Proc(string prodedure, params OleDbParameter[] parameters)
		{
			return Execute<DataTable>(command => {
				command.CommandType = CommandType.StoredProcedure;
				using(OleDbDataAdapter adapter = new OleDbDataAdapter(command))
				{
					DataTable table = new DataTable();
					adapter.Fill(table);
					return table;
				}
			}, parameters);
		}

		public static int NonQuery(string sql, params OleDbParameter[] parameters)
		{
			return Execute<int>(command => { return command.ExecuteNonQuery(); }, parameters);
		}

		public static object Scalar(string sql, params OleDbParameter[] parameters)
		{
			return Execute<object>(command => { return command.ExecuteScalar(); }, parameters);
		}

		private static T Execute<T>(Func<OleDbCommand, T> query, params OleDbParameter[] parameters)
		{
			using(OleDbConnection connection = new OleDbConnection(ConnectionString))
			{
				connection.Open();
				using(OleDbCommand command = new OleDbCommand())
				{
					if(parameters != null && parameters.Length > 0)
					{
						command.Parameters.AddRange(parameters);
					}

					command.Connection = connection;
					using(OleDbTransaction transaction = connection.BeginTransaction(IsolationLevel.ReadCommitted))
					{
						command.Transaction = transaction;
						try
						{
							T result = query(command);
							transaction.Commit();
							return result;
						}
						catch(Exception)
						{
							transaction.Rollback();
							throw;
						}
					}
				}
			}
		}
	}
}
