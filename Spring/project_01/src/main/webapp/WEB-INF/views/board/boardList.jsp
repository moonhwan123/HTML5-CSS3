<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<%@include file="../include/header.jsp"%>


<!-- container-->
    <div class="container">
        <div class="row">
            <div class="col-xs-12">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">
                            <span class="glyphicon glyphicon-tags"></span>
                            &nbsp;&nbsp;Board
                        </h3>
                    </div><!-- panel-heading -->
                    <div class="panel-body">
                        <div class="media">
                            <div class="media-left">
                                <a href="#">
                                    <img class="media-object" src="/resources/img/android.png" alt="Test img">
                                </a>
                            </div>
                            <div class="media-body">
                                <h4 class="media-heading">Test</h4><br>
                                Lorem ipsum dolor sit amet consectetur adipisicing elit. 
                                Nobis asperiores unde quidem magni nisi placeat corrupti adipisci, 
                                facilis optio perspiciatis nihil sint ipsum voluptatum nemo? 
                                Suscipit voluptatum qui similique illo!
                            </div>
                        </div><!-- end media -->
                    </div>
                    <table class="table">
                        <thead>
                            <tr>
                                <th>BNO</th>
                                <th>TITLE</th>
                                <th>WRITER</th>
                                <th>UPLOAD DATE</th>
                                <th>UPDATE DATE</th>
                            </tr>
                        </thead>
                        <tbody>
                        	<c:forEach var="board" items="${boardList}">
	                            <tr>
	                                <td><c:out value="${board.bno}" /></td>
	                                <td><c:out value="${board.title}" /></td>
	                                <td><c:out value="${board.writer}" /></td>
									<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate}" /></td>
									<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate}" /></td>
	                            </tr>
                            </c:forEach>
                        </tbody>
                    </table><!-- end table -->
                </div>
            </div>
        </div><!-- end row -->
        
        <!-- pagination -->
        <nav aria-label="Page navigation" style="text-align: center;">
	        <ul class="pagination">
		        <c:if test="${pageMaker.prev}">
			        <li class="paginate_button">
				        <a href="${pageMaker.startPage -1}" aria-label="Previous">
				        	<span aria-hidden="true">&laquo;</span>
				        </a>
			        </li>
		        </c:if>
		        
		        <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
		        	<li class="paginate_button ${pageMaker.cri.pageNum == num ? 'active':'' }">
		        		<a href="${num}">${num}</a>
		        	</li>
		        </c:forEach>
		        
		        <c:if test="${pageMaker.next}">
			        <li class="paginate_button">
				        <a href="${pageMaker.endPage +1}" aria-label="Next">
				        	<span aria-hidden="true">&raquo;</span>
				        </a>
			        </li>
		        </c:if>
	        </ul>
	        <button id='regBtn' type="button" class="btn pull-right">Register New Board</button>
        </nav>
        <!-- end pagination -->
    </div><!-- end container -->
	
	<!-- 페이지 번호 클릭시 같이 넘기는 데이터들 -->
	<form id='actionForm' action="/board/boardList" method='get'>
		<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
		<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
		<!-- 
		<input type='hidden' name='type' value='<c:out value="${ pageMaker.cri.type }"/>'> 
		<input type='hidden' name='keyword' value='<c:out value="${ pageMaker.cri.keyword }"/>'>
		 -->
	</form>

<script type="text/javascript">
$(document).ready(function() {
	
	//page번호 클릭시 이벤트 처리
	var actionForm = $("#actionForm");
	$(".paginate_button a").on("click",function(e) {
		e.preventDefault();
		console.log('click');
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	});
	
	
	
});
</script>
<%@include file="../include/footer.jsp"%>