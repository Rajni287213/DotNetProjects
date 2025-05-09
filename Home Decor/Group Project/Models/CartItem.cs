using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Group_Project.Models
{
    /// <summary>
    /// Represents an item in the shopping cart, including product details, quantity, and price.
    /// </summary>
    public class CartItem
    {
        /// <summary>
        /// Gets or sets the unique identifier for the product.
        /// </summary>
        public int ProductID { get; set; }

        /// <summary>
        /// Gets or sets the name of the product.
        /// </summary>
        public string Name { get; set; }

        /// <summary>
        /// Gets or sets the price of a single unit of the product.
        /// </summary>
        public decimal Price { get; set; }

        /// <summary>
        /// Gets or sets the quantity of the product in the cart.
        /// </summary>
        public int Quantity { get; set; }

        /// <summary>
        /// Gets the total price for the cart item, calculated as Price multiplied by Quantity.
        /// </summary>
        public decimal Total
        {
            get
            {
                return Price * Quantity; // Total = Price * Quantity
            }
        }
    }
}