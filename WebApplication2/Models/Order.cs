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

    public enum PaymentMethod
    {
        None,
        Cash,
        CreditCard,
        eWallet
    }

    public enum PaymentStatus
    {
        Pending,
        Paid,
        Failed
    }

    public class Order
    {
        public int OrderId { get; set; }
        public DateTime OrderDate { get; set; }
        public OrderStatus Status { get; set; }
        public List<OrderItem> Items { get; set; }

        // --- Payment info ---
        public PaymentMethod paymentMethod { get; set; } = PaymentMethod.None;
        public PaymentStatus paymentStatus { get; set; } = PaymentStatus.Pending;
        public string TransactionRef { get; set; }
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