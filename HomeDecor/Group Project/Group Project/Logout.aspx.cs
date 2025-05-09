/***************************************************************
Name: Aparna Girijia Ashokan            ID: 8983519

Name: Janvi Dhameliya                   ID: 8893709

Name: Rajni Rajni                       ID: 8838072

Name: Rohil Shobhashana                 ID: 8970375

Name: Saksham Sood                      ID: 8983034
****************************************************************/

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Group_Project
{
    /// <summary>
    /// Represents the Logout page of the application.
    /// Handles user session termination and redirects the user to the login page.
    /// </summary>
    public partial class Logout : System.Web.UI.Page
    {
        /// <summary>
        /// Handles the Page_Load event for the Logout page.
        /// Clears the current user session and redirects the user to the login page.
        /// </summary>
        /// <param name="sender">The source of the event, the page itself.</param>
        /// <param name="e">The event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            // Clear session data
            Session.Clear();

            // End the session
            Session.Abandon();

            // Redirect to login page
            Response.Redirect("~/shop/login");
        }
    }
}