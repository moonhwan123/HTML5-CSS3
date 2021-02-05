<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<%@include file="../include/header.jsp"%>

 <div class="container">
        <h4>Register</h4>
        <hr>
        <form name="regiForm" action="/board/boardRegister" method="post">
        <div class="row">
            <div class="col-sm-9">
                <h5>TITLE</h5>
                <div class="input-group">
                    <span class="input-group-addon" id="sizing-addon2"></span>
                    <input type="text" class="form-control" placeholder="TITLE" aria-describedby="sizing-addon2" name='title'>
                </div>
                <br>   
                <h5>CONTENT</h5>
                <div class="input-group">
                    <span class="input-group-addon" id="sizing-addon2"></span>
                    <textarea class="form-control" placeholder="CONTENT" rows="4" cols="10" 
                    	style="resize: none; height:200px;" name='content'></textarea>
                </div>
                <br>
                <h5>WRITER</h5>
                <div class="input-group">
                    <span class="input-group-addon" id="sizing-addon2"></span>
                    <input type="text" class="form-control" placeholder="WRITER" aria-describedby="sizing-addon2" name='writer'>
                </div>
                <br>
            </div><!-- end col-sm-4 -->
            
        </div><!-- end row -->
        <hr>
        <button type="submit" class="btn btn-default pull-right">Submit</button>
        <button type="reset" class="btn btn-default pull-right">Reset</button>
        <br><br><br><br><br>
        </form>
    </div>

	


<script type="text/javascript">
$(document).ready(function() {

	var formObj = $("form[name='regiForm']");
	
	$("button[type='submit']").on("click",function(e){
		e.preventDefault();
		
		if(regiForm.title.value == null || regiForm.title.value == ""){
			alert("please insert title");
			return;
		}
		
		if(regiForm.content.value == null || regiForm.content.value == ""){
			alert("please insert content");
			return;
		}
		
		console.log("submit clicked");
		formObj.submit();
	});
	
});
</script>


<%@include file="../include/footer.jsp"%>