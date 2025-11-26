using Npgsql;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Application.Helpers
{
    public interface IQuery
    {
        List<Dictionary<string, object?>> ExecuteReader(string sql, NpgsqlParameter[]? parametros = null);

        int ExecuteNonQuery(string sql, NpgsqlParameter[]? parametros = null);
    }
}
