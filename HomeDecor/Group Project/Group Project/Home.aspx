<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site1.Master" CodeBehind="Home.aspx.cs" Inherits="Group_Project.home1" %>

<%@ MasterType VirtualPath="~/Site1.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <title>Home | Aura & Aesthetics</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainPlaceHolder1" Runat="Server">
     <!-- Home Page Content -->
  <div class="banner">
      <img src="../images/banner.jpg" style="width: 100%; height: 65vh;" />
  </div>

  <div class="container mt-5">
      <h2 class="text-center mb-5">Featured Products</h2>

      <div class="row">
          <!-- Featured Product 1 -->
          <div class="col-md-4">
              <div class="product-card">
                  <img src="../images/decor1.jpg" alt="Product 1" style="width: 100%" />
                  <div class="product-card-body">
                      <h5>Trees & Canoe: Elegant Rustic Metal Wall Art</h5>
                      <p>
                          Handcrafted metal wall art featuring a serene canoe amidst tranquil trees, 
                          perfect for adding a rustic, nature-inspired touch to your home.
                      </p>
                      <a href="product" class="btn">View Details</a>
                  </div>
              </div>
          </div>

          <!-- Featured Product 2 -->
          <div class="col-md-4">
              <div class="product-card">
                  <img src="../images/decor2.jpg" alt="Product 2" style="width: 100%;" />
                  <div class="product-card-body">
                      <h5>Abstract Human Oil Paintings: Modern Art Women</h5>
                      <p>
                          Colorful abstract oil paintings of women, blending modern art with vibrant,
                          perfect for adding a bold,
                          expressive designs for a stunning wall decor statement.
                      </p>
                      <a href="product" class="btn">View Details</a>
                  </div>
              </div>
          </div>

          <!-- Featured Product 3 -->
          <div class="col-md-4">
              <div class="product-card">
                  <img src="../images/decor4.jpg" alt="Product 3" style="width: 100%; height: 50%" />
                  <div class="product-card-body">
                      <h5>Glass Dynamic Quicksand Desk Decor - Moving Sand Art Dome</h5>
                      <p>
                          Captivating and soothing moving sand art in a sleek glass dome, 
                          perfect for adding a dynamic and calming touch to your home or office desk.
                      </p>
                       <a href="product" class="btn">View Details</a>
                  </div>
              </div>
          </div>
      </div>
  </div>

  <!-- Categories Section -->
  <div class="categories-section mt-5">
      <div class="container">
          <h2 class="text-center section-title mb-5">Shop by Category</h2>
          <div class="row">
              <div class="col-md-3">
                  <div class="cat-card">
                       <a href="product"><img src="../images/category1.jpg" alt="Category 1" class="category-image" style="width:100%; height:305px" /></a>
                      <h5 class="category-title">Wall Art</h5>
                  </div>
              </div>
              <div class="col-md-3">
                  <div class="cat-card">
                        <a href="product"><img src="../images/category2.jpg" alt="Category 2" class="category-image"  style="width:100%; height:305px" /></a>
                      <h5 class="category-title">Table Decor</h5>
                  </div>
              </div>
              <div class="col-md-3">
                  <div class="cat-card">
                        <a href="product"><img src="../images/category3.jpeg" alt="Category 3" class="category-image"  style="width:100%; height:305px" /></a>
                      <h5 class="category-title">Sculptures</h5>
                  </div>
              </div>
              <div class="col-md-3">
                  <div class="cat-card">
                        <a href="product"><img src="../images/category4.jpg" alt="Category 4" class="category-image"  style="width:100%; height:305px"/></a>
                      <h5 class="category-title">Lighting</h5>
                  </div>
              </div>
          </div>
      </div>
  </div>

  <!-- Latest Blog Posts Section -->
  <div class="blog-section mt-5 mb-5">
      <div class="container">
          <h2 class="text-center section-title mb-5">Latest Blog Posts</h2>
          <div class="row">
              <div class="col-md-4">
                  <div class="blog-card">
                      <img src="../images/blog1.jpeg" alt="Blog 1" class="blog-image" style="width: 100%; height: auto;" />
                      <h5 class="blog-title mt-3">5 Tips to Style Your Living Room</h5>
                      <p>Learn the secrets to creating a cozy and stylish living space with our expert tips.</p>
                      <button class="btn btn-secondary">Read More</button>
                  </div>
              </div>
              <div class="col-md-4">
                  <div class="blog-card">
                      <img src="../images/blog2.jpeg" alt="Blog 2" class="blog-image" style="width: 100%; height: auto;" />
                      <h5 class="blog-title mt-3">Top Trends in Home Decor 2024</h5>
                      <p>Discover the hottest trends in home decor to keep your space up-to-date.</p>
                      <button class="btn btn-secondary">Read More</button>
                  </div>
              </div>
              <div class="col-md-4">
                  <div class="blog-card">
                      <img src="../images/blog3.jpeg" alt="Blog 3" class="blog-image" style="width: 100%; height: auto;" />
                      <h5 class="blog-title mt-3">Choosing the Perfect Wall Art</h5>
                      <p>Find out how to pick wall art that complements your home's aesthetic.</p>
                      <button class="btn btn-secondary">Read More</button>
                  </div>
              </div>
          </div>
      </div>
  </div>
  <br />
</asp:Content>

