/***************************************************************
Name: Aparna Girijia Ashokan            ID: 8983519

Name: Janvi Dhameliya                   ID: 8893709

Name: Rajni Rajni                       ID: 8838072

Name: Rohil Shobhashana                 ID: 8970375

Name: Saksham Sood                      ID: 8983034
****************************************************************/

using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Group_Project
{
    /// <summary>
    /// Represents the Login page of the application where users can log in.
    /// Handles user authentication and redirects based on their roles (e.g., admin or customer).
    /// </summary>
    public partial class Login : System.Web.UI.Page
    {
        /// <summary>
        /// Handles the Page_Load event for the Login page.
        /// This method is called whenever the page is loaded or refreshed.
        /// </summary>
        /// <param name="sender">The source of the event, the page itself.</param>
        /// <param name="e">The event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        /// <summary>
        /// Handles the Login button click event.
        /// Authenticates the user by verifying the username and password against the database.
        /// Redirects the user to the appropriate page based on their role (e.g., admin or customer).
        /// </summary>
        /// <param name="sender">The source of the event, the Login button.</param>
        /// <param name="e">The event data associated with the button click.</param>
        protected void btnlogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text;
            string password = txtPassword.Text;

            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string query = "SELECT COUNT(*), Status FROM Users WHERE Username = @Username AND Password = @Password GROUP BY Status";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Username", username);
                cmd.Parameters.AddWithValue("@Password", password);

                try
                {
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        int result = (int)reader[0];
                        string status = reader["Status"].ToString().Trim();

                        if (result > 0)
                        {
                            // Store the status in a session or cookie
                            Session["Status"] = status;  // Using session here

                            // Redirect based on the role
                            if (status.Equals("admin", StringComparison.OrdinalIgnoreCase))
                            {
                                Response.Redirect("~/shop/adminPanel"); // Admin panel page
                            }
                            else
                            {
                                Response.Redirect("~/shop/home"); // Regular user home page
                            }
                        }
                        else
                        {
                            lblError.Text = "Invalid username or password!";
                            lblError.ForeColor = System.Drawing.Color.Red;
                            txtUsername.Text = string.Empty;
                            txtPassword.Text = string.Empty;
                        }
                    }
                    else
                    {
                        lblError.Text = "Invalid username or password!";
                        lblError.ForeColor = System.Drawing.Color.Red;
                        txtUsername.Text = string.Empty;
                        txtPassword.Text = string.Empty;
                    }
                }
                catch (Exception ex)
                {
                    lblError.Text = "An error occurred: " + ex.Message;
                    lblError.ForeColor = System.Drawing.Color.Red;
                    txtUsername.Text = string.Empty;
                    txtPassword.Text = string.Empty;
                }
            }
        }

    }
}