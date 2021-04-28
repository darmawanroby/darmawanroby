///''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
// 1. Identifikasi Program
//        Nama file     : BasePage.cs                                   
//        File terkait  : 
//        Deskripsi     : File Pengolahan Multi Bahasa
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
//        Versi 2.0.1   : Penyempurnaan fungsi
//
///''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
using System;
using System.Globalization;
using System.Threading;

namespace Udev
{
	namespace MasterPageWithLocalization
	{
		namespace Classes
		{
			public class BasePage : System.Web.UI.Page
			{
					
				protected override void InitializeCulture()
				{
					//retrieve culture information from session
					string culture = Convert.ToString(Session[Global.SESSION_KEY_CULTURE]);
						
					//check whether a culture is stored in the session
					if (culture.Length > 0)
					{
						this.Culture = culture;
					}
						
					//set culture to current thread
					Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(culture);
					Thread.CurrentThread.CurrentUICulture = new CultureInfo(culture);
						
					//call base class
					base.InitializeCulture();
				}

                protected bool isEntryUseNIP()
                {
                    if (Session["TipeEntry"].ToString() == "NIP")
                    {
                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }

                protected bool isEntrySambung()
                {
                    if ((bool)Session["SambungEntry"])
                    {
                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }
			}
		}
	}
}
	