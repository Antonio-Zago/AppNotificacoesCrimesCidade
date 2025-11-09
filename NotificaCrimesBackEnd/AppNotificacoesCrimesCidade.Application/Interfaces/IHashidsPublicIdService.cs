using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Application.Interfaces
{
    public interface IHashidsPublicIdService
    {
        string ToPublic(int id);
        int? ToInternal(string publicId);
    }
}
