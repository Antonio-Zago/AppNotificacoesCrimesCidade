using AppNotificacoesCrimesCidade.Infraestructure.Context;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.IdentityModel.Tokens;
using NetTopologySuite;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace AppNotificacoesCrimesCidade.CrossCutting.Ioc
{
    public static class DependencyInjection
    {
        public static IServiceCollection AddInfraestructure(this IServiceCollection services, IConfigurationManager configuration)
        {
            services.AddAuthorization();

            var secretKey = Environment.GetEnvironmentVariable("JWT_SECRET_KEY_API_CRIMES")
                   ?? throw new ArgumentException("Invalid secret key!!");



            var secretKeyEmail = Environment.GetEnvironmentVariable("EMAIL_SECRET_KEY_API_CRIMES")
                   ?? throw new ArgumentException("Invalid secret key!!");

            services
            .AddFluentEmail("antoniozagodev@gmail.com") // Email de onde envia
            .AddSmtpSender("smtp.gmail.com", 587, "antoniozagodev@gmail.com", secretKeyEmail);

            services.AddAuthentication(options =>
            {
                options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
                options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
            }).AddJwtBearer(options =>
            {
                options.SaveToken = true;
                options.RequireHttpsMetadata = false;
                options.TokenValidationParameters = new TokenValidationParameters()
                {
                    ValidateIssuer = true,
                    ValidateAudience = true,
                    ValidateLifetime = true,
                    ValidateIssuerSigningKey = true,
                    ClockSkew = TimeSpan.Zero,
                    ValidAudience = configuration["JWT:ValidAudience"],
                    ValidIssuer = configuration["JWT:ValidIssuer"],
                    IssuerSigningKey = new SymmetricSecurityKey(
                                       Encoding.UTF8.GetBytes(secretKey))
                };
            });

            var postgresConnection = configuration.GetConnectionString("DefaultConnection");

            services.AddDbContext<AppDbContext>(options => options.UseNpgsql(postgresConnection, o => {
                o.UseNetTopologySuite();
            }));
           
            return services;
        }
    }
}
