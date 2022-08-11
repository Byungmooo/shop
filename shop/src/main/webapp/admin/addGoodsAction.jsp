<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@ page import="service.GoodsService"%>
<%@ page import="vo.Goods"%>
<%@ page import="vo.GoodsImg"%>

<%
String dir = request.getServletContext().getRealPath("/upload");
int max = 10 * 1024 * 1024; // 10mb
MultipartRequest mRequest = new MultipartRequest(request, dir, max, "utf-8", new DefaultFileRenamePolicy());

// parameter
// goods
String goodsName = mRequest.getParameter("goodsName");
int goodsPrice = Integer.parseInt(mRequest.getParameter("goodsPrice"));
String soldOut = mRequest.getParameter("soldOut");

// goodsImg
String originFilename = mRequest.getOriginalFileName("imgFile");
String fileName = mRequest.getFilesystemName("imgFile"); // 실제로 저장되는 파일명
String contentType = mRequest.getContentType("imgFile");


// 디버깅	
System.out.println("addGoodsAction.jsp goodsName : " + goodsName);
System.out.println("addGoodsAction.jsp goodsPrice : " + goodsPrice);
System.out.println("addGoodsAction.jsp soldOut : " + soldOut);
System.out.println("addGoodsAction.jsp contentType : " + contentType);
System.out.println("addGoodsAction.jsp originFilename : " + originFilename);
System.out.println("addGoodsAction.jsp filename : " + fileName);


// setter 
Goods goods = new Goods();
goods.setGoodsName(goodsName);
goods.setGoodsPrice(goodsPrice);
goods.setSoldOut(soldOut);
System.out.println(goods);

GoodsImg goodsImg = new GoodsImg();
goodsImg.setContentType(contentType);
goodsImg.setFilename(fileName);
goodsImg.setOriginFilename(originFilename);
System.out.println(goodsImg);

// 메소드 호출
GoodsService goodsService = new GoodsService();
int goodsNo = goodsService.addGoods(goods, goodsImg);

//이미지인지 검사 후 파일 삭제
if(!(contentType.equals("image/gif") || contentType.equals("image/png") || contentType.equals("image/jpeg"))){
	// 이미지가 아닌 파일 삭제
	File f = new File(dir + "/" + fileName);
	
	if(f.exists()){
		f.delete(); // return boolean
	}
	
	response.sendRedirect(request.getContextPath() + "/addGoodsForm.jsp?errorMsg=img file only");
	return;
}

if(goodsNo == 0){
	// db insert 실패 시 파일 삭제
	File f = new File(dir + "/" + fileName);
	
	if(f.exists()){
		f.delete(); // return boolean
	}
	
	response.sendRedirect(request.getContextPath() + "/admin/addGoodsForm.jsp?errorMsg=insert error");
	return;
}

response.sendRedirect(request.getContextPath() + "/admin/GoodsOne.jsp?goodsNo=" + goodsNo);

%>