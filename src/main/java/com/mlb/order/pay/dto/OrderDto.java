package com.mlb.order.pay.dto;

import java.time.LocalDateTime;

public class OrderDto {
    Long order_id;
    Long user_id;
    LocalDateTime order_date;
    Long total_price;
    String pay_id;
    String shipping_address;
    LocalDateTime shipping_date;

    public OrderDto() {}
    public Long getOrderId() {
        return order_id;
    }
    public void setOrderId(Long order_id) {
        this.order_id = order_id;
    }
    public Long getUserId() {
        return user_id;
    }
    public void setUserId(Long user_id) {
        this.user_id = user_id;
    }
    public LocalDateTime getOrderDate() {
        return order_date;
    }
    public void setOrderDate(LocalDateTime order_date) {
        this.order_date = order_date;
    }
    public Long getTotalPrice() {
        return total_price;
    }
    public void setTotalPrice(Long total_price) {
        this.total_price = total_price;
    }
    public String getPayId() {
        return pay_id;
    }
    public void setPayId(String pay_id) {
        this.pay_id = pay_id;
    }
    public String getShippingAddress() {
        return shipping_address;
    }
    public void setShippingAddress(String shipping_address) {
        this.shipping_address = shipping_address;
    }
    public LocalDateTime getShippingDate() {
        return shipping_date;
    }
    public void setShippingDate(LocalDateTime shipping_date) {
        this.shipping_date = shipping_date;
    }

    @Override
    public String toString() {
        return "OrderDto{" +
                "order_id=" + order_id +
                ", user_id=" + user_id +
                ", order_date=" + order_date +
                ", total_price=" + total_price +
                ", pay_id='" + pay_id + '\'' +
                ", shipping_address='" + shipping_address + '\'' +
                ", shipping_date=" + shipping_date +
                '}';
    }
}
