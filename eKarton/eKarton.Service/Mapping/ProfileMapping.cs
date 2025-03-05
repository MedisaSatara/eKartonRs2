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
            CreateMap<KorisnikUlogaSearchObject, Databases.KorisnikUloga>();
            CreateMap<KorisnikUlogaInsertRequest, Databases.KorisnikUloga>();
            CreateMap<KorisnikUlogaUpdateRequest, Databases.KorisnikUloga>();

            CreateMap<Databases.Uloga, Model.Models.Uloga>();

            CreateMap<Databases.Doktor, Model.Models.Doktor>();
            CreateMap<DoktorSearchObject, Databases.Doktor>();
            CreateMap<DoktorInsertRequest, Databases.Doktor>();
            CreateMap<DoktorUpdateRequest, Databases.Doktor>();

            CreateMap<Databases.Pacijent, Model.Models.Pacijent>();
            CreateMap<PacijentSearchObject, Databases.Pacijent>();
            CreateMap<PacijentInsertRequest, Databases.Pacijent>();
            CreateMap<PacijentUpdateRequest, Databases.Pacijent>();
            CreateMap<Databases.PacijentOsiguranje, Model.Models.PacijentOsiguranje>();
            CreateMap<Databases.Osiguranje, Model.Models.Osiguranje>();
            CreateMap<Databases.PreventivneMjere, Model.Models.PreventivneMjere>();

            CreateMap<Databases.Odjel, Model.Models.Odjel>();
            CreateMap<OdjelInsertRequest, Databases.Odjel>();
            CreateMap<OdjelUpdateRequest, Databases.Odjel>();
            CreateMap<Databases.TehnickaPodrska, Model.Models.TehnickaPodrska>();


            CreateMap<PacijentSearchObject, Databases.PreventivneMjere>();
            CreateMap<PreventivneMjereInsertRequest, Databases.PreventivneMjere>();
            CreateMap<PreventivneMjereUpdateRequest, Databases.PreventivneMjere>();

            CreateMap<PacijentSearchObject, Databases.Osiguranje>();
            CreateMap<OsiguranjeInsertRequest, Databases.Osiguranje>();
            CreateMap<OsiguranjeUpdateRequest, Databases.Osiguranje>();

            CreateMap<Databases.Termin, Model.Models.Termin>();
            CreateMap<TerminSearchObject, Databases.Termin>();
            CreateMap<TerminInsertRequest, Databases.Termin>();
            CreateMap<TerminUpdateRequest, Databases.Termin>();

            CreateMap<Databases.PacijentOsiguranje, Model.Models.PacijentOsiguranje>();
            CreateMap<PacijentSearchObject, Databases.PacijentOsiguranje>();
            CreateMap<PacijentOsiguranjeInsertRequest, Databases.PacijentOsiguranje>();
            CreateMap<PacijentOsiguranjeUpdateRequest, Databases.PacijentOsiguranje>();

            CreateMap<Databases.PacijentOboljenja, Model.Models.PacijentOboljenja>();
            CreateMap<PacijentSearchObject, Databases.PacijentOboljenja>();

            CreateMap<Databases.Oboljenje, Model.Models.Oboljenje>();
            CreateMap<PacijentClassesSearchObject, Databases.Oboljenje>();

            CreateMap<Databases.Nalaz, Model.Models.Nalaz>();
            CreateMap<PacijentClassesSearchObject, Databases.Nalaz>();

            CreateMap<Databases.Uputnica, Model.Models.Uputnica>();
            CreateMap<BaseSearchObject, Databases.Uputnica>();
            CreateMap<UputnicaInsertRequest, Databases.Uputnica>();
            CreateMap<UputnicaUpdateRequest, Databases.Uputnica>();

            CreateMap<Databases.Pregled, Model.Models.Pregled>();
            CreateMap<PacijentClassesSearchObject, Databases.Pregled>();

            CreateMap<Databases.Terapija, Model.Models.Terapija>();

            CreateMap<Databases.OcjenaDoktor, Model.Models.OcjenaDoktor>();
            CreateMap<DoktorSearchObject, Databases.OcjenaDoktor>();
            CreateMap<OcjenaDoktorInsertRequest, Databases.OcjenaDoktor>();
            CreateMap<OcjenaDoktorUpdateRequest, Databases.OcjenaDoktor>();







        }
    }
}
