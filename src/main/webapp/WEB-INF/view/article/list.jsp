<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>文章列表 | kidbridge manage</title>
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
                            <h5>文章列表</h5>
                        </div>
                        <div class="ibox-content">
                            <table class="table table-striped">
                                <thead>
                                <tr>
                                    <th>编号</th>
                                    <th>标题</th>
                                    <th>文章链接</th>
                                    <th>发布时间</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:choose>
                                    <c:when test="${not empty articleList }">
                                        <c:forEach items="${articleList }" var="article">
                                            <tr>
                                                <td>${article.id }</td>
                                                <td>${article.title }</td>
                                                <td><a href="http://api.kidbridge.org/article/${article.id }" target="_blank">http://api.kidbridge.org/article/${article.id }</a></td>
                                                <td>
                                                    <fmt:formatDate value="${article.createTime }" pattern="yyyy-MM-dd HH:mm:ss" />
                                                </td>
                                                <td>
                                                    <a href="http://api.kidbridge.org/article/${article.id }" target="_blank" class="btn btn-primary btn-xs">详情</a>
                                                    <%--<button type="button" data-id="${article.id }" data-title="${article.title }" data-content="${article.content }" class="btn btn-primary btn-xs article-detail">详情</button>--%>
                                                    <a href="/article/edit/${article.id }" class="btn btn-primary btn-xs">编辑</a>
                                                    <%--<button type="button" data-content="${article.id }" class="btn btn-primary btn-xs copy">复制链接</button>--%>
                                                    <button type="button" class="btn btn-danger btn-xs article-del" data-id="${article.id }">删除</button>
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
                                                    <a href="/article/list/?page=${page.min }" aria-label="Previous"><i class="fa fa-angle-double-left" aria-hidden="true"></i></a>
                                                </li>
                                                <li>
                                                    <a href="/article/list/?page=${param.page - 1 }" aria-label="Previous"><i class="fa fa-angle-left" aria-hidden="true"></i></a>
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
                                                        <a href="/article/list/?page=${number }">
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
                                                    <a href="/article/list/?page=${empty param.page ? param.page + 1 + 1 : param.page + 1 }" aria-label="Next"><i class="fa fa-angle-right" aria-hidden="true"></i></a>
                                                </li>
                                                <li>
                                                    <a href="/article/list/?&page=${page.max }" aria-label="Next"><i class="fa fa-angle-double-right" aria-hidden="true"></i></a>
                                                </li>
                                            </c:otherwise>
                                        </c:choose>
                                    </ul>
                                </div>
                            </div>
                            <div class="modal fade" id="article-detail" tabindex="-1" role="dialog">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content book-segment-add-body">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                            <h4 class="modal-title">文章详情</h4>
                                        </div>
                                        <div class="modal-body" style="padding-bottom: 0;">
                                            <div class="panel panel-default">
                                                <div class="panel-heading text-center article-detail-title">Panel heading without title</div>
                                                <div class="panel-body article-detail-content" style="overflow-y: scroll;max-height: 500px;">
                                                    Panel content
                                                </div>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-default" data-dismiss="modal" style="margin-bottom: 0;">关闭</button>
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
    var copy = new ZeroClipboard($(".copy"));
    copy.on( 'ready', function(event) {
        copy.on( 'copy', function(event) {
            var content = $(event.target).data("content");
            event.clipboardData.setData('text/plain', "http://api.kidbridge.org/article/" + content);
        } );
    } );
    $(".article-detail").on("click",function () {
       var id = $(this).data("id");
       var title = $(this).data("title");
       var content = $(this).data("content");
        $.ajax({
            url: "http://res.kidbridge.org/" + content,
            type: "GET",
            dataType: "text",
            success: function(resp){
                $(".article-detail-title").text(title);
                $(".article-detail-content").html(resp);
                $("#article-detail").modal({
                    backdrop: "static"
                },'show');
            }
        });
    });
    $(".article-del").on("click",function () {
        var id = $(this).data("id");
        $.ajax({
            type:"POST",
            url:"/article/del",
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