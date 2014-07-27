using MySql.Data.MySqlClient;
using System;
using System.Data;

namespace AdmissionsInformationSystem.Data
{
	public static class Database
	{
		public static string ConnectionString { get; set; }

		public static DataTable Proc(string prodedure, params MySqlParameter[] parameters)
		{
			return Execute<DataTable>(prodedure, command => {
				command.CommandType = CommandType.StoredProcedure;
				using(MySqlDataAdapter adapter = new MySqlDataAdapter(command))
				{
					DataTable table = new DataTable();
					adapter.Fill(table);
					return table;
				}
			}, parameters);
		}

		public static DataTable Query(string sql, params MySqlParameter[] parameters)
		{
			return Execute<DataTable>(sql, command => {
				using(MySqlDataAdapter adapter = new MySqlDataAdapter(command))
				{
					DataTable table = new DataTable();
					adapter.Fill(table);
					return table;
				}
			}, parameters);
		}

		public static int NonQuery(string sql, params MySqlParameter[] parameters)
		{
			return Execute<int>(sql, command => { return command.ExecuteNonQuery(); }, parameters);
		}

		public static object Scalar(string sql, params MySqlParameter[] parameters)
		{
			return Execute<object>(sql, command => { return command.ExecuteScalar(); }, parameters);
		}

		private static T Execute<T>(string sql, Func<MySqlCommand, T> query, params MySqlParameter[] parameters)
		{
			using(MySqlConnection connection = new MySqlConnection(ConnectionString))
			{
				connection.Open();
				using(MySqlCommand command = new MySqlCommand(sql, connection))
				{
					if(parameters != null && parameters.Length > 0)
					{
						command.Parameters.AddRange(parameters);
					}

					using(MySqlTransaction transaction = connection.BeginTransaction(IsolationLevel.ReadCommitted))
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
