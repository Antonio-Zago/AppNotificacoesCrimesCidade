using AppNotificacoesCrimesCidade.Infraestructure.Context;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Extensions.Configuration;
using Microsoft.EntityFrameworkCore;
using NetTopologySuite;


namespace AppNotificacoesCrimesCidade.CrossCutting.Ioc
{
    public static class DependencyInjection
    {
        public static IServiceCollection AddInfraestructure(this IServiceCollection services, IConfigurationManager configuration)
        {
            var postgresConnection = configuration.GetConnectionString("DefaultConnection");

            services.AddDbContext<AppDbContext>(options => options.UseNpgsql(postgresConnection, o => {
                o.UseNetTopologySuite();
            }));
           
            return services;
        }
    }
}
