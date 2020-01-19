<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp" %>

    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
        <div class="row">
          <div class="col-12">
            <div class="card">
              <div class="card-header">
                <h3 class="card-title pull-left">Board Table</h3>
                <button id="regBtn" type="button" class="btn bg-gradient-success btn-xs float-right"><i class="far fa-edit" style="font-size:15px;"></i>글쓰기</button>
              </div>
              <!-- /.card-header -->
              <div class="card-body table-responsive p-0">
                <table class="table table-hover">
                  <thead>                  
                    <tr bgcolor="#bfbfbf"> 
                      <th>No</th>
                      <th>Title</th>
                      <th>Writer</th> 
                      <th>Register</th>
                      <th>Update</th>
                    </tr>
                  </thead>
                  
                  <c:forEach items="${list}" var="board">
                  <tbody>
                    <tr>
                      <td><c:out value="${board.bno}"/></td>
                      <td><a class='move' href='<c:out value="${board.bno}"/>'><c:out value="${board.title}"/><b>[<c:out value="${board.replyCnt}"/>]</b></a></td>
                      <td><c:out value="${board.writer}"/></td>
                      <td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate}"/></td>
                      <td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate}"/></td>
                    </tr>
                  </tbody>
                  </c:forEach>
                  
                </table>
                
              </div>
              
              <!-- /.card-body -->
              <div class="card-footer clearfix">
                <form id='searchForm' action="/board/list" method='get'>
                	<div class="row clearfix">
                    <div class="col">
                      <!-- select --> 
                      <div class="form-group float-left">
                        <select class="form-control" name='searchType' style="width:200px;" >
                          <option value="" <c:out value="${PageMaker.pm.searchType == null?'selected':''}"/>>Select option</option>
                          <option value="T" <c:out value="${PageMaker.pm.searchType eq 'T'?'selected':''}"/>>제목</option>
                          <option value="C" <c:out value="${PageMaker.pm.searchType eq 'C'?'selected':''}"/>>내용</option>
                          <option value="W" <c:out value="${PageMaker.pm.searchType eq 'W'?'selected':''}"/>>작성자</option>
                          <option value="TC" <c:out value="${PageMaker.pm.searchType eq 'TC'?'selected':''}"/>>제목OR내용</option>
                          <option value="TW" <c:out value="${PageMaker.pm.searchType eq 'TW'?'selected':''}"/>>제목OR작성자</option>
                          <option value="TWC" <c:out value="${PageMaker.pm.searchType eq 'TWC'?'selected':''}"/>>제목OR내용OR작성자</option>
                        </select>
                      </div>
                      <!-- SEARCH FORM -->
    				<div class="card-tools float-left" > 
                  		<div class="input-group input-group-sm" style="width: 170px;">
                    		<input type="text" name="searchKeyword" value="${PageMaker.pm.searchKeyword}" class="form-control" placeholder="Search" style="height:38px;">
                    		<div class="input-group-append">
                      			<button class="btn btn-default"><i class="fas fa-search"></i></button>
                    		</div>
                  		</div>
                	</div>
                      
                    </div>
                	<input type='hidden' name='pageNum' value='${PageMaker.pm.pageNum}'>
					<input type='hidden' name='amount' value='${PageMaker.pm.amount}'>
                	</div>
                </form>
                
                <ul class="pagination pagination-sm m-0 float-right">
                
                  <c:if test="${PageMaker.prev}">
                  	<li class="page-item">
                  		<a class="page-link" href="${PageMaker.startPage -1}">&laquo;</a>
                  	</li>
                  </c:if> 
                  
                  <c:forEach var="num" begin="${PageMaker.startPage}" end="${PageMaker.endPage}">
                  	<li class="page-item ${PageMaker.pm.pageNum == num ? "active":""} ">
                  		<a class="page-link" href="${num}">${num}</a>
                  	</li>
                  </c:forEach>
                  
                  <c:if test="${PageMaker.next}">
                  	<li class="page-item">
                  		<a class="page-link" href="${PageMaker.endPage +1}">&raquo;</a>
                  	</li>
                  </c:if>
                </ul>
              </div>
              
              
              <form id='actionForm' action="/board/list" method='get'>
				<input type='hidden' name='pageNum' value='${PageMaker.pm.pageNum}'>
				<input type='hidden' name='amount' value='${PageMaker.pm.amount}'>
				<input type='hidden' name='searchType' value='<c:out value="${PageMaker.pm.searchType}"/>'>
				<input type='hidden' name='searchKeyword' value='<c:out value="${PageMaker.pm.searchKeyword}"/>'>
			  </form>  
			  
			
            </div>
        </div>
      </div>
      <!-- /.card -->
     </div><!-- /.container-fluid -->
   </section>
   <!-- /.content -->
    
<script type="text/javascript">
$(document).ready(function(){
	
	var result = '<c:out value="${result}"/>' // result == bno값
	
	checkAlert(result);
	
	history.replaceState({},null,null); // 히스토리 객체에 현제 저장된 데이터를 변경한다.
	
	function checkAlert(result){
		
		if(result === '' || history.state){ // 등록-> 목록 -> 조회 에서 뒤로가기를 누르면 모달창이 나오는 문제 수정
			return; // bno값이 없으면 모달창을 보여줄 필요가없음
		}
		
		if(parseInt(result) > 0) {
			swal ( "Success" ,  "게시글 " + parseInt(result)+ "번이 등록되었습니다!!!" ,  "success" );
		}
		
		if(result == "modifySuccess"){
			swal ( "Success" ,  "수정이 완료되었습니다!!" ,  "success" );
		}
		
		if(result == "removeSuccess"){
			swal ( "Success" ,  "삭제가 완료되었습니다!!" ,  "success" );
		}
		

	}
	
	$("#regBtn").on("click", function(){ // 등록 버튼을 클릭하면 등록 페이지로 이동
		self.location = "/board/register";
	});
	
	var actionForm = $("#actionForm"); // id가 "actionForm" 으로 지정된 form태그
	
	$(".page-item a").on("click", function(e){
		
		e.preventDefault(); // a태그의 기능을 막음
		
		console.log('click');
		
		// input태그의 name이 "pageNum"인 부분을 찾아서 양식의 값을 가져와서(val()->${PageMaker.pm.pageNum}) 클릭한 해당 속성($(this))의 href값으로 으로 변경해준다
		actionForm.find("input[name='pageNum']").val($(this).attr("href")); 
		actionForm.submit();
	});
	
	$(".move").on("click", function(e){ // 글의 제목을 눌렀을때
		e.preventDefault(); // 기본적인 이동의 기능을 막음
		
		actionForm.append("<input type='hidden' name='bno' value='"+$(this).attr("href")+"'>"); // form에 input태그를 추가(bno값을 같이 전송)
		actionForm.attr("action", "/board/get");
		actionForm.submit();
	});
	
	var searchForm = $("#searchForm");
	
	$("#searchForm button").on("click", function(e){
		
		if(!searchForm.find("option:selected").val()){ // 검색 옵션을 선택하지 않았을 경우
			swal ( "Oops" ,  "검색 옵션을 선택해 주세요!!" ,  "error" );
			return false;
		}
		
		if(!searchForm.find("input[name='searchKeyword']").val()){ // 검색 내용을 선택하지 않았을 경우 
			swal ( "Oops" ,  "검색 내용을 선택해 주세요!!" ,  "error" );
			return false;
		}
		
		searchForm.find("input[name='pageNum']").val("1"); // 검색은 1페지를 수행

		e.preventDefault();

		searchForm.submit();
	});
	
});
</script>
  
 <%@include file="../includes/footer.jsp" %>