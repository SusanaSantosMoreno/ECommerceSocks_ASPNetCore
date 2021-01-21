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
