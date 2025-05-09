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
    /// This page handles the checkout process where users can submit their order details.
    /// After submitting the order, the cart is cleared and the user is redirected to the order confirmation page.
    /// </summary>
    public partial class Checkout : System.Web.UI.Page
    {
        /// <summary>
        /// Handles the Page_Load event for the checkout page. 
        /// This method is called when the page is first loaded or refreshed
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Initial setup if needed
            }
        }

        /// <summary>
        /// Handles the checkout button click event. 
        /// Clears the cart and redirects to the order confirmation page if the page is valid.
        /// </summary>
        /// <param name="sender">The source of the event, the Checkout button.</param>
        /// <param name="e">The event data associated with the button click.</param>
        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    // Clear the cart
                    Session["Cart"] = null;

                    // Redirect to a confirmation page
                    Response.Redirect("~/shop/orderConfirmation");
                }
                catch (Exception ex)
                {
                    // Handle errors gracefully
                    Response.Write($"<script>alert('An error occurred: {ex.Message}');</script>");
                }
            }
        }
    }
}
