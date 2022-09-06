<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="service.*"%>
<%@ page import="vo.*"%>
<%
request.setCharacterEncoding("utf-8");

if (session.getAttribute("user") == null && session.getAttribute("active").equals("Y")) {
	response.sendRedirect(request.getContextPath() + "/index.jsp");
	System.out.println("없음");
	return;
}

// 페이징값
int currentPage = 1;
if (request.getParameter("currentPage") != null) {
	currentPage = Integer.parseInt(request.getParameter("currentPage"));
}
final int ROW_PER_PAGE = 10;

GoodsService goodsService = new GoodsService();
List<Goods> list = new ArrayList<Goods>();
list = goodsService.getGoodsListByPage(ROW_PER_PAGE, currentPage);

int lastPage = goodsService.getGoodsLastPage(ROW_PER_PAGE);
System.out.print("lastPage : " + lastPage);

if (list == null) {
	response.sendRedirect(request.getContextPath() + "/admin/adminIndex.jsp");
	return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">
<title>adminGoodsList</title>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <meta content="" name="description">
  <meta content="" name="keywords">

  <!-- Favicons -->
  <link href="assets/img/favicon.png" rel="icon">
  <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="assets/vendor/animate.css/animate.min.css" rel="stylesheet">
  <link href="assets/vendor/aos/aos.css" rel="stylesheet">
  <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
  <link href="assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
  <link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet">
  <link href="assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">

  <!-- Template Main CSS File -->
  <link href="assets/css/style.css" rel="stylesheet">

  <!-- =======================================================
  * Template Name: Selecao - v4.8.0
  * Template URL: https://bootstrapmade.com/selecao-bootstrap-template/
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
</head>

<body>

  <!-- ======= Header ======= -->
  <header id="header" class="fixed-top d-flex align-items-center  header-transparent">
  									
    <div class="container d-flex align-items-center justify-content-between">

      <div class="logo">
        <h1><a href="index.html">ByungwooFarm</a></h1>
        <!-- Uncomment below if you prefer to use an image logo -->
        <!-- <a href="index.html"><img src="assets/img/logo.png" alt="" class="img-fluid"></a>-->
      </div>

	<nav id="navbar" class="navbar">
        <ul>
          <li><a class="nav-link scrollto active" href="<%=request.getContextPath()%>/admin/adminIndex.jsp">Home</a></li>
          <li><a class="nav-link scrollto" href="<%=request.getContextPath()%>/admin/adminGoodsList.jsp">상품관리</a></li>
          <li><a class="nav-link scrollto" href="<%=request.getContextPath()%>/admin/adminCustomerList.jsp">고객관리</a></li>
          <li><a class="nav-link scrollto " href="<%=request.getContextPath()%>/admin/adminOrderList.jsp">주문관리</a></li>
          <li><a class="nav-link scrollto" href="<%=request.getContextPath()%>/admin/adminNoticeList.jsp">공지관리</a></li>
          <li><a class="nav-link scrollto" href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a></li>
          <li><a class="nav-link scrollto" href="<%=request.getContextPath()%>/removeIdForm.jsp">회원 탈퇴</a></li>
          <li><a class="nav-link scrollto" href="<%=request.getContextPath()%>/test.jsp">test</a></li>
        </ul>
	</nav>
      <!-- .navbar -->

    </div>
  </header><!-- End Header -->
  
   <!-- ======= Hero Section ======= -->
  <section id="hero" class="d-flex flex-column justify-content-end align-items-center">
    <div id="heroCarousel" data-bs-interval="5000" class="container carousel carousel-fade" data-bs-ride="carousel">

      <!-- Slide 1 -->
      <form id="customerForm" method="post" action="<%=request.getContextPath()%>/customerLoginAction.jsp">
      <fieldset>
      <div class="carousel-item active" >
        <div class="carousel-container">
       
          <h2 class="animate__animated animate__fadeInDown">GOODS LIST (<span><%=session.getAttribute("user")%>)</span></h2>
          <p class="animate__animated fanimate__adeInUp"><%=session.getAttribute("user")%>님 환영합니다.</p>

        </div>
        
        
        <div>
        
        
        </div>
        
        
      </div>
      
      </fieldset>
      </form>

    </div>


  </section><!-- End Hero -->
  
  
   <!-- ======= Services Section ======= -->
    <section id="services" class="services">
      <div class="container">

        <div class="section-title" data-aos="zoom-out">
          <h2>sales list</h2>
          <p>판매목록</p>
        </div>

        <div class="row">
          <div class="col-lg-4 col-md-6">
            <div class="icon-box" data-aos="zoom-in-left">
              <div class="icon"><i class="" style="color: #ff689b;"></i></div>
              <h4 class="title"><a href="">감자</a></h4>
              <p class="description">Korean GangWon-do Potato</p>
              <p class="description">Korean GangWon-do Potato</p>
            </div>
          </div>
          <div class="col-lg-4 col-md-6 mt-5 mt-md-0">
            <div class="icon-box" data-aos="zoom-in-left" data-aos-delay="100">
              <h4 class="title"><a href="">고구마</a></h4>
              <p class="description">Korean HeaNam-gun SweetPoatato</p>
            </div>
          </div>

          <div class="col-lg-4 col-md-6 mt-5 mt-lg-0 ">
            <div class="icon-box" data-aos="zoom-in-left" data-aos-delay="200">
              <h4 class="title"><a href="">참외</a></h4>
              <p class="description">Korean WaterMelon</p>
            </div>
          </div>
          <div class="col-lg-4 col-md-6 mt-5">
            <div class="icon-box" data-aos="zoom-in-left" data-aos-delay="300">
              <h4 class="title"><a href="">M16</a></h4>
              <p class="description">Korean Rifle</p>
            </div>
          </div>

          <div class="col-lg-4 col-md-6 mt-5">
            <div class="icon-box" data-aos="zoom-in-left" data-aos-delay="400">
              <h4 class="title"><a href="">Retona</a></h4>
              <p class="description">Korean Hummer</p>
            </div>
          </div>
          <div class="col-lg-4 col-md-6 mt-5">
            <div class="icon-box" data-aos="zoom-in-left" data-aos-delay="500">
              <h4 class="title"><a href="">Do DonBan 2½</a></h4>
              <p class="description">Korean Millitary Truck</p>
            </div>
          </div>
        </div>

      </div>
    </section><!-- End Services Section -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</head>
<body>
	<div>
			<div>
				<table class="i">
					<thead>
						<tr>
							<th>NO</th>
							<th>NAME</th>
							<th>PRICE</th>
							<th>CREATEDATE</th>
							<th>SOLDOUT</th>
						</tr>
					</thead>
					<tbody>
						<%
						for (Goods g : list) {
						%>
						<tr>
							<td><%=g.getGoodsNo()%></td>
							<td>							
								<a href="<%=request.getContextPath()%>/admin/GoodsOne.jsp?goodsNo=<%=g.getGoodsNo()%>">
									<%=g.getGoodsName()%>
							</a>
							</td>
							<td><%=g.getGoodsPrice()%>원</td>
							<td><%=g.getCreateDate()%></td>
							<td>
								<form
									action="<%=request.getContextPath()%>/admin/updateGoodsSoldOutAction.jsp"
									method="post">
									<input type="hidden" name="goodsNo" value="<%=g.getGoodsNo()%>">
									<select name="soldOut">
										<%
										if (g.getSoldOut().equals("N")) {
										%>
										<option value="Y">Y</option>
										<option value="N" selected="selected">N</option>
										<%
										} else {
										%>
										<option value="Y" selected="selected">Y</option>
										<option value="N">N</option>
										<%
										}
										%>
									</select>
									<button type="submit">UPDATE</button>
								</form>
							</td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>
			</div>
		</div>
		<hr>
		<div>
			<%
			if (currentPage > 1) {
			%>
			<a
				href="<%=request.getContextPath()%>/admin/adminGoodsList.jsp?currentPage=<%=currentPage - 1%>">이전</a>
			<%
			}
			if (currentPage < lastPage) {
			%>
			<a
				href="<%=request.getContextPath()%>/admin/adminGoodsList.jsp?currentPage=<%=currentPage + 1%>">다음</a>
			<%
			}
			%>
			<a href="<%=request.getContextPath()%>/admin/addGoodsForm.jsp" style = "margin:325px;"><button>상품추가</button></a>
		</div>
  <!-- ======= Footer ======= -->
  <footer id="footer">
    <div class="container">
      <h3>ByungWoo Farm</h3>
      <p>Gyunggi-do,  buchun-si </p>
      <div class="social-links">
        <a href="#" class="twitter"><i class="bx bxl-twitter"></i></a>
        <a href="#" class="facebook"><i class="bx bxl-facebook"></i></a>
        <a href="#" class="instagram"><i class="bx bxl-instagram"></i></a>
        <a href="#" class="google-plus"><i class="bx bxl-skype"></i></a>
        <a href="#" class="linkedin"><i class="bx bxl-linkedin"></i></a>
      </div>
      <div class="copyright">
        &copy; Copyright <strong><span>ByungwooFarm</span></strong>. All Rights Reserved
      </div>
      <div class="credits">
        <!-- All the links in the footer should remain intact. -->
        <!-- You can delete the links only if you purchased the pro version. -->
        <!-- Licensing information: https://bootstrapmade.com/license/ -->
        <!-- Purchase the pro version with working PHP/AJAX contact form: https://bootstrapmade.com/selecao-bootstrap-template/ -->
        Designed by <a href="https://bootstrapmade.com/">BootstrapMade</a>
      </div>
    </div>
  </footer><!-- End Footer -->

  <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

  <!-- Vendor JS Files -->
  <script src="assets/vendor/aos/aos.js"></script>
  <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="assets/vendor/glightbox/js/glightbox.min.js"></script>
  <script src="assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
  <script src="assets/vendor/swiper/swiper-bundle.min.js"></script>
  <script src="assets/vendor/php-email-form/validate.js"></script>

  <!-- Template Main JS File -->
  <script src="assets/js/main.js"></script>

		
</body>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
</html>