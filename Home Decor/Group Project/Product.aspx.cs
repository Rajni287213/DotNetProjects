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
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Group_Project
{
    /// <summary>
    /// Code-behind for the Product page, allowing users to add products to their cart.
    /// </summary>
    public partial class Product : System.Web.UI.Page
    {
        /// <summary>
        /// Handles the Page_Load event of the Product page.
        /// This method is invoked when the page is loaded or refreshed.
        /// </summary>
        /// <param name="sender">he source of the event, the page itself.</param>
        /// <param name="e">The event data.</param>
        protected void Page_Load(object sender, EventArgs e) { }

        /// <summary>
        /// Handles the AddToCart button click event.
        /// Adds the selected product to the user's cart stored in the session.
        /// </summary>
        /// <param name="sender">The source of the button click event.</param>
        /// <param name="e">The event arguments associated with the button click event.</param>
        protected void AddToCart_Click(object sender, EventArgs e)
        {
            // Get the Button that was clicked
            Button btn = (Button)sender;

            // Get the ProductID from CommandArgument
            int productID = Convert.ToInt32(btn.CommandArgument);

            // Fetch product details using the methods
            string productName = GetProductNameByID(productID);
            decimal productPrice = GetProductPriceByID(productID);

            // Check if product details are valid
            if (string.IsNullOrEmpty(productName) || productPrice == 0)
            {
                // Handle the error (e.g., display a message to the user)
                return;
            }

            // Create a new CartItem object
            CartItem newItem = new CartItem
            {
                ProductID = productID,
                Name = productName,
                Price = productPrice,
                Quantity = 1 // Initially set quantity to 1
            };

            // Get the current cart from the session
            List<CartItem> cart = (List<CartItem>)Session["Cart"];
            if (cart == null)
            {
                cart = new List<CartItem>();
            }

            // Check if the product already exists in the cart
            CartItem existingItem = cart.FirstOrDefault(item => item.ProductID == productID);
            if (existingItem != null)
            {
                // If the product exists, increase its quantity
                existingItem.Quantity++;
            }
            else
            {
                // Otherwise, add the new product to the cart
                cart.Add(newItem);
            }

            // Save the updated cart back to the session
            Session["Cart"] = cart;

            // Show the success message
            lblSuccessMessage.Text = $"{productName} has been successfully added to your cart!";
            lblSuccessMessage.Visible = true;

            // Inject JavaScript to hide the message after 3 seconds
            SuccessMessageScript.Text = @"
            <script>
                setTimeout(function() {
                    document.getElementById('" + lblSuccessMessage.ClientID + @"').style.display = 'none';
                }, 2000);
            </script>";
        }

        /// <summary>
        /// Retrieves the name of the product based on its ID.
        /// </summary>
        /// <param name="productID">The ID of the product to retrieve the name for.</param>
        /// <returns>The name of the product as a string.</returns>
        private string GetProductNameByID(int productID)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ToString();
            string productName = string.Empty;

            // Define your SQL query
            string query = "SELECT Name FROM Products WHERE ProductID = @ProductID";

            // Create and open the connection
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@ProductID", productID);

                // Open the connection and execute the query
                try
                {
                    conn.Open();
                    productName = cmd.ExecuteScalar()?.ToString(); // Fetch the first column of the first row
                }
                catch (Exception ex)
                {
                    // Log or handle the exception
                    Console.WriteLine("Error: " + ex.Message);
                }
            }

            return productName;
        }


        /// <summary>
        /// Retrieves the price of the product based on its ID.
        /// </summary>
        /// <param name="productID">The ID of the product to retrieve the price for.</param>
        /// <returns>The price of the product as a decimal.</returns>
        private decimal GetProductPriceByID(int productID)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ToString();
            decimal productPrice = 0.0m;

            // Define your SQL query
            string query = "SELECT UnitPrice FROM Products WHERE ProductID = @ProductID";

            // Create and open the connection
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@ProductID", productID);

                // Open the connection and execute the query
                try
                {
                    conn.Open();
                    object result = cmd.ExecuteScalar();
                    if (result != null)
                    {
                        productPrice = Convert.ToDecimal(result); // Convert the result to decimal
                    }
                }
                catch (Exception ex)
                {
                    // Log or handle the exception
                    Console.WriteLine("Error: " + ex.Message);
                }
            }

            return productPrice;
        }

    }
}
