<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.util.*" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@include file="./includes/header.jsp" %>


<!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>403 Access Denied page</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right"> 
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">
      <div class="error-page">
        <h2 class="headline text-danger">403</h2>

        <div class="error-content">
          <h3><i class="fas fa-exclamation-triangle text-danger"></i> Oops! Something went wrong.</h3>
          <p>
      		Access is denied<a href="/board/list"> return to list page.</a>
          </p>
        </div>
      </div>
      <!-- /.error-page -->

    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->  
    
<%@include file="./includes/footer.jsp" %>