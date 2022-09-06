<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
 <%	
	
	if (session.getAttribute("user") == null) {
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		System.out.println("없음");
		return;
	}
 //
%>   
    
<!DOCTYPE html>
<html lang="utf-8">
<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>Selecao Bootstrap Template - Index</title>
  
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
       
          <h2 class="animate__animated animate__fadeInDown">Login ID : <span><%=session.getAttribute("user")%></span></h2>
          <p class="animate__animated fanimate__adeInUp"><%=session.getAttribute("user")%>님 환영합니다.</p>

        </div>
      </div>
      </fieldset>
      </form>

    </div>


  </section><!-- End Hero -->


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
</html>