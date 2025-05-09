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
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Group_Project
{
    /// <summary>
    /// This page is responsible for displaying the category list and handling category insertion, updates, and deletions.
    /// </summary>
    public partial class CategoryList : System.Web.UI.Page
    {
        /// <summary>
        /// Event handler for the page load. Hides the success message on initial page load.
        /// </summary>
        /// <param name="sender">Source of the event, the page</param>
        /// <param name="e">Event data</param>
        protected void Page_Load(object sender, EventArgs e) {
            lblSuccess_AddCategory.Visible = false; // Hide success message on first load
        }

        /// <summary>
        /// Handles the RowDeleted event for the GridView. Displays an error message if an exception occurs during deletion.
        /// </summary>
        /// <param name="sender">The source of the event, the GridView control</param>
        /// <param name="e">The event data, which contains information about the deleted row.</param>
        protected void GridView1_RowDeleted(object sender, GridViewDeletedEventArgs e)
        {
            if (e.Exception != null)
            {
                lblError_categoryList.Text = " Database error : <br/> " + e.Exception.Message;
                e.ExceptionHandled = true;
            }
            else
            {
                lblError_categoryList.Text = "";
            }
        }

        /// <summary>
        /// Handles the RowUpdated event for the GridView. Displays specific error messages for empty fields or other database errors.
        /// </summary>
        /// <param name="sender">The source of the event, the GridView control.</param>
        /// <param name="e">The event data, which contains information about the updated row.</param>
        protected void GridView1_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {
            if (e.Exception != null)
            {
                // Specific error handling for empty fields
                if (e.Exception.Message.Contains("Cannot insert the value NULL into column 'Category'"))
                {
                    lblError_categoryList.Text = "Error: The 'Category' field cannot be empty. Please provide a value.";
                }
                else
                {
                    // General fallback for other database errors
                    lblError_categoryList.Text = "An error occurred while updating the record. Please check your input and try again.";
                }

                e.ExceptionHandled = true;
                e.KeepInEditMode = true;
            }
            else
            {
                // Clear error message on successful update
                lblError_categoryList.Text = "";
            }
        }

        /// <summary>
        /// Handles the RowCancelingEdit event for the GridView. Clears any error message and rebinds the GridView to refresh the data.
        /// </summary>
        /// <param name="sender">The source of the event, the GridView control.</param>
        /// <param name="e">The event data.</param>
        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            lblError_categoryList.Text = "";

            // Rebind the GridView to refresh the data
            GridView1.DataBind();
        }


        /////////////////////////////////////////////////////////////////////////////////////////////


        /// <summary>
        /// Handles the FormView's ItemInserting event. Validates whether the Category ID already exists before inserting the new category.
        /// </summary>
        /// <param name="sender">The source of the event, the FormView control.</param>
        /// <param name="e">The event data, which contains the values to be inserted.</param>
        protected void FormView1_ItemInserting(object sender, FormViewInsertEventArgs e)
        {
            lblError_AddCategory.Text = "";
            lblSuccess_AddCategory.Text = "";
            lblSuccess_AddCategory.Visible = false;

            if (!Page.IsValid) // If validation fails
            {
                lblSuccess_AddCategory.Text = "";
                lblSuccess_AddCategory.Visible = false; // Hide success message
                e.Cancel = true; // Cancel the insert operation
            }

            // Your custom validation logic to check if the Category ID already exists
            string categoryID = ((TextBox)FormView1.FindControl("IdTextBox")).Text;
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string checkQuery = "SELECT COUNT(*) FROM Category WHERE CategoryID = @CategoryID";
                using (SqlCommand checkCmd = new SqlCommand(checkQuery, connection))
                {
                    checkCmd.Parameters.AddWithValue("@CategoryID", categoryID);
                    connection.Open();

                    int count = (int)checkCmd.ExecuteScalar();
                    if (count > 0)
                    {
                        // Display error if CategoryID already exists
                        lblError_AddCategory.Text = "Category ID already exists. Please choose a different one.";
                        lblError_AddCategory.Visible = true;

                        // Optionally clear the TextBox controls when error occurs
                        ClearFormControls(FormView1);

                        e.Cancel = true; // Cancel the insert operation if CategoryID exists
                        connection.Close();
                        return; // Exit if validation fails
                    }
                    connection.Close();
                }
            }
        }

        /// <summary>
        /// Event handler for the FormView's Inserted event. Displays a success message if the category insertion is successful.
        /// </summary>
        /// <param name="sender">The source of the event, the FormView control.</param>
        /// <param name="e">The event data, which contains information about the inserted item.</param>
        protected void FormView1_Inserted(object sender, FormViewInsertedEventArgs e)
        {
            // Show success message only if the insertion is successful
            if (e.AffectedRows > 0)
            {
                lblSuccess_AddCategory.Text = "Category added successfully!";
                lblSuccess_AddCategory.Visible = true;
            }
            else
            {
                lblError_AddCategory.Text = "Failed to add category. Please try again.";
                lblError_AddCategory.Visible = true;
                lblSuccess_AddCategory.Visible = false;
            }
        }

        /// <summary>
        /// Resets the FormView to Insert mode and hides the success message when the Insert command is triggered.
        /// </summary>
        /// <param name="sender">The source of the event, the FormView control.</param>
        /// <param name="e">The event data, which contains the command name and arguments.</param>
        protected void FormView1_ItemCommand(object sender, FormViewCommandEventArgs e)
        {
            // Reset the success message visibility when the form command is triggered
            if (e.CommandName == "Insert")
            {
                FormView1.ChangeMode(FormViewMode.Insert);
                lblSuccess_AddCategory.Visible = false;
            }
        }

        /// <summary>
        /// Clears the input fields in the FormView controls
        /// </summary>
        /// <param name="formView">The FormView control to clear.</param>
        private void ClearFormControls(FormView formView)
        {
            foreach (Control control in formView.Controls)
            {
                if (control is TextBox)
                {
                    ((TextBox)control).Text = string.Empty; // Clear the TextBox value
                }
            }
        }
    }
}