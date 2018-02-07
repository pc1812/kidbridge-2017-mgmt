<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户登录 | kidbridge manage</title>
    <link href="/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="/resources/font-awesome/css/font-awesome.css" rel="stylesheet">
    <link href="/resources/css/animate.css" rel="stylesheet">
    <link href="/resources/css/style.css" rel="stylesheet">
    <link href="/resources/css/plugins/sweetalert/sweetalert.css" rel="stylesheet">
    <link href="/resources/css/service/base.css" rel="stylesheet">
</head>
<body class="gray-bg">
<div class="login">
    <form class="login-form">
        <div class="input-group">
            <span class="input-group-addon" id="user-name">用户名称</span>
            <input autofocus="autofocus" type="text" class="form-control" placeholder="请输入用户名称" aria-describedby="user-name" name="user-name">
        </div>
        <div class="input-group">
            <span class="input-group-addon" id="user-password">用户密码</span>
            <input type="password" class="form-control" placeholder="请输入登录密码" aria-describedby="user-password" name="user-password">
        </div>
        <button type="button" class="btn btn-primary block full-width login-submit">登录</button>
    </form>
    <div class="copyright text-center"> <small>&copy; kidbridge</small> </div>
</div>

<script src="/resources/js/jquery-3.1.1.min.js"></script>
<script src="/resources/js/bootstrap.min.js"></script>
<script src="/resources/js/plugins/metisMenu/jquery.metisMenu.js"></script>
<script src="/resources/js/plugins/slimscroll/jquery.slimscroll.min.js"></script>
<script src="/resources/js/inspinia.js"></script>
<script src="/resources/js/plugins/pace/pace.min.js"></script>
<script src="/resources/js/plugins/sweetalert/sweetalert.min.js"></script>
<script src="/resources/js/service/base.js"></script>
<script>
    $(".login-submit").on("click",function (){
        var name = $("input[name='user-name']").val();
        var password = $("input[name='user-password']").val();
        $.ajax({
            url: "/login",
            type:"POST",
            data:JSON.stringify({"name":name, "password":password}),
            contentType: "application/json",
            dataType: "json",
            success: function(resp){
                if(!resp.success){
                    swal({
                        title: "错误提示",
                        text: resp.message,
                        type: "error",
                        cancelButtonText: "关闭",
                        showCancelButton: true,
                        showConfirmButton: false
                    });
                    return;
                }
                window.location.href = "/";
            }
        });
    });
</script>
</body>
</html>