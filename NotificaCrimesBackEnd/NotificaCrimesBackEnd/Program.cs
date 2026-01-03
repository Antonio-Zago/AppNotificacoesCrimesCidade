using AppNotificacoesCrimesCidade.Application.Helpers;
using AppNotificacoesCrimesCidade.Application.Interfaces;
using AppNotificacoesCrimesCidade.Application.Mappers;
using AppNotificacoesCrimesCidade.Application.Middlewares;
using AppNotificacoesCrimesCidade.Application.Services;
using AppNotificacoesCrimesCidade.CrossCutting.Ioc;
using AppNotificacoesCrimesCidade.Domain.Interfaces;
using AppNotificacoesCrimesCidade.Infraestructure.Context;
using AppNotificacoesCrimesCidade.Infraestructure.Repositories;
using FirebaseAdmin;
using Google.Apis.Auth.OAuth2;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddInfraestructure(builder.Configuration);

FirebaseApp.Create(new AppOptions()
{
    Credential = GoogleCredential.FromFile("secrets/key.json")
});


builder.Services.AddScoped<IUnitOfWork, UnitOfWork>();
builder.Services.AddScoped<IAgressaoService, AgressaoService>();
builder.Services.AddScoped<IServiceFactory, ServiceFactory>();
builder.Services.AddScoped<IAssaltoService, AssaltoService>();
builder.Services.AddScoped<ITipoArmaService, TipoArmaService>();
builder.Services.AddScoped<ITipoBemService, TipoBemService>();
builder.Services.AddScoped<ILocalizacaoOcorrenciaService, LocalizacaoOcorrenciaService>();
builder.Services.AddScoped<IOcorrenciaService,OcorrenciaService>();
builder.Services.AddScoped<IUsuarioService, UsuarioService>();
builder.Services.AddScoped<IHashidsPublicIdService, HashidsPublicIdService>();
builder.Services.AddScoped<IRouboService, RouboService>();
builder.Services.AddScoped<ITokenService, TokenService>();
builder.Services.AddScoped<ILocalService, LocalService>();
builder.Services.AddScoped(typeof(IMapperBase<,,>), typeof(MapperBase<,,>));
builder.Services.AddTransient<IQuery, Query>();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthentication(); 
app.UseMiddleware<SessionValidationMiddleware>(); 
app.UseAuthorization();

app.MapControllers();

app.Run();
