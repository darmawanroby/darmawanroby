///''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
// 1. Identifikasi Program
//        Nama file     : azlib.cs                                   
//        File terkait  : 
//        Deskripsi     : File Rutin-rutin Function dan Procedure
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
//        Versi 2.0.1   : Penambahan fungsi-fungsi
//
///''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
using System.Data;
using System;
using System.IO;
using System.Data.SqlClient;

namespace rtwin
{
	public class azlib
	{
        //fungsi: periksa inputan string apakah berupa number atau bukan
        public static bool IsNumeric(string numberString)
        {
            foreach (char c in numberString)
            {
                if (!char.IsNumber(c))
                    return false;
            }
            return true;
        }
        
        //fungsi: menggabungkan dua inputan string dengan pemisah koma
        public static string StringComma(string strKalimat, string strKata)
		{
			string strGabung = "";
			if (strKalimat != "")
			{
				strGabung = strKalimat + ", " + strKata;
			}
            else
            {
                strGabung = strKata;
            }
            return strGabung;
        }

        //fungsi: menggabungkan dua inputan string dengan pemisah berupa inputan
        public static string StringKurungBuka(string strKalimat, string strOperand, string strKata)
        {
            string strGabung = "";
            if (strKalimat == "")
            {
                strGabung = " (" + strKata;
            }
            else
            {
                strGabung = strKalimat + strOperand + strKata;
            }
            return strGabung;
        }

        //fungsi: membaca isi dari suatu file
        public static string GetFileContents(string FullPath, ref string ErrInfo)
        {
            string strContents;
            StreamReader objReader;
            try
            {
                objReader = new StreamReader(FullPath);
                strContents = objReader.ReadToEnd();
                objReader.Close();
            }
            catch (Exception Ex)
            {
                ErrInfo = Ex.Message;
                strContents = "";
            }
            return strContents;
        }

        //fungsi: menulis data ke file
        public static bool SaveTextToFile(string strData, string FullPath, string ErrInfo)
        {
            bool bAns = false;
            StreamWriter objReader;
            try
            {
                objReader = new StreamWriter(FullPath);
                objReader.Write(strData);
                objReader.Close();
                bAns = true;
            }
            catch (Exception Ex)
            {
                ErrInfo = Ex.Message;
            }
            return bAns;
        }

        //fungsi: menambahkan 0 pada inputan string sampai inputan string memiliki panjang sesuai dengan yang diinginkan
        public static string FillNull(string strText, int len)
        {
            string strNull = "";
            strNull = strNull.PadRight((len - strText.Length), '0');
            return strNull + strText;
        }

        //fungsi: mengambil tanggal awal dari suatu bulan
        public static DateTime FirstDate(DateTime tgl, string lang)
        {
            int bln;
            int thn;
            DateTime tglbaru;
            bln = tgl.Month;
            thn = tgl.Year;
            if (lang == "id")
            {
                tglbaru = (DateTime.Parse("1/" + bln.ToString() + "/" + thn.ToString())).Date;
            }
            else
            {
                tglbaru = (DateTime.Parse(bln.ToString() + "/1/" + thn.ToString())).Date; ;
            }
            return tglbaru;
        }

        //fungsi: mengambil tanggal akhir dari suatu bulan
        public static DateTime LastDate(DateTime tgl, string lang)
        {
            int bln;
            int thn;
            DateTime tglbaru;
            bln = tgl.Month;
            thn = tgl.Year;
            if (bln < 12)
            {
                if (lang == "id")
                {
                    tglbaru = ((DateTime.Parse("1/" + System.Convert.ToString(bln + 1) + "/" + thn.ToString())).Date).AddDays(-1);
                }
                else
                {
                    tglbaru = ((DateTime.Parse(System.Convert.ToString(bln + 1) + "/1/" + thn.ToString())).Date).AddDays(-1);
                }
            }
            else
            {
                tglbaru = ((DateTime.Parse("1/1/" + System.Convert.ToString(thn + 1))).Date).AddDays(-1);
            }
            return tglbaru;
        }

