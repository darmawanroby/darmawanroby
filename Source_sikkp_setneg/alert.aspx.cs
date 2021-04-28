///''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
// 1. Identifikasi Program
//        Nama file     : alert.aspx.cs                                   
//        File terkait  : alert.aspx
//        Deskripsi     : Halaman Informasi Status data
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
using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using Udev.MasterPageWithLocalization.Classes;

namespace rtwin
{
    public partial class alert : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"].ToString() == "")
            {
                Response.Redirect("notauthorized.aspx");
            }

            string strCn;
            SqlConnection cn;
            string strSelect;
            string strFilter;
            DataSet dsMsg = new DataSet();
            SqlDataAdapter adpSQL;

            //Buka koneksi database DataReal
            strCn = Application["strCn"].ToString();
            cn = new SqlConnection(strCn);

            strFilter = "";
            if (Session["GradeID"].ToString() == "2") //validator
            {
                strFilter = " WHERE (KODE_CABANG ='" + Session["CabangID"].ToString() + "')";
            }
            else if (Session["GradeID"].ToString() != "1") //selain admin
            {
                strFilter = " where kode_departemen IN (SELECT KODE_DEPARTEMEN FROM taOtoritasDepartemen WHERE username='" + Session["UserID"].ToString() + "')";
            }

            strSelect = "declare @tglTutup smalldatetime " +
                "set @tglTutup = '" + (System.Convert.ToDateTime(Session["tglTutup"])).ToString("MM/dd/yyyy") + "' "+
                "select " +
                "case when sum(D.tot_ijinhari) is null then 0 else sum(D.tot_ijinhari) end as total_ijinhari, "+
                "case when sum(D.tot_ijinjam) is null then 0 else sum(D.tot_ijinjam) end as total_ijinjam, "+
                "case when sum(D.tot_lembur) is null then 0 else sum(D.tot_lembur) end as total_lembur, "+
                "case when sum(D.tot_pelanggaran) is null then 0 else sum(D.tot_pelanggaran) end as total_pelanggaran " +
                "from ( " +
                "select taKaryawan.NIP, taKaryawan.KODE_DEPARTEMEN, "+
                "case when A.jml_ijinhari is null then 0 else A.jml_ijinhari end AS tot_ijinhari, "+
                "case when B.jml_ijinjam is null then 0 else B.jml_ijinjam end AS tot_ijinjam, "+
                "case when C.jml_lembur is null then 0 else C.jml_lembur end AS tot_lembur, "+
                "case when E.jml_pelanggaran is null then 0 else E.jml_pelanggaran end AS tot_pelanggaran " +
                "from taKaryawan left join "+
                "(select NIP, count(NIP) as jml_ijinhari from taIjinHari "+
                "where status_ijin=0 and tgl_awal >= @tglTutup and tgl_awal<=dbo.LastDate(getdate()) "+
                "and nip in (select nip from taKaryawan" + strFilter + ") " +
                "group by nip) as A "+
                "on taKaryawan.NIP = A.NIP "+
                "left join "+ 
                "(select nip, count(nip) as jml_ijinjam from taijinjam "+
                "where status_ijin=0 and tgl_ijin >= @tglTutup and tgl_ijin<=dbo.LastDate(getdate()) "+
                "and nip in (select nip from taKaryawan" + strFilter + ") " +
                "group by nip) as B "+
                "on taKaryawan.NIP = B.NIP "+
                "left join "+ 
                "(select nip, count(nip) as jml_lembur from taLembur "+
                "where status_lembur=0 and tgl_spl >= @tglTutup and tgl_spl<=dbo.LastDate(getdate()) "+
                "and nip in (select nip from taKaryawan" + strFilter + ") " +
                "group by nip) as C "+
                "on taKaryawan.NIP = C.NIP "+
                "left join "+
                "(select nip, count(nip) as jml_pelanggaran from q_Pelanggaran where year(periode_pelanggaran) = year(getdate()) " + 
                "and nip in (select nip from taKaryawan" + strFilter + ") " +
                "group by nip) as E "+ 
                "on taKaryawan.NIP = E.NIP "+
                "where (not A.jml_ijinhari is null) or (not B.jml_ijinjam is null) or (not C.jml_lembur is null) or (not E.jml_pelanggaran is null)" + 
                ") as D";

            adpSQL = new SqlDataAdapter(strSelect, cn);
            adpSQL.Fill(dsMsg);

            lblAlert.Text = "Status Data Entry yang belum disetujui oleh validator kepegawaian : <br/><br>";
            int recordCount = dsMsg.Tables[0].Rows.Count;
            if (recordCount > 0)
            {
                lblAlert.Text += "<table width='200'><tr><td colspan='3'>&nbsp;</td>";
                lblAlert.Text += "</tr><tr>";

                lblAlert.Text += "<td>Ijin harian</td>";
                lblAlert.Text += "<td align='right'>" + dsMsg.Tables[0].Rows[0][0].ToString() + "</td>";
                if (Int32.Parse(dsMsg.Tables[0].Rows[0][0].ToString()) > 0)
                {
                    lblAlert.Text += "<td><a href='dayoff.aspx?process=no'>Lihat</a></td>";
                }
                else
                {
                    lblAlert.Text += "<td></td>";
                }
                lblAlert.Text += "</tr><tr>";

                lblAlert.Text += "<td>Ijin perjam</td>";
                lblAlert.Text += "<td align='right'>" + dsMsg.Tables[0].Rows[0][1].ToString() + "</td>";
                if (Int32.Parse(dsMsg.Tables[0].Rows[0][1].ToString()) > 0)
                {
                    lblAlert.Text += "<td><a href='timeoff.aspx?process=no'>Lihat</a></td>";
                }
                else
                {
                    lblAlert.Text += "<td></td>";
                }
                lblAlert.Text += "</tr><tr>";

                lblAlert.Text += "<td>Lembur</td>";
                lblAlert.Text += "<td align='right'>" + dsMsg.Tables[0].Rows[0][2].ToString() + "</td>";
                if (Int32.Parse(dsMsg.Tables[0].Rows[0][2].ToString()) > 0)
                {
                    lblAlert.Text += "<td><a href='notice.aspx?process=no'>Lihat</a></td>";
                }
                else
                {
                    lblAlert.Text += "<td></td>";
                }

                lblAlert.Text += "</tr><tr>";

                lblAlert.Text += "<td>Pelanggaran</td>";
                lblAlert.Text += "<td align='right'>" + dsMsg.Tables[0].Rows[0][3].ToString() + "</td>";
                if (Int32.Parse(dsMsg.Tables[0].Rows[0][3].ToString()) > 0)
                {
                    lblAlert.Text += "<td><a href='foul.aspx'>Lihat</a></td>";
                }
                else
                {
                    lblAlert.Text += "<td></td>";
                }

                lblAlert.Text += "</tr></table>";

                lblAlert.Visible = true;
            }
            else
            {
                Response.Redirect("level.aspx");
            }

            cn.Close();
        }
    }
}
