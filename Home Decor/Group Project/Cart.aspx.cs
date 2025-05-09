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
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Group_Project
{
    /// <summary>
    /// Represents the Cart page functionality.
    /// Handles displaying, updating, and removing items from the shopping cart.
    /// </summary>
    public partial class Cart : System.Web.UI.Page
    {
        /// <summary>
        /// Handles the Page Load event.
        /// Initializes the cart page by loading cart data and setting up the UI.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if the page is being loaded for the first time (not a postback)
            if (!IsPostBack)
            {
                // Retrieve the cart data from the session
                List<CartItem> cart = (List<CartItem>)Session["Cart"];

                // Check if the cart contains items
                if (cart != null && cart.Count > 0)
                {
                    // Bind the cart items to the Repeater control
                    CartRepeater.DataSource = cart;
                    CartRepeater.DataBind();

                    // Calculate and display the cart total (sum of each item's total price)
                    lblCartTotal.Text = cart.Sum(c => c.Total).ToString("C");

                    // Hide the empty cart message since the cart has items
                    emptyCartAlert.Visible = false;
                }
                else
                {
                    // Show the "No products available" message if the cart is empty
                    emptyCartAlert.Visible = true;

                    // Disable the checkout button if the cart is empty
                    btnProceedToCheckout.Enabled = false;
                }
            }
        }

        /// <summary>
        /// Handles the ItemCommand event for actions on individual cart items, such as removing or updating the quantity.
        /// </summary>
        /// <param name="source">The source of the event, typically the Repeater control.</param>
        /// <param name="e">The event data, including the command name and arguments.</param>
        protected void CartRepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            // If the "Remove" command is triggered (for removing an item)
            if (e.CommandName == "Remove")
            {
                // Retrieve the product ID of the item to be removed
                int productID = Convert.ToInt32(e.CommandArgument);

                // Retrieve the cart data from the session
                List<CartItem> cart = (List<CartItem>)Session["Cart"];
                if (cart != null && cart.Count > 0)
                {
                    // Find the cart item to remove based on its ProductID
                    CartItem itemToRemove = cart.FirstOrDefault(item => item.ProductID == productID);

                    if (itemToRemove != null)
                    {
                        // Remove the item from the cart
                        cart.Remove(itemToRemove);

                        // Update the session with the modified cart
                        Session["Cart"] = cart;

                        // Check if the cart is empty after removal
                        if (cart.Count == 0)
                        {
                            // Display the empty cart message if no items are left
                            emptyCartAlert.Visible = true;

                            // Disable the checkout button
                            btnProceedToCheckout.Enabled = false;

                            // Clear the Repeater's data source and rebind it
                            CartRepeater.DataSource = null;
                            CartRepeater.DataBind();

                            // Set the cart total to 0
                            lblCartTotal.Text = 0.ToString("C");
                        }
                        else
                        {
                            // Rebind the cart data to the Repeater control
                            CartRepeater.DataSource = cart;
                            CartRepeater.DataBind();

                            // Update the cart total after the item removal
                            lblCartTotal.Text = cart.Sum(c => c.Total).ToString("C");
                        }
                    }
                }
            }
            // If the "UpdateQuantity" command is triggered (for updating an item's quantity)
            else if (e.CommandName == "UpdateQuantity")
            {
                // Retrieve the product ID of the item whose quantity is to be updated
                int productID = Convert.ToInt32(e.CommandArgument);

                // Retrieve the cart data from the session
                List<CartItem> cart = (List<CartItem>)Session["Cart"];
                if (cart != null)
                {
                    // Find the cart item to update based on its ProductID
                    CartItem itemToUpdate = cart.FirstOrDefault(item => item.ProductID == productID);
                    if (itemToUpdate != null)
                    {
                        // Find the TextBox control for the quantity inside the current Repeater item
                        TextBox txtQuantity = (TextBox)e.Item.FindControl("txtQuantity");
                        if (txtQuantity != null && int.TryParse(txtQuantity.Text, out int newQuantity))
                        {
                            // Validate the new quantity (it must be between 1 and 100)
                            if (newQuantity >= 1 && newQuantity <= 100)
                            {
                                // Update the quantity of the item
                                itemToUpdate.Quantity = newQuantity;

                                // Update the session with the modified cart
                                Session["Cart"] = cart;

                                // Recalculate and update the cart total
                                lblCartTotal.Text = cart.Sum(c => c.Total).ToString("C");

                                // Rebind the updated cart to the Repeater control
                                CartRepeater.DataSource = cart;
                                CartRepeater.DataBind();

                                // Hide any error message if the quantity was valid
                                lblError.Visible = false;
                            }
                            else
                            {
                                // Show an error message if the quantity is outside the valid range (1-100)
                                lblError.Text = "Quantity must be between 1 and 100.";
                                lblError.Visible = true;
                            }
                        }
                        else
                        {
                            // Show an error message if the entered quantity is not a valid number
                            lblError.Text = "Please enter a valid numeric quantity.";
                            lblError.Visible = true;
                        }
                    }
                }
            }
        }
    }
}



