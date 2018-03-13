<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>绘本列表 | kidbridge manage</title>
    <link href="/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="/resources/font-awesome/css/font-awesome.css" rel="stylesheet">
    <link href="/resources/css/animate.css" rel="stylesheet">
    <link href="/resources/css/style.css" rel="stylesheet">
    <link href="/resources/css/plugins/sweetalert/sweetalert.css" rel="stylesheet">
    <link href="/resources/css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="/resources/css/service/base.css" rel="stylesheet">
</head>
<body>
<div id="wrapper">

    <jsp:include page="/WEB-INF/view/templet/navigation.jsp" />

    <div id="page-wrapper" class="gray-bg">
        <div class="row border-bottom">
            <nav class="navbar navbar-static-top white-bg" role="navigation" style="margin-bottom: 0">
                <div class="navbar-header" style="margin: 10px 24px;">
                    <%--<a class="minimalize-styl-2 btn btn-primary " href="javascript:"><i class="fa fa-search"></i> </a>--%>
                    <%--<form role="search" class="navbar-form-custom" method="get" action="/book/list" style="width: 250px;">--%>
                        <%--<div class="form-group">--%>
                            <%--<input type="text" placeholder="输入绘本编号或名称进行检索" value="${param.keyword }" class="form-control" name="keyword" id="top-search">--%>
                        <%--</div>--%>
                    <%--</form>--%>


                    <form method="get" action="/book/list">
                        <div class="input-group" style="width: 500px;float: left;">
                            <span class="input-group-addon">绘本关键词</span>
                            <input type="text" placeholder="输入绘本编号或名称进行检索" value="${param.keyword }" class="form-control" name="keyword" id="top-search">
                        </div>
                        <div class="input-group" style="width: 200px;float: left;margin-left: 20px;">
                            <span class="input-group-addon">价格区间</span>
                            <input type="text" placeholder="最低价格" value="${param.minimum }" class="form-control" name="minimum" style="width: 100px;">
                            <span class="input-group-addon">-</span>
                            <input type="text" placeholder="最高价格" value="${param.maximum }" class="form-control" name="maximum" style="width: 100px;">
                            <span class="input-group-addon">元</span>
                        </div>
                        <div class="btn-search" style="float: left;margin-left: 20px;">
                            <button type="submit" class="btn btn-xs btn-primary" style="height: 34px;width: 34px;">
                                <i class="fa fa-search"></i>
                            </button>
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
                            <h5>绘本列表 共 <span style="font-weight: normal">${count }</span> 本</h5>
                            <div class="ibox-tools">
                                <a title="筛选" class="dropdown-toggle" data-toggle="dropdown" href="javascript:">
                                    <i class="fa fa-wrench"></i>
                                </a>
                                <ul class="dropdown-menu dropdown-user">
                                    <li>
                                        <a href="/book/list" class="${empty param.fit ? "filter-select" : "" }">全部</a>
                                    </li>
                                    <li>
                                        <a href="/book/list?fit=0" class="${param.fit eq '0' ? "filter-select" : "" }">3-5岁</a>
                                    </li>
                                    <li>
                                        <a href="/book/list?fit=1" class="${param.fit eq '1' ? "filter-select" : "" }">6-8岁</a>
                                    </li>
                                    <li>
                                        <a href="/book/list?fit=2" class="${param.fit eq '2' ? "filter-select" : "" }">9-12岁</a>
                                    </li>
                                    <li>
                                        <a href="/book/list?fit=3" class="${param.fit eq '3' ? "filter-select" : "" }">4-7岁</a>
                                    </li>
                                    <li>
                                        <a href="/book/list?fit=4" class="${param.fit eq '4' ? "filter-select" : "" }">8-10岁</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div class="ibox-content">

                            <table class="table table-striped">
                                <thead>
                                <tr>
                                    <th>
                                        <input type="checkbox" class="icheck" id="book-select-all">
                                    </th>
                                    <th>编号</th>
                                    <th>标题</th>
                                    <th>价格</th>
                                    <th>适龄</th>
                                    <th>标签</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${not empty bookList }">
                                            <c:forEach items="${bookList }" var="book">
                                                <tr style="color: ${empty book.audio ? "red" : "black" };">
                                                    <td>
                                                        <input type="checkbox" data-id="${book.id }" class="icheck book-select">
                                                    </td>
                                                    <td>${book.id }</td>
                                                    <td>${book.name }</td>
                                                    <td>${book.price }</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${book.fit eq '0' }">
                                                                3-5岁
                                                            </c:when>
                                                            <c:when test="${book.fit eq '1' }">
                                                                6-8岁
                                                            </c:when>
                                                            <c:when test="${book.fit eq '2' }">
                                                                9-12岁
                                                            </c:when>
                                                            <c:when test="${book.fit eq '3' }">
                                                                4-7岁
                                                            </c:when>
                                                            <c:when test="${book.fit eq '4' }">
                                                                8-10岁
                                                            </c:when>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        ${fn:join(book.tag.toArray(), ", ") }
                                                    </td>
                                                    <td>
                                                        <a href="/book/detail/${book.id }" target="_blank" class="btn btn-primary btn-xs">详情</a>
                                                        <a href="/book/edit/${book.id }" target="_blank" class="btn btn-primary btn-xs">编辑</a>
                                                        <button type="button" class="btn btn-danger btn-xs book-del" data-id="${book.id }">删除</button>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="7">暂无数据 ~</td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                            <div style="height: 35px;">
                                <%--<div style="float: left;">
                                    <button type="button" class="btn btn-primary" data-type="0" data-toggle="modal" data-target="#export" data-backdrop="static">导出</button>
                                </div>--%>
                                <div style="float: left;">
                                    <button id="batch-update-price" disabled="disabled" type="button" class="btn btn-primary" data-toggle="modal" data-target="#book-price" data-backdrop="static">批量改价</button>
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
                                                    <a href="/book/list/?keyword=${param.keyword }&minimum=${param.minimum }&maximum=${param.maximum }&page=${page.min }" aria-label="Previous"><i class="fa fa-angle-double-left" aria-hidden="true"></i></a>
                                                </li>
                                                <li>
                                                    <a href="/book/list/?keyword=${param.keyword }&minimum=${param.minimum }&maximum=${param.maximum }&page=${param.page - 1 }" aria-label="Previous"><i class="fa fa-angle-left" aria-hidden="true"></i></a>
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
                                                        <a href="/book/list/?keyword=${param.keyword }&minimum=${param.minimum }&maximum=${param.maximum }&page=${number }">
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
                                                    <a href="/book/list/?keyword=${param.keyword }&minimum=${param.minimum }&maximum=${param.maximum }&page=${empty param.page ? param.page + 1 + 1 : param.page + 1 }" aria-label="Next"><i class="fa fa-angle-right" aria-hidden="true"></i></a>
                                                </li>
                                                <li>
                                                    <a href="/book/list/?keyword=${param.keyword }&minimum=${param.minimum }&maximum=${param.maximum }&page=${page.max }" aria-label="Next"><i class="fa fa-angle-double-right" aria-hidden="true"></i></a>
                                                </li>
                                            </c:otherwise>
                                        </c:choose>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="modal fade" id="book-price" tabindex="-1" role="dialog">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                        <h4 class="modal-title">批量修改绘本价格</h4>
                                    </div>
                                    <div class="modal-body" style="padding-bottom: 10px;">
                                        <div class="input-group" style="margin-bottom: 10px;">
                                            <span class="input-group-addon">绘本价格</span>
                                            <input id="input-update-book-price" type="text" class="form-control" placeholder="请输入修改后的绘本价格">
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default" data-dismiss="modal" style="margin-bottom: 0;">关闭</button>
                                        <button type="button" class="btn btn-primary btn-update-book-price">保存</button>
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
<script src="/resources/js/plugins/iCheck/icheck.min.js"></script>
<script src="/resources/js/service/base.js"></script>
<script>
    $('#book-price').on('show.bs.modal', function (e) {
        $("#input-update-book-price").val("");
    });
    $(".btn-update-book-price").on("click",function () {
        var ids = [];
        $(".book-select:checked").each(function () {
            ids.push($(this).data("id"));
        });
        var price = $("#input-update-book-price").val();
        $.ajax({
            type:"POST",
            url:"/book/update/price",
            async: false,
            data:JSON.stringify({"ids":ids,"price":price}),
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
    $(".icheck").iCheck({
        checkboxClass: 'icheckbox_square-green',
        radioClass: 'iradio_square-green'
    });
    $("#book-select-all").on("ifClicked",function () {
        var state = !$(this).is(':checked');
        $(".book-select").iCheck(state ? 'check' : 'uncheck');
    });
    $(".book-select").on("ifChanged",function (e) {
        if($(".book-select:checked").length > 0){
            $("#batch-update-price").attr("disabled",false);
        }else{
            $("#batch-update-price").attr("disabled",true);
        }
        if($(".book-select:checked").length == $('.book-select').length){
            $("#book-select-all").iCheck('check');
        }else{
            $("#book-select-all").iCheck('uncheck');
        }
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