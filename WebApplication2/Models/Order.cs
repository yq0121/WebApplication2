using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApplication2.Models
{
    public enum OrderStatus
    {
        Pending,
        Preparing,
        Confirmed,
        Cancelled
    }
    public class Order
    {
        public int OrderId { get; set; }
        public DateTime OrderDate { get; set; }
        public OrderStatus Status { get; set; }
        public List<OrderItem> Items { get; set; }
        public decimal Total
        {
            get 
            {
                if (Items == null) return 0;
                return Items.Sum(i => i.SubTotal); 
            }
        }
    }
}