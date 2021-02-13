<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<%@include file="../include/header.jsp"%>

 <div class="container">
        <h4>Register</h4>
        <hr>
        <form name="modiForm" action="/fileBoard/fileBoardModify" method="post">
	        <input type="hidden" name="bno" value="<c:out value="${board.bno}" />">
	        <input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'> 
			<input type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
			<input type='hidden' name='type' value='<c:out value="${cri.type}"/>' />
			<input type='hidden' name='keyword' value='<c:out value="${cri.keyword}"/>' />
        <div class="row">
            <div class="col-sm-9">
                <h5>TITLE</h5>
                <div class="input-group">
                    <span class="input-group-addon" id="sizing-addon2"></span>
                    <input type="text" class="form-control" placeholder="TITLE" aria-describedby="sizing-addon2" name='title'
                    value='<c:out value="${board.title}" />'>
                </div>
                <br>   
                <h5>CONTENT</h5>
                <div class="input-group">
                    <span class="input-group-addon" id="sizing-addon2"></span>
                    <textarea class="form-control" placeholder="CONTENT" rows="4" cols="10" 
                    	style="resize: none; height:200px;" name='content'><c:out value="${board.content}" /></textarea>
                </div>
                <br>
                <h5>WRITER</h5>
                <div class="input-group">
                    <span class="input-group-addon" id="sizing-addon2"></span>
                    <input type="text" class="form-control" placeholder="WRITER" aria-describedby="sizing-addon2" name='writer'
                    value='<c:out value="${board.writer}" />' readonly="readonly">
                </div>
                <br>
            </div><!-- end col-sm-4 -->
            
        </div><!-- end row -->
        <hr>
        <button type="submit" class="btn btn-default pull-right">Modify</button>
        <br><br><br><br><br>
        </form>
    </div>

	


<script type="text/javascript">
$(document).ready(function() {

	var formObj = $("form[name='modiForm']");
	
	$("button[type='submit']").on("click",function(e){
		e.preventDefault();
		
		if(modiForm.title.value == null || modiForm.title.value == ""){
			alert("please insert title");
			return;
		}
		
		if(modiForm.content.value == null || modiForm.content.value == ""){
			alert("please insert content");
			return;
		}
		
		console.log("submit clicked");
		formObj.submit();
	});
	
});
</script>


<%@include file="../include/footer.jsp"%>