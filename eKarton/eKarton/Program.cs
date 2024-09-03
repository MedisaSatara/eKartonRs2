using eKarton;
using eKarton.Filters;
using eKarton.Service.Databases;
using eKarton.Service.RabbitMQ;
using eKarton.Service.Services;
using eKarton.Service.UputniceStateMachine;
using Microsoft.AspNetCore.Authentication;
using Microsoft.EntityFrameworkCore;
using Microsoft.OpenApi.Models;
using Newtonsoft.Json.Serialization;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddTransient<IAdministratorService, AdministratorService>();
builder.Services.AddTransient<IBolnicaService, BolnicaService>();
builder.Services.AddTransient<IKorisnikService, KorisnikService>();
builder.Services.AddTransient<IDoktorService, DoktorService>();
builder.Services.AddTransient<IPacijentService, PacijentService>();
builder.Services.AddTransient<IOdjelService, OdjelService>();
builder.Services.AddTransient<IPreventivneMjere, PreventivneMjereService>();
builder.Services.AddTransient<IOsiguranjeService, OsiguranjeService>();
builder.Services.AddTransient<ITerminService, TerminService>();
builder.Services.AddTransient<IPacijentOsiguranjeService, PacijentOsiguranjeService>();
builder.Services.AddTransient<IPacijentOboljenjeService, PacijentOboljenjeService>();
builder.Services.AddTransient<INalazService, NalazService>();
builder.Services.AddTransient<IUputnicaService, UputnicaService>();
builder.Services.AddTransient<IPregledService, PregledService>();
builder.Services.AddTransient<ITerapijaService, TerapijaService>();
builder.Services.AddSingleton<IMailProducer, MailProducer>();


builder.Services.AddTransient<BaseDoktorState>();
builder.Services.AddTransient<InitialDoktorState>();
builder.Services.AddTransient<DraftDoktorState>();
builder.Services.AddTransient<ActiveDoktorState>();

builder.Services.AddSingleton<IHttpContextAccessor, HttpContextAccessor>();



// Add services to the container.
builder.Services.AddControllers()
    .AddNewtonsoftJson(options =>
    {
        options.SerializerSettings.ContractResolver = new Newtonsoft.Json.Serialization.DefaultContractResolver();
    });

builder.Services.AddControllers(x =>
{
    x.Filters.Add<ErrorFilter>();
});
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    c.AddSecurityDefinition("basicAuth", new Microsoft.OpenApi.Models.OpenApiSecurityScheme()
    {
        Type = Microsoft.OpenApi.Models.SecuritySchemeType.Http,
        Scheme = "basic"
    });

    c.AddSecurityRequirement(new Microsoft.OpenApi.Models.OpenApiSecurityRequirement()
    {
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference{Type = ReferenceType.SecurityScheme, Id = "basicAuth"}
            },
            new string[]{}
    } });

});

var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
builder.Services.AddDbContext<eKartonContext>(options => options.UseSqlServer(connectionString));

builder.Services.AddAutoMapper(typeof(IKorisnikService));
builder.Services.AddAuthentication("BasicAuthentication")
    .AddScheme<AuthenticationSchemeOptions, BasicAuthenticationHandler>("BasicAuthentication", null);

builder.Services.AddControllers().AddNewtonsoftJson(options =>
{
    options.SerializerSettings.ContractResolver = new DefaultContractResolver
    {
        NamingStrategy = new CamelCaseNamingStrategy()
    };
    options.SerializerSettings.ReferenceLoopHandling = Newtonsoft.Json.ReferenceLoopHandling.Ignore;
});



var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

app.Run();
