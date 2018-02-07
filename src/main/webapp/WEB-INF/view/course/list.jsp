<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>课程列表 | kidbridge manage</title>
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
                    <form role="search" class="navbar-form-custom" method="get" action="/course/list" style="width: 250px;">
                        <div class="form-group">
                            <input type="text" placeholder="输入课程编号或名称进行检索" value="${param.keyword }" class="form-control" name="keyword" id="top-search">
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
                            <h5>课程列表 共 <span style="font-weight: normal">${count }</span> 本</h5>
                            <div class="ibox-tools">
                                <a title="筛选" class="dropdown-toggle" data-toggle="dropdown" href="javascript:">
                                    <i class="fa fa-wrench"></i>
                                </a>
                                <ul class="dropdown-menu dropdown-user">
                                    <li>
                                        <a href="/course/list" class="${empty param.fit ? "filter-select" : "" }">全部</a>
                                    </li>
                                    <li>
                                        <a href="/course/list?fit=0" class="${param.fit eq '0' ? "filter-select" : "" }">3-5岁</a>
                                    </li>
                                    <li>
                                        <a href="/course/list?fit=1" class="${param.fit eq '1' ? "filter-select" : "" }">6-8岁</a>
                                    </li>
                                    <li>
                                        <a href="/course/list?fit=2" class="${param.fit eq '2' ? "filter-select" : "" }">9-12岁</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div class="ibox-content">

                            <table class="table table-striped">
                                <thead>
                                <tr>
                                    <th>编号</th>
                                    <th>标题</th>
                                    <th>价格</th>
                                    <th>适龄</th>
                                    <th>标签</th>
                                    <th>绘本数量</th>
                                    <th>报名人数</th>
                                    <th>课程状态</th>
                                    <th>所属教师</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:choose>
                                    <c:when test="${not empty courseList }">
                                        <c:forEach items="${courseList }" var="course">
                                            <tr>
                                                <td>${course.id }</td>
                                                <td>${course.name }</td>
                                                <td>${course.price }元</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${course.fit eq '0' }">
                                                            3-5岁
                                                        </c:when>
                                                        <c:when test="${course.fit eq '1' }">
                                                            6-8岁
                                                        </c:when>
                                                        <c:when test="${course.fit eq '2' }">
                                                            9-12岁
                                                        </c:when>
                                                    </c:choose>
                                                </td>
                                                <td>${fn:join(course.tag.toArray(), ", ") }</td>
                                                <td>${course.bookCount }</td>
                                                <td>${course.enter } / ${course.limit }</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${course.status eq '0' }">
                                                            <fmt:formatDate value="${course.startTime }" pattern="yyyy-MM-dd" /> | ${course.cycle } | 未开课
                                                        </c:when>
                                                        <c:when test="${course.status eq '1' }">
                                                            <fmt:formatDate value="${course.startTime }" pattern="yyyy-MM-dd" /> | ${course.cycle } | 开课中
                                                        </c:when>
                                                        <c:when test="${course.status eq '2' }">
                                                            <fmt:formatDate value="${course.startTime }" pattern="yyyy-MM-dd" /> | ${course.cycle } | 已结束
                                                        </c:when>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <a href="javascript:" data-id="${course.teacher.id }">${course.teacher.realname }</a>
                                                </td>
                                                <td>
                                                    <a href="/course/detail/${course.id }" class="btn btn-primary btn-xs">详情</a>
                                                    <a href="/course/edit/${course.id }" target="_blank" class="btn btn-primary btn-xs">编辑</a>
                                                    <c:choose>
                                                        <c:when test="${not empty course.courseHot }">
                                                            <button type="button" data-id="${course.courseHot.id }" class="btn btn-danger btn-xs course-hot-cancel">热门课程</button>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <button type="button" data-id="${course.id }" class="btn btn-primary btn-xs course-hot-become">热门课程</button>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <button type="button" target="_blank" class="btn btn-danger btn-xs course-del" data-id="${course.id }">删除</button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="10">暂无数据 ~</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                            </table>
                            <div style="height: 35px;">
                                <div style="float: left;">
                                    <button type="button" class="btn btn-primary" data-type="0" data-toggle="modal" data-target="#export" data-backdrop="static">导出</button>
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
                                                    <a href="/course/list/?keyword=${param.keyword }&page=${page.min }" aria-label="Previous"><i class="fa fa-angle-double-left" aria-hidden="true"></i></a>
                                                </li>
                                                <li>
                                                    <a href="/course/list/?keyword=${param.keyword }&page=${param.page - 1 }" aria-label="Previous"><i class="fa fa-angle-left" aria-hidden="true"></i></a>
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
                                                        <a href="/course/list/?keyword=${param.keyword }&page=${number }">
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
                                                    <a href="/course/list/?keyword=${param.keyword }&page=${empty param.page ? param.page + 1 + 1 : param.page + 1 }" aria-label="Next"><i class="fa fa-angle-right" aria-hidden="true"></i></a>
                                                </li>
                                                <li>
                                                    <a href="/course/list/?keyword=${param.keyword }&page=${page.max }" aria-label="Next"><i class="fa fa-angle-double-right" aria-hidden="true"></i></a>
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
    $(".course-del").on("click",function () {
        var id = $(this).data("id");
        $.ajax({
            type:"POST",
            url:"/course/del",
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
    $(".course-hot-become").on("click",function () {
        var id = $(this).data("id");
        $.ajax({
            type:"POST",
            url:"/course/hot",
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
    $(".course-hot-cancel").on("click",function () {
        var id = $(this).data("id");
        $.ajax({
            type:"POST",
            url:"/course/hot/cancel",
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