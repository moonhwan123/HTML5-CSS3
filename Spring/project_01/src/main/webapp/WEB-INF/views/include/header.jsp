<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Main</title>
    <link rel="stylesheet" href="/resources/css/bootstrap.css?after">
    <script src="/resources/js/jquery.min.js"></script>
    <script src="/resources/js/bootstrap.js"></script>
</head>
<body>
    <div class="navbar navbar-default fixed-top navbar-expand-lg">
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                    data-target="#bs-example-navbar-collapse-1" aria-expanded="flase">
                    <span class="sr-only"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="/">Test Page</a>
            </div>

            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav navbar-left">
                    <li><a href="/board/boardList">Board</a><span class="sr-only"></span></li>
                    <li><a href="instructor.html">test2</a></li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" 
                            aria-haspopup="true" aria-expanded="false">test3<span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="lecture.html?lecture=C">test3-1</a></li>
                            <li><a href="lecture.html?lecture=JAVA">test3-2</a></li>
                            <li><a href="lecture.html?lecture=ANDROID">test3-3</a></li>
                        </ul>
                    </li>
                </ul>
                <!--
                <form class="navbar-form navbar-left"> 
                    <div class="form-group">
                        <input type="text" class="form-control" placeholder="Search">

                    </div>
                    <button type="submit" class="btn btn-default">Search</button>
                </form>
                -->
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="loginform.html">Login</a></li>
                    <li><a href="register.html">Register</a></li>
                </ul>
            </div>
        </div>
    </div>
