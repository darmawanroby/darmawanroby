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


public partial class upload_manual : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Seleksi Hak akses Halaman
        if (!rtwin.azlib.AksesHalaman(13, Session["UserID"].ToString(), Session["GradeID"].ToString(), Session["MenuID"].ToString()))
        {
            //Redirect ke page notauthorized.aspx bila tidak berhak mengakses
            Response.Redirect("notauthorized.aspx");
        }
    }

    protected void btnImport_Click(object sender, EventArgs e)
    {
        string connString = "";
        string strFileType = Path.GetExtension(fileuploadExcel.FileName).ToLower();
        string path = Server.MapPath("tmp") + "\\" + Path.GetFileName(fileuploadExcel.PostedFile.FileName).ToString();
        fileuploadExcel.PostedFile.SaveAs(path);
        //Response.Write(path);
        //Connection String to Excel Workbook
        
        if (strFileType.Trim() == ".xls")
        {
            //connString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + path + ";Extended Properties=\"Excel 8.0;HDR=Yes;IMEX=2\"";
            connString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + path + ";Extended Properties=\"Excel 12.0;HDR=Yes;IMEX=2\"";
        }
        else if (strFileType.Trim() == ".xlsx")
        {
            connString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + path + ";Extended Properties=\"Excel 12.0;HDR=Yes;IMEX=2\"";
        }
        string query = "SELECT [PIN],[TGL_MASUK],[JAM_MASUK],[JAM_KELUAR] FROM [Sheet1$]";
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
            for (int i = 0; i < grvExcelData.Rows.Count; i++)
            {
                mycomand =  new SqlCommand();
                mycomand.Connection = myconection;
                mycomand.CommandTimeout = 0;
                try
                {
                    string PIN = grvExcelData.Rows[i].Cells[0].Text;
                    string TGL_MASUK = grvExcelData.Rows[i].Cells[1].Text;
                    string JAM_MASUK = grvExcelData.Rows[i].Cells[2].Text;
                    string JAM_KELUAR = grvExcelData.Rows[i].Cells[3].Text;

                    //mycomand.CommandText = "INSERT INTO taAbsenTmp (PIN, TGL_MASUK, JAM_MASUK, JAM_KELUAR)";
                    //mycomand.CommandText += "SELECT dbo.FillChars('" + PIN + "','0',10,1) AS PIN, convert(datetime,'" + TGL_MASUK + "', 103) AS TGL_MASUK, convert(datetime, '" + TGL_MASUK + "', 103) + ' " + JAM_MASUK + "' AS JAM_MASUK, convert(datetime, '" + TGL_MASUK + "', 103) + ' " + JAM_KELUAR + "' AS JAM_KELUAR";
                    mycomand.CommandText = "INSERT INTO taAbsen (NIP, TGL_MASUK, KODE_ABSEN, KODE_RANGE, JAM_MASUK, JAM_KELUAR, ISI_MANUAL)";
                    //mycomand.CommandText += "SELECT NIP, convert(datetime,'" + TGL_MASUK + "', 103) AS TGL_MASUK, '1' AS KODE_ABSEN, dbo.RangeCode(NIP,convert(datetime,'" + TGL_MASUK + "', 103)) AS KODE_RANGE, convert(datetime, '" + TGL_MASUK + "', 103) + ' " + JAM_MASUK + "' AS JAM_MASUK, convert(datetime, '" + TGL_MASUK + "', 103) + ' " + JAM_KELUAR + "' AS JAM_KELUAR, 'Y' AS ISI_MANUAL FROM taKaryawan where pin = dbo.FillChars('" + PIN + "','0',10,1)";
                    mycomand.CommandText += "SELECT NIP, convert(datetime,'" + TGL_MASUK + "', 103) AS TGL_MASUK, '1' AS KODE_ABSEN, dbo.RangeCode(NIP,convert(datetime,'" + TGL_MASUK + "', 103)) AS KODE_RANGE, convert(datetime, '" + TGL_MASUK + "', 103) + ' " + JAM_MASUK + "' AS JAM_MASUK, case when ' " + JAM_MASUK + "' >= ' " + JAM_KELUAR + "' then dateadd(day,1,convert(datetime, '" + TGL_MASUK + "', 103)) + ' " + JAM_KELUAR + "' else convert(datetime, '" + TGL_MASUK + "', 103) + ' " + JAM_KELUAR + "' end AS JAM_KELUAR, 'Y' AS ISI_MANUAL FROM taKaryawan where pin = dbo.FillChars('" + PIN + "','0',10,1)";
                    
                    mycomand.Connection.Open();
                    mycomand.ExecuteNonQuery();
                    mycomand.Connection.Close();
                                
                    lblError.Text += grvExcelData.Rows[i].Cells[0].Text + " Berhasil<br/>";
                    lblError.Visible = true;
                    rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "2106", PIN + "," + TGL_MASUK, Application["strCn"].ToString());

                }
                catch (Exception ex)
                { 
                    //lblError.Text += grvExcelData.Rows[i].Cells[0].Text + " " + Label2.Text + " [" + ex.Message + "] <br/>";
                    lblError.Text += mycomand.CommandText + " <br/>";
                    lblError.Visible = true;
                    //rtwin.azlib.LogImport(Session("UserID"), "2", GridView1.Rows(i).Cells(0).Text, "0", ex.Message, Application("strCn").ToString())
                    //if (ConnectionState.Open)
                    //{
                            mycomand.Connection.Close();
                    //}
                }


            }
        }

        //DataTable dt = new DataTable();
 
            //// add the columns to the datatable            
            //if (dtg.HeaderRow != null)
            //{
 
            //    for (int i = 0; i < dtg.HeaderRow.Cells.Count; i++)
            //    {
            //        dt.Columns.Add(dtg.HeaderRow.Cells[i].Text);
            //    }
            //}
 
            ////  add each of the data rows to the table
            //foreach (GridViewRow row in dtg.Rows)
            //{
            //    DataRow dr;
            //    dr = dt.NewRow();
 
            //    for (int i = 0; i < row.Cells.Count; i++)
            //    {
            //        dr[i] = row.Cells[i].Text.Replace(" ", "");
            //    }
            //    dt.Rows.Add(dr);
            //}
    }
}
