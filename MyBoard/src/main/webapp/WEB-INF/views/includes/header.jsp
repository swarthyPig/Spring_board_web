<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <link rel="icon" type="image/png"  href="/resources/dist/img/pig.png"/>
  <title>Boarder Tables</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="/resources/plugins/fontawesome-free/css/all.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="/resources/dist/css/adminlte.min.css">
  <!-- Google Font: Source Sans Pro -->
  <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
</head>
<body class="hold-transition sidebar-mini">
<div class="wrapper">
  <!-- Navbar -->
  <nav class="main-header navbar navbar-expand navbar-white navbar-light">
  
    <!-- Left navbar links -->
    
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" data-widget="pushmenu" href="#"><i class="fas fa-bars"></i></a>
      </li>
      <li class="nav-item">
        <a href="/board/list" class="nav-link">Home</a>
      </li>
    </ul>
    
    <!-- Right navbar links -->
    <ul class="navbar-nav ml-auto">
      <!-- Messages Dropdown Menu -->
      
      <sec:authorize access="isAuthenticated()"> <!-- 로그인 상태일 때 -->
      	<li class="nav-item">
        	<a class="nav-link" href="javascript:void(0);" onclick="logoutForm();">
        	Sign out
        	</a>
      	</li>
      </sec:authorize>
      
      <sec:authorize access="isAnonymous()"> <!-- 로그아웃 상태일 때 -->
      	<li class="nav-item">
        	<a class="nav-link" href="/customLogin">
            Sign in
        	</a>
        </li>
        <li class="nav-item">
        	<a class="nav-link" href="/memberRegister">
            Sign up
        	</a>
        </li>
      </sec:authorize>
      
      <li class="nav-item">
        <a class="nav-link" data-widget="control-sidebar" data-slide="true" href="#">
          <i class="fas fa-th-large"></i>
        </a>
      </li>
    </ul>
  </nav>
  <!-- /.navbar -->

  <!-- Main Sidebar Container -->
  <aside class="main-sidebar sidebar-dark-primary elevation-4">
    <!-- Brand Logo -->
    <a href="/board/list" class="brand-link">
      <img src="/resources/dist/img/pig.png"
           alt="Pig Logo"
           class="brand-image img-circle elevation-3"
           style="opacity: .8">
      <span class="brand-text font-weight-light">SwarthyPig</span>
    </a>

    <!-- Sidebar -->
    <div class="sidebar">
      <!-- Sidebar user (optional) -->
      <div class="user-panel mt-3 pb-3 mb-3 d-flex"> 
        <div class="image">
          <img src="/resources/dist/img/myImg.jpg" class="img-circle elevation-2" alt="User Image">  
        </div>
        <div class="info">
          <a href="http://www.github.com/swarthyPig" class="d-block" target="_blank">JEONG YEONGGWAN</a>
        </div>
      </div>

      <!-- Sidebar Menu -->
      <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
          <!-- Add icons to the links using the .nav-icon class
               with font-awesome or any other icon font library -->
   
          <li class="nav-item has-treeview menu-open">
          
          	<a href="http://www.github.com/swarthyPig" class="nav-link" target="_blank">
              &nbsp;<i class="fab fa-github" style="font-size:21px;"></i>
              <p>
              	 &nbsp; Github Site
              </p>
            </a>
            
            <a href="/board/list" class="nav-link">
              <i class="nav-icon fas fa-table"></i>
              <p>
                Board Table
              </p>
            </a>
            
          </li>
         </ul> 
      </nav>
      <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
  </aside>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>Simple Tables</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="/board/list">Home</a></li>
              <li class="breadcrumb-item active">Simple Table</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>
    
<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- SweetAlert -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript">

function logoutForm() {
	
	var form = document.createElement("form");
       
    form.action = "/customLogout";
    form.method = "post";
             
    var input = document.createElement("input");
    input.setAttribute("type", "hidden");
    input.setAttribute("name", "${_csrf.parameterName}");
    input.setAttribute("value", "${_csrf.token}");
             
    form.appendChild(input);   
    
    document.body.appendChild(form);
             
    form.submit();
}
</script>	
	