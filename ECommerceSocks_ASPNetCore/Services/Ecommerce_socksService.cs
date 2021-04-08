using EcommerceSocksAPI.Models;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;

namespace ECommerceSocks_ASPNetCore.Services {
    public class Ecommerce_socksService {

        private Uri UriApi;
        private MediaTypeWithQualityHeaderValue Header;

        public Ecommerce_socksService (String url) {
            this.UriApi = new Uri(url);
            this.Header = new MediaTypeWithQualityHeaderValue("application/json");
        }

        private async Task<T> CallApi<T> (String request) {
            using (HttpClient client = new HttpClient()) {
                client.BaseAddress = this.UriApi;
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(this.Header);
                HttpResponseMessage response = await client.GetAsync(request);

                if (response.IsSuccessStatusCode) {
                    T data = await response.Content.ReadAsAsync<T>();
                    return data;
                } else {
                    return default(T);
                }
            }
        }

        #region PRODUCTS
        public async Task<List<Product>> GetProductsAsync () {
            String request = "api/Products";
            List<Product> products = await this.CallApi<List<Product>>(request);
            return products;
        }

        public async Task<Product> GetProductAsync (int productId) {
            String request = "api/Products/" + productId;
            Product product = await this.CallApi<Product>(request);
            return product;
        }

        public async Task<List<Product>> GetLastProductAsync (int amount) {
            String request = "api/Products/GetLastProducts/" + amount;
            List<Product> products = await this.CallApi<List<Product>>(request);
            return products;
        }

        public async Task<List<Product>> GetFirstProductAsync (int amount) {
            String request = "api/Products/GetFirstProducts/" + amount;
            List<Product> products = await this.CallApi<List<Product>>(request);
            return products;
        }
        
        public async Task<List<String>> GetProductsStylesAsync () {
            String request = "api/Products/GetProductsStyles";
            List<String> styles = await this.CallApi<List<String>>(request);
            return styles;
        }

        public async Task<List<String>> GetProductsPrintAsync () {
            String request = "api/Products/GetProductsPrint";
            List<String> styles = await this.CallApi<List<String>>(request);
            return styles;
        }

        public async Task<List<String>> GetProductsColorAsync () {
            String request = "api/Products/GetProductColor";
            List<String> styles = await this.CallApi<List<String>>(request);
            return styles;
        }

        public async Task<List<Product>> GetProductsByCategoryAsync (int categoryId) {
            String request = "api/Products/GetProductsByCategory/" + categoryId;
            List<Product> styles = await this.CallApi<List<Product>>(request);
            return styles;
        }

        public async Task<List<Product_Complete>> GetProductCompleteAsync () {
            String request = "api/Products_Complete";
            List<Product_Complete> products = await this.CallApi<List<Product_Complete>>(request);
            return products;
        }

        //completebycategory
        #endregion
        
        #region CATEGORIES

        public async Task<List<Category>> GetCategoriesAsync () {
            String request = "api/Categories";
            List<Category> categories = await this.CallApi<List<Category>>(request);
            return categories;
        }
        public async Task<Category> GetCategoryAsync (int categoryId) {
            String request = "api/Categories/" + categoryId;
            Category category = await this.CallApi<Category>(request);
            return category;
        }

        #endregion

        #region SUBCATEGORIES

        public async Task<List<Subcategory>> GetSubcategoriesAsync () {
            String request = "api/Subcategories";
            List<Subcategory> subcategories = await this.CallApi<List<Subcategory>>(request);
            return subcategories;
        }

        public async Task<Subcategory> GetSubcategoryAsync (int subcategoryId) {
            String request = "api/Subcategories/" + subcategoryId;
            Subcategory subcategory = await this.CallApi<Subcategory>(request);
            return subcategory;
        }

        #endregion

        #region SIZE

        public async Task<List<Size>> GetSizes () {
            String request = "api/Sizes";
            List<Size> sizes = await this.CallApi<List<Size>>(request);
            return sizes;
        }

        public async Task<Size> GetSize (int sizeId) {
            String request = "api/Sizes/" + sizeId;
            Size size = await this.CallApi<Size>(request);
            return size;
        }

        #endregion

        #region PRODUCT_SIZE

        public async Task<List<Product_size>> GetProduct_SizesByProductAsync (int productId) {
            String request = "api/Product_Sizes/GetProduct_Sizes/" + productId;
            List<Product_size> productSizes = await this.CallApi<List<Product_size>>(request);
            return productSizes;
        }

        public async Task<List<Product_size>> GetProduct_SizesByProductSizeAsync 
            (int productId, int sizeId) {
            String request = "api/Product_Sizes/GetProduct_Size/" + productId + "/" + sizeId;
            List<Product_size> productSizes = await this.CallApi<List<Product_size>>(request);
            return productSizes;
        }

        #endregion

        #region FAVORITES

        public async Task<List<Favorite>> GetFavoritesAsync () {
            String request = "api/Favorites";
            List<Favorite> favorites = await this.CallApi<List<Favorite>>(request);
            return favorites;
        } 

