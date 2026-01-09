using AppNotificacoesCrimesCidade.Application.Interfaces;
using HashidsNet;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Application.Services
{
    public class HashidsPublicIdService : IHashidsPublicIdService
    {
        private readonly Hashids _hashids;
        public HashidsPublicIdService(IConfiguration config)
        {
            var hashId = Environment.GetEnvironmentVariable("SALT_PARA_ID");
            // Salt secreta: defina no appsettings.json
            _hashids = new Hashids(hashId, 8);
        }

        public string ToPublic(int id) => _hashids.Encode(id);

        public int? ToInternal(string publicId)
        {
            var arr = _hashids.Decode(publicId);
            return arr.Length > 0 ? arr[0] : (int?)null;
        }
    }
}
