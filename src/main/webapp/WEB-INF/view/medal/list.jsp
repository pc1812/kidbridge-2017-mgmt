<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>勋章列表 | kidbridge manage</title>
    <link href="/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="/resources/font-awesome/css/font-awesome.css" rel="stylesheet">
    <link href="/resources/css/animate.css" rel="stylesheet">
    <link href="/resources/css/style.css" rel="stylesheet">
    <link href="/resources/css/plugins/sweetalert/sweetalert.css" rel="stylesheet">
    <link href="/resources/css/service/base.css" rel="stylesheet">
    <style type="text/css">
        .medal tr td {
            line-height: 100px !important;
        }
        .medal tr td img {
            height: 100px;
        }
        .medal-add-active, .medal-add-quiet {
            text-align: center;
        }
        .medal-add-active img, .medal-add-quiet img {
            height: 100px;
            margin: 10px 0px;
        }
    </style>
</head>
<body>
<div id="wrapper">

    <jsp:include page="/WEB-INF/view/templet/navigation.jsp" />

     <div id="page-wrapper" class="gray-bg">
        <div class="wrapper wrapper-content">
            <div class="row">
                <div class="col-lg-12">
                    <div class="ibox float-e-margins">
                        <div class="ibox-title">
                            <h5>勋章列表</h5>
                        </div>
                        <div class="ibox-content">

                            <table class="table table-striped medal">
                                <thead>
                                <tr>
                                    <th>编号</th>
                                    <th>勋章名称</th>
                                    <th>所需水滴</th>
                                    <th>彩色图片</th>
                                    <th>灰度图片</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${not empty medalList }">
                                            <c:forEach items="${medalList }" var="medal">
                                                <tr>
                                                    <td>${medal.id }</td>
                                                    <td>${medal.name }</td>
                                                    <td>${medal.bonus }</td>
                                                    <td>
                                                        <a href="http://res.kidbridge.org/${medal.icon.active }" target="_blank">
                                                            <img src="http://res.kidbridge.org/${medal.icon.active }">
                                                        </a>
                                                    </td>
                                                    <td>
                                                        <a href="http://res.kidbridge.org/${medal.icon.quiet }" target="_b">
                                                            <img src="http://res.kidbridge.org/${medal.icon.quiet }">
                                                        </a>
                                                    </td>
                                                    <td>
                                                        <button type="button" data-id="${medal.id }" class="btn btn-primary btn-xs medal-edit">编辑</button>
                                                        <button type="button" data-id="${medal.id }" class="btn btn-danger btn-xs medal-delete">删除</button>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="6">暂无数据 ~</td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                            <div style="height: 35px;">
                                <div style="float: left;">
                                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#medal-edit" data-backdrop="static">
                                        <i class="fa fa-plus"></i>
                                    </button>
                                </div>
                                <div style="float: right; display: ${page.numberList.size() == 0 ? "none" : "block" }">
                                    <ul class="pagination">
                                        <c:choose>
                                            <c:when test="${page.current le page.min }">
                                                <li class="disabled">
                                                    <a href="javascript:" aria-label="Previous"><i class="fa fa-angle-double-left" aria-hidden="true"></i></a>
                                                </li>
                                                <li class="disabled">
                                                    <a href="javascript:" aria-label="Previous"><i class="fa fa-angle-left" aria-hidden="true"></i></a>
                                                </li>
                                            </c:when>
                                            <c:otherwise>
                                                <li>
                                                    <a href="/medal/list/?keyword=${param.keyword }&page=${page.min }" aria-label="Previous"><i class="fa fa-angle-double-left" aria-hidden="true"></i></a>
                                                </li>
                                                <li>
                                                    <a href="/medal/list/?keyword=${param.keyword }&page=${param.page - 1 }" aria-label="Previous"><i class="fa fa-angle-left" aria-hidden="true"></i></a>
                                                </li>
                                            </c:otherwise>
                                        </c:choose>

                                        <c:forEach items="${page.numberList }" var="number">
                                            <c:choose>
                                                <c:when test="${page.current eq number }">
                                                    <li class="active">
                                                        <a href="javascript:">
                                                                ${number }
                                                        </a>
                                                    </li>
                                                </c:when>
                                                <c:otherwise>
                                                    <li>
                                                        <a href="/medal/list/?keyword=${param.keyword }&page=${number }">
                                                                ${number }
                                                        </a>
                                                    </li>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>

                                        <c:choose>
                                            <c:when test="${page.current ge page.max }">
                                                <li class="disabled">
                                                    <a href="javascript:" aria-label="Next"><i class="fa fa-angle-right" aria-hidden="true"></i></a>
                                                </li>
                                                <li class="disabled">
                                                    <a href="javascript:" aria-label="Next"><i class="fa fa-angle-double-right" aria-hidden="true"></i></a>
                                                </li>
                                            </c:when>
                                            <c:otherwise>
                                                <li>
                                                    <a href="/medal/list/?keyword=${param.keyword }&page=${empty param.page ? param.page + 1 + 1 : param.page + 1 }" aria-label="Next"><i class="fa fa-angle-right" aria-hidden="true"></i></a>
                                                </li>
                                                <li>
                                                    <a href="/medal/list/?keyword=${param.keyword }&page=${page.max }" aria-label="Next"><i class="fa fa-angle-double-right" aria-hidden="true"></i></a>
                                                </li>
                                            </c:otherwise>
                                        </c:choose>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="modal fade" id="medal-edit" tabindex="-1" role="dialog">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                        <h4 class="modal-title">新增勋章</h4>
                                    </div>
                                    <div class="modal-body" style="padding-bottom: 10px;">
                                        <input type="hidden" id="medal-id" >
                                        <div class="input-group" style="margin-bottom: 10px;">
                                            <span class="input-group-addon">勋章名称</span>
                                            <input type="text" class="form-control" placeholder="请输入勋章名称" id="medal-name">
                                        </div>
                                        <div class="input-group" style="margin-bottom: 10px;">
                                            <span class="input-group-addon">所需水滴</span>
                                            <input type="number" class="form-control" placeholder="请输入勋章所需水滴数量" id="medal-bonus">
                                        </div>
                                        <div style="width: 49%;display: inline-block;margin-right: 1%;">
                                            <div class="panel panel-default" style="margin-bottom: 10px;">
                                                <div class="panel-heading">彩色图片</div>
                                                <div class="panel-body medal-add-active" style="padding: 0;">
                                                    <img id="medal-add-active-image" src="http://res.kidbridge.org/FvD_maMJi2CYSjJAhm-oe542nmAn" data-key="FvD_maMJi2CYSjJAhm-oe542nmAn">
                                                </div>
                                            </div>
                                            <input type="file" accept="image/png" name="medal-add-active-image-file" id="medal-add-active-image-file" style="display: none;">
                                            <button type="button" class="btn btn-block btn-default btn-medal-add-active-edit">修改图片</button>
                                        </div>
                                        <div style="width: 49%;display: inline-block;">
                                            <div class="panel panel-default" style="margin-bottom: 10px;">
                                                <div class="panel-heading">灰度图片</div>
                                                <div class="panel-body medal-add-quiet" style="padding: 0;">
                                                    <img id="medal-add-quiet-image" src="http://res.kidbridge.org/FvD_maMJi2CYSjJAhm-oe542nmAn" data-key="FvD_maMJi2CYSjJAhm-oe542nmAn">
                                                </div>
                                            </div>
                                            <input type="file" accept="image/png" name="medal-add-quiet-image-file" id="medal-add-quiet-image-file" style="display: none;">
                                            <button type="button" class="btn btn-block btn-default btn-medal-add-quiet-edit">修改图片</button>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default" data-dismiss="modal" style="margin-bottom: 0;">关闭</button>
                                        <button type="button" class="btn btn-primary save">保存</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="/WEB-INF/view/templet/footer.jsp" />

    </div>
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
    $(".medal-delete").on("click",function () {
       var id = $(this).data("id");
        $.ajax({
            type:"POST",
            url:"/medal/delete",
            data:JSON.stringify({"id":id}),
            dataType:"json",
            contentType:"application/json",
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
                window.location.reload();
            }
        });
    });
    $(".save").on("click",function () {
        var medal = {};
        medal.id = $("#medal-id").val();
        medal.name = $("#medal-name").val();
        medal.bonus = $("#medal-bonus").val();
        medal.icon = {};
        medal.icon.active = $("#medal-add-active-image").data("key");
        medal.icon.quiet = $("#medal-add-quiet-image").data("key");
        $.ajax({
            type:"POST",
            url:"/medal/add",
            data:JSON.stringify(medal),
            dataType:"json",
            contentType:"application/json",
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
                window.location.reload();
            }
        });
    });
    $("#medal-edit").on("hidden.bs.modal", function (e) {
        $("#medal-id").val(null);
        $("#medal-name").val(null);
        $("#medal-bonus").val(null);
        $("#medal-add-active-image").data("key","FvD_maMJi2CYSjJAhm-oe542nmAn");
        $("#medal-add-active-image").attr("src","http://res.kidbridge.org/FvD_maMJi2CYSjJAhm-oe542nmAn");
        $("#medal-add-quiet-image").data("key","FvD_maMJi2CYSjJAhm-oe542nmAn");
        $("#medal-add-quiet-image").attr("src","http://res.kidbridge.org/FvD_maMJi2CYSjJAhm-oe542nmAn");
    });
    $(".medal-edit").on("click",function () {
        var id = $(this).data("id");
        $.ajax({
            type:"POST",
            url:"/medal/detail",
            data:JSON.stringify({"id":id}),
            dataType:"json",
            contentType:"application/json",
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
                var medal = resp.data;
                $("#medal-id").val(medal.id);
                $("#medal-name").val(medal.name);
                $("#medal-bonus").val(medal.bonus);
                $("#medal-add-active-image").data("key",medal.icon.active);
                $("#medal-add-active-image").attr("src","http://res.kidbridge.org/" + medal.icon.active);
                $("#medal-add-quiet-image").data("key",medal.icon.quiet);
                $("#medal-add-quiet-image").attr("src","http://res.kidbridge.org/" + medal.icon.quiet);
                $("#medal-edit").modal({
                    backdrop: "static",
                    show: true
                });
            }
        });
    });
    $(".btn-medal-add-active-edit").on("click",function () {
        $("#medal-add-active-image-file").trigger("click");
    });
    $("#medal-add-active-image-file").on("change",function (e) {
        var file = e.target.files[0];
        $.ajax({
            url: "/file/token",
            async: false,
            contentType: "application/json",
            dataType: "json",
            success: function(resp){
                if(resp.event != "SUCCESS"){
                    return;
                }
                var formData = new FormData();
                formData.append("token",resp.data.token);
                formData.append("file",file);
                $.ajax({
                    async: false,
                    url: 'http://upload.qiniu.com/' ,
                    type: 'POST',
                    data: formData,
                    async: false,
                    cache: false,
                    contentType: false,
                    processData: false,
                    success: function (resp) {
                        $("#medal-add-active-image").data("key",resp.key);
                        $("#medal-add-active-image").attr("src","http://res.kidbridge.org/" + resp.key);
                    }
                });
            }
        });
    });
    $(".btn-medal-add-quiet-edit").on("click",function () {
        $("#medal-add-quiet-image-file").trigger("click");
    });
    $("#medal-add-quiet-image-file").on("change",function (e) {
        var file = e.target.files[0];
        $.ajax({
            url: "/file/token",
            async: false,
            contentType: "application/json",
            dataType: "json",
            success: function(resp){
                if(resp.event != "SUCCESS"){
                    return;
                }
                var formData = new FormData();
                formData.append("token",resp.data.token);
                formData.append("file",file);
                $.ajax({
                    async: false,
                    url: 'http://upload.qiniu.com/' ,
                    type: 'POST',
                    data: formData,
                    async: false,
                    cache: false,
                    contentType: false,
                    processData: false,
                    success: function (resp) {
                        $("#medal-add-quiet-image").data("key",resp.key);
                        $("#medal-add-quiet-image").attr("src","http://res.kidbridge.org/" + resp.key);
                    }
                });
            }
        });
    });
    $(".book-del").on("click",function () {
       var id = $(this).data("id");
        $.ajax({
            type:"POST",
            url:"/book/del",
            async: false,
            data:JSON.stringify({"id":id}),
            dataType:"json",
            contentType:"application/json",
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
                window.location.reload();
            }
        });
    });
</script>
</body>
</html>