using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.OleDb;
using System.IO;
using System.Data.SqlClient;


public partial class upload_salary : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Seleksi Hak akses Halaman
        if (!rtwin.azlib.AksesHalaman(23, Session["UserID"].ToString(), Session["GradeID"].ToString(), Session["MenuID"].ToString()))
        {
            //Redirect ke page notauthorized.aspx bila tidak berhak mengakses
            Response.Redirect("notauthorized.aspx");
        }
    }

    protected void btnImport_Click(object sender, EventArgs e)
    {
        string connString = "";
        string strFileType = Path.GetExtension(fileuploadExcel.FileName).ToLower();
        string path = Server.MapPath("tmp") + "\\" + fileuploadExcel.PostedFile.FileName;
        fileuploadExcel.PostedFile.SaveAs(path);
        //Response.Write(path);
        //Connection String to Excel Workbook
        if (strFileType.Trim() == ".xls")
        {
            connString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + path + ";Extended Properties=\"Excel 12.0;HDR=Yes;IMEX=2\"";
            //connString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + path + ";Extended Properties=\"Excel 8.0;HDR=Yes;IMEX=2\"";
        }
        else if (strFileType.Trim() == ".xlsx")
        {
            connString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + path + ";Extended Properties=\"Excel 12.0;HDR=Yes;IMEX=2\"";
        }
        string query = "SELECT [bulan],[tahun],[nip],[gjpokok],[tjistri],[tjanak],[tjupns],[tjstruk],[tjfungs],[pembul],[tjberas],[potpph],[stspajak] FROM [lampiranspm$]";
        OleDbConnection conn = new OleDbConnection(connString);
        if (conn.State == ConnectionState.Closed)
            conn.Open();
        OleDbCommand cmd = new OleDbCommand(query, conn);
        OleDbDataAdapter da = new OleDbDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        grvExcelData.DataSource = ds.Tables[0];
        grvExcelData.DataBind();
        da.Dispose();
        conn.Close();
        conn.Dispose();
        btnSave.Visible = true;
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        SqlConnection myconection = new SqlConnection(Application["strCn"].ToString());
        SqlCommand mycomand;

        if (grvExcelData.HeaderRow != null)
        {
            string xBULAN = "";
            string xTAHUN = "";

            mycomand = new SqlCommand();
            mycomand.Connection = myconection;
            // mycomand.CommandTimeout = 0;

            for (int i = 0; i < grvExcelData.Rows.Count; i++)
            {

                // [bulan],[tahun],[nip],[gjpokok],[tjistri],[tjanak],[tjupns],[tjstruk],[tjfungs],[pembul],[tjberas],[potpph],[stspajak]
                string BULAN = grvExcelData.Rows[i].Cells[0].Text;
                string TAHUN = grvExcelData.Rows[i].Cells[1].Text;
                string NIP = grvExcelData.Rows[i].Cells[2].Text;

                string GJPOKOK = grvExcelData.Rows[i].Cells[3].Text;
                string TJISTRI = grvExcelData.Rows[i].Cells[4].Text;
                string TJANAK = grvExcelData.Rows[i].Cells[5].Text;
                string TJUPNS = grvExcelData.Rows[i].Cells[6].Text;
                string TJSTRUK = grvExcelData.Rows[i].Cells[7].Text;
                string TJFUNGS = grvExcelData.Rows[i].Cells[8].Text;
                string PEMBUL = grvExcelData.Rows[i].Cells[9].Text;
                string TJBERAS = grvExcelData.Rows[i].Cells[10].Text;
                string POTPPH = grvExcelData.Rows[i].Cells[11].Text;
                string KDKAWIN = grvExcelData.Rows[i].Cells[12].Text;

                if (xBULAN == "")
                    xBULAN = BULAN;
                if (xTAHUN == "")
                    xTAHUN = TAHUN;

                try
                {
                    mycomand.CommandText = "INSERT INTO taPPH(NIP,TAHUN,BULAN,GJPOKOK,TJISTRI,TJANAK,TJUPNS,TJSTRUK,TJFUNGS,PEMBUL,TJBERAS,POTPPH,KDKAWIN) ";
                    mycomand.CommandText += "VALUES ('" + NIP + "', " + TAHUN + ", " + BULAN + "," + GJPOKOK + "," + TJISTRI + "," + TJANAK + "," + TJUPNS + "," + TJSTRUK + "," + TJFUNGS + "," + PEMBUL + "," + TJBERAS + "," + POTPPH + "," + KDKAWIN + ")";
                     
                    mycomand.Connection.Open();
                    mycomand.ExecuteNonQuery();
                    mycomand.Connection.Close();

                }
                catch (Exception ex)
                {
                    try
                    {
                        mycomand.CommandText = "UPDATE taPPH SET GJPOKOK=" + GJPOKOK + ",TJISTRI=" + TJISTRI + ",TJANAK=" + TJANAK + ",TJUPNS=" + TJUPNS + ",TJSTRUK=" + TJSTRUK + ",TJFUNGS=" + TJFUNGS + ",PEMBUL=" + PEMBUL + ",TJBERAS=" + TJBERAS + ",POTPPH=" + POTPPH + ",KDKAWIN=" + KDKAWIN + " ";
                        mycomand.CommandText += "WHERE NIP='" + NIP + "' AND TAHUN=" + TAHUN + " AND BULAN=" + BULAN + " AND LEN(NIP) > 1";
                        //mycomand.Connection.Open();
                        mycomand.ExecuteNonQuery();
                        mycomand.Connection.Close();
                    }
                    catch (Exception ex0)
                    {

                        lblError.Text += "";
                        //lblError.Text += grvExcelData.Rows[i].Cells[2].Text + " " + Label2.Text + " [" + ex.Message + "] <br/>";
                        //lblError.Text += mycomand.CommandText + " <br/>";
                        lblError.Visible = true;
                        //rtwin.azlib.LogImport(Session("UserID"), "2", GridView1.Rows(i).Cells(0).Text, "0", ex.Message, Application("strCn").ToString())
                        //if (ConnectionState.Open)
                        //{
                        mycomand.Connection.Close();
                        //}
                    } 
                }
            }
            lblError.Text += "Upload Data Gaji selesai.";
            lblError.Visible = true;
                try
                {
                    mycomand.CommandText = "INSERT INTO taPPHStatus(TAHUN,BULAN,WAKTU_UPLOAD,PAJAK_TAHUNAN,BULAN_AWAL,TAHUN_AWAL,BULAN_AKHIR,TAHUN_AKHIR) ";
                    mycomand.CommandText += "VALUES (" + xTAHUN + ", " + xBULAN + ", getdate(),  0, " + xBULAN + ", " + xTAHUN + ", " + xBULAN + ", " + xTAHUN + ")";
                     
                    mycomand.Connection.Open();
                    mycomand.ExecuteNonQuery();
                    mycomand.Connection.Close();
                }
                catch (Exception ex1)
                {
                    mycomand.CommandText = "UPDATE taPPHStatus SET WAKTU_UPLOAD = getdate() ";
                    mycomand.CommandText += "WHERE TAHUN=" + xTAHUN + " AND BULAN=" + xBULAN + " ";
                    //mycomand.Connection.Open();
                    mycomand.ExecuteNonQuery();
                    mycomand.Connection.Close();
                }
        }
       
       
    }
}
