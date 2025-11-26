using Microsoft.Extensions.Configuration;
using Npgsql;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Application.Helpers
{
    public class Query : IQuery
    {
        private readonly string _connectionString;

        public Query(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection")
                ?? throw new InvalidOperationException("Connection string 'DefaultConnection' not found.");
        }

        public List<Dictionary<string, object?>> ExecuteReader(string sql, NpgsqlParameter[]? parametros = null)
        {
            var resultados = new List<Dictionary<string, object?>>();

            using var connection = new NpgsqlConnection(_connectionString);
            using var command = new NpgsqlCommand(sql, connection);

            if (parametros  is { Length: > 0 })
                command.Parameters.AddRange(parametros);

            connection.Open();

            using var reader = command.ExecuteReader();
            while (reader.Read())
            {
                var linha = new Dictionary<string, object?>();
                for (int i = 0; i < reader.FieldCount; i++)
                {
                    string nomeColuna = reader.GetName(i);
                    var valor = reader.IsDBNull(i) ? null : reader.GetValue(i);
                    linha[nomeColuna] = valor;
                }
                resultados.Add(linha);
            }

            return resultados;
        }

        public int ExecuteNonQuery(string sql, NpgsqlParameter[]? parametros = null)
        {
            using var connection = new NpgsqlConnection(_connectionString);
            using var command = new NpgsqlCommand(sql, connection);

            if (parametros is { Length: > 0 })
                command.Parameters.AddRange(parametros);

            connection.Open();

            return command.ExecuteNonQuery();
        }
    }
}
