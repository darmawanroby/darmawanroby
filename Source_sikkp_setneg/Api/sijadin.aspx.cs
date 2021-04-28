using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Api_sijadin : System.Web.UI.Page
{
    string info;
    protected void Page_Load(object sender, EventArgs e)
    {
        string paramUrl = Request.QueryString["paramurl"];
        HttpContext c = HttpContext.Current;
        
       // Response.Write(paramUrl);
        if (paramUrl == "ddlBiro")
        {
           // string kodeDeputi = Request.QueryString["kodeDeputi"].ToString();
            string strQuery = "SELECT KODE_BIRO AS value,CASE WHEN NAMA_BIRO IS NULL THEN '-' ELSE NAMA_BIRO END AS options FROM q_Biro";
            if (Session["GradeID"].ToString() == "2") //validator
            {
                strQuery += " WHERE (KODE_CABANG ='" + Session["CabangID"].ToString() + "' OR KODE_BIRO='0000')";
            }
            else if (Session["GradeID"].ToString().Substring(0, 1) == "3") //operator
            {
                strQuery += " WHERE (KODE_BIRO IN (SELECT KODE_DEPARTEMEN FROM taOtoritasDepartemen WHERE username='" + Session["UserID"].ToString() + "') OR KODE_BIRO='0000')";
            }
            else
            {
                strQuery += " WHERE 1=1";
            }
            //if (kodeDeputi != "000")
            //{
            //    strQuery += " AND (KODE_DEPUTI='" + kodeDeputi + "' OR KODE_BIRO='0000')";
            //}
              Response.Write(generateDropdown(strQuery));
           // Response.Write(strQuery);
        }
        else if (paramUrl == "ddlBagian")
        {
            string kodeBiro = c.Request.Form["kodeBiro"].ToString();
            string strQuery = "SELECT KODE_BAGIAN AS value,CASE WHEN NAMA_BAGIAN IS NULL THEN '-' ELSE NAMA_BIRO END AS options FROM q_Bagian";
            if (Session["GradeID"].ToString() == "2") //validator
            {
                strQuery += " WHERE (KODE_CABANG ='" + Session["CabangID"].ToString() + "' OR KODE_BAGIAN='00000')";
            }
            else if (Session["GradeID"].ToString().Substring(0, 1) == "3") //operator
            {
                strQuery += " WHERE (KODE_BAGIAN IN (SELECT KODE_DEPARTEMEN FROM taOtoritasDepartemen WHERE username='" + Session["UserID"].ToString() + "') OR KODE_BAGIAN='00000')";
            }
            else
            {
                strQuery += " WHERE 1=1";
            }
            if (kodeBiro != "0000")
            {
                strQuery += " AND (KODE_BIRO='" + kodeBiro + "' OR KODE_BAGIAN='00000')";
            }
            Response.Write(generateDropdown(strQuery));
        }
        else if (paramUrl == "tableSijadin")
        {
            string kolomnumber = c.Request.Form["order[0][column]"];
            string kolomname = c.Request.Form["columns[" + kolomnumber + "][data]"];
            string sort = c.Request.Form["order[0][dir]"];

            string query = "select ROW_NUMBER() OVER(ORDER BY " + kolomname + " " + sort + ")  AS ROWID,  ID_SPPD,NIP,NAMA,CONVERT(varchar, TGL_AWAL, 105) as TGL_AWAL, CONVERT(varchar, TGL_AKHIR, 105) AS TGL_AKHIR,NO_SPRIN  from q_ImporJadin";
            string queryCount = "select COUNT(ID_SPPD) FROM q_ImporJadin";
            string queryTemp = filterSijadin(query,c.Request.Form["tglAwal"].ToString(), c.Request.Form["tglAkhir"].ToString(),c.Request.Form["kode_biro"],c.Request.Form["kode_bagian"]);
            string queryCountTemp = filterSijadin(queryCount, c.Request.Form["tglAwal"].ToString(), c.Request.Form["tglAkhir"].ToString(), c.Request.Form["kode_biro"], c.Request.Form["kode_bagian"]); ;
            string queryPaging = paging(queryTemp, c.Request.Form["length"], c.Request.Form["start"]);
            generateBootgrid(queryPaging, c.Request.Form["draw"], queryCountTemp, kolomname);
        }
        else if (paramUrl == "synch")
        {
            string querySynch = "INSERT INTO taImportJadin (NIP,TGL_AWAL,TGL_AKHIR,NO_SPRIN,WAKTU_SIMPAN) VALUES('" + c.Request.Form["nip"] + "','" + c.Request.Form["tgl_awal"].Replace('+',' ') + "','" + c.Request.Form["tgl_akhir"].Replace('+', ' ') + "','" + c.Request.Form["no_sprin"] + "',GETDATE())";
            string message = simpanDataUpdateDeleteTabel(querySynch,false);
            Response.Write(message);
            //if (message == "ok")
            //{
            //     querySynch= "exec proc_sync_sppd ";
            //    simpanDataUpdateDeleteTabel(querySynch,true);
            //}
        }
        else if (paramUrl == "aksesSijadin")
        {
            
            Response.Write(sendToWEbsService(Request.QueryString["tgl_awal"].ToString()));
        }
        else if (paramUrl == "synchSijadin")
        {
            string querySynch = "exec proc_sync_sppd ";
            Response.Write(simpanDataUpdateDeleteTabel(querySynch,true));
        }
        else if (paramUrl == "deleteSijadin")
        {
            string querySynch = "DELETE FROM taImportJadin WHERE TGL_AWAL >='" + c.Request.Form["tgl_awal"] + " 00:00:00' AND TGL_AWAL <='" + c.Request.Form["tgl_awal"] + " 23:59:59'";
            string message = simpanDataUpdateDeleteTabel(querySynch,false);
            Response.Write(message);
        }
    }
    public string sendToWEbsService(string berangkat_tg)
    {
        //string url = "https://reqres.in/api/users";
        string url = "https://bersatu.setneg.go.id/services/sijadin_listpd.SOAP12Endpoint/_getr_list_pd?berangkat_tgl=" + berangkat_tg ;
        string responseFromServer = "";
        try
        {
            WebRequest request = WebRequest.Create(url);

           
            request.Credentials = CredentialCache.DefaultCredentials;
            // Get the response.  
            WebResponse response = request.GetResponse();
            Console.WriteLine(((HttpWebResponse)response).StatusDescription);
            // Get the stream containing content returned by the server.  
            Stream dataStream = response.GetResponseStream();
            // Open the stream using a StreamReader for easy access.  
            StreamReader reader = new StreamReader(dataStream);
            // Read the content.  
            responseFromServer = reader.ReadToEnd();
            // Display the content.  
           

        }
        catch (Exception e)
        {
            responseFromServer = e.Message;
        }
        return responseFromServer;
    }

    private string filterSijadin(string query,string tgl_awal,string tgl_akhir,string kode_biro,string kode_bagian)
    {
        query += " WHERE 1=1";
        if (tgl_awal!="" && tgl_akhir != "")
        {
            query += "  AND TGL_AWAL >='" + tgl_awal + " 00:00:00' AND TGL_AKHIR<='" + tgl_akhir + " 23:59:59'";
        }
        else if (kode_biro != "")
        {
            query += " AND KODE_BIRO='" + kode_biro + "'";
        }else if (kode_bagian != "")
        {
            query += " AND KODE_BAGIAN='" + kode_bagian + "'";
        }
        return query;
    }
    private string generateDropdown(string query)
    {
        string koneksi = ConfigurationManager.ConnectionStrings["StrCn"].ConnectionString;
        SqlConnection con = new SqlConnection(koneksi);
        string sb = "";
        try
        {
            SqlCommand cmd = new SqlCommand(query, con);
            con.Open();
            SqlDataReader hasil = cmd.ExecuteReader();
            
            while (hasil.Read())
            {
                sb += "<option value=" + hasil["value"] + ">" + hasil["options"] + "</option>";
            }
            con.Close();
        }
        catch (SqlException ex)
        {
            sb = ex.Message+query;
            //   HttpContext.Current.Response.Write(generateJsonStatus("Maaf Data Tidak Bisa Ditampilkan silakan cek Koneksi", ex.Message.ToString()));
            con.Close();
        }
        return sb;
    }
    private string simpanDataUpdateDeleteTabel(string query,bool printinfo)
    {
        string koneksi = ConfigurationManager.ConnectionStrings["strCn"].ConnectionString;
        SqlConnection con = new SqlConnection(koneksi);
        SqlCommand cmd = new SqlCommand(query, con);
        try
        {
            con.Open();
            cmd.CommandTimeout = 60;
            cmd.ExecuteNonQuery();
            con.Close();
            if (printinfo)
            {
                 con.InfoMessage += new SqlInfoMessageEventHandler(myConnection_InfoMessage);
            }
            else
            {
                info = "ok";
            }


        }
        catch (SqlException ex)
        {
            con.Close();
            info = "nok";
        }
        return info;
    }
    void myConnection_InfoMessage(object sender, SqlInfoMessageEventArgs e)
    {
        info = e.Message;
    }
    private string paging(string query, string rows, string page)
    {
        int awal = 0;
        int akhir = 0;
        awal = Convert.ToInt32(page) + 1;
        akhir = (Convert.ToInt32(page) + Convert.ToInt32(rows));
        string query_page = "WITH query AS(" + query + ")Select TOP " + rows + " * from query where ROWID BETWEEN " + awal + " AND " + akhir;
        return query_page;
    }
    public int jumlahData(string queryClient)
    {
        int tampungHasil = 0;
        string koneksi = ConfigurationManager.ConnectionStrings["strCn"].ConnectionString;
        string query = queryClient;
        SqlConnection con = new SqlConnection(koneksi);
        try
        {
            SqlCommand cmd = new SqlCommand(query, con);
            con.Open();
            tampungHasil = Convert.ToInt32(cmd.ExecuteScalar());

            con.Close();
        }
        catch (SqlException ex)
        {
            con.Close();
            return 0;
            // HttpContext.Current.Response.Write(generateJsonStatus("Kesalahan Pada Aplikasi", ex.Message.ToString() + ", " + queryClient));
        }
        return tampungHasil;
    }
    public void generateBootgrid(string queryClient, string curent, string queryCount, string kolom)
    {
        try
        {
            int total = jumlahData(queryCount);
            string koneksi = ConfigurationManager.ConnectionStrings["strCn"].ConnectionString;
            SqlConnection con = new SqlConnection(koneksi);
            SqlCommand cmd = new SqlCommand(queryClient, con);
            con.Open();
            SqlDataReader hasil = cmd.ExecuteReader();
            StringBuilder sb = new StringBuilder();
            StringWriter sw = new StringWriter(sb);
            JsonWriter jsonWriter1 = new JsonTextWriter(sw);

            jsonWriter1.WriteStartObject();
            jsonWriter1.WritePropertyName("draw");
            jsonWriter1.WriteValue(curent);
            jsonWriter1.WritePropertyName("recordsTotal");
            jsonWriter1.WriteValue(total);
            jsonWriter1.WritePropertyName("recordsFiltered");
            jsonWriter1.WriteValue(total);
            jsonWriter1.WritePropertyName("data");
            jsonWriter1.WriteStartArray();

            while (hasil.Read())
            {
                jsonWriter1.WriteStartObject();

                int field = hasil.FieldCount;
                for (int i = 0; i < field; i++)
                {
                    jsonWriter1.WritePropertyName(hasil.GetName(i));
                    jsonWriter1.WriteValue(hasil[i]);

                }

                jsonWriter1.WriteEndObject();
            }

            jsonWriter1.WriteEndArray();
            jsonWriter1.WritePropertyName("kolom");
            jsonWriter1.WriteValue(kolom);
            jsonWriter1.WritePropertyName("total");
            jsonWriter1.WriteValue(total);
            jsonWriter1.WritePropertyName("query");
            jsonWriter1.WriteValue(queryClient);
            jsonWriter1.WritePropertyName("queryCount");
            jsonWriter1.WriteValue(queryCount);
            jsonWriter1.WriteEndObject();
            HttpContext.Current.Response.Write(sb);
            con.Close();
        }
        catch (SqlException ex)
        {
            HttpContext.Current.Response.Write(ex.Message + " " + queryClient);
        }
    }

}