using System.Data;
using System;
using System.IO;
using System.Data.SqlClient;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

using System.Text;
using Newtonsoft.Json;
using System.Text.RegularExpressions;



public partial class control : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
        string paramUrl = Request.QueryString["paramurl"];
        HttpContext c = HttpContext.Current;
        if (paramUrl == "simpan")
        {
            //string query = "INSERT INTO [dbo].[taInformasi]([JUDUL],[KONTEN],[IS_ADMIN])VALUES('" + txtJudulBerita.Text + "','" + editor1.Value + "','" + chkAdmin.Checked + "')";

            Response.Write(simpanDataUpdateDeleteTabel(c.Request.Form["query"], "Data Berhasil Disimpan"));
        }
        else if (paramUrl == "simpanSuratIjin")
        {
            //string query = "INSERT INTO [dbo].[taInformasi]([JUDUL],[KONTEN],[IS_ADMIN])VALUES('" + txtJudulBerita.Text + "','" + editor1.Value + "','" + chkAdmin.Checked + "')";

            Response.Write(simpanDataSuratIjin(c.Request.Form["query"], "Data Berhasil Disimpan", c.Request.Form["kode_ijin"], c.Request.Form["tahun"],c.Request.Form["no_surat"]));
        }
        else if (paramUrl == "getJumlahHari")
        {
            string query = "select dbo.SetJmlHari('198507222008121001','" + c.Request.Form["KODE_IJIN"] + "','" + c.Request.Form["tgl_awal"] + "','" + c.Request.Form["tgl_akhir"] + "') AS JUMLAH";
            Response.Write(getJumlahHari(query));
        }
        
        else if (paramUrl == "dataTable")
        {
            Response.Write(generateDataTable());
        }
        else if (paramUrl == "dsWFH")
        {
            string nip = Request.QueryString["nip"].ToString();
            string kodebiro = Request.QueryString["kodebiro"].ToString();
            string kodedeputi = Request.QueryString["kodedeputi"].ToString();
            string bulan = Request.QueryString["bulan"].ToString();
            string tahun = Request.QueryString["tahun"].ToString();

            string query = "";
            query += "SELECT NIP, NAMA, NAMA_GOLONGAN, JABATAN, JADWAL_WFH,BULAN,TAHUN, STATUS_JADWAL FROM q_JadwalWFH WHERE TAHUN ='" + tahun + "' AND BULAN = '" + bulan + "'";
            if (nip != "")
            {

                query += " and nip='"+nip+"'";
            }
          /*  if(kodedeputi!=""){
                query += " and KODE_DEPUTI='" + kodedeputi + "'";
            }
             if (kodebiro != "")
            {
                query += " and KODE_DEPUTI='"+kodedeputi+"' and KODE_BIRO='" + kodebiro + "'";
            }*/
             if ((((kodedeputi == "000") || (kodedeputi == "null")) && ((kodebiro == "0000") || (kodebiro == "null"))))
             {
                 if ((Session["GradeID"].ToString() == "2"))
                 {
                      
                         query += " AND KODE_CABANG='" + Session["CabangID"].ToString() + "'";
                     
                 }
                 else if ((Session["GradeID"].ToString().Substring(0, 1) == "3"))
                 {
                     query += " AND KODE_DEPARTEMEN IN (SELECT KODE_DEPARTEMEN FROM taOtoritasDepartemen WHERE username='" + Session["UserID"].ToString() + "')";
                       
                 }
            }

           dataTable(query);
           // Response.Write("NIP :"+nip+" Bulan:"+bulan+" Tahun:"+tahun+" DEPUTI:"+kodedeputi+" BIRO:"+kodebiro);
          // Response.Write(query);
        }
        else if (paramUrl == "prosesWfh")
        {
            string bulan = c.Request.Form["bulan"];
            string tahun = c.Request.Form["tahun"];
            string username = Session["UserID"].ToString();
            string query = "";
            string message = "";
            query += "EXEC proc_ProsesJadwalWFH " + bulan + ", " + tahun + ", '" + username + "'";
            crudData(query, message);
            Response.Write(query);
        }
        else if (paramUrl == "simpanJadwalWfh")
        {
            string nip = "";
            string jadwalWfh = "";
            string tahun = "";
            string bulan = "";


            string mode = c.Request.Form["mode"];

            string query = "";
            string message = "";
            if (mode == "1")
            {
                nip += c.Request.Form["nip"];
                jadwalWfh += c.Request.Form["jadwal"];
                bulan += c.Request.Form["bulan"];
                tahun += c.Request.Form["tahun"];
                query += "INSERT INTO taJadwalWFH (NIP, TAHUN, BULAN, JADWAL_WFH, WAKTU_SIMPAN) VALUES ('" + nip + "', '" + tahun + "', '" + bulan + "', '" + jadwalWfh + "', GETDATE())";
                Response.Write(query);
            }
            if (mode == "2")
            {
                nip += c.Request.Form["nip"];
                jadwalWfh += c.Request.Form["jadwal"];
                bulan += c.Request.Form["bulan"];
                tahun += c.Request.Form["tahun"];
                query += "update taJadwalWFH set JADWAL_WFH='" + jadwalWfh + "' where nip='" + nip + "' and tahun='" + tahun + "' and bulan='" + bulan + "'";
            }
            if (mode == "3")
            {
                nip += c.Request.Form["nip"];
                tahun += c.Request.Form["tahun"];
                bulan += c.Request.Form["bulan"];
                query += "delete from taJadwalWFH where nip='" + nip + "' and tahun='" + tahun + "' and bulan='" + bulan + "'";
                // Response.Write(query);
            }
            crudData(query, message);
            Response.Write(query);
        }
        else if (paramUrl == "dsDeputi")
        {

            string query = "SELECT KODE_DEPUTI,CASE WHEN NAMA_DEPUTI IS NULL THEN '-' ELSE NAMA_DEPUTI END AS NAMA_DEPUTI FROM q_Deputi order by NAMA_DEPUTI ASC";
            if (Session["GradeID"].ToString() == "2") //validator
            {
                query += " WHERE (KODE_CABANG ='" + Session["CabangID"].ToString() + "' OR KODE_DEPUTI='000')";
            }
            else if (Session["GradeID"].ToString() == "3a") //viewer
            {

                query += " WHERE (KODE_DEPUTI IN (SELECT KODE_DEPARTEMEN FROM taOtoritasDepartemen WHERE USERNAME ='" + Session["UserID"].ToString() + "') OR KODE_DEPUTI='000')";
            }

            ddlData(query);
        }
        else if (paramUrl == "dsBiro")
        {
            string kodeDeputi = Request.QueryString["kodeDeputi"].ToString();
            string strQuery = "SELECT KODE_BIRO,CASE WHEN NAMA_BIRO IS NULL THEN '-' ELSE NAMA_BIRO END AS NAMA_BIRO FROM q_Biro";
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
            if (kodeDeputi != "000")
            {
                strQuery += " AND (KODE_DEPUTI='" + kodeDeputi + "' OR KODE_BIRO='0000')";
            }

            ddlData(strQuery);
        }

        else if (paramUrl == "detail")
        {
            masukDataKomponen(c.Request.Form["query"].ToString());
        }
        else if (paramUrl == "delete")
        {
            Response.Write(simpanDataUpdateDeleteTabel(c.Request.Form["query"], "Data Berhasil Dihapus"));
        }
        else if (paramUrl == "getInformasi")
        {
            masukDataKomponen(c.Request.Form["query"].ToString());
        }
        else if (paramUrl == "getGrafik")
        {
            masukDataGrafik(c.Request.Form["query"].ToString());
        }
        else if (paramUrl == "cekSaldoCuti")
        {
            //Response.Write(cekKredit(c.Request.Form["kode_ijin"]));
            bool cekDataKRedit = cekKredit(c.Request.Form["kode_ijin"]);
            if (cekDataKRedit)
            {
                masukDataKomponen(c.Request.Form["query"].ToString());
            }
            else
            {
                Response.Write("0");
            }

        }
        else if (paramUrl == "autocompletekaryawan")
        {
            autocomplete(doFilteringLookup(Request.QueryString["phrase"].ToString()));
        }
        else if (paramUrl == "autocompleteNIP")
        {
            string query = "select NIP,NAMA,taJabatan.NAMA_JABATAN,taGolongan.NAMA_GOLONGAN,NAMA_UNIT from q_Karyawan left join taJabatan ON q_karyawan.KODE_JABATAN = taJabatan.KODE_JABATAN left join taGolongan on q_karyawan.KODE_GOLONGAN = taGolongan.KODE_GOlongan where nama like '%" + Request.QueryString["term"] + "%'";

            //  "select NIP,NAMA,NAMA_JABATAN,NAMA_UNIT from q_Karyawan where nama like '%" + Request.QueryString["term"] + "%'";

            if (Session["GradeID"].ToString() == "2")
            {
                query += " AND KODE_CABANG = '" + Session["CabangID"].ToString() + "'";
            }
            else if (Session["GradeID"].ToString().Substring(0, 1) == "3")
            {
                query += " AND KODE_DEPARTEMEN IN (SELECT KODE_DEPARTEMEN FROM taOtoritasDepartemen WHERE USERNAME = '" + Session["UserID"].ToString() + "')";
            }
            autocomplete(query);
            // Response.Write(query);

        }
        else if (paramUrl == "hapus_file")
        {
            string FileToDelete;
            // Set full path to file
            FileToDelete = Server.MapPath(c.Request.Form["file"]);
            File.Delete(FileToDelete);
            Response.Write("File Berhasil Dihapus");
        }
        else if (paramUrl == "generateNumber")
        {

            Response.Write(genereateRandomNumber());
        }
        else if (paramUrl == "dataTabelEasyUi")
        {
            string queryGrid = "SELECT ROW_NUMBER() OVER(ORDER BY TGL_AWAL)  AS ROWID, KODE_REKAP, ID_SURAT,NO_SURAT AS ID,CONCAT(KODE_REKAP,'/',ID_SURAT) AS NO_REGISTER, URUTAN,KODE_IJIN, KET_IJIN, " +
                " NO_SURAT," + convertToVarcharDateSql2("TGL_AWAL") + " ," + convertToVarcharDateSql2("TGL_AKHIR") + " , JML_HARI, " +
                " TAHUN_SURAT, NAMA_BIRO,CASE STATUS_SURAT WHEN 1 THEN 'DISETUJUI' ELSE 'BELUM DISETUJUI' END AS DISETUJUI, DOKUMEN_SURAT FROM q_IjinSurat ";
            string queryCount = "SELECT  COUNT(KODE_REKAP) FROM q_IjinSurat ";
            //  HttpContext.Current.Response.Write(generateTableCekboxDanPDF(filTerGridClient(queryGrid, c.Request.Form["tgl_awal"].ToString(), c.Request.Form["tgl_akhir"], c.Request.Form["kode_rekap"], c.Request.Form["id_surat"], c.Request.Form["status_surat"], c.Request.Form["jenis_surat"]), "editIjin", "hapusIjin", "ID"));
            //HttpContext.Current.Response.Write(generateTableCekboxDanPDF(filTerGridClient(queryGrid, c.Request.Form["tgl_awal"].ToString(), c.Request.Form["tgl_akhir"], "", "", Request.QueryString["status_surat"], Request.QueryString["jenis_surat"]), "editIjin", "hapusIjin", "ID"));
            string data = generateTableCekboxDanPDF(paging(filTerGridClient(queryGrid, c.Request.Form["tgl_awal"].ToString(), c.Request.Form["tgl_akhir"], c.Request.Form["kode_rekap"], c.Request.Form["id_surat"], c.Request.Form["status_surat"], c.Request.Form["jenis_surat"]), "10", c.Request.Form["pg"]), "editIjin", "hapusIjin", "URUTAN");
            int count = jumlahData(filTerGridClient(queryCount, c.Request.Form["tgl_awal"].ToString(), c.Request.Form["tgl_akhir"], c.Request.Form["kode_rekap"], c.Request.Form["id_surat"], c.Request.Form["status_surat"], c.Request.Form["jenis_surat"]));
            generateJsonStatus(count, data, paging(filTerGridClient(queryGrid, c.Request.Form["tgl_awal"].ToString(), c.Request.Form["tgl_akhir"], c.Request.Form["kode_rekap"], c.Request.Form["id_surat"], c.Request.Form["status_surat"], c.Request.Form["jenis_surat"]), "10", c.Request.Form["pg"]));
        }
        else if (paramUrl == "dataTabelEasyUi_")
        {

            string queryGrid = "SELECT ROW_NUMBER() OVER(ORDER BY TGL_AWAL)  AS ROWID, KODE_REKAP, ID_SURAT,NO_SURAT AS ID, URUTAN,KODE_IJIN, KET_IJIN, " +
                " NO_SURAT," + convertToVarcharDateSql2("TGL_AWAL") + " ," + convertToVarcharDateSql2("TGL_AKHIR") + " , JML_HARI, " +
                " TAHUN_SURAT, NAMA_BIRO, DOKUMEN_SURAT FROM [q_IjinSuratRakor]";
            string queryCount = "SELECT  COUNT(KODE_REKAP) FROM [q_IjinSuratRakor]";
            //  HttpContext.Current.Response.Write(generateTableCekboxDanPDF(filTerGridClient(queryGrid, c.Request.Form["tgl_awal"].ToString(), c.Request.Form["tgl_akhir"], c.Request.Form["kode_rekap"], c.Request.Form["id_surat"], c.Request.Form["status_surat"], c.Request.Form["jenis_surat"]), "editIjin", "hapusIjin", "ID"));
            //HttpContext.Current.Response.Write(generateTableCekboxDanPDF(filTerGridClient(queryGrid, c.Request.Form["tgl_awal"].ToString(), c.Request.Form["tgl_akhir"], "", "", Request.QueryString["status_surat"], Request.QueryString["jenis_surat"]), "editIjin", "hapusIjin", "ID"));
            string data = generateTableCekboxDanPDF_(paging(filTerGridClient(queryGrid, c.Request.Form["tgl_awal"].ToString(), c.Request.Form["tgl_akhir"], c.Request.Form["kode_rekap"], c.Request.Form["id_surat"], c.Request.Form["status_surat"], c.Request.Form["jenis_surat"]), "10", c.Request.Form["pg"]), "editIjin", "hapusIjin", "URUTAN");
            int count = jumlahData(filTerGridClient(queryCount, c.Request.Form["tgl_awal"].ToString(), c.Request.Form["tgl_akhir"], c.Request.Form["kode_rekap"], c.Request.Form["id_surat"], c.Request.Form["status_surat"], c.Request.Form["jenis_surat"]));
            generateJsonStatus(count, data, paging(filTerGridClient(queryGrid, c.Request.Form["tgl_awal"].ToString(), c.Request.Form["tgl_akhir"], c.Request.Form["kode_rekap"], c.Request.Form["id_surat"], c.Request.Form["status_surat"], c.Request.Form["jenis_surat"]), "10", c.Request.Form["pg"]));
        }
        else if (paramUrl == "dataTabelEasyUi___")
        {

            string queryGrid = "SELECT ROW_NUMBER() OVER(ORDER BY TGL_AWAL)  AS ROWID, KODE_REKAP, ID_SURAT,NO_SURAT AS ID, URUTAN,KODE_IJIN, KET_IJIN, " +
                " NO_SURAT," + convertToVarcharDateSql2("TGL_AWAL") + " ," + convertToVarcharDateSql2("TGL_AKHIR") + " , JML_HARI, " +
                " TAHUN_SURAT, NAMA_BIRO, DOKUMEN_SURAT FROM [q_IjinSuratRakor]";
            string queryCount = "SELECT  COUNT(KODE_REKAP) FROM [q_IjinSuratRakor]";
            //  HttpContext.Current.Response.Write(generateTableCekboxDanPDF(filTerGridClient(queryGrid, c.Request.Form["tgl_awal"].ToString(), c.Request.Form["tgl_akhir"], c.Request.Form["kode_rekap"], c.Request.Form["id_surat"], c.Request.Form["status_surat"], c.Request.Form["jenis_surat"]), "editIjin", "hapusIjin", "ID"));
            //HttpContext.Current.Response.Write(generateTableCekboxDanPDF(filTerGridClient(queryGrid, c.Request.Form["tgl_awal"].ToString(), c.Request.Form["tgl_akhir"], "", "", Request.QueryString["status_surat"], Request.QueryString["jenis_surat"]), "editIjin", "hapusIjin", "ID"));
            string data = generateTableCekboxDanPDF___(paging(filTerGridClient(queryGrid, c.Request.Form["tgl_awal"].ToString(), c.Request.Form["tgl_akhir"], c.Request.Form["kode_rekap"], c.Request.Form["id_surat"], c.Request.Form["status_surat"], c.Request.Form["jenis_surat"]), "10", c.Request.Form["pg"]), "editIjin", "hapusIjin", "URUTAN");
            int count = jumlahData(filTerGridClient(queryCount, c.Request.Form["tgl_awal"].ToString(), c.Request.Form["tgl_akhir"], c.Request.Form["kode_rekap"], c.Request.Form["id_surat"], c.Request.Form["status_surat"], c.Request.Form["jenis_surat"]));
            generateJsonStatus(count, data, paging(filTerGridClient(queryGrid, c.Request.Form["tgl_awal"].ToString(), c.Request.Form["tgl_akhir"], c.Request.Form["kode_rekap"], c.Request.Form["id_surat"], c.Request.Form["status_surat"], c.Request.Form["jenis_surat"]), "10", c.Request.Form["pg"]));
        }
        else if (paramUrl == "cek_session")
        {
            if (Session["NIPID"] == null)
            {
                Response.Write("0");
            }
            else
            {
                Response.Write("1");
            }

        }
    }
    public string paging(string query, string rows, string page)
    {
        int awal = 0;
        int akhir = 0;
        awal = ((Convert.ToInt32(page) - 1) * Convert.ToInt32(rows) + 1);
        akhir = (Convert.ToInt32(page) * Convert.ToInt32(rows));
        string query_page = "WITH query AS(" + query + ")Select TOP " + rows + " * from query where ROWID BETWEEN " + awal + " AND " + akhir;
        return query_page;
    }
    public string filTerGridClient(string query, string tgl_awal, string tgl_akhir, string kode_rekap, string id_surat, string status_surat, string jenis_surat)
    {
        if (tgl_awal == "" || tgl_akhir.ToString() == "")
        {
            query += "";
        }
        else
        {

            if (Session["GradeID"].ToString() == "1")
            {
                query += " WHERE ((tgl_awal>='" + convertDate(tgl_awal) + "' AND tgl_awal<='" + convertDate(tgl_akhir) + "') OR (tgl_akhir>='" + convertDate(tgl_awal) + "'" +
                 "AND tgl_akhir='" + convertDate(tgl_akhir) + "') OR (tgl_awal>='" + convertDate(tgl_awal) + "' AND tgl_akhir<='" + convertDate(tgl_akhir) + "'))";
            }
            else
            {
                query += "  WHERE ((tgl_awal>='" + convertDate(tgl_awal) + "' AND tgl_awal<='" + convertDate(tgl_akhir) + "') OR (tgl_akhir>='" + convertDate(tgl_awal) + "'" +
                "AND tgl_akhir='" + convertDate(tgl_akhir) + "') OR (tgl_awal>='" + convertDate(tgl_awal) + "' AND tgl_akhir<='" + convertDate(tgl_akhir) + "')) AND KODE_BIRO='" + Session["BiroID"] + "'";
            }
           // query += " WHERE TGL_AWAL >='" + convertDate(tgl_awal) + "' AND TGL_AKHIR<='" + convertDate(tgl_akhir) + "'";
            
          //  query += " WHERE TGL_AWAL >='" + az.convertDate("01/11/2015") + "' AND TGL_AKHIR<='" + az.convertDate(txtSampai_.Value.ToString()) + "'";
            if (kode_rekap != "")
            {
                query += " AND KODE_REKAP='" + kode_rekap + "'";
            }
            if (id_surat != "")
            {
                query += " AND ID_SURAT='" + id_surat + "'";
            }
            if (status_surat != "-")
            {
                query += " AND STATUS_SURAT='" + status_surat + "'";
            }
            if (jenis_surat != "-")
            {
                query += " AND KODE_IJIN='" + jenis_surat + "'";
            }
        }

        return query;
    }
    public string generateTableCekboxDanPDF(string queryClient, string fungsi_edit, string fungsi_hapus, string keyYangDiambil)
    {
        string hasil_ = "<tr>";
        string hasil__ = "";

        try
        {
            string koneksi = ConfigurationManager.ConnectionStrings["StrCn"].ConnectionString;
            SqlConnection con = new SqlConnection(koneksi);
            SqlCommand cmd = new SqlCommand(queryClient, con);
            con.Open();
            SqlDataReader hasil = cmd.ExecuteReader();
            string cekbox = "";
            int a = 0;
            string idchekbox = "";
            while (hasil.Read())
            {
                hasil__ += "<tr class=\"odd gradeX\">";
                int field = hasil.FieldCount;
                if (hasil["DOKUMEN_SURAT"].ToString() != "")
                {
                    //  hasil__ += "<td><a href='pdf/" + hasil["DOKUMEN_SURAT"] + "'  class=btn btn-primary  ><img src='../images/pdf.jpg' style='width:35px'><div class=box><iframe src='pdf/" + hasil["DOKUMEN_SURAT"] + "' width = 500px height = 500px></iframe></div></a></td>";
                    hasil__ += "<td><a href='#' onclick=zzooom_('" + hasil["DOKUMEN_SURAT"] + "') > <img src='../images/pdf.jpg' style='width:25px'></a>";
                }
                else
                {
                    hasil__ += "<td><a href='" + hasil["DOKUMEN_SURAT"] + "' style='display:none'></a></td>";
                }

                for (int i = 0; i < field; i++)
                {
                    //      jsonWriter1.WritePropertyName(hasil.GetName(i));
                    //     jsonWriter1.WriteValue(hasil[i]);
                    hasil_ += "<th>" + hasil.GetName(i) + "</th>";
                    if (hasil.GetName(i) != "ID" && hasil.GetName(i) != "ROWID" && hasil.GetName(i) != "URUTAN")
                    {
                        if (hasil.GetName(i) == "DOKUMEN_SURAT")
                        {
                            hasil__ += "<td class=\"center\" style='display:none'>" + hasil[i] + "</td>";
                        }
                        else if (hasil.GetName(i) == "DISETUJUI")
                        {
                            string status = hasil["DISETUJUI"].ToString().Trim();
                            idchekbox = "id=idchk_" + fungsi_edit + "_" + a.ToString();
                            idchekbox = "#idchk_" + fungsi_edit + "_" + a.ToString();

                            if (status.Equals("BELUM DISETUJUI"))
                            {
                                if (Session["GradeID"].ToString() != "1" && Session["GradeID"].ToString() != "2")
                                {
                                    cekbox = "<input type='checkbox' disabled='disabled'  name=chk_" + fungsi_edit + "[] id=idchk_" + fungsi_edit + "_" + a + " onclick=chk" + fungsi_edit + "('" + hasil[keyYangDiambil] + "','" + a + "') />";
                                }
                                else
                                {
                                    cekbox = "<input type='checkbox'  name=chk_" + fungsi_edit + "[] id=idchk_" + fungsi_edit + "_" + a + " onclick=chk" + fungsi_edit + "('" + hasil[keyYangDiambil] + "','" + a + "') />";
                                }
                            }
                            else
                            {
                                if (Session["GradeID"].ToString() != "1" && Session["GradeID"].ToString() != "2")
                                {
                                    cekbox = "<input type='checkbox' disabled='disabled' checked='checked' name=chk_" + fungsi_edit + "[] id=idchk_" + fungsi_edit + "_" + a + " onclick=chk" + fungsi_edit + "('" + hasil[keyYangDiambil] + "','" + a + "') />";
                                }
                                else
                                {
                                    cekbox = "<input type='checkbox' checked='checked' name=chk_" + fungsi_edit + "[] id=idchk_" + fungsi_edit + "_" + a + " onclick=chk" + fungsi_edit + "('" + hasil[keyYangDiambil] + "','" + a + "') />";
                                }
                                
                            }

                        }
                        else if ((hasil.GetName(i) == "KODE_REKAP") || (hasil.GetName(i) == "ID_SURAT") || (hasil.GetName(i) == "NAMA_BIRO") || (hasil.GetName(i) == "KODE_IJIN") || (hasil.GetName(i) == "TAHUN_SURAT"))
                        {
                            if (Session["GradeID"].ToString() != "2")
                            {
                                hasil__ += "<td class=\"center\">" + hasil[i] + "</td>";
                            }
                        }
                        else if ((hasil.GetName(i) == "NO_REGISTER") )
                        {
                            if (Session["GradeID"].ToString() == "2")
                            {
                                hasil__ += "<td class=\"center\">" + hasil[i] + "</td>";
                            }
                        }
                        else if ((hasil.GetName(i) == "NO_SURAT"))
                        {
                            hasil__ += "<td class=\"center\">" + hasil[i] + "</td>";
                            if (Session["GradeID"].ToString() == "2")
                            {
                                string query = "select NAMA from q_IjinSuratPegawai WHERE NO_SURAT='" + hasil[i] + "'";
                                hasil__ += "<td class=\"center\">" + getPeserta(query) + "</td>";
                            }
                        }
                        else
                        {
                            hasil__ += "<td class=\"center\">" + hasil[i] + "</td>";
                        }
                    }

                }
                // cekbox = status;
                hasil__ += "<td>" + cekbox + "</td><td><a href='#' class=btn btn-primary  data-toggle='tab' onclick=" + fungsi_edit + "('" + hasil[keyYangDiambil] + "')  ><i class='glyphicon glyphicon-pencil'></i> </a></td><td><a href='#'  onclick=" + fungsi_hapus + "('" + hasil[keyYangDiambil] + "','" + hasil["DOKUMEN_SURAT"] + "','" + hasil["NO_SURAT"] + "')  ><i class='glyphicon glyphicon-trash'></i> </a></td>";
                hasil__ += "</tr>";
                a++;
            }


            con.Close();

        }
        catch (SqlException ex)
        {
            hasil__ = ex.Message + ", " + queryClient;
            // HttpContext.Current.Response.Write(generateJsonStatus("Maaf Data Tidak Bisa Ditampilkan silakan cek Koneksi", ex.Message.ToString() + ", " + queryClient));
        }
        return hasil__ + "</tr>";
    }
    public string generateTableCekboxDanPDF_(string queryClient, string fungsi_edit, string fungsi_hapus, string keyYangDiambil)
    {
        HttpContext c = HttpContext.Current;
        string hasil_ = "<tr>";
        string hasil__ = "";

        try
        {
            string koneksi = ConfigurationManager.ConnectionStrings["StrCn"].ConnectionString;
            SqlConnection con = new SqlConnection(koneksi);
            SqlCommand cmd = new SqlCommand(queryClient, con);
            con.Open();
            SqlDataReader hasil = cmd.ExecuteReader();
            string cekbox = "";
            int a = 0;
            string idchekbox = "";
            while (hasil.Read())
            {
                hasil__ += "<tr class=\"odd gradeX\">";
                int field = hasil.FieldCount;
                if (hasil["DOKUMEN_SURAT"].ToString() != "")
                {
                    //  hasil__ += "<td><a href='pdf/" + hasil["DOKUMEN_SURAT"] + "'  class=btn btn-primary  ><img src='../images/pdf.jpg' style='width:35px'><div class=box><iframe src='pdf/" + hasil["DOKUMEN_SURAT"] + "' width = 500px height = 500px></iframe></div></a></td>";
                    hasil__ += "<td><a href='#' onclick=zzooom_('" + hasil["DOKUMEN_SURAT"] + "') > <img src='../images/pdf.jpg' style='width:25px'></a>";
                }
                else
                {
                    hasil__ += "<td><a href='" + hasil["DOKUMEN_SURAT"] + "' style='display:none'></a></td>";
                }

                for (int i = 0; i < field; i++)
                {
                    //      jsonWriter1.WritePropertyName(hasil.GetName(i));
                    //     jsonWriter1.WriteValue(hasil[i]);
                    hasil_ += "<th>" + hasil.GetName(i) + "</th>";
                    if (hasil.GetName(i) != "ID" && hasil.GetName(i) != "ROWID" && hasil.GetName(i) != "URUTAN")
                    {
                        if (hasil.GetName(i) == "DOKUMEN_SURAT")
                        {
                            hasil__ += "<td class=\"center\" style='display:none'>" + hasil[i] + "</td>";
                        }
                       /* else if (hasil.GetName(i) == "DISETUJUI")
                        {
                            string status = hasil["DISETUJUI"].ToString().Trim();
                            idchekbox = "id=idchk_" + fungsi_edit + "_" + a.ToString();
                            idchekbox = "#idchk_" + fungsi_edit + "_" + a.ToString();

                            if (status.Equals("BELUM DISETUJUI"))
                            {
                                if (Session["GradeID"].ToString() != "1" && Session["GradeID"].ToString() != "2")
                                {
                                    cekbox = "<input type='checkbox' disabled='disabled'  name=chk_" + fungsi_edit + "[] id=idchk_" + fungsi_edit + "_" + a + " onclick=chk" + fungsi_edit + "('" + hasil[keyYangDiambil] + "','" + a + "') />";
                                }
                                else
                                {
                                    cekbox = "<input type='checkbox'  name=chk_" + fungsi_edit + "[] id=idchk_" + fungsi_edit + "_" + a + " onclick=chk" + fungsi_edit + "('" + hasil[keyYangDiambil] + "','" + a + "') />";
                                }
                            }
                            else
                            {
                                if (Session["GradeID"].ToString() != "1" && Session["GradeID"].ToString() != "2")
                                {
                                    cekbox = "<input type='checkbox' disabled='disabled' checked='checked' name=chk_" + fungsi_edit + "[] id=idchk_" + fungsi_edit + "_" + a + " onclick=chk" + fungsi_edit + "('" + hasil[keyYangDiambil] + "','" + a + "') />";
                                }
                                else
                                {
                                    cekbox = "<input type='checkbox' checked='checked' name=chk_" + fungsi_edit + "[] id=idchk_" + fungsi_edit + "_" + a + " onclick=chk" + fungsi_edit + "('" + hasil[keyYangDiambil] + "','" + a + "') />";
                                }

                            }

                        }*/
                        else if ((hasil.GetName(i) == "KODE_REKAP") || (hasil.GetName(i) == "ID_SURAT") || (hasil.GetName(i) == "NAMA_BIRO") || (hasil.GetName(i) == "KODE_IJIN") || (hasil.GetName(i) == "TAHUN_SURAT"))
                        {
                            if (Session["GradeID"].ToString() != "2")
                            {
                                hasil__ += "<td class=\"center\">" + hasil[i] + "</td>";
                            }
                        }
                        else if ((hasil.GetName(i) == "NO_REGISTER"))
                        {
                            if (Session["GradeID"].ToString() == "2")
                            {
                                hasil__ += "<td class=\"center\">" + hasil[i] + "</td>";
                            }
                        }
                        else if ((hasil.GetName(i) == "NO_SURAT"))
                        {
                            hasil__ += "<td class=\"center\">" + hasil[i] + "</td>";
                            if (Session["GradeID"].ToString() == "2")
                            {
                                string query = "select NAMA from q_IjinSuratPegawai WHERE NO_SURAT='" + hasil[i] + "'";
                                hasil__ += "<td class=\"center\">" + getPeserta(query) + "</td>";
                            }
                        }
                        else
                        {
                            hasil__ += "<td class=\"center\">" + hasil[i] + "</td>";
                        }
                    }

                }
                // cekbox = status;
                hasil__ += "<td><a href='#' class=btn btn-primary   onclick=print('" + hasil["NO_SURAT"] + "','" + c.Request.Form["tgl_awal"].ToString() + "')  ><i class='glyphicon glyphicon-print'></i> </a></td><td><a href='#' class=btn btn-primary  data-toggle='tab' onclick=" + fungsi_edit + "('" + hasil[keyYangDiambil] + "')  ><i class='glyphicon glyphicon-pencil'></i> </a></td><td><a href='#'  onclick=" + fungsi_hapus + "('" + hasil[keyYangDiambil] + "','" + hasil["DOKUMEN_SURAT"] + "','" + hasil["NO_SURAT"] + "')  ><i class='glyphicon glyphicon-trash'></i> </a></td>";
                hasil__ += "</tr>";
                a++;
            }


            con.Close();

        }
        catch (SqlException ex)
        {
            hasil__ = ex.Message + ", " + queryClient;
            // HttpContext.Current.Response.Write(generateJsonStatus("Maaf Data Tidak Bisa Ditampilkan silakan cek Koneksi", ex.Message.ToString() + ", " + queryClient));
        }
        return hasil__ + "</tr>";
    }
    public string generateTableCekboxDanPDF___(string queryClient, string fungsi_edit, string fungsi_hapus, string keyYangDiambil)
    {
        HttpContext c = HttpContext.Current;
        string hasil_ = "<tr>";
        string hasil__ = "";

        try
        {
            string koneksi = ConfigurationManager.ConnectionStrings["StrCn"].ConnectionString;
            SqlConnection con = new SqlConnection(koneksi);
            SqlCommand cmd = new SqlCommand(queryClient, con);
            con.Open();
            SqlDataReader hasil = cmd.ExecuteReader();
            string cekbox = "";
            int a = 0;
            string idchekbox = "";
            while (hasil.Read())
            {
                hasil__ += "<tr class=\"odd gradeX\">";
                int field = hasil.FieldCount;

                if (hasil["DOKUMEN_SURAT"].ToString() != "")
                {
                    //  hasil__ += "<td><a href='pdf/" + hasil["DOKUMEN_SURAT"] + "'  class=btn btn-primary  ><img src='../images/pdf.jpg' style='width:35px'><div class=box><iframe src='pdf/" + hasil["DOKUMEN_SURAT"] + "' width = 500px height = 500px></iframe></div></a></td>";
                    hasil__ += "<td><a href='#' onclick=zzooom_('" + hasil["DOKUMEN_SURAT"] + "') > <img src='../images/pdf.jpg' style='width:25px'></a>";
                }
                else
                {
                    hasil__ += "<td><a href='" + hasil["DOKUMEN_SURAT"] + "' style='display:none'></a></td>";
                }

                for (int i = 0; i < field; i++)
                {
                    //      jsonWriter1.WritePropertyName(hasil.GetName(i));
                    //     jsonWriter1.WriteValue(hasil[i]);

                    hasil_ += "<th>" + hasil.GetName(i) + "</th>";
                    if (hasil.GetName(i) != "ID" && hasil.GetName(i) != "ROWID" && hasil.GetName(i) != "URUTAN" && hasil.GetName(i) != "DOKUMEN_SURAT")
                    {
                        
                        hasil__ += "<td class=\"center\">" + hasil[i] + "</td>";
                    }

                }
                // cekbox = status;
                hasil__ += "<td><a href='#' class=btn btn-primary   onclick=print('" + hasil["NO_SURAT"] + "','" + hasil["TGL_AWAL"].ToString() + "')  ><i class='glyphicon glyphicon-print'></i> </a></td><td><a href='#' class=btn btn-primary  data-toggle='tab' onclick=" + fungsi_edit + "('" + hasil[keyYangDiambil] + "')  ><i class='glyphicon glyphicon-pencil'></i> </a></td><td><a href='#'  onclick=" + fungsi_hapus + "('" + hasil[keyYangDiambil] + "','" + hasil["DOKUMEN_SURAT"] + "','" + hasil["NO_SURAT"] + "')  ><i class='glyphicon glyphicon-trash'></i> </a></td>";
                hasil__ += "</tr>";
                a++;
            }


            con.Close();

        }
        catch (SqlException ex)
        {
            hasil__ = ex.Message + ", " + queryClient;
            // HttpContext.Current.Response.Write(generateJsonStatus("Maaf Data Tidak Bisa Ditampilkan silakan cek Koneksi", ex.Message.ToString() + ", " + queryClient));
        }
        return hasil__ + "</tr>";
    }

    public string getPeserta(string query)
    {
        string values = "";
        try
        {
            //string queryString = "SELECT * from taJenisCharts";
            
            string koneksi = ConfigurationManager.ConnectionStrings["strCn"].ConnectionString;
            SqlConnection connection = new SqlConnection(koneksi);
            SqlCommand cmd = new SqlCommand(query, connection);
            connection.Open();
            SqlDataReader hasil = cmd.ExecuteReader();
            while (hasil.Read())
            {
                values +="- "+ hasil["NAMA"].ToString()+"</br>";
            }
            connection.Close();

        }
        catch (SqlException ex)
        {
            ex.Message.ToString();
            //  HttpContext.Current.Response.Write(ex.Message.ToString());
        }
        return values ;
    }
    public string generateDataTable()
    {
        string query = "select JUDUL,KONTEN,case IS_ADMIN when 'True' THEN 'Admin' ELSE 'User' END AS IS_ADMIN,ID_INFORMASI AS ID from taInformasi";
        return generateTableCekbox(query, "editInformasi", "hapusInformasi", "ID");
    }
    public void dataTable(string query)
    {
        try
        {
            string koneksi = ConfigurationManager.ConnectionStrings["StrCn"].ConnectionString;
            SqlConnection con = new SqlConnection(koneksi);
            SqlCommand cmd = new SqlCommand(query, con);
            con.Open();
            SqlDataReader hasil = cmd.ExecuteReader();
            StringBuilder sb = new StringBuilder();
            StringWriter sw = new StringWriter(sb);
            JsonWriter jsonWriter1 = new JsonTextWriter(sw);

            jsonWriter1.WriteStartObject();
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
                    //   jsonWriter1.WriteValue(query);

                }
                jsonWriter1.WriteEndObject();
            }
            jsonWriter1.WriteEndArray();
            jsonWriter1.WriteEndObject();
            HttpContext.Current.Response.Write(sb);
            con.Close();
        }
        catch (SqlException ex)
        {
            HttpContext.Current.Response.Write(ex.Message.ToString() + "," + query);
            //   HttpContext.Current.Response.Write(generateJsonStatus("Maaf Data Tidak Bisa Ditampilkan silakan cek Koneksi", ex.Message.ToString()));
        }
    }
    public string crudData(string query, string message)
    {

        try
        {


            string koneksi = ConfigurationManager.ConnectionStrings["strCn"].ConnectionString;
            SqlConnection con = new SqlConnection(koneksi);
            SqlCommand cmd = new SqlCommand(query, con);

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

        }
        catch (SqlException ex)
        {
            message += ex.Message;
            Response.Write("Data Gagal Disimpan !!!");
        }
        return message;
    }


    public void ddlData(string query)
    {
        try
        {
            string koneksi = ConfigurationManager.ConnectionStrings["StrCn"].ConnectionString;
            SqlConnection con = new SqlConnection(koneksi);
            SqlCommand cmd = new SqlCommand(query, con);
            con.Open();
            SqlDataReader hasil = cmd.ExecuteReader();
            StringBuilder sb = new StringBuilder();
            StringWriter sw = new StringWriter(sb);
            JsonWriter jsonWriter1 = new JsonTextWriter(sw);

            // jsonWriter1.WriteStartObject();
            //jsonWriter1.WritePropertyName("data");
            jsonWriter1.WriteStartArray();

            while (hasil.Read())
            {
                jsonWriter1.WriteStartObject();

                int field = hasil.FieldCount;
                for (int i = 0; i < field; i++)
                {
                    jsonWriter1.WritePropertyName(hasil.GetName(i));
                    jsonWriter1.WriteValue(hasil[i]);
                    //   jsonWriter1.WriteValue(query);

                }
                jsonWriter1.WriteEndObject();
            }
            jsonWriter1.WriteEndArray();
            //jsonWriter1.WriteEndObject();
            HttpContext.Current.Response.Write(sb);
            con.Close();
        }
        catch (SqlException ex)
        {
            HttpContext.Current.Response.Write(ex.Message.ToString() + "," + query);
            //   HttpContext.Current.Response.Write(generateJsonStatus("Maaf Data Tidak Bisa Ditampilkan silakan cek Koneksi", ex.Message.ToString()));
        }
    }



    public void masukDataKomponen(string queryClient)
    {
        try
        {
            string koneksi = ConfigurationManager.ConnectionStrings["strCn"].ConnectionString;
            SqlConnection con = new SqlConnection(koneksi);
            SqlCommand cmd = new SqlCommand(queryClient, con);
            con.Open();
            SqlDataReader hasil = cmd.ExecuteReader();
            StringBuilder sb = new StringBuilder();
            StringWriter sw = new StringWriter(sb);
            JsonWriter jsonWriter1 = new JsonTextWriter(sw);

            jsonWriter1.WriteStartObject();
            jsonWriter1.WritePropertyName("rows");
            jsonWriter1.WriteStartArray();

            while (hasil.Read())
            {
                jsonWriter1.WriteStartObject();

                int field = hasil.FieldCount;
                for (int i = 0; i < field; i++)
                {
                    if (hasil[i] != "")
                    {
                        jsonWriter1.WritePropertyName(hasil.GetName(i));
                        jsonWriter1.WriteValue(hasil[i]);
                    }
                    else
                    {
                        jsonWriter1.WritePropertyName(hasil.GetName(i));
                        jsonWriter1.WriteValue("0");
                    }

                }

                jsonWriter1.WriteEndObject();
            }

            jsonWriter1.WriteEndArray();
            jsonWriter1.WritePropertyName("Status");
            jsonWriter1.WriteValue(queryClient);
            jsonWriter1.WriteEndObject();
            HttpContext.Current.Response.Write(sb);
            con.Close();
        }
        catch (SqlException ex)
        {
            HttpContext.Current.Response.Write(ex.Message);
        }
    }
    public void masukDataGrafik(string queryClient)
    {
        try
        {
            string koneksi = ConfigurationManager.ConnectionStrings["strCn"].ConnectionString;
            SqlConnection con = new SqlConnection(koneksi);
            SqlCommand cmd = new SqlCommand(queryClient, con);
            con.Open();
            SqlDataReader hasil = cmd.ExecuteReader();
            StringBuilder sb = new StringBuilder();
            StringWriter sw = new StringWriter(sb);
            JsonWriter jsonWriter1 = new JsonTextWriter(sw);

            jsonWriter1.WriteStartObject();
            jsonWriter1.WritePropertyName("rows");
            jsonWriter1.WriteStartArray();

            while (hasil.Read())
            {
                

                int field = hasil.FieldCount;
                for (int i = 0; i < field; i++)
                {
                    if (hasil[i] != "")
                    {
                        if (hasil.GetName(i) != "NIP")
                        {

                            jsonWriter1.WriteStartObject();
                            jsonWriter1.WritePropertyName("VALUE");
                            jsonWriter1.WriteValue(hasil.GetName(i).ToString());
                            jsonWriter1.WritePropertyName("JUMLAH");
                            jsonWriter1.WriteValue(hasil[i]);
                            jsonWriter1.WriteEndObject();
                        }
                        
                    }
                    else
                    {
                        if (hasil.GetName(i) != "NIP")
                        {
                            jsonWriter1.WriteStartObject();
                            jsonWriter1.WritePropertyName("VALUE");
                            jsonWriter1.WriteValue(hasil.GetName(i));
                            jsonWriter1.WritePropertyName("JUMLAH");
                            jsonWriter1.WriteValue(hasil[i]);
                            jsonWriter1.WriteEndObject();
                        }
                    }

                }

                
            }

            jsonWriter1.WriteEndArray();
            jsonWriter1.WritePropertyName("Status");
            jsonWriter1.WriteValue(queryClient);
            jsonWriter1.WriteEndObject();
            HttpContext.Current.Response.Write(sb);
            con.Close();
        }
        catch (SqlException ex)
        {
            HttpContext.Current.Response.Write(ex.Message);
        }
    }
    public string generateTableCekbox(string queryClient, string fungsi_edit, string fungsi_hapus, string keyYangDiambil)
    {
        string hasil_ = "<tr>";
        string hasil__ = "";

        try
        {
            string koneksi = ConfigurationManager.ConnectionStrings["strCn"].ConnectionString;
            SqlConnection con = new SqlConnection(koneksi);
            SqlCommand cmd = new SqlCommand(queryClient, con);
            con.Open();
            SqlDataReader hasil = cmd.ExecuteReader();
            string cekbox = "";
            int a = 0;
            string idchekbox = "";
            while (hasil.Read())
            {
                hasil__ += "<tr>";
                int field = hasil.FieldCount;

                for (int i = 0; i < field; i++)
                {
                    //      jsonWriter1.WritePropertyName(hasil.GetName(i));
                    //     jsonWriter1.WriteValue(hasil[i]);
                    if (hasil.GetName(i).ToString() != "ID")
                    {

                        hasil_ += "<th>" + hasil.GetName(i) + "</th>";
                        hasil__ += "<td >" + hasil[i] + "</td>";
                    }


                }
                hasil__ += "<td class=\"center\" ><a href='#'   data-toggle='modal' onclick=" + fungsi_edit + "('" + hasil[keyYangDiambil] + "')  ><img src='images/iedit.gif' /></a></td><td><a href='#'  onclick=" + fungsi_hapus + "('" + hasil[keyYangDiambil] + "')  ><img src='images/idelete.gif' /> </a></td>";
                hasil__ += "</tr>";
                a++;
            }


            con.Close();

        }
        catch (SqlException ex)
        {
            hasil__ = ex.Message + ", " + queryClient;
            // HttpContext.Current.Response.Write(generateJsonStatus("Maaf Data Tidak Bisa Ditampilkan silakan cek Koneksi", ex.Message.ToString() + ", " + queryClient));
        }
        return hasil__ + "</tr>";
    }
    public void generateTable_(string queryClient)
    {
        string hasil_ = "<tr>";
        string hasil__ = "";

        try
        {
            string koneksi = ConfigurationManager.ConnectionStrings["strCn"].ConnectionString;
            SqlConnection con = new SqlConnection(koneksi);
            SqlCommand cmd = new SqlCommand(queryClient, con);
            con.Open();
            SqlDataReader hasil = cmd.ExecuteReader();
            int a = 0;
            while (hasil.Read())
            {
                hasil__ += "<tr>";
                int field = hasil.FieldCount;

                for (int i = 0; i < field; i++)
                {
                    //      jsonWriter1.WritePropertyName(hasil.GetName(i));
                    //     jsonWriter1.WriteValue(hasil[i]);
                    if (hasil.GetName(i).ToString() != "ID")
                    {

                        hasil_ += "<th>" + hasil.GetName(i) + "</th>";
                        hasil__ += "<td >" + hasil[i] + "</td>";
                    }


                }
                
                a++;
            }

            
            con.Close();
            
        }
        catch (SqlException ex)
        {
            hasil__ = ex.Message + ", " + queryClient;
            // HttpContext.Current.Response.Write(generateJsonStatus("Maaf Data Tidak Bisa Ditampilkan silakan cek Koneksi", ex.Message.ToString() + ", " + queryClient));
        }
        HttpContext.Current.Response.Write(hasil__+"</tr>");
    }
    public string simpanDataUpdateDeleteTabel(string query, string message)
    {
        //string message2 = "";
        try
        {
            string koneksi = ConfigurationManager.ConnectionStrings["strCn"].ConnectionString;
            SqlConnection con = new SqlConnection(koneksi);
            SqlCommand cmd = new SqlCommand(query, con);

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            //Response.Write("Data Berhasil Disimpan");
            //message2 = message;

        }
        catch (SqlException ex)
        {
            message = "Data Gagal Diproses!!! " + ex.Message + " ," + query;
            //Response.Write("Data Gagal Disimpan !!!");
        }
        return message;
    }
    public string simpanDataSuratIjin(string query, string message,string kode_ijin, string tahun,string noSurat)
    {
        string noreg = "";
        string query_ = query.ToString().Replace("@KODE_REKAP", noreg);
        //string message2 = "";
        try
        {
            
            
            string koneksi = ConfigurationManager.ConnectionStrings["strCn"].ConnectionString;
            SqlConnection con = new SqlConnection(koneksi);
            SqlCommand cmd = new SqlCommand(query_, con);

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            //Response.Write("Data Berhasil Disimpan");
            //message2 = message;
            noreg = getNoreg("select CONCAT(KODE_REKAP,'/',ID_SURAT) AS JUMLAH  from q_IjinSurat where NO_SURAT='" + noSurat + "'");
            message += "-" + noreg+" ";
        }
        catch (SqlException ex)
        {
            message = "Data Gagal Diproses!!!" + "-" + ex.Message + "-" + query_ + " select CONCAT(KODE_REKAP,'/',ID_SURAT) AS JUMLAH  from q_IjinSurat where NO_SURAT='" + noSurat + "' " + noreg;
            //Response.Write("Data Gagal Disimpan !!!");
        }
        return message;
    }
    public string simpanDataSuratRakor(string query, string message, string kode_ijin, string tahun,string noSurat)
    {
        string noreg = "";
        string query_ = query.ToString().Replace("@KODE_REKAP", noreg);
        //string message2 = "";
        try
        {


            string koneksi = ConfigurationManager.ConnectionStrings["strCn"].ConnectionString;
            SqlConnection con = new SqlConnection(koneksi);
            SqlCommand cmd = new SqlCommand(query_, con);

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            //Response.Write("Data Berhasil Disimpan");
            //message2 = message;
            noreg = getNoreg("select CONCAT(KODE_REKAP,'/',ID_SURAT) AS JUMLAH  from q_IjinSuratRakor where KODE_IJIN='RK' AND NO_SURAT='"+noSurat+"'");
            message += "-" + noreg ;
        }
        catch (SqlException ex)
        {
            message = "Data Gagal Diproses!!!" + "-" + ex.Message + "-" + query_ + " select CONCAT(KODE_REKAP,'/',ID_SURAT) AS JUMLAH  from q_IjinSuratRakor where KODE_IJIN='RK' AND NO_SURAT='" + noSurat + "' ";
            //Response.Write("Data Gagal Disimpan !!!");
        }
        return message;
    }
    public string getNoreg(string query)
    {
        string message = "";
        try
        {
            string koneksi = ConfigurationManager.ConnectionStrings["strCn"].ConnectionString;
            SqlConnection con = new SqlConnection(koneksi);
            SqlCommand cmd = new SqlCommand(query, con);

            con.Open();
            SqlDataReader hasil = cmd.ExecuteReader();
            while (hasil.Read())
            {
                if (hasil["JUMLAH"].ToString() == "")
                {
                    message = "1";
                }
                else {
                    message = hasil["JUMLAH"].ToString();
                }
                
            }
            con.Close();
            //Response.Write("Data Berhasil Disimpan");
            //message2 = message;
           
        }
        catch (SqlException ex)
        {
           message=ex.Message+", "+query;
        }
        return message;
    }
    public string getJumlahHari(string query)
    {
        string message = "";
        try
        {
            string koneksi = ConfigurationManager.ConnectionStrings["strCn"].ConnectionString;
            SqlConnection con = new SqlConnection(koneksi);
            SqlCommand cmd = new SqlCommand(query, con);

            con.Open();
            SqlDataReader hasil = cmd.ExecuteReader();
            while (hasil.Read())
            {
                message = hasil["JUMLAH"].ToString();
                
                
            }
            con.Close();
            //Response.Write("Data Berhasil Disimpan");
            //message2 = message;
           
        }
        catch (SqlException ex)
        {
           message=ex.Message+", "+query;
        }
        return message;
    }
    public string getDataEasyUiJson( string fungsi_edit, string fungsi_hapus, string keyYangDiambil,string query,string queryCount)
    {
        string hasil___ = "";
        try
        {
            string koneksi = ConfigurationManager.ConnectionStrings["StrCn"].ConnectionString;
            SqlConnection con = new SqlConnection(koneksi);
            SqlCommand cmd = new SqlCommand(query, con);
            con.Open();
            SqlDataReader hasil = cmd.ExecuteReader();
            StringBuilder sb = new StringBuilder();
          //  sb.Clear();
            string cekbox = "";
            int a = 0;
            string idchekbox = "";
            StringWriter sw = new StringWriter(sb);

            JsonWriter jsonWriter1 = new JsonTextWriter(sw);

            jsonWriter1.WriteStartObject();

            jsonWriter1.WritePropertyName("total");
            jsonWriter1.WriteValue(jumlahData(queryCount));

            jsonWriter1.WritePropertyName("rows");
            jsonWriter1.WriteStartArray();

            while (hasil.Read())
            {
                jsonWriter1.WriteStartObject();

                int field = hasil.FieldCount;
                for (int i = 0; i < field; i++)
                {
                    if (hasil.GetName(i) == "DISETUJUI")
                    {
                        string status = hasil["DISETUJUI"].ToString().Trim();
                        idchekbox = "id=idchk_" + fungsi_edit + "_" + a.ToString();
                        idchekbox = "#idchk_" + fungsi_edit + "_" + a.ToString();

                        if (status.Equals("BELUM DISETUJUI"))
                        {
                            cekbox = "<input type='checkbox' name=chk_" + fungsi_edit + "[] id=idchk_" + fungsi_edit + "_" + a + " onclick=chk" + fungsi_edit + "('" + hasil[keyYangDiambil] + "','" + a + "') />";
                        }
                        else
                        {
                            cekbox = "<input type='checkbox' checked='checked' name=chk_" + fungsi_edit + "[] id=idchk_" + fungsi_edit + "_" + a + " onclick=chk" + fungsi_edit + "('" + hasil[keyYangDiambil] + "','" + a + "') />";
                        }
                        jsonWriter1.WritePropertyName("DISETUJUI");
                        jsonWriter1.WriteValue(cekbox);
                    }
                    else if (hasil.GetName(i) == "DOKUMEN_SURAT")
                    {
                        if (hasil["DOKUMEN_SURAT"].ToString() != "")
                        {
                            jsonWriter1.WritePropertyName("DOKUMEN_SURAT");
                            jsonWriter1.WriteValue("<a href='#' data-toggle='modal' onclick=zzooom('pdf/" + hasil["DOKUMEN_SURAT"] + "')  > <img src='../images/pdf.jpg' style='width:25px'></a>");
                            //  hasil__ += "<td><a href='pdf/" + hasil["DOKUMEN_SURAT"] + "'  class=btn btn-primary  ><img src='../images/pdf.jpg' style='width:35px'><div class=box><iframe src='pdf/" + hasil["DOKUMEN_SURAT"] + "' width = 500px height = 500px></iframe></div></a></td>";

                        }
                        else
                        {
                            jsonWriter1.WritePropertyName("DOKUMEN_SURAT");
                            jsonWriter1.WriteValue("<a href='" + hasil["DOKUMEN_SURAT"] + "' style='display:none'></a>");

                        }
                    }
                    else
                    {
                        jsonWriter1.WritePropertyName(hasil.GetName(i));
                        jsonWriter1.WriteValue(hasil[i]);

                    }
                    jsonWriter1.WritePropertyName("edit");
                    jsonWriter1.WriteValue("<a href='#' class=btn btn-primary  data-toggle='modal' onclick=" + fungsi_edit + "('" + hasil[keyYangDiambil] + "')  ><i class='glyphicon glyphicon-pencil'></i> </a>");
                    jsonWriter1.WritePropertyName("hapus");
                    jsonWriter1.WriteValue("<a href='#' class=btn btn-primary onclick=" + fungsi_hapus + "('" + hasil[keyYangDiambil] + "')  ><i class='glyphicon glyphicon-trash'></i> </a>");
                }

                jsonWriter1.WriteEndObject();
            }
            a++;
            jsonWriter1.WriteEndArray();
            jsonWriter1.WritePropertyName("query");
            jsonWriter1.WriteValue(query);
            jsonWriter1.WriteEndObject();
            hasil___ = sb.ToString();
            //HttpContext.Current.Response.Write(sb);
            con.Close();
        }
        catch (SqlException ex)
        {
            hasil___ = ex.Message.ToString();
            //HttpContext.Current.Response.Write(generateJsonStatus("Maaf Data Tidak Bisa Ditampilkan silakan cek Koneksi", ex.Message.ToString() + ", " + queryClient));
        }
        return hasil___;
    }
     public int jumlahData(string queryClient)
    {
        int tampungHasil = 0;
        try
        {
            string koneksi = ConfigurationManager.ConnectionStrings["strCn"].ConnectionString;
            string query = queryClient;
            SqlConnection con = new SqlConnection(koneksi);
            SqlCommand cmd = new SqlCommand(query, con);
            con.Open();
            tampungHasil = Convert.ToInt32(cmd.ExecuteScalar());

            con.Close();
        }
        catch (SqlException ex)
        {
            return 0;
           // HttpContext.Current.Response.Write(generateJsonStatus("Kesalahan Pada Aplikasi", ex.Message.ToString() + ", " + queryClient));
        }
        return tampungHasil;
    }
     public string convertDate(string date)
     {
         string[] hasil = date.Split('/');

         return hasil[2] + "-" + hasil[1] + "-" + hasil[0];
     }
     public void generateJsonStatus(int count, string data,string query)
     {
         StringBuilder sb = new StringBuilder();
         StringWriter sw = new StringWriter(sb);
         JsonWriter jsonWriter1 = new JsonTextWriter(sw);
         jsonWriter1.WriteStartObject();
         jsonWriter1.WritePropertyName("count");
         jsonWriter1.WriteValue(count.ToString());
         jsonWriter1.WritePropertyName("data");
         jsonWriter1.WriteValue(data);
         jsonWriter1.WritePropertyName("query");
         jsonWriter1.WriteValue(query);
         jsonWriter1.WriteEndObject();

         Response.Write(sb.ToString());
     }
     public string convertToVarcharDateSql2(string field)
     {
         //return "CONVERT(varchar(10)," + field + ",105) as " + field;
         return "CONVERT(varchar(10)," + field + ",103) as " + field;
     }
     public void autocomplete(string query)
     {
         try
         {
             string koneksi = ConfigurationManager.ConnectionStrings["StrCn"].ConnectionString;
             SqlConnection con = new SqlConnection(koneksi);
             SqlCommand cmd = new SqlCommand(query, con);
             con.Open();
             SqlDataReader hasil = cmd.ExecuteReader();
             StringBuilder sb = new StringBuilder();
             StringWriter sw = new StringWriter(sb);
             JsonWriter jsonWriter1 = new JsonTextWriter(sw);

             //jsonWriter1.WriteStartObject();

             jsonWriter1.WriteStartArray();

             while (hasil.Read())
             {
                 jsonWriter1.WriteStartObject();

                 int field = hasil.FieldCount;
                 for (int i = 0; i < field; i++)
                 {
                     jsonWriter1.WritePropertyName(hasil.GetName(i));
                     jsonWriter1.WriteValue(hasil[i]);
                  //   jsonWriter1.WriteValue(query);

                 }
                 jsonWriter1.WriteEndObject();
             }
             jsonWriter1.WriteEndArray();
             //jsonWriter1.WriteEndObject();
             HttpContext.Current.Response.Write(sb);
             con.Close();
         }
         catch (SqlException ex)
         {
             HttpContext.Current.Response.Write( query);
          //   HttpContext.Current.Response.Write(generateJsonStatus("Maaf Data Tidak Bisa Ditampilkan silakan cek Koneksi", ex.Message.ToString()));
         }
     }
     private string doFilteringLookup(string nama)
     {
         string strFilter = "";

         string query = "SELECT NIP, PIN, NAMA FROM taKaryawan WHERE NON_AKTIF IS NULL AND NAMA LIKE '%" + nama + "%' OR NIP LIKE '%" + nama + "%' ";
         
         if ((Session["GradeID"].ToString() != "1") && (Session["GradeID"].ToString() != "1a"))
         {
            
             if (Session["GradeID"].ToString() == "2")
             {
                 //strFilter += "AND KODE_CABANG = '" + Session["CabangID"].ToString() + "'";
                 //strFilter += "AND KODE_BIRO='" + Session["BiroID"] + "' ";
             }
             else if (Session["GradeID"].ToString().Substring(0, 1) == "3")
             {
                 strFilter += "";
              //  strFilter += "AND KODE_BIRO='"+Session["BiroID"]+"' ";
             }
             else if (Session["GradeID"].ToString() == "4")
             {
                 strFilter += "AND NIP = '" + Session["NIPID"].ToString() + "'";
             }
             query += strFilter;
         }
         //dsLookup.FilterExpression = strFilter;
         //if (strFilter != "" && Session["GradeID"].ToString().Substring(0, 1) != "3")
         //{
         //    query += " AND " + strFilter;
         //}
         query += " ORDER BY NIP";
         return query;
     }
     private bool cekKredit(string queryCekIjin)
     {
         bool val = true;
         SqlConnection cn = new SqlConnection(Application["strCn"].ToString());
         string strSelect = "";
         strSelect = queryCekIjin;
         SqlCommand cmd = new SqlCommand(strSelect, cn);
         cn.Open();
         SqlDataReader hasil = cmd.ExecuteReader();
         while (hasil.Read())
         {
             if (hasil["KREDIT"].ToString() != "1")
             {
                 return false;
             }
         }
         return val;
         //DataSet dsMsg = new DataSet();
         //SqlDataAdapter adpSQL = new SqlDataAdapter(strSelect, cn);
         //adpSQL.Fill(dsMsg);
         //if (dsMsg.Tables[0].Rows[0][0].ToString() != "1")
         //{
         //    return false;
         //}
         //else
         //{
         //    return true;
         //}
     }
     public string genereateRandomNumber()
     {
         // azlib az = new azlib();
         Random ran = new Random();
         int randomValue = ran.Next(1000000000);
         // int randomValue2 = ran.Next(1000000000);
         string query_ = "";
         query_ = "SELECT COUNT(NO_SURAT) FROM q_IjinSurat WHERE NO_SURAT='"+randomValue+"'";
         if (jumlahData(query_) > 0)
         {
             genereateRandomNumber();
         }
         return randomValue.ToString();
     }
}