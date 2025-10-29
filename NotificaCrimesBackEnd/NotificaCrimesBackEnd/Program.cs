using AppNotificacoesCrimesCidade.Application.Interfaces;
using AppNotificacoesCrimesCidade.Application.Services;
using AppNotificacoesCrimesCidade.CrossCutting.Ioc;
using AppNotificacoesCrimesCidade.Domain.Interfaces;
using AppNotificacoesCrimesCidade.Infraestructure.Context;
using AppNotificacoesCrimesCidade.Infraestructure.Repositories;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddInfraestructure(builder.Configuration);

builder.Services.AddScoped<IUnitOfWork, UnitOfWork>();
builder.Services.AddScoped<IAgressaoService, AgressaoService>();
builder.Services.AddScoped<IServiceFactory, ServiceFactory>();
builder.Services.AddScoped<IAssaltoService, AssaltoService>();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
