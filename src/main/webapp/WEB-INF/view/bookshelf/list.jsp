<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>书单列表 | kidbridge manage</title>
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
                            <h5>书单列表</h5>
                            <div class="ibox-tools">
                                <a title="筛选" class="dropdown-toggle" data-toggle="dropdown" href="javascript:">
                                    <i class="fa fa-wrench"></i>
                                </a>
                                <ul class="dropdown-menu dropdown-user">
                                    <li>
                                        <a href="/bookshelf/list" class="${empty param.fit ? "filter-select" : "" }">全部</a>
                                    </li>
                                    <li>
                                        <a href="/bookshelf/list?fit=0" class="${param.fit eq '0' ? "filter-select" : "" }">3-5岁</a>
                                    </li>
                                    <li>
                                        <a href="/bookshelf/list?fit=1" class="${param.fit eq '1' ? "filter-select" : "" }">6-8岁</a>
                                    </li>
                                    <li>
                                        <a href="/bookshelf/list?fit=2" class="${param.fit eq '2' ? "filter-select" : "" }">9-12岁</a>
                                    </li>
                                    <li>
                                        <a href="/bookshelf/list?fit=3" class="${param.fit eq '2' ? "filter-select" : "" }">4-7岁</a>
                                    </li>
                                    <li>
                                        <a href="/bookshelf/list?fit=4" class="${param.fit eq '2' ? "filter-select" : "" }">8-10岁</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div class="ibox-content">

                            <table class="table table-striped">
                                <thead>
                                <tr>
                                    <th>编号</th>
                                    <th>名称</th>
                                    <th>适龄</th>
                                    <th>标签</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:choose>
                                    <c:when test="${not empty bookshelfList }">
                                        <c:forEach items="${bookshelfList }" var="bookshelf">
                                            <tr>
                                                <td>${bookshelf.id }</td>
                                                <td>${bookshelf.name }</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${bookshelf.fit eq '0' }">
                                                            3-5岁
                                                        </c:when>
                                                        <c:when test="${bookshelf.fit eq '1' }">
                                                            6-8岁
                                                        </c:when>
                                                        <c:when test="${bookshelf.fit eq '2' }">
                                                            9-12岁
                                                        </c:when>
                                                        <c:when test="${bookshelf.fit eq '3' }">
                                                            4-7岁
                                                        </c:when>
                                                        <c:when test="${bookshelf.fit eq '4' }">
                                                            8-10岁
                                                        </c:when>
                                                    </c:choose>
                                                </td>
                                                <td>${fn:join(bookshelf.tag.toArray(), ", ") }</td>
                                                <td>
                                                    <a href="/bookshelf/detail/${bookshelf.id }" class="btn btn-primary btn-xs">详情</a>
                                                    <a href="/bookshelf/edit/${bookshelf.id }" class="btn btn-primary btn-xs">编辑</a>
                                                    <c:choose>
                                                        <c:when test="${not empty bookshelf.bookshelfHot }">
                                                            <button type="button" data-id="${bookshelf.bookshelfHot.id }" class="btn btn-danger btn-xs bookshelf-hot-cancel">热门书单</button>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <button type="button" data-id="${bookshelf.id }" class="btn btn-primary btn-xs bookshelf-hot-become">热门书单</button>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${not empty bookshelf.bookshelfRecommend }">
                                                            <button type="button" data-id="${bookshelf.bookshelfRecommend.id }" class="btn btn-danger btn-xs bookshelf-recommend-cancel">今日打卡</button>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <button type="button" data-id="${bookshelf.id }" class="btn btn-primary btn-xs bookshelf-recommend-become">今日打卡</button>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <button type="button" class="btn btn-danger btn-xs bookshelf-del" data-id="${bookshelf.id }">删除</button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="4">暂无数据 ~</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
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
                                                    <a href="/bookshelf/list/?page=${page.min }" aria-label="Previous"><i class="fa fa-angle-double-left" aria-hidden="true"></i></a>
                                                </li>
                                                <li>
                                                    <a href="/bookshelf/list/?page=${param.page - 1 }" aria-label="Previous"><i class="fa fa-angle-left" aria-hidden="true"></i></a>
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
                                                        <a href="/bookshelf/list/?page=${number }">
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
                                                    <a href="/bookshelf/list/?page=${empty param.page ? param.page + 1 + 1 : param.page + 1 }" aria-label="Next"><i class="fa fa-angle-right" aria-hidden="true"></i></a>
                                                </li>
                                                <li>
                                                    <a href="/bookshelf/list/?page=${page.max }" aria-label="Next"><i class="fa fa-angle-double-right" aria-hidden="true"></i></a>
                                                </li>
                                            </c:otherwise>
                                        </c:choose>
                                    </ul>
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
    $(".bookshelf-del").on("click",function () {
        var id = $(this).data("id");
        $.ajax({
            type:"POST",
            url:"/bookshelf/del",
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
    $(".bookshelf-recommend-cancel").on("click",function () {
        var id = $(this).data("id");
        $.ajax({
            type:"POST",
            url:"/bookshelf/recommend/cancel",
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
    $(".bookshelf-hot-cancel").on("click",function () {
        var id = $(this).data("id");
        $.ajax({
            type:"POST",
            url:"/bookshelf/hot/cancel",
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
    $(".bookshelf-hot-become").on("click",function () {
        var id = $(this).data("id");
        $.ajax({
            type:"POST",
            url:"/bookshelf/hot",
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
    $(".bookshelf-recommend-become").on("click",function () {
        var id = $(this).data("id");
        $.ajax({
            type:"POST",
            url:"/bookshelf/recommend",
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