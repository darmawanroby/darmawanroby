<%@ Application Language="C#" %>
<%@ Import Namespace="Udev.MasterPageWithLocalization.Classes" %>

<script runat="server">
    void Application_Start(object sender, EventArgs e) 
    {
        // Code that runs on application startup
        //Application.Lock();
        Application["strCn"] = ConfigurationManager.ConnectionStrings["strCn"].ConnectionString;
        Application["strCnRpt"] = ConfigurationManager.ConnectionStrings["strCnRpt"].ConnectionString;
        Application["strCnImageMesin"] = ConfigurationManager.ConnectionStrings["strCnImageMesin"].ConnectionString;
        Application["DatabaseServer"] = "localhost";
        //Application.UnLock();
    }
    
    void Application_End(object sender, EventArgs e) 
    {
        //  Code that runs on application shutdown
    }
        
    void Application_Error(object sender, EventArgs e) 
    { 
        // Code that runs when an unhandled error occurs
    }

    void Session_Start(object sender, EventArgs e) 
    {
        // Code that runs when a new session is started
        //set indonesia as default startup language
        Session[Global.SESSION_KEY_CULTURE] = Culture.ID; //"id-ID" 
        Session["strlang"] = "id";
        Session["UserID"] = "";
        Session["GradeID"] = "4";
    }

    void Session_End(object sender, EventArgs e) 
    {
        // Code that runs when a session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If session mode is set to StateServer 
        // or SQLServer, the event is not raised.
    }       
</script>
