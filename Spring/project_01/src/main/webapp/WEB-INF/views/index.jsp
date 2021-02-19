<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="include/header.jsp"%>


<div class="container">
	<!--jumbotron-->
	<div class="jumbotron">
		<h1 class="text-center">Test index</h1>
		<p class="text-center">Lorem ipsum dolor, sit amet consectetur
			adipisicing elit. Modi nulla, commodi quidem quod quae quas
			consequatur aspernatur assumenda id cupiditate distinctio neque vel
			maxime facere perferendis quibusdam, tempore recusandae minus!</p>
		<p class="text-center">
			<a class="btn btn-primary btn-lg" href="#" role="button">TEST</a>
		</p>
	</div>
	<!--end jumbotron-->


	<div class="row">
		<div class="col-md-4">
			<h4>MODAL</h4>
			<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Id,
				fugiat dolore. Beatae quod modi amet repudiandae iste magnam est ea
				vel. Magnam esse at rem culpa numquam optio nemo animi!</p>
			<p>
				<a class="btn btn-default" data-target="#modal" data-toggle="modal">자세히</a>
			</p>
		</div>
		<div class="col-md-4">
			<h4>MODAL</h4>
			<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Id,
				fugiat dolore. Beatae quod modi amet repudiandae iste magnam est ea
				vel. Magnam esse at rem culpa numquam optio nemo animi!</p>
			<p>
				<a class="btn btn-default" href="#">자세히</a>
			</p>
		</div>
		<div class="col-md-4">
			<h4>MODAL</h4>
			<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Id,
				fugiat dolore. Beatae quod modi amet repudiandae iste magnam est ea
				vel. Magnam esse at rem culpa numquam optio nemo animi!</p>
			<p>
				<a class="btn btn-default" href="#">자세히</a>
			</p>
		</div>
	</div>

	<hr>

	<div class="panel panel-primary">
		<div class="panel-heading">
			<h3 class="panel-title">
				<span class="glyphicon glyphicon-pencil"></span> &nbsp;&nbsp;TEST
			</h3>
		</div>
		<div class="panel-body">
			<div class="media">
				<div class="media-left">
					<a href="#"><img class="media-object" src="resources/img/C.png" alt="C언어"></a>
				</div>
				<div class="media-body">
					<h4 class="media-heading">
						<a href="#">TEST</a>&nbsp;<span class="badge">New</span>
					</h4>
					Lorem ipsum dolor, sit amet consectetur adipisicing elit. Ut
					tempore asperiores numquam, error quasi itaque eveniet recusandae,
					nobis perspiciatis architecto eum aliquid sunt, repudiandae veniam
					saepe quae quo in odit.
				</div>
			</div>
			<hr>
			<div class="media">
				<div class="media-left">
					<a href="#"><img class="media-object" src="resources/img/android.png"
						alt="android"></a>
				</div>
				<div class="media-body">
					<h4 class="media-heading">
						<a href="#">TEST</a>&nbsp;<span class="badge">New</span>
					</h4>
					Lorem ipsum dolor, sit amet consectetur adipisicing elit. Ut
					tempore asperiores numquam, error quasi itaque eveniet recusandae,
					nobis perspiciatis architecto eum aliquid sunt, repudiandae veniam
					saepe quae quo in odit.
				</div>
			</div>
		</div>
		<!-- end panel-body -->
	</div>
	<!-- end panel-primary -->

</div>
<!-- end container -->





<%@include file="include/footer.jsp"%>