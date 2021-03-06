package com.palette.orkney.admin.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.palette.orkney.order.model.vo.OrderDetail;
import com.palette.orkney.order.model.vo.Orders;
import com.palette.orkney.product.model.vo.Product;
import com.palette.orkney.product.model.vo.Product_image;

public interface AdminDao {

	List<String> userCount(SqlSession session);

	List<Map> chatData(SqlSession session, Map data);

	List<String> roomNo(SqlSession session, String data);

	List<Orders> selectOrderList(SqlSession session,int cPage, int numPerPage,String search_option,String keyword);

	int modifyFAQ(SqlSession session, Map data);

	int addFAQ(SqlSession session, Map data);

	int deleteFAQ(SqlSession session, String no);

	List<Map> memberList(SqlSession session, int cPage, int numPerPage,Map data);

	int totalData(SqlSession session,Map data);

	List<Map> memberAddr(SqlSession session, String no);

	List<Map> orderList(SqlSession session, String no);

	int deleteMember(SqlSession session, String no);

	int modifyPoint(SqlSession session, Map data);

	int pointModify(SqlSession session, Map data);
	
	int updateOrderState(SqlSession session, Map o);

	int updateOrderInfo(SqlSession session, Map orderInfo);

	Map countOrderState(SqlSession session);
	
	Map countOrderDetailState(SqlSession session);
	
	int totalOrder(SqlSession session);
	
	List<Orders> selectOrderChangeList(SqlSession session, Map s);
	
	int updateOrderListState(SqlSession session, Map m);
	

	List<OrderDetail> selectOrderDetailChangeList(SqlSession session, String state);

	List<Map> productList(SqlSession session, int cPage, int numPerPage, Map<String,Object> all);
	int productTotalData(SqlSession session);
	int productPer(SqlSession session, Map<String,Object> list);
	int productPutIn(SqlSession session, Map<String,Object> list);
	int deleteProduct(SqlSession session, String pNo);
	int deleteProductImg(SqlSession session, String pNo);
	List<Map> productOne(SqlSession session, Map<String,Object> list);
	int productInsert(SqlSession session, Product product);
	int insertProductImage(SqlSession session, Product_image pi);
	Map<String,Object> productUpdate(SqlSession session, String pNo);
	int producUpdateIn(SqlSession session, Product product);
	int producUpdateInImg(SqlSession session, Product_image pi);	
	List<Map> productImg(SqlSession session, Product product);
	List<Map> sCategoryList(SqlSession session, Map<String,Object> list);


	
	int selectRefundCount(SqlSession session, String oNo);
	
	int updateStateAndSort(SqlSession session, Map m);
	
	List<OrderDetail> selectOrderOngoingList(SqlSession session);
	
	int updateSortEnd(SqlSession session, Map m);

}
