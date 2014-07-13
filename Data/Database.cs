using System;
using System.Data;
using System.Data.SqlClient;

namespace AdmissionsInformationSystem.Data
{
	public static class Database
	{
		public static string ConnectionString { get; set; }

		public static DataTable Query(string prodedure, CommandType type = CommandType.Text, params SqlParameter[] parameters)
		{
			return Execute<DataTable>(command => {
				command.CommandType = type;
				using(SqlDataAdapter adapter = new SqlDataAdapter(command))
				{
					DataTable table = new DataTable();
					adapter.Fill(table);
					return table;
				}
			}, parameters);
		}

		public static int NonQuery(string sql, params SqlParameter[] parameters)
		{
			return Execute<int>(command => {
				command.CommandType = CommandType.Text;
				return command.ExecuteNonQuery();
			}, parameters);
		}

		public static object Scalar(string sql, params SqlParameter[] parameters)
		{
			return Execute<object>(command => {
				command.CommandType = CommandType.Text;
				return command.ExecuteScalar();
			}, parameters);
		}

		private static T Execute<T>(Func<SqlCommand, T> query, params SqlParameter[] parameters)
		{
			using(SqlConnection connection = new SqlConnection(ConnectionString))
			{
				connection.Open();
				using(SqlCommand command = new SqlCommand())
				{
					if(parameters != null && parameters.Length > 0)
					{
						command.Parameters.AddRange(parameters);
					}

					command.Connection = connection;
					using(SqlTransaction transaction = connection.BeginTransaction(IsolationLevel.ReadCommitted))
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
