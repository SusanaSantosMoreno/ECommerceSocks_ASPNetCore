using ECommerceSocks_ASPNetCore.Models;
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

        public void EditUser (int user_id, String name, String lastName, String nationality,
            String phone, DateTime birthdate, String gender);
        public Users GetUser (String email, String password);

        public Users GetUser (int user_id);
        #endregion

        #region FAVORITES
        public void AddFavorite (int product_id, int user_id);
        public List<Favorite> GetFavorites ();
        public List<Favorite> GetFavorites (int userId);

        #endregion

        #region ADDRESSES
        public List<Addresses> GetAddresses ();
        public List<Addresses> GetAddresses (int user_id);
        public Addresses GetAddress (int address_id);
        public void AddAddress (int user_id, string name, string street,
           string cp, string country, string province, string city);
        public void EditAddress (int address_id,
            string name, string street, string cp, string country,
            string province, string city);
        public void deleteAddress (int address_id);
        #endregion

        #region ORDERS

        public Orders AddOrder (int user_id);

        public void AddOrderDetails (int order_id, int product_id, int size_id, int amount);

        public List<Orders> GetOrders (int user_id);
        public Orders GetOrdersById (int order_id);

        public List<Order_details> GetOrder_Detail (int order_id);

        #endregion
    }
}
