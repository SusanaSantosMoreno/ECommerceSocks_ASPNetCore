﻿using ECommerceSocks_ASPNetCore.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ECommerceSocks_ASPNetCore.Repositories {
    public interface IRepositoryEcommerce_socks {

        #region PRODUCTS
        public List<Product> GetProducts ();
        public List<Product> GetLastProduct (int amount);
        public List<Product> GetFirstProduct (int amount);
        public Product GetProduct (int product_id);
        public List<String> GetProductsStyles ();
        public List<String> GetProductsPrint ();
        public List<String> GetProductColor ();
        public List<Product> GetProductsByCategory (int category_id);
        public List<Product_Complete> GetProduct_CompletesByCategory (int category_id);
        public List<Product_Complete> GetProduct_Completes ();
        public Product_Complete GetProduct_Complete (int product_id);
        public List<Product_Complete> GetFirstProduct_Complete (int amount);
        public List<Product_Complete> FilterProduct_Completes (int category_id, int subcategory_id,
            List<String> stylesFilter, List<String> printsFilter, List<String> colorsFilter);
        #endregion

        #region CATEGORIES
        public List<Category> GetCategories ();
        public Category GetCategory (int categoryId);
        #endregion

        #region SUBCATEGORIES
        public List<Subcategory> GetSubcategories ();
        public Subcategory GetSubcategory (int subcategory_id);
        #endregion

        #region SIZE
        public Size GetSize (int size_id);
        public List<Size> GetSizes ();
        #endregion

        #region PRODUCT_SIZE
        public List<Product_sizes> GetProduct_Sizes_Views (int product_id);
        public Product_sizes GetProduct_Size_View (int product_id, int size_id);
        #endregion

        public int generateRandomId ();

        #region USERS
        public bool AddUser (String email, String name, String password, String repeatPassword);
        public Users GetUser (String email, String password);
        #endregion
    }
}