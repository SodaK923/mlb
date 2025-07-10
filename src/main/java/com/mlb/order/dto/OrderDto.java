package com.mlb.order.dto;

import com.mlb.order.dto.*;
import com.mlb.order.dto.option.*;
import java.util.*;


// orderDetail Repository
public class OrderDto {
	
	private OrderNo orderno;
	private ArrayList<OrderDetail> orderDetailList;
	
	
	public OrderDto(OrderNo orderno, ArrayList<OrderDetail> orderDetailList) {
		this.orderno = orderno;
		this.orderDetailList = orderDetailList;
	}

	public HashSet<Long> getPrIdList()
	{
		HashSet<Long> prIds = new HashSet<>();
		for( OrderDetail o : orderDetailList )
		{
			prIds.add(o.getProduct().getPrId());
		}
		
		return prIds;
	}
	
	
	public ArrayList<OrderDetail> getOrderDetailPrId( Long prId )
	{
		ArrayList<OrderDetail> list = new ArrayList<>();
		for( OrderDetail o : orderDetailList )
		{
			if( prId == o.getProduct().getPrId() )
			{
				list.add(o);
			}
		}
		
		return list;
	}
	
	public OrderDetail getOrderDetail( Long detailId )
	{
		
		for( OrderDetail o : orderDetailList )
		{
			if( detailId == o.getOrderDetailId() )
			{
				return o;
			}
		}
		
		return null;
	}

	public OrderNo getOrderno() {
		return orderno;
	}

	public void setOrderno(OrderNo orderno) {
		this.orderno = orderno;
	}

	public ArrayList<OrderDetail> getOrderDetailList() {
		return orderDetailList;
	}

	public void setOrderDetailList(ArrayList<OrderDetail> orderDetailList) {
		this.orderDetailList = orderDetailList;
	}
	
	

}
