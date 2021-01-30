using ECommerceSocks_ASPNetCore.Data;
using ECommerceSocks_ASPNetCore.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Threading.Tasks;

namespace ECommerceSocks_ASPNetCore.Repositories {
    public class Ecommerce_socksRepository {

        private Ecommerce_socksContext context;

        public Ecommerce_socksRepository(Ecommerce_socksContext context ) {
            this.context = context;
        }

        #region PRODUCTS
        //GET ALL PRODUCTS
        public List<Product> GetProducts() {
            var consulta = from datos in this.context.products
                           select datos;
            return consulta.ToList();
        }

        //GET THE LAST N PRODUCTS
        public List<Product> GetLastProduct(int amount) {
            List<Product> lastProducts = Enumerable.Reverse
                (this.GetProducts()).Take(amount).Reverse().ToList();
            return lastProducts;
        }

        public List<Product> GetFirstProduct( int amount ) {
            List<Product> lastProducts = this.GetProducts().Take(amount).ToList();
            return lastProducts;
        }

        //GET A PRODUCT BY ID
        public Product GetProduct(int product_id ) {
            var consulta = from datos in this.context.products
                              where datos.Product_id == product_id
                              select datos;
            return consulta.Count() == 0 ? null : consulta.First();
        }

        public List<String> GetProductsStyles () {
            var consulta = this.GetProducts().Select(x => x.Product_style).Distinct();
            return consulta.ToList();
        }

        public List<String> GetProductsPrint () {
            var consulta = this.GetProducts().Select(x => x.Product_print).Distinct();
            return consulta.ToList();
        }

        public List<String> GetProductColor () {
            var consulta = this.GetProducts().Select(x => x.Product_color).Distinct();
            return consulta.ToList();
        }

        public List<Product> GetProductsByCategory (int category_id){
            return this.GetProducts().Where(x => x.Product_category == category_id).ToList();
        }

        public List<Product_Complete> GetProduct_CompletesByCategory(int category_id) {
            var consulta = from datos in this.context.products_Complete
                           where datos.Product_category == category_id
                           select datos;
            return consulta.ToList();
        }

        public Product_Complete GetProduct_Complete(int product_id) {
            var consulta = from datos in this.context.products_Complete
                           where datos.Product_id == product_id
                           select datos;
            return consulta.Count() == 0 ? null : consulta.First();
        }
        #endregion

        #region CATEGORIES
        public List<Category> GetCategories() {
            var consulta = from datos in this.context.categories
                           select datos;
            return consulta.ToList();
        }

        public Category GetCategory(int categoryId ) {
            var consulta = from datos in this.context.categories
                           where datos.Category_id == categoryId
                           select datos;
            return consulta.Count() == 0 ? null : consulta.First();
        }
        #endregion

        #region SUBCATEGORIES

        public List<Subcategory> GetSubcategories () {
            var consulta = from datos in this.context.subcategories
                           select datos;
            return consulta.ToList();
        }

        public Subcategory GetSubcategory(int subcategory_id) {
            var consulta = from datos in this.context.subcategories
                           where datos.Subcategory_id == subcategory_id
                           select datos;
            return consulta.Count() == 0 ? null : consulta.First();
        }

        #endregion

        #region SIZES
        public Size GetSize(int size_id) {
            var consulta = from datos in this.context.size
                           where datos.Size_id == size_id
                           select datos;
            return consulta.First();
        }

        public List<Size> GetSizes () {
             return (from datos in this.context.size
                           select datos).ToList();
        }

        public List<Product_sizes> GetProduct_Sizes_Views (int product_id) {
            return (from datos in this.context.product_sizes_view
                    where datos.Product_id == product_id
                    select datos).ToList();
        }

        public Product_sizes GetProduct_Size_View (int product_id, int size_id) {
            return (from datos in this.context.product_sizes_view
                    where datos.Product_id == product_id && datos.Size_id==size_id
                    select datos).FirstOrDefault();
        }
        #endregion

        /*public void createUser(String user_name, String user_email, 
            String user_password, String user_nationality, String user_phone, 
            DateTime user_birthDate, List<Addresses> addresses) {

            Users user = new Users(generateRandomId(), user_name, user_email, user_password,
                user_nationality, user_phone, user_birthDate, addresses);
            this.context.users.Add(user);
            //comprobar si se insertan las direcciones
            this.context.SaveChanges();
        }*/

        public int generateRandomId() {
            int randomValue;
            using (RNGCryptoServiceProvider crypto = new RNGCryptoServiceProvider()) {
                byte [] val = new byte [6];
                crypto.GetBytes(val);
                randomValue = BitConverter.ToInt32(val, 1);
            }
            return randomValue;
        }
    
        
    }
}
