///''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
// 1. Identifikasi Program
//        Nama file     : Culture.cs                                   
//        File terkait  : 
//        Deskripsi     : File Pengolahan Multi Bahasa Lokal
//
// 2. Penulis Program
//        Programer     : Aas Meinardi, Irwan Asminan
//        Co-Programmer : Bayu Widiaiswara
//
// 3. Tanggal update    : 10/09/2009
//
// 4. Versi             : 2.0.1
//
// 5. Historis revisi
//        Versi 2.0.1   : Penyempurnaan Fungsi
//
///''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
namespace Udev
{
	namespace MasterPageWithLocalization
	{
		namespace Classes
		{
			public struct Culture
			{
				//German - Switzerland definition
				public string strTmp;
				public const string DE = "de-CH";
				//English - Great Britain definition
				public const string EN = "en-GB";
                //Indonesian definition
                public const string ID = "id-ID";
			}
		}
	}
}
