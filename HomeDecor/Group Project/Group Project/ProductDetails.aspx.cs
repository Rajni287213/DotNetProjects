/***************************************************************
Name: Aparna Girijia Ashokan            ID: 8983519

Name: Janvi Dhameliya                   ID: 8893709

Name: Rajni Rajni                       ID: 8838072

Name: Rohil Shobhashana                 ID: 8970375

Name: Saksham Sood                      ID: 8983034
****************************************************************/


using Group_Project.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Group_Project
{
    /// <summary>
    /// Handles the functionality of the ProductDetails page, including
    /// loading product details, adding products to the cart, and displaying messages.
    /// </summary>
    public partial class ProductDetails : System.Web.UI.Page
    {
        /// <summary>
        /// Event handler for the Page_Load event.
        /// Loads product details if the page is not being loaded as a postback.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProductDetails();
            }
        }

        /// <summary>
        /// Loads product details from the data source and displays them on the page.
        /// </summary>
        private void LoadProductDetails()
        {
            // Access the SqlDataSource programmatically to retrieve the data.
            DataView dv = (DataView)sqlProductDetails.Select(DataSourceSelectArguments.Empty);

            if (dv != null && dv.Count > 0)
            {
                DataRowView row = dv[0];
                lblProductName.Text = row["Name"].ToString();
                lblProductDescription.Text = row["ShortDescription"].ToString();
                lblLongProductDescription.Text = row["LongDescription"].ToString();
                //lblOnHand.Text = row["OnHand"].ToString();
                decimal unitPrice = Convert.ToDecimal(row["UnitPrice"]);
                lblProductPrice.Text = unitPrice.ToString("C2");
                imgProduct.ImageUrl = "~/images/" + row["ImageFile"].ToString();
                imgProduct.AlternateText = "Image of " + lblProductName.Text;
                pnlProductDetail.Visible = true;
            }
            else
            {
                ShowErrorMessage("Product not found. Please go back and try again.");
            }
        }

        /// <summary>
        /// Displays an error message to the user.
        /// </summary>
        /// <param name="message">The error message to display.</param>
        private void ShowErrorMessage(string message)
        {
            lblErrorMessage.Text = message;
            lblErrorMessage.Visible = true;
        }


        /// <summary>
        /// Event handler for the Add to Cart button click event.
        /// Adds the selected product to the cart.
        /// </summary>
        /// <param name="sender">The source of the event, the button.</param>
        /// <param name="e">The event data.</param>
        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            int productId;
            if (int.TryParse(Request.QueryString["ProductID"], out productId))
            {
                AddToCart(productId);
            }
        }

        /// <summary>
        /// Adds the specified product to the cart. If the product is already in the cart,
        /// its quantity is incremented. Otherwise, it is added as a new item.
        /// </summary>
        /// <param name="productId">The ID of the product to add to the cart.</param>
        private void AddToCart(int productId)
        {
            // Retrieve the cart from the session or initialize a new cart if null
            List<CartItem> cart = Session["Cart"] as List<CartItem> ?? new List<CartItem>();

            // Check if the product is already in the cart
            CartItem existingItem = cart.FirstOrDefault(item => item.ProductID == productId);

            if (existingItem != null)
            {
                // If the product is already in the cart, increment its quantity
                existingItem.Quantity++;
            }
            else
            {
                // Retrieve the product details from the SqlDataSource
                DataView dv = (DataView)sqlProductDetails.Select(DataSourceSelectArguments.Empty);

                if (dv != null && dv.Count > 0)
                {
                    DataRowView row = dv[0];

                    // Create a new CartItem
                    CartItem newItem = new CartItem
                    {
                        ProductID = productId,
                        Name = row["Name"].ToString(),
                        Price = Convert.ToDecimal(row["UnitPrice"]),
                        Quantity = 1,

                    };

                    // Add the new item to the cart
                    cart.Add(newItem);

                    // Set the success message with the product name
                    lblSuccessMessage.Text = $"{newItem.Name} has been successfully added to your cart.";
                    lblSuccessMessage.Visible = true;

                    // Inject JavaScript to hide the message after 3 seconds
                    SuccessMessageScript.Text = @"
                    <script>
                        setTimeout(function() {
                            document.getElementById('" + lblSuccessMessage.ClientID + @"').style.display = 'none';
                        }, 2000);
                    </script>";
                }
            }

            // Save the updated cart back to the session
            Session["Cart"] = cart;
        }

    }
}