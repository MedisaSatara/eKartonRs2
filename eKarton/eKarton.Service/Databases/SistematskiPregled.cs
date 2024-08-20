using System;
using System.Collections.Generic;

namespace eKarton.Service.Databases
{
    public partial class SistematskiPregled
    {
        public int SistematskiPregledId { get; set; }
        public string Datum { get; set; } = null!;
        public decimal Visina { get; set; }
        public string Tezina { get; set; } = null!;
        public string ObimGrudi { get; set; } = null!;
        public string ObimStruka { get; set; } = null!;
        public string Bmi { get; set; } = null!;
        public string KrvniPritisak { get; set; } = null!;
        public string Puls { get; set; } = null!;
        public string PromjenaNaKozi { get; set; } = null!;
        public string Ekstremiteti { get; set; } = null!;
        public string Cula { get; set; } = null!;
        public string Tonzile { get; set; } = null!;
        public string Vrat { get; set; } = null!;
        public string GrudniKos { get; set; } = null!;
        public string Pluca { get; set; } = null!;
        public string Abdomen { get; set; } = null!;
        public string KicmeniStub { get; set; } = null!;
        public int PacijentId { get; set; }

        public virtual Pacijent Pacijent { get; set; } = null!;
    }
}
