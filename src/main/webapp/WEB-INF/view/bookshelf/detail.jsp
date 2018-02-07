<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>书单详情 | kidbridge manage</title>
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
                            <h5>
                                ${bookshelf.name }
                            </h5>
                        </div>
                        <div class="ibox-content">
                            <div class="bookshelf-view center-block">
                                <div class="bookshelf-head">
                                    <div class="panel panel-default">
                                        <div class="panel-body" style="padding: 0;">
                                            <div class="bookshelf-icon">
                                                <img style="width: 735px;" class="img-responsive" src="http://res.kidbridge.org/${bookshelf.icon }">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="bookshelf-body">
                                    <div class="bookshelf-outline">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">书单名称</div>
                                            <div class="panel-body">
                                                ${bookshelf.name }
                                            </div>
                                        </div>
                                    </div>
                                    <div class="bookshelf-fit">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">适合年龄</div>
                                            <div class="panel-body">
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
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="bookshelf-tag">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">关键词</div>
                                            <div class="panel-body">
                                                ${fn:join(bookshelf.tag.toArray(), ", ") }
                                            </div>
                                        </div>
                                    </div>
                                    <div class="bookshelf-cover">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">导航封面</div>
                                            <div class="panel-body">
                                                <a target="_blank" href="${bookshelf.cover.link }">
                                                    <img style="width: 735px; height: 245px;" class="img-responsive" src="http://res.kidbridge.org/${bookshelf.cover.icon }">
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="bookshelf-book">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">绘本目录</div>
                                            <div class="panel-body">
                                                <div class="bookshelf-book-list" style="margin: 0 auto;">
                                                    <div class="list-group" style="margin-bottom: 0;">
                                                        <c:forEach items="${bookshelf.bookList }" var="b" varStatus="status">
                                                            <a class="list-group-item" href="/book/detail/${b.id }" style="outline: none;" target="_blank" data-id="${b.id }">
                                                                <div>${status.index + 1 }. ${b.name }</div>
                                                            </a>
                                                        </c:forEach>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>



                                    <%--<div class="book-segment">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">段落信息</div>
                                            <div class="panel-body" style="padding-bottom: 0px;">
                                                <div class="book-segment-list">
                                                    <c:forEach items="${bookSegmentList }" var="bookSegment" varStatus="status">
                                                        <div class="book-segment-detail">
                                                            <div class="book-segment-icon">
                                                                <img class="img-responsive" src="http://res.kidbridge.org/${bookSegment.icon }" />
                                                            </div>
                                                            <div class="book-segment-body">
                                                                <div class="book-segment-schedule">
                                                                        ${status.index + 1 } / ${bookSegmentList.size() }
                                                                </div>
                                                                <div class="book-segment-text">
                                                                <span>
                                                                        ${bookSegment.text }
                                                                </span>
                                                                </div>
                                                            </div>
                                                            <div class="book-segment-audio">
                                                                <a href="http://res.kidbridge.org/${bookSegment.audio }" target="_blank"><i class="fa fa-play-circle"></i></a>
                                                            </div>
                                                        </div>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                        </div>
                                    </div>--%>
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
</body>
</html>