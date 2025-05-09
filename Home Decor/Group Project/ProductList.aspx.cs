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
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Group_Project
{
    /// <summary>
    /// Handles the product list functionality, including inserting, updating, deleting, and managing images.
    /// </summary>
    public partial class ProductList : System.Web.UI.Page
    {
        /// <summary>
        /// Handles the page load event and clears the success message.
        /// </summary>
        protected void Page_Load(object sender, EventArgs e) {
            lblSuccess_AddProduct.Text = "";
        }

        /// <summary>
        /// Handles the event when an item is deleted in the DetailsView.
        /// Deletes the image file associated with the product if present.
        /// </summary>
        /// <param name="sender">The source of the event, the DetailsView control.</param>
        /// <param name="e">The event data, which contains information about the deleted row.</param>
        protected void DetailsView1_ItemDeleted(object sender, DetailsViewDeletedEventArgs e)
        {
            if (e.Exception != null)
            {
                lblError_productDetails.Text = "Database error: </br> " + e.Exception.Message;
                e.ExceptionHandled = true;
            }
            else
            {
                lblError_productDetails.Text = "";
                lblSuccess_ProductUpdateDelete.Text = "Product deleted successfully!";

                // Get the image file name from the DetailsView's deleted values
                string imageFileName = e.Values["ImageFile"]?.ToString();

                if (!string.IsNullOrEmpty(imageFileName))
                {
                    // Extract the file name to avoid duplication of the folder path
                    string fileName = Path.GetFileName(imageFileName);

                    // Construct the full file path
                    string folderPath = Server.MapPath("~/images/"); // Map to the 'images' folder
                    string fullPath = Path.Combine(folderPath, fileName);

                    try
                    {
                        // Check if the file exists and delete it
                        if (File.Exists(fullPath))
                        {
                            File.Delete(fullPath); // Delete the image file silently
                        }
                    }
                    catch
                    {
                        // Handle errors silently for the image deletion
                    }
                }
            }
        }

        /// <summary>
        /// Handles the event when an item is updated in the DetailsView.
        /// Handles different errors and displays corresponding messages.
        /// </summary>
        /// <param name="sender">The source of the event, the DetailsView control.</param>
        /// <param name="e">The event data, which contains information about the updated row.</param>
        protected void DetailsView1_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
        {
            if (e.Exception != null)
            {
                // Specific error handling for empty fields
                if (e.Exception.Message.Contains("Cannot insert the value NULL into column 'Name'"))
                {
                    lblError_productDetails.Text = "Error: The 'Name' field cannot be empty. Please provide a value.";
                }
                else if (e.Exception.Message.Contains("Cannot insert the value NULL into column 'ShortDescription'"))
                {
                    lblError_productDetails.Text = "Error: The 'Short Description' field cannot be empty. Please provide a value.";
                }
                else if (e.Exception.Message.Contains("Cannot insert the value NULL into column 'LongDescription'"))
                {
                    lblError_productDetails.Text = "Error: The 'Long Description' field cannot be empty. Please provide a value.";
                }
                else if (e.Exception.Message.Contains("Cannot insert the value NULL into column 'UnitPrice'"))
                {
                    lblError_productDetails.Text = "Error: The 'Unit Price' field cannot be empty. Please provide a value.";
                }
                else if (e.Exception.Message.Contains("Cannot insert the value NULL into column 'OnHand'"))
                {
                    lblError_productDetails.Text = "Error: The 'On Hand' field cannot be empty. Please provide a value.";
                }
                else
                {
                    lblError_productDetails.Text = "An error occurred while updating the record. Please check your input and try again.";
                }
                e.ExceptionHandled = true;
            }
            else
            {
                lblError_productDetails.Text = "";
                lblSuccess_ProductUpdateDelete.Text = "Product updated successfully!";
            }

        }

        /// <summary>
        /// Handles the event when an item is about to be updated in the DetailsView.
        /// Handles file upload for product images and validates file types.
        /// </summary>
        /// <param name="sender">The source of the event, the DetailsView control.</param>
        /// <param name="e">DetailsViewUpdateEventArgs containing information about the updated row.</param>
        protected void DetailsView1_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
        {
            // Get the FileUpload control
            FileUpload fileUpload = (FileUpload)DetailsView1.FindControl("FileUpload1");
            Label lblImageFile = (Label)DetailsView1.FindControl("Label2"); // Label displaying the existing file name

            if (fileUpload != null && fileUpload.HasFile)
            {
                try
                {
                    // Validate the file extension
                    string extension = Path.GetExtension(fileUpload.FileName).ToLower();
                    if (extension != ".jpg" && extension != ".jpeg" && extension != ".gif")
                    {
                        lblError_productDetails.Text = "Only JPG, JPEG, and GIF files are allowed.";
                        e.Cancel = true; // Cancel the update operation
                        return;
                    }

                    // Save the file to the server
                    string folderPath = Server.MapPath("~/images/");
                    if (!Directory.Exists(folderPath))
                    {
                        Directory.CreateDirectory(folderPath);
                    }

                    // Save the file with its original file name
                    string originalFileName = fileUpload.FileName;
                    string filePath = Path.Combine(folderPath, originalFileName);
                    fileUpload.SaveAs(filePath);

                    // Store the new file name in the database
                    e.NewValues["ImageFile"] = originalFileName;
                }
                catch (Exception ex)
                {
                    lblError_productDetails.Text = "Error uploading image: " + ex.Message;
                    e.Cancel = true; // Cancel the update operation
                }
            }
            else
            {
                // Retain the existing file name if no new file is uploaded
                if (lblImageFile != null)
                {
                    e.NewValues["ImageFile"] = lblImageFile.Text;
                }
                else
                {
                    lblError_productDetails.Text = "Error: Unable to retrieve the existing image file name.";
                    e.Cancel = true; // Cancel the update operation
                }
            }
        }

        /// <summary>
        /// Handles the event when a command (Edit, Cancel) is triggered in the DetailsView.
        /// Clears any error or success messages.
        /// </summary>
        /// <param name="sender">The source of the event, the DetailsView control.</param>
        /// <param name="e">The event data, which contains information about the command being triggered (Edit or Cancel).</param>
        protected void DetailsView1_ItemCommand(object sender, DetailsViewCommandEventArgs e)
        {
            if (e.CommandName == "Cancel" || e.CommandName == "Edit")
            {
                lblError_productDetails.Text = "";
                lblSuccess_ProductUpdateDelete.Text = "";
            }
        }

        /// <summary>
        /// Handles the event when a GridView item is selected. Clears success and error messages.
        /// </summary>
        /// <param name="sender">The source of the event, the GridView control.</param>
        /// <param name="e">The event data, which contains information about the selected row in the GridView.</param>
        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblSuccess_ProductUpdateDelete.Text = "";
            lblError_productDetails.Text = "";
        }


        ////////////////////////////////////////////////////////////////////////////////////////


        /// <summary>
        /// Handles the event when an item is being inserted into the ProductFormView.
        /// Validates the input data, checks for existing ProductID, and handles image upload.
        /// </summary>
        /// <param name="sender">The source of the event, the FormView control.</param>
        /// <param name="e">FormViewInsertEventArgs containing information about the inserted item.</param>
        protected void ProductFormView_ItemInserting(object sender, FormViewInsertEventArgs e)
        {
            lblSuccess_AddProduct.Text = "";

            // Clear the success message if validation fails
            if (!Page.IsValid) // Checks if required fields or other validations failed
            {
                e.Cancel = true; // Cancel the insert operation
                lblSuccess_AddProduct.Text = "";
                return;
            }

            string productID = ((TextBox)FormView1.FindControl("IdTextBox")).Text;

            // Get the connection string from the web.config file
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string checkQuery = "SELECT COUNT(*) FROM Products WHERE ProductID = @ProductID";

                using (SqlCommand checkCmd = new SqlCommand(checkQuery, connection))
                {
                    checkCmd.Parameters.AddWithValue("@ProductID", productID);
                    connection.Open();

                    int count = (int)checkCmd.ExecuteScalar();
                    if (count > 0)
                    {
                        // Display error if ProductID exists
                        lblError_AddProduct.Text = "Product ID already exists. Please choose a different one.";
                        lblError_AddProduct.Visible = true;

                        // Optionally clear the TextBox controls when error occurs
                        ClearFormControls(FormView1);

                        connection.Close();
                        e.Cancel = true; // Cancel the insert operation
                        return;
                    }
                    connection.Close();
                }
            }

            // Find the FileUpload control within the FormView
            FileUpload fileUploadControl = (FileUpload)FormView1.FindControl("FileUploadControl");

            // Check if a file is selected
            if (fileUploadControl.HasFile)
            {
                // Validate the file extension
                string fileExtension = Path.GetExtension(fileUploadControl.FileName).ToLower();
                string[] allowedExtensions = { ".jpg", ".jpeg", ".gif" };

                if (!allowedExtensions.Contains(fileExtension))
                {
                    // If the file extension is not valid, show an error
                    lblError_AddProduct.Text = "Invalid file type. Only .jpg, .jpeg, and .gif are allowed.";
                    lblError_AddProduct.Visible = true;
                    e.Cancel = true; // Cancel the insert operation
                    return;
                }

                try
                {
                    // Generate the file path for storing the uploaded image
                    string sanitizedFileName = Path.GetFileNameWithoutExtension(fileUploadControl.PostedFile.FileName);
                    sanitizedFileName = sanitizedFileName.Replace(" ", "_");
                    string filePath = "~/images/" + sanitizedFileName + Path.GetExtension(fileUploadControl.PostedFile.FileName);
                    string imagePath = sanitizedFileName + Path.GetExtension(fileUploadControl.PostedFile.FileName);

                    // Save the uploaded file to the server
                    fileUploadControl.SaveAs(Server.MapPath(filePath));

                    // Set the file path in the Insert parameters (for the ImageFile column)
                    e.Values["ImageFile"] = imagePath;
                }
                catch (Exception ex)
                {
                    // Handle any errors that occur during file upload (e.g., file size too large)
                    lblError_AddProduct.Text = $"Error uploading the image: {ex.Message}";
                    lblError_AddProduct.Visible = true;
                    e.Cancel = true; // Cancel the insert operation
                    return;
                }
            }
            else
            {
                // If file is not selected, show error
                lblError_AddProduct.Text = "Please upload an image.";
                lblError_AddProduct.Visible = true;
                e.Cancel = true; // Cancel the insert operation
                return;
            }

            // If no errors, show success message
            if (!e.Cancel)
            {
                lblError_AddProduct.Text = "";
                lblSuccess_AddProduct.Text = "Product added successfully!";
                lblSuccess_AddProduct.Visible = true;

                // clear the form 
                ClearFormControls(FormView1);
            }
        }


        /// <summary>
        /// Clears the FormView controls
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

