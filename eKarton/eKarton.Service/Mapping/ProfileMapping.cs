using AutoMapper;
using eKarton.Model.Request;
using eKarton.Model.Request.SearchObject;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Service.Mapping
{
    public class ProfileMapping : Profile
    {
        public ProfileMapping()
        {

            CreateMap<Databases.Administrator, Model.Models.Administrator>();
            CreateMap<Databases.Bolnica, Model.Models.Bolnica>();

            CreateMap<Databases.Korisnik, Model.Models.Korisnik>();
            CreateMap<KorisnikSearchObject, Databases.Korisnik>();
            CreateMap<KorisnikInsertRequest, Databases.Korisnik>();
            CreateMap<KorisnikUpdateRequest, Databases.Korisnik>();
            CreateMap<Databases.KorisnikUloga, Model.Models.KorisnikUloga>();
            CreateMap<Databases.Uloga, Model.Models.Uloga>();

            CreateMap<Databases.Doktor, Model.Models.Doktor>();
            CreateMap<DoktorSearchObject, Databases.Doktor>();


            CreateMap<Databases.Pacijent, Model.Models.Pacijent>();
            CreateMap<PacijentSearchObject, Databases.Pacijent>();
            CreateMap<PacijentInsertRequest, Databases.Pacijent>();
            CreateMap<PacijentUpdateRequest, Databases.Pacijent>();
            CreateMap<Databases.PacijentOsiguranje, Model.Models.PacijentOsiguranje>();
            CreateMap<Databases.Osiguranje, Model.Models.Osiguranje>();
            CreateMap<Databases.PreventivneMjere, Model.Models.PreventivneMjere>();

            CreateMap<Databases.Odjel, Model.Models.Odjel>();

            CreateMap<PacijentSearchObject, Databases.PreventivneMjere>();
            CreateMap<PacijentInsertRequest, Databases.PreventivneMjere>();
            CreateMap<PacijentUpdateRequest, Databases.PreventivneMjere>();

            CreateMap<PacijentSearchObject, Databases.Osiguranje>();
            CreateMap<PacijentInsertRequest, Databases.Osiguranje>();
            CreateMap<PacijentUpdateRequest, Databases.Osiguranje>();

            CreateMap<Databases.Termin, Model.Models.Termin>();
            CreateMap<TerminSearchObject, Databases.Termin>();
            CreateMap<TerminInsertRequest, Databases.Termin>();
            CreateMap<TerminUpdateRequest, Databases.Termin>();






        }
    }
}
