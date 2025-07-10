package com.mlb.order.pay.dto;

import com.mlb.product.dao.ProductDao;
import com.mlb.product.dao.ProductStockDao;

public class OrderDetailDto {
    Long order_detail_id;
    Long order_id;
    Long user_id;
    Long pr_st_id;
    Long order_quantity;
    Long order_price;
    public OrderDetailDto() {}
    public Long getOrderDetailId() {
        return order_detail_id;
    }
    public void setOrderDetailId(Long order_detail_id) {
        this.order_detail_id = order_detail_id;
    }
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
    public Long getPrStId() {
        return pr_st_id;
    }
    public void setPrStId(Long pr_st_id) {
        this.pr_st_id = pr_st_id;
    }
    public Long getOrderQuantity() {
        return order_quantity;
    }
    public void setOrderQuantity(Long order_quantity) {
        this.order_quantity = order_quantity;
    }
    public Long getOrderPrice() {
        return order_price;
    }
    public void setOrderPrice(Long order_price) {
        this.order_price = order_price;
    }
    @Override
    public String toString() {
        return "OrderDetailDto{" +
                "order_detail_id=" + order_detail_id +
                ", order_id=" + order_id +
                ", user_id=" + user_id +
                ", pr_st_id=" + pr_st_id +
                ", order_quantity=" + order_quantity +
                ", order_price=" + order_price +
                '}';
    }

    public Long getCurrentPrice() {
        return new ProductStockDao().selectByProductStockId(pr_st_id).getPrice();
    }
    public Long getCurrentTotalPrice() {
        return getCurrentPrice() * order_quantity;
    }
    public Long getTotalPrice() {
        return order_price * order_quantity;
    }
    public String getPr_thum_img() {
        return new ProductDao().selectByProductId(new ProductStockDao().selectByProductStockId(pr_st_id).getPr_id()).getPr_thum_img();
    }

    public String getPr_name() {
        return new ProductDao().selectByProductId(new ProductStockDao().selectByProductStockId(pr_st_id).getPr_id()).getPr_name();
    }

    public String getTm_name() {
        return new ProductDao().selectByProductId(new ProductStockDao().selectByProductStockId(pr_st_id).getPr_id()).getTm_name();
    }
    public String getCl_name() {
        return new ProductStockDao().selectByProductStockId(pr_st_id).getCl_name();
    }

    public String getSz_id() {
        return new ProductStockDao().selectByProductStockId(pr_st_id).getSz_id();
    }

}
