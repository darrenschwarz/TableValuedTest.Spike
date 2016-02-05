using System;
using System.Data;
using System.Data.SqlClient;
using NUnit.Framework;

namespace TableValuedTest.Spike
{
    [TestFixture]
    public class DataTableSpike
    {
        [Test]
        public void DataTableTest()
        {
            var connectionString = ConfigurationManager.ConnectionStrings.GetConnectionString("TableValuedTest");

            using (var sqlConnection = new SqlConnection(connectionString))
            {
                sqlConnection.Open();

                var staffIds = GetTestStaffIds();

                var searchStaffIdsCommand = new SqlCommand("usp_SearchStaffIds", sqlConnection);
                searchStaffIdsCommand.CommandType = CommandType.StoredProcedure;

                var projectUidParam = searchStaffIdsCommand.Parameters.AddWithValue("@ProjectUID", 1);
                projectUidParam.SqlDbType = SqlDbType.Int;

                var tvpParam = searchStaffIdsCommand.Parameters.AddWithValue("@TvpStaffIDS", staffIds);
                tvpParam.SqlDbType = SqlDbType.Structured;

                var sqlDataReader = searchStaffIdsCommand.ExecuteReader();

                while (sqlDataReader.Read())
                {
                    Console.WriteLine("{0}\t{1}\t{2}\t{3}\t{4}\t{5}\t{6}\t{7}\t{8}\t{9}\t{10}",
                        sqlDataReader.GetInt32(0),
                        sqlDataReader.GetString(1),
                        sqlDataReader.GetString(2),
                        sqlDataReader.GetString(3),
                        sqlDataReader.GetString(4),
                        sqlDataReader.GetString(5),
                        sqlDataReader.GetString(6),
                        sqlDataReader.GetString(7),
                        sqlDataReader.GetString(8),
                        sqlDataReader.GetString(9),
                        sqlDataReader.GetString(10));
                }

                sqlDataReader.Close();
            }
        }

        protected static DataTable GetTestStaffIds()
        {
            var table = new DataTable();
            table.Columns.Add("StaffID", typeof(string));

            table.Rows.Add("11111");
            table.Rows.Add("22222");
            table.Rows.Add("33333");
            table.Rows.Add("44444");
            table.Rows.Add("55555");

            return table;
        }
    }
}
