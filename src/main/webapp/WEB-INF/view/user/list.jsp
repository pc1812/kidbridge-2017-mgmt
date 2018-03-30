<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>教师列表 | kidbridge manage</title>
    <link href="/resources/css/service/base.css" rel="stylesheet">
    <link href="/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="/resources/font-awesome/css/font-awesome.css" rel="stylesheet">
    <link href="/resources/css/animate.css" rel="stylesheet">
    <link href="/resources/css/style.css" rel="stylesheet">
    <link href="/resources/css/plugins/sweetalert/sweetalert.css" rel="stylesheet">
    <link href="/resources/css/service/base.css" rel="stylesheet">
</head>
<body>
<div id="wrapper">

    <jsp:include page="/WEB-INF/view/templet/navigation.jsp" />

    <div id="page-wrapper" class="gray-bg">
        <div class="row border-bottom">
            <nav class="navbar navbar-static-top white-bg" role="navigation" style="margin-bottom: 0">
                <div class="navbar-header" style="margin-bottom: 10px;">
                    <a class="minimalize-styl-2 btn btn-primary " href="javascript:"><i class="fa fa-search"></i> </a>
                    <form role="search" class="navbar-form-custom" method="get" action="/user/list" style="width: 250px;">
                        <div class="form-group">
                            <input type="text" placeholder="输入用户编号、手机号、昵称进行检索" value="${param.keyword }" class="form-control" name="keyword" id="top-search">
                        </div>
                    </form>
                </div>
            </nav>
        </div>
        <div class="wrapper wrapper-content">
            <div class="row">
                <div class="col-lg-12">
                    <div class="ibox float-e-margins">
                        <div class="ibox-title">
                            <h5>用户列表 共 <span style="font-weight: normal">${count }</span> 人</h5>
                        </div>
                        <div class="ibox-content">
                            <table class="user table table-striped">
                                <thead>
                                <tr>
                                    <th>编号</th>
                                    <th>用户头像</th>
                                    <th>手机号码</th>
                                    <th>用户昵称</th>
                                    <th>出生年月</th>
                                    <th>当前水滴</th>
                                    <th>当前余额</th>
                                    <th>收货信息</th>
                                    <th>注册时间</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:choose>
                                    <c:when test="${not empty userList }">
                                        <c:forEach items="${userList }" var="user">
                                            <tr>
                                                <td>${user.id }</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${not empty user.head }">
                                                            <img class="user-head" src="http://res.kidbridge.org/${user.head }" />
                                                        </c:when>
                                                        <c:otherwise>
                                                            <img class="user-head" style="border: none;" src="http://res.kidbridge.org/FqgZkuLLMuoNo_ST5vg82j8UHr5S" />
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>${user.phone }</td>
                                                <td>${empty user.nickname ? "未知" : user.nickname }</td>
                                                <td>
                                                    <fmt:parseDate value="1970-01-01" pattern="yyyy-MM-dd" var="normalDate" />
                                                    <c:choose>
                                                        <c:when test="${normalDate eq user.birthday }">
                                                            未知
                                                        </c:when>
                                                        <c:otherwise>
                                                            <fmt:formatDate value="${user.birthday }" pattern="yyyy-MM-dd" />
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>${user.bonus }</td>
                                                <td>${user.balance }</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${not empty user.receivingContact and not empty user.receivingPhone and not empty user.receivingRegion and not empty user.receivingStreet }">
                                                            ${user.receivingContact } ${user.receivingPhone } ${user.receivingRegion } ${user.receivingStreet }
                                                        </c:when>
                                                        <c:otherwise>
                                                            未知
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <fmt:formatDate value="${user.createTime }" pattern="yyyy-MM-dd" />
                                                </td>
                                                <td>
                                                    <button type="button" data-id="${user.id }" data-number="${user.bonus }" class="btn btn-primary" data-toggle="modal" data-backdrop="static" data-target="#bonus-edit">水滴编辑</button>
                                                    <button type="button" data-id="${user.id }" data-number="${user.balance }" class="btn btn-primary" data-toggle="modal" data-backdrop="static" data-target="#balance-edit">余额编辑</button>
                                                    <button type="button" data-id="${user.id }" class="btn btn-danger user-delete">删除</button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="9">暂无数据 ~</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                            </table>
                            <div style="height: 35px;">
                                <div style="float: left">
                                    <button type="button" class="btn btn-primary pull-left" data-toggle="modal" data-backdrop="static" data-target="#user-add"><i class="fa fa-plus"></i></button>
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
                                                    <a href="/user/list/?keyword=${param.keyword }&page=${page.min }" aria-label="Previous"><i class="fa fa-angle-double-left" aria-hidden="true"></i></a>
                                                </li>
                                                <li>
                                                    <a href="/user/list/?keyword=${param.keyword }&page=${param.page - 1 }" aria-label="Previous"><i class="fa fa-angle-left" aria-hidden="true"></i></a>
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
                                                        <a href="/user/list/?keyword=${param.keyword }&page=${number }">
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
                                                    <a href="/user/list/?keyword=${param.keyword }&page=${empty param.page ? param.page + 1 + 1 : param.page + 1 }" aria-label="Next"><i class="fa fa-angle-right" aria-hidden="true"></i></a>
                                                </li>
                                                <li>
                                                    <a href="/user/list/?keyword=${param.keyword }&page=${page.max }" aria-label="Next"><i class="fa fa-angle-double-right" aria-hidden="true"></i></a>
                                                </li>
                                            </c:otherwise>
                                        </c:choose>
                                    </ul>
                                </div>
                            </div>
                            <div class="modal fade" id="user-add" tabindex="-1" role="dialog">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                            <h4 class="modal-title">用户添加</h4>
                                        </div>
                                        <div class="modal-body" style="padding-bottom: 20px;">
                                            <div class="input-group" style="margin-bottom: 15px;">
                                                <span class="input-group-addon">手机号码</span>
                                                <select class="form-control" name="user-add-region">
                                                    <option value="+1">+1</option>
                                                    <option value="+86">+86</option>
                                                </select>
                                                <input type="text" class="form-control" name="user-add-phone" placeholder="请输入手机号码">
                                            </div>
                                            <div class="input-group">
                                                <span class="input-group-addon">登录密码</span>
                                                <input type="text" class="form-control" name="user-add-password" placeholder="请输入登录密码">
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-default" data-dismiss="modal" style="margin-bottom: 0;">关闭</button>
                                            <button type="button" class="btn btn-primary user-add-save">保存</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal fade" id="balance-edit" tabindex="-1" role="dialog">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                            <h4 class="modal-title">余额编辑</h4>
                                        </div>
                                        <div class="modal-body" style="padding-bottom: 0;">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">用户编号</div>
                                                <div class="panel-body">
                                                    <input name="id" class="form-control" type="text" readonly="readonly" />
                                                </div>
                                            </div>
                                            <div class="panel panel-default">
                                                <div class="panel-heading">当前余额</div>
                                                <div class="panel-body">
                                                    <input name="balance" class="form-control" type="text" readonly="readonly" />
                                                </div>
                                            </div>
                                            <div class="panel panel-default">
                                                <div class="panel-heading">附加余额</div>
                                                <div class="panel-body">
                                                    <input name="append" class="form-control" type="text" placeholder="请输入整数" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-default" data-dismiss="modal" style="margin-bottom: 0;">关闭</button>
                                            <button type="button" class="btn btn-primary balance-save">保存</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal fade" id="bonus-edit" tabindex="-1" role="dialog">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                            <h4 class="modal-title">水滴编辑</h4>
                                        </div>
                                        <div class="modal-body" style="padding-bottom: 0;">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">用户编号</div>
                                                <div class="panel-body">
                                                    <input name="id" class="form-control" type="text" readonly="readonly" />
                                                </div>
                                            </div>
                                            <div class="panel panel-default">
                                                <div class="panel-heading">当前水滴</div>
                                                <div class="panel-body">
                                                    <input name="bonus" class="form-control" type="text" readonly="readonly" />
                                                </div>
                                            </div>
                                            <div class="panel panel-default">
                                                <div class="panel-heading">附加水滴</div>
                                                <div class="panel-body">
                                                    <input name="append" class="form-control" type="text" placeholder="请输入整数" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-default" data-dismiss="modal" style="margin-bottom: 0;">关闭</button>
                                            <button type="button" class="btn btn-primary bonus-save">保存</button>
                                        </div>
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
<script src="/resources/js/plugins/zeroclipboard/ZeroClipboard.min.js"></script>
<script src="/resources/js/plugins/sweetalert/sweetalert.min.js"></script>
<script src="/resources/js/service/base.js"></script>
<script>
    $(".user-add-save").on("click",function () {
        var region = $("select[name='user-add-region']").val();
        var phone = $("input[name='user-add-phone']").val();
        var password = $("input[name='user-add-password']").val();
        $.ajax({
            url: "/user/register",
            type:"POST",
            data:JSON.stringify({"phone": (region+phone), "password": password}),
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
                window.location.reload();
            }
        });
    });
    $('#bonus-edit').on('show.bs.modal', function (event) {
        var t = $(event.relatedTarget);
        var id = t.data("id");
        var number = t.data("number");

        var modal = $(this);
        modal.find("input[name='id']").val(id);
        modal.find("input[name='bonus']").val(number);
    });
    $('#balance-edit').on('show.bs.modal', function (event) {
        var t = $(event.relatedTarget);
        var id = t.data("id");
        var number = t.data("number");

        var modal = $(this);
        modal.find("input[name='id']").val(id);
        modal.find("input[name='balance']").val(number);
    });
    $('#bonus-edit,#balance-edit').on('hide.bs.modal', function (event) {
        var modal = $(this);
        modal.find("input[name='id']").val('');
        modal.find("input[name='append']").val('');
        modal.find("input[name='balance']").val('');
    });
    $(".balance-save").on("click",function () {
        var modal = $(this).parents(".modal-content");
        var id = modal.find("input[name='id']").val();
        var append = modal.find("input[name='append']").val();
        $.ajax({
            url: "/user/update/balance",
            type:"POST",
            data:JSON.stringify({"id": id, "append": append}),
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
                window.location.reload();
            }
        });
    });
    $(".bonus-save").on("click",function () {
        var modal = $(this).parents(".modal-content");
        var id = modal.find("input[name='id']").val();
        var append = modal.find("input[name='append']").val();
        $.ajax({
            url: "/user/update/bonus",
            type:"POST",
            data:JSON.stringify({"id": id, "append": append}),
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
                window.location.reload();
            }
        });
    });
    $(".user-delete").on("click",function () {
       var id = $(this).data("id");
        $.ajax({
            url: "/user/delete",
            type:"POST",
            data:JSON.stringify({"id": id}),
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
                window.location.reload();
            }
        });
    });

</script>

</body>
</html>