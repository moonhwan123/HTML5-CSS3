<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<%@include file="../include/header.jsp"%>

 <div class="container">
        <h3>BoardRead</h3>
        <hr>
        <div class="row">
            <div class="col-sm-9">
                <h5>BNO</h5>
                <div class="input-group">
                    <span class="input-group-addon" id="sizing-addon2"></span>
                    <input type="text" class="form-control" aria-describedby="sizing-addon2" 
                    	name='bno' value="<c:out value="${board.bno}" />" readonly="readonly">
                </div>
                <br>
            </div>
            <div class="col-sm-9">
                <h5>TITLE</h5>
                <div class="input-group">
                    <span class="input-group-addon" id="sizing-addon2"></span>
                    <input type="text" class="form-control" aria-describedby="sizing-addon2" 
                    	name='title' value="<c:out value="${board.title}" />" readonly="readonly">
                </div>
            </div>
                <br> 
            <div class="col-sm-9">  
                <h5>CONTENT</h5>
                <div class="input-group">
                    <span class="input-group-addon" id="sizing-addon2"></span>
                    <textarea class="form-control" rows="4" cols="10" style="resize: none; height:200px;" name='content' readonly="readonly"><c:out value="${board.content}" />
                    </textarea>
                </div>
                <br>
            </div>
            <div class="col-sm-9">
                <h5>WRITER</h5>
                <div class="input-group">
                    <span class="input-group-addon" id="sizing-addon2"></span>
                    <input type="text" class="form-control" aria-describedby="sizing-addon2" 
                    	name='writer' value="<c:out value="${board.writer}" />" readonly="readonly">
                </div>
                <br>
            </div>
            <div class="col-sm-4">
            <h5>REGDATE</h5>
	            <div class="input-group">
	            	<span class="input-group-addon" id="sizing-addon2"></span>
	            	<input type="text" class="form-control" aria-describedby="sizing-addon2" 
	            	value="<fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate}" />" readonly="readonly"/>
	            </div>
            </div>
            <div class="col-sm-4">
            	<h5>LAST UPDATE</h5>
	            <div class="input-group">
	            	<span class="input-group-addon" id="sizing-addon2"></span>
	            	<input type="text" class="form-control" aria-describedby="sizing-addon2" 
	            	value="<fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate}" />" readonly="readonly"/>
	            </div>
            </div>
        </div><!-- end row -->
        <br><br>
        <button type="button" data-oper='remove' class="btn btn-default pull-left">Remove</button>
        <button type="button" data-oper='modify' class="btn btn-default pull-left">Modify</button>
        <button type="button" data-oper='list' class="btn btn-default pull-left">List</button>
        <br><br>
        
        <form id='operForm' method='get' action='/fileBoard/fileBoardModify'> 
			<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'> 
			<input type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
			<input type='hidden' name='type' value='<c:out value="${cri.type}"/>' />
			<input type='hidden' name='keyword' value='<c:out value="${cri.keyword}"/>' />
			<input type='hidden' name='bno' value='<c:out value="${board.bno}"/>' />
		</form>
		<hr>
    </div><!-- end container -->'
    
	
	<br><br><br>
	
	<!-- 댓글 처리용 modal -->
	<div class="row">
		<div class="modal" id="myModal" tabindex="-1">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
							&times;
						</button>
						<h4 class="modal-title" id="myModalLabel">Reply</h4>
					</div> 
					<div class="modal-body">
						<div class='form-group'>
							<label>Replyer</label>
							<input class='form-control' name='replyer' value=''/>
						</div>
						<div class='form-group'>
							<label>Reply</label>
							<textarea class='form-control' rows="3" style='resize: none;' name='reply'></textarea>
						</div>
						<div class='form-group'>
							<label>Reply Date</label>
							<input class='form-control' name='replyDate' value=''/>
						</div>
						<input type="hidden" name="rno" value=''/>
					</div>
					<div class="modal-footer">
						<button type="button" id="modalModiBtn" class="btn btn-default">
							Modify
						</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">
							Close
						</button>
					</div>
				</div><!-- end modal-content -->
			</div><!-- end modal-dialog -->
		</div><!-- end modal -->
	</div><!-- end row -->
	<!-- 댓글 처리용 모달 끝 -->


<!-- 기본적인 스크립트 -->
<script type="text/javascript">
$(document).ready(function() {
	
	var operForm = $("#operForm");
	
	$("button[data-oper='list']").on("click", function(e) {

		operForm.find("#bno").remove();
		operForm.attr("action", "/fileBoard/fileBoardList");
		operForm.submit();

	});
	$("button[data-oper='modify']").on("click", function(e) {

		operForm.attr("action", "/fileBoard/fileBoardModify");
		operForm.submit();

	});
	$("button[data-oper='remove']").on("click", function(e) {
		
		var con_test = confirm("Are you sure you want to delete it?");
		if(con_test == true){
			operForm.attr("method","post");
			operForm.attr("action", "/fileBoard/fileBoardRemove");
			operForm.submit();
		}
		else if(con_test == false){
		  return;
		}
	});
	
	
});
</script>




<%@include file="../include/footer.jsp"%>