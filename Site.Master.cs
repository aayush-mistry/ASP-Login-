using System;
using System.Web.UI;

public partial class SiteMaster : MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Check if user is logged in
        if (Session["StudentId"] != null)
        {
            GuestNav.Visible = false;
            StudentNav.Visible = true;
        }
        else
        {
            GuestNav.Visible = true;
            StudentNav.Visible = false;
        }
    }
}
