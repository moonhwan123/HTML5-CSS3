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
                                <h4 class="media-heading">BOARD</h4><br>
                                This is FreeBoard!
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
	                                <td>
	                                	<a class='move' href="<c:out value="${board.bno}" />"><c:out value="${board.title}" /></a>
	                                </td>
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
        
        <div class="row">
        	<!-- 새글 등록 버튼 -->
        	<div class="col-md-4">
        		<button id='regBtn' type="button" class="btn">Register New Board</button>
        	</div>
        	<!-- 검색 처리 -->
        	<div class="col-md-8 input-group">
        		<form id='searchForm' class="pull-right" method="get" action="/board/boardList">
        			<select class="form-control" style="width:250px;" name="type">
        				<option value="">--</option>
        				<option value="T" <c:out value="${pageMaker.cri.type eq 'T'?'selected':''}"/> >TITLE</option>
        				<option value="C" <c:out value="${pageMaker.cri.type eq 'C'?'selected':''}"/> >CONTENT</option>
        				<option value="W" <c:out value="${pageMaker.cri.type eq 'W'?'selected':''}"/> >WRITER</option>
        				<option value="TC" <c:out value="${pageMaker.cri.type eq 'TC'?'selected':''}"/> >TITLE + CONTENT</option>
        				<option value="TW" <c:out value="${pageMaker.cri.type eq 'TW'?'selected':''}"/> >TITLE + WRITER</option>
        				<option value="TCW" <c:out value="${pageMaker.cri.type eq 'TCW'?'selected':''}"/> >TITLE + CONTENT + WRITER</option>
        			</select>
        			<input type="text" class="form-control" style="width:300px;" name='keyword' value="${pageMaker.cri.keyword}"/>
        			<input type='hidden' name='pageNum' value='<c:out value="${pageMaker.cri.pageNum}"/>' /> 
					<input type='hidden' name='amount' value='<c:out value="${pageMaker.cri.amount}"/>' />
        			<span class="input-group-btn">
        				<button class="btn btn-default" type="button">Search</button>
     				</span>
        		</form>
        	</div><!-- 검색 부분 끝 -->
        </div>
        
        <!-- pagination -->
        <div class="row">
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
        </nav>
        </div><!-- end pagination -->
        
        
        
        
    </div><!-- end container -->
	
	<!-- 페이지 번호 클릭시 같이 넘기는 데이터들 과 검색시 넘어가는 데이터 -->
	<form id='actionForm' action="/board/boardList" method='get'>
		<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
		<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
		<input type='hidden' name='type' value='<c:out value="${pageMaker.cri.type}"/>'> 
		<input type='hidden' name='keyword' value='<c:out value="${pageMaker.cri.keyword}"/>'>
	</form>
	
	<!-- modal -->
	<div class="row">
		<div class="modal" id="myModal" tabindex="-1">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
							&times;
						</button>
						<h4 class="modal-title" id="myModalLabel">Modal title</h4>
					</div> 
					<div class="modal-body">
						처리가 완료되었습니다.
					</div>
					<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">
								Close
							</button>
					</div>
				</div><!-- end modal-content -->
			</div><!-- end modal-dialog -->
		</div><!-- end modal -->
	</div><!-- end row -->

<script type="text/javascript">
$(document).ready(function() {
	
	//글 등록 완료시 뜨는 모달창 처리
	var result = '<c:out value="${result}"/>';
	checkModal(result);
	history.replaceState({}, null, null); //뒤로가기 눌렀을때 모달창 또 뜨는거 방지
	function checkModal(result) {
		console.log("checkModal....... result : " + result);
		if (result === '' || history.state) {
			return;
		}
		if (parseInt(result) > 0) {
			$(".modal-body").html("게시글 " + parseInt(result) + " 번이 등록되었습니다.");
		}
		$("#myModal").modal("show");
	}
	
	//page번호 클릭시 이벤트 처리
	var actionForm = $("#actionForm");
	$(".paginate_button a").on("click",function(e) {
		e.preventDefault();
		console.log('click');
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	});
	
	//글쓰기 버튼 클릭시 버튼 처리
	$("#regBtn").on("click", function() {
		self.location = "/board/boardRegister";
	});
	
	//검색버튼 처리
	var searchForm = $("#searchForm");
	$("#searchForm button").on("click",function(e) {
		console.log("button click");
		
		if (!searchForm.find("input[name='keyword']").val()) {
			alert("Please insert search keyword");
			return false;
		}
		if (!searchForm.find("option:selected").val()) {
			alert("Please choice search type");
			return false;
		}


		searchForm.find("input[name='pageNum']").val("1");
		e.preventDefault();
		searchForm.submit();
	});
	
	
	//게시글 보기로 넘어가기 스크립트 처리
	//actionForm은 위에서 객체생성함
	$(".move").on("click",function(e) {
		e.preventDefault();
		actionForm.append("<input type='hidden' name='bno' value='" + $(this).attr("href") + "'>");
		actionForm.attr("action","/board/boardRead");
		actionForm.submit();
	});
	
});
</script>
<%@include file="../include/footer.jsp"%>