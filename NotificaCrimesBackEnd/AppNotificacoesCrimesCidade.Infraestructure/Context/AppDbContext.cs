using AppNotificacoesCrimesCidade.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Infraestructure.Context
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
        {

        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Agressao>().ToTable("agressoes");
            modelBuilder.Entity<Assalto>().ToTable("assaltos");
            modelBuilder.Entity<Ocorrencia>().ToTable("ocorrencias");
            modelBuilder.Entity<LocalizacaoOcorrencia>().ToTable("localizacao_ocorrencia");
            modelBuilder.Entity<TipoBem>().ToTable("tipo_bens");
            modelBuilder.Entity<AssaltoTipoBem>().ToTable("assaltos_tipo_bens");
            modelBuilder.Entity<TipoArma>().ToTable("tipo_armas");

            modelBuilder.Entity<AssaltoTipoBem>()
                .HasKey(ea => new { ea.TipoBemId, ea.AssaltoId });  // Chave primária composta
        }

        public DbSet<Agressao> Agressoes { get; set; }

        public DbSet<Assalto> Assaltos { get; set; }

        public DbSet<Ocorrencia> Ocorrencias { get; set; }

        public DbSet<LocalizacaoOcorrencia> LocalizacaoOcorrencia { get; set; }

        public DbSet<TipoBem> TipoBens { get; set; }

        public DbSet<AssaltoTipoBem> AssaltoTipoBens { get; set; }

        public DbSet<TipoArma> TipoArmas { get; set; }

    }
}
