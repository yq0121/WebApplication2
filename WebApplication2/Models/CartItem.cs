using System;

namespace WebApplication2.Models
{
    public class CartItem
    {
        public int FoodID { get; set; }
        public string FoodName { get; set; }
        public decimal Price { get; set; }
        public int Quantity { get; set; }
        public string ImageUrl { get; set; }

        public decimal SubTotal
        {
            get { return Price * Quantity; }
        }

        public string Flavor { get; set; }
        public string Extras { get; set; }
        public string SpecialRequest { get; set; }
    }
}
