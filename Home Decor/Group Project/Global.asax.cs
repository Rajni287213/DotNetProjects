using Microsoft.AspNet.FriendlyUrls;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;

namespace Group_Project
{
    public class Global : System.Web.HttpApplication
    {
        protected void Application_Start(object sender, EventArgs e)
        {
            RouteConfig.RegisterRoutes(RouteTable.Routes);
        }

        protected void Session_Start(object sender, EventArgs e) { }

        protected void Application_BeginRequest(object sender, EventArgs e) { }

        protected void Application_AuthenticateRequest(object sender, EventArgs e) { }

        protected void Application_Error(object sender, EventArgs e) { }

        protected void Session_End(object sender, EventArgs e) { }

        protected void Application_End(object sender, EventArgs e) { }

        public static class RouteConfig
        {
            public static void RegisterRoutes(RouteCollection routes)
            {
                var settings = new FriendlyUrlSettings
                {
                    AutoRedirectMode = RedirectMode.Permanent
                };
                routes.EnableFriendlyUrls(settings);

                // Define custom routes with route names
                routes.MapPageRoute("HomeRoute", "shop/home", "~/Home.aspx");
                routes.MapPageRoute("ProductRoute", "shop/product", "~/Product.aspx");
                routes.MapPageRoute("ProductDetailsRoute", "shop/productDetails", "~/ProductDetails.aspx");
                routes.MapPageRoute("CartRoute", "shop/cart", "~/Cart.aspx");
                routes.MapPageRoute("CheckoutRoute", "shop/checkout", "~/Checkout.aspx");
                routes.MapPageRoute("OrderConfirmation", "shop/orderConfirmation", "~/OrderConfirmation.aspx");

                routes.MapPageRoute("LoginRoute", "shop/login", "~/Login.aspx");
                routes.MapPageRoute("LogoutRoute", "shop/logout", "~/Logout.aspx");
                
                routes.MapPageRoute("AdminPanelRoute", "shop/adminPanel", "~/AdminPanel.aspx");
                routes.MapPageRoute("ProductListRoute", "shop/productList", "~/ProductList.aspx");
                routes.MapPageRoute("CategoryListRoute", "shop/categoryList", "~/CategoryList.aspx");

            }
        }
    }
}