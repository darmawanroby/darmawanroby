public partial class Controls_Lookup : System.Web.UI.UserControl
{
		
	public string Height
	{
		get
		{
			return this.ViewState["Height"].ToString();
		}
		set
		{
			this.ViewState["Height"] = value;
		}
	}
		
	public string Width
	{
		get
		{
			return this.ViewState["Width"].ToString();
		}
		set
		{
			this.ViewState["Width"] = value;
		}
	}
		
	public string Url
	{
		get
		{
			return this.ViewState["Url"].ToString();
		}
		set
		{
			this.ViewState["Url"] = value;
		}
	}

    public string LookupWindowName
	{
		get
		{
			return this.ViewState["LookupWindowName"].ToString();
		}
		set
		{
			this.ViewState["LookupWindowName"] = value;
		}
	}
	
    public string ReturnToControlID
	{
		get
		{
			return this.ViewState["ReturnToControlID"].ToString();
		}
		set
		{
			this.ViewState["ReturnToControlID"] = value;
		}
	}
	
	protected void Page_Load(object sender, System.EventArgs e)
	{
		string sJS;
		sJS = "javascript:w=window.open(" + "\"" + ResolveClientUrl(this.Url) + "?setLookupValueToControlID=" + this.Parent.FindControl(this.ReturnToControlID).ClientID + "\"," + "\"" + this.LookupWindowName + "\"," + "\"" + "location=0,status=0,scrollbars=yes,resizable=yes," + "width=" + this.Width + ",height=" + this.Height + "\"" + ");w.focus();";
		this.Lookup.NavigateUrl = "javascript://";
		this.Lookup.Attributes.Add("onclick", sJS);
	}

}
