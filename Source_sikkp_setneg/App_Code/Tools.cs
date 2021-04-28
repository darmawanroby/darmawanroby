using Microsoft.VisualBasic;
using System.Web.UI.WebControls;

public class Tools
{

    public static void BuildLookupValueReturnControl(System.Web.UI.WebControls.GridViewRow e, string LinkControlId)
	{
		if (e.RowType == DataControlRowType.DataRow)
		{
			System.Web.UI.WebControls.HyperLink hl = new System.Web.UI.WebControls.HyperLink();
			string js;
			hl = (System.Web.UI.WebControls.HyperLink) (e.FindControl(LinkControlId));
			js = BuildJS_ReturnLookupValue(System.Web.HttpContext.Current.Request.QueryString["setLookupValueToControlID"], e.Cells[0].Text);
			hl.NavigateUrl = "javascript://";
			hl.Attributes.Add("onclick", js);
		}
	}
	
    public static string BuildJS_ReturnLookupValue(string controlID, string valueToSet)
	{
		string s;
		
		s = "winOpener=window.self.opener;" + "winOpener.document.getElementById(\'" + controlID + "\').value=\'" + valueToSet + "\';" + "window.close();" + "winOpener.document.getElementById(\'" + controlID + "\').focus();";
		return s;
	}
}
