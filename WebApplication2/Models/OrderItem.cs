using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApplication2.Models
{
    public class OrderItem
    {
        public string FoodName { get; set; }
        public int Quantity { get; set; }
        public decimal Price { get; set; }
        public string Flavor { get; set; }
        public string Extras { get; set; }
        public string SpecialRequest { get; set; }
        public decimal SubTotal
        {
            get { return Price * Quantity; }
        }
    }
}