        public async Task<List<Favorite>> GetUserFavoritesAsync (int userId) {
            String request = "api/Favorites/GetUserFavorites/" + userId;
            List<Favorite> favorites = await this.CallApi<List<Favorite>>(request);
            return favorites;
        }

        public async void AddFavoriteAsync (int favoriteId, int favoriteProduct, int favoriteUser) {
            using (HttpClient client = new HttpClient()) {
                String request = "api/Favorites/AddFavorite";
                client.BaseAddress = this.UriApi;
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(this.Header);
                Favorite favorites = new Favorite(favoriteId, favoriteProduct, favoriteUser);
                String json = JsonConvert.SerializeObject(favorites);
                StringContent content = new StringContent(json, Encoding.UTF8, "application/json");
                await client.PostAsync(request, content);
            }
        }

        public async void DeleteFavoriteAsync (int userId) {
            using (HttpClient client = new HttpClient()) {
                String request = "api/Favorites/RemoveUserFavorites/" + userId;
                client.BaseAddress = this.UriApi;
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(this.Header);
                await client.DeleteAsync(request);
            }
        }

        #endregion

        #region ADDRESSES

        public async Task<List<Addresses>> GetAddressesAsync () {
            String request = "api/Addresses";
            List<Addresses> addresses = await this.CallApi<List<Addresses>>(request);
            return addresses;
        }
        public async Task<Addresses> GetAddressAsync (int addressId) {
            String request = "/api/Addresses/GetAddress/" + addressId;
            Addresses address = await this.CallApi<Addresses>(request);
            return address;
        }

        public async Task<List<Addresses>> GetAddressesByUserAsync (int userId) {
            String request = "api/Addresses/GetUserAddresses/" + userId;
            List<Addresses> addresses = await this.CallApi<List<Addresses>>(request);
            return addresses;
        }

        public async void AddAddressAsync (int addressId, int userId, String name, String street, 
            String cp, String country, String province, String city) {
            using (HttpClient client = new HttpClient()) {
                String request = "api/Addresses/AddAddress";
                client.BaseAddress = this.UriApi;
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(this.Header);
                Addresses address = new Addresses(addressId, userId, name, street, cp, country, province, city);
                String json = JsonConvert.SerializeObject(address);
                StringContent content = new StringContent(json, Encoding.UTF8, "application/json");
                await client.PostAsync(request, content);
            }
        }

        public async void EditAddressAsync (int addressId, int userId, String name, String street,
            String cp, String country, String province, String city) {
            using (HttpClient client = new HttpClient()) {
                String request = "api/Addresses/EditAddress";
                client.BaseAddress = this.UriApi;
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(this.Header);
                Addresses address = new Addresses(addressId, userId, name, street, cp, country, province, city);
                String json = JsonConvert.SerializeObject(address);
                StringContent content = new StringContent(json, Encoding.UTF8, "application/json");
                await client.PutAsync(request, content);
            }
        }

        public async void DeleteAddressAsync (int addressId) {
            using (HttpClient client = new HttpClient()) {
                String request = "api/Addresses/deleteAddress/" + addressId;
                client.BaseAddress = this.UriApi;
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(this.Header);
                await client.DeleteAsync(request);
            }
        }
        #endregion

        #region ORDERS

        public async Task<List<Orders>> GetOrdersAsync (int userId) {
            String request = "api/Orders/GetOrders/" + userId;
            List<Orders> orders = await this.CallApi<List<Orders>>(request);
            return orders;
        }

        public async Task<Orders> GetOrderByIdAsync (int orderId) {
            String request = "api/Orders/GetOrderById/" + orderId;
            Orders order = await this.CallApi<Orders>(request);
            return order;
        }

        public async Task<Order_details> GetOrderDetailsAsync (int orderId) {
            String request = "api/Orders/GetOrder_Detail/" + orderId;
            Order_details order_Details = await this.CallApi<Order_details>(request);
            return order_Details;
        }

        public async void AddOrderAsync (int orderId, int orderUser, DateTime orderDate) {
            using (HttpClient client = new HttpClient()) {
                String request = "api/Orders/AddOrder";
                client.BaseAddress = this.UriApi;
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(this.Header);
                Orders order = new Orders(orderId, orderUser, orderDate);
                String json = JsonConvert.SerializeObject(order);
                StringContent content = new StringContent(json, Encoding.UTF8, "application/json");
                await client.PostAsync(request, content);
            }
        }

        public async void AddOrderDetailsAsync (int orderDetailsId, int orderId, 
            int product_id, int size_id, int amount) {
            using (HttpClient client = new HttpClient()) {
                String request = "api/Orders/AddOrderDetails";
                client.BaseAddress = this.UriApi;
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(this.Header);
                Order_details orderDetails = new Order_details(product_id, product_id, size_id, amount);
                String json = JsonConvert.SerializeObject(orderDetails);
                StringContent content = new StringContent(json, Encoding.UTF8, "application/json");
                await client.PostAsync(request, content);
            }
        }
        #endregion
    }
}
