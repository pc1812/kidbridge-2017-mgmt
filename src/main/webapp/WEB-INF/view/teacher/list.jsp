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
        <div class="wrapper wrapper-content">
            <div class="row">
                <div class="col-lg-12">
                    <div class="ibox float-e-margins">
                        <div class="ibox-title">
                            <h5>教师列表</h5>
                        </div>
                        <div class="ibox-content">
                            <table class="table table-striped">
                                <thead>
                                <tr>
                                    <th>编号</th>
                                    <th>教师姓名</th>
                                    <th>用户编号</th>
                                    <th>用户昵称</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:choose>
                                    <c:when test="${not empty teacherList }">
                                        <c:forEach items="${teacherList }" var="teacher">
                                            <tr>
                                                <td>${teacher.id }</td>
                                                <td>${teacher.realname }</td>
                                                <td><a href="javascript:">${teacher.user.id }</a></td>
                                                <td>${teacher.user.nickname }</td>
                                                <th><button type="button" data-id="${teacher.id }" data-realname="${teacher.realname }" class="btn btn-primary btn-xs teacher-edit">编辑</button></th>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="5">暂无数据 ~</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td colspan="5">
                                            <button type="button" class="btn btn-primary pull-left" data-toggle="modal" data-backdrop="static" data-target="#user-search"><i class="fa fa-plus"></i></button>
                                        </td>
                                    </tr>
                                </tfoot>
                            </table>
                            <div style="height: 35px;">
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
                                                    <a href="/teacher/list/?page=${page.min }" aria-label="Previous"><i class="fa fa-angle-double-left" aria-hidden="true"></i></a>
                                                </li>
                                                <li>
                                                    <a href="/teacher/list/?page=${param.page - 1 }" aria-label="Previous"><i class="fa fa-angle-left" aria-hidden="true"></i></a>
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
                                                        <a href="/teacher/list/?page=${number }">
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
                                                    <a href="/teacher/list/?page=${empty param.page ? param.page + 1 + 1 : param.page + 1 }" aria-label="Next"><i class="fa fa-angle-right" aria-hidden="true"></i></a>
                                                </li>
                                                <li>
                                                    <a href="/teacher/list/?page=${page.max }" aria-label="Next"><i class="fa fa-angle-double-right" aria-hidden="true"></i></a>
                                                </li>
                                            </c:otherwise>
                                        </c:choose>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="modal fade" id="teacher-edit" tabindex="-1" role="dialog">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                        <h4 class="modal-title">教师编辑</h4>
                                    </div>
                                    <div class="modal-body" style="padding-bottom: 10px;">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">教师编号</div>
                                            <div class="panel-body">
                                                <input readonly="readonly" name="teacher-edit-id" class="form-control" type="text" />
                                            </div>
                                        </div>
                                        <div class="panel panel-default">
                                            <div class="panel-heading">教师姓名</div>
                                            <div class="panel-body">
                                                <input placeholder="输入教师的真实姓名 ~" name="teacher-edit-realname" class="form-control" type="text" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default" data-dismiss="modal" style="margin-bottom: 0;">关闭</button>
                                        <button type="button" class="btn btn-primary teacher-edit-save">保存</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal fade" id="user-search" tabindex="-1" role="dialog">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                        <h4 class="modal-title">用户检索</h4>
                                    </div>
                                    <div class="modal-body" style="padding-bottom: 10px;">
                                        <div class="user-search form-inline">
                                            <div class="form-group input-group input-group-xs">
                                                <span class="input-group-addon">用户信息</span>
                                                <input type="text" class="form-control" style="width: 399px;" placeholder="输入用户昵称、编号或手机号码查询" aria-describedby="sizing-addon1">
                                            </div>
                                            <div class="form-group">
                                                <button type="button" class="btn btn-primary">搜索</button>
                                            </div>
                                        </div>
                                        <div class="user-search-result" style="margin-top: 10px;margin-bottom: 10px;">
                                            <table class="table table-striped" style="margin-bottom: 0;border: 1px solid #ddd;display: none;">
                                                <thead>
                                                <tr>
                                                    <th>用户编号</th>
                                                    <th>手机号码</th>
                                                    <th>用户昵称</th>
                                                    <th>注册时间</th>
                                                    <th>操作</th>
                                                </tr>
                                                </thead>
                                                <tbody>

                                                </tbody>
                                            </table>
                                            <div style="height: 35px;display: none;margin-top: 20px;" class="pageblock">
                                                <div style="float: right; display: ${page.numberList.size() == 0 ? "none" : "block" }">
                                                    <ul class="pagination">

                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default" data-dismiss="modal" style="margin-bottom: 0;">关闭</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal fade" id="teacher-add" tabindex="-1" role="dialog">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                        <h4 class="modal-title">教师新增</h4>
                                    </div>
                                    <div class="modal-body" style="padding-bottom: 0px;">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">用户编号</div>
                                            <div class="panel-body">
                                                <input readonly="readonly" name="user-id" class="form-control" type="text" />
                                            </div>
                                        </div>
                                        <div class="panel panel-default">
                                            <div class="panel-heading">教师姓名</div>
                                            <div class="panel-body">
                                                <input placeholder="输入教师的真实姓名 ~" name="teacher-realname" class="form-control" type="text" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default" data-dismiss="modal" style="margin-bottom: 0;">关闭</button>
                                        <button type="button" class="btn btn-primary teacher-add-save">保存</button>
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
<script src="/resources/js/plugins/moment/moment.min.js"></script>
<script src="/resources/js/plugins/sweetalert/sweetalert.min.js"></script>
<script src="/resources/js/service/base.js"></script>
<script>
    $(".teacher-edit-save").on("click",function () {
        var teacher = {};
        teacher.id = $("input[name='teacher-edit-id']").val();
        teacher.realname = $("input[name='teacher-edit-realname']").val();
        $.ajax({
            url: "/teacher/edit",
            type:"POST",
            data:JSON.stringify(teacher),
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
    $(".teacher-edit").on("click",function () {
        var id = $(this).data("id");
        var realname = $(this).data("realname");
        $("input[name='teacher-edit-id']").val(id);
        $("input[name='teacher-edit-realname']").val(realname);
        $("#teacher-edit").modal({
            backdrop: "static"
        },"show");
    });
    $(".teacher-add-save").on("click",function () {
        var teacher = {};
        teacher.user = {};
        teacher.user.id = $("input[name='user-id']").val();
        teacher.realname= $("input[name='teacher-realname']").val();
        $.ajax({
            url: "/teacher/add",
            type:"POST",
            data:JSON.stringify(teacher),
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
    $(".user-search button").on("click",function () {
        var keyword = $(".user-search input").val();
        $(".user-search-result .pageblock").hide();
        $(".user-search-result .pageblock .pagination").html('');
        userPagination(1,keyword);
    });
    $(".user-search-result table tbody").on("click","a",function () {
        var id = $(this).data("id");
        $("#user-search").modal("hide");
        $("input[name='user-id']").val(id);
        $("#teacher-add").modal({
            backdrop: "static"
        },"show");
    });
    $('#user-search').on('hidden.bs.modal', function () {
        $(".user-search input").val("");
        $(".user-search-result table tbody").html("");
        $(".user-search-result .pageblock").hide();
        $(".user-search-result .pageblock .pagination").html('');
        $(".user-search-result table").hide();
    });
    function userPagination(cpage,keyword) {
        $.ajax({
            url: "/user/search",
            type:"POST",
            data:JSON.stringify({"keyword":keyword,"filter":1,"page":cpage}),
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
                var userList = resp.data.dataList;
                var html = "";
                if(userList.length == 0){
                    html = "<tr><td colspan=\"5\">无检索结果内容 ~</td></tr>";
                }else{
                    for(var i=0;i<userList.length;i++){
                        var user = userList[i];
                        html += "<tr>";
                        html += "<td>"+user.id+"</td>";
                        html += "<td>"+user.phone+"</td>";
                        html += "<td>"+(user.nickname.trim() == "" ? "未知" : user.nickname )+"</td>";
                        html += "<td>"+moment(user.createTime).format("YYYY-MM-DD HH:mm:ss")+"</td>";
                        html += "<td><a data-id=\""+user.id+"\" href=\"javascript:;\">添加</a></td>";
                        html += "</tr>";
                    }
                    var page = resp.data.page;
                    var pageHtml = "";
                    if(page.current <= page.min){
                        pageHtml += '<li class="disabled"> <a href="javascript:" aria-label="Previous"><i class="fa fa-angle-double-left" aria-hidden="true"></i></a> </li> <li class="disabled"> <a href="javascript:" aria-label="Previous"><i class="fa fa-angle-left" aria-hidden="true"></i></a> </li>';
                    }else{
                        pageHtml += '<li> <a href="javascript:;" data-page="'+(page.min)+'" data-keyword="'+keyword+'" aria-label="Previous"><i class="fa fa-angle-double-left" aria-hidden="true"></i></a> </li> <li> <a href="javascript:;" data-page="'+(page.current - 1)+'" data-keyword="'+keyword+'" aria-label="Previous"><i class="fa fa-angle-left" aria-hidden="true"></i></a> </li>';
                    }
                    for(var i = 0;i<page.numberList.length;i++){
                        if(page.current == page.numberList[i]){
                            pageHtml += '<li class="active"> <a href="javascript:"> '+page.numberList[i]+' </a> </li>';
                        }else{
                            pageHtml += '<li> <a href="javascript:;" data-page="'+(page.numberList[i])+'" data-keyword="'+keyword+'"> '+page.numberList[i]+' </a> </li>';
                        }
                    }
                    if(page.current >= page.max){
                        pageHtml += '<li class="disabled"> <a href="javascript:" aria-label="Next"><i class="fa fa-angle-right" aria-hidden="true"></i></a> </li> <li class="disabled"> <a href="javascript:" aria-label="Next"><i class="fa fa-angle-double-right" aria-hidden="true"></i></a> </li>';
                    }else{
                        pageHtml += '<li> <a href="javascript:;" data-page="'+(page.current + 1)+'" data-keyword="'+keyword+'" aria-label="Next"><i class="fa fa-angle-right" aria-hidden="true"></i></a> </li> <li> <a href="javascript:;" data-page="'+(page.max)+'" data-keyword="'+keyword+'" aria-label="Next"><i class="fa fa-angle-double-right" aria-hidden="true"></i></a> </li>';
                    }
                    $(".user-search-result .pageblock .pagination").html(pageHtml);
                    $(".user-search-result .pageblock").show();
                }
                $(".user-search-result table tbody").html(html);
                $(".user-search-result table").show();
            }
        });
    }
    $(".user-search-result .pageblock .pagination").on("click","li a",function () {
        var page = $(this).data("page");
        var keyword = $(this).data("keyword");
        if(page != undefined && page != null && page != ''){
            userPagination(page,keyword);
        }
    });
</script>
</body>
</html>