        //fungsi: validasi untuk mengakses halaman
        public static bool AksesHalaman(byte PageID, string UserID, string GradeID, string MenuID)
        {
            if (UserID == "")
            {
                return false;
            }
            else
            {
                if ((GradeID == "1") || (GradeID == "0") || (MenuID.Substring(PageID - 1, 1) == "1"))
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
        }

        //fungsi: menambahkan Log ke database (taLog)
        public static void AddUserAct(string UserID, string ActID, string StrTarget, string StrCn)
        {
            SqlConnection cn;
            SqlCommand cmd = new SqlCommand();
            /*
            if (StrTarget.Length > 50)
            {
                StrTarget = StrTarget.Substring(0, 50);
            }
            */
            cn = new SqlConnection(StrCn);
            cn.Open();
            cmd.CommandText = "INSERT INTO taLog VALUES ('RTE', '" + DateTime.Now.ToString("MM/dd/yyyy") + " " + DateTime.Now.ToLongTimeString() + "','" + UserID + "','" + ActID + "',LEFT('" + StrTarget + "',50))"; 
            cmd.CommandType = CommandType.Text;
            cmd.Connection = cn;
            try
            {
                cmd.ExecuteNonQuery();
            }
            catch (Exception)
            {
            }
            cn.Close();
        }

        //fungsi: menambahkan Log ke database (taLogImport)
        public static void LogImport(string UserID, string ImportID, string StrTarget, string StrStatus, string StrError, string StrCn)
        {
            SqlConnection cn;
            SqlCommand cmd = new SqlCommand();
            if (StrError.Length > 70)
            {
                StrError = StrError.Substring(0, 70);
            }
            cn = new SqlConnection(StrCn);
            cn.Open();
            cmd.CommandText = "INSERT INTO taLogImport (WAKTU, USERNAME, KODE_IMPORT, NIP, STATUS_IMPORT, ERROR_IMPORT) VALUES ('" + DateTime.Now.ToString("MM/dd/yyyy") + " " + DateTime.Now.ToLongTimeString() + "','" + UserID + "','" + ImportID + "','" + StrTarget + "'," + StrStatus + ",'" + StrError + "')"; 
            cmd.CommandType = CommandType.Text;
            cmd.Connection = cn;
            try
            {
                cmd.ExecuteNonQuery();
            }
            catch (Exception)
            {
            }
            cn.Close();
        }

        public static string getNIP(string PIN, string StrCn)
        {
            SqlConnection cn = new SqlConnection(StrCn);
            cn.Open();
            DataSet dsUsers = new DataSet();
            string strSelect = "SELECT NIP FROM taKaryawan WHERE PIN = '" + PIN + "'";
            SqlDataAdapter adpSQL = new SqlDataAdapter(strSelect, cn);
            adpSQL.Fill(dsUsers);
            string hasil = "";
            int recordCount = dsUsers.Tables[0].Rows.Count;
            if (recordCount > 0)
            {
                hasil = dsUsers.Tables[0].Rows[0][0].ToString();
            }
            cn.Close();
            return hasil;
        }

        public static string getLibur(DateTime dTgl, string StrCn)
        {
            SqlConnection cn = new SqlConnection(StrCn);
            cn.Open();
            DataSet dsLibur = new DataSet();
            string strSelect = "SELECT * FROM taLibur WHERE TGL_LIBUR = '" + dTgl.ToString("MM/dd/yyyy") + "'";
            SqlDataAdapter adpSQL = new SqlDataAdapter(strSelect, cn);
            adpSQL.Fill(dsLibur);
            string hasil = "";
            int recordCount = dsLibur.Tables[0].Rows.Count;
            if (recordCount > 0)
            {
                hasil = "1";
            }
            else
            {
                hasil = "0";
            }
            cn.Close();
            return hasil;
        }

    }		
}