<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>kidbridge manage | Main view</title>
    <link href="/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="/resources/font-awesome/css/font-awesome.css" rel="stylesheet">
    <link href="/resources/css/animate.css" rel="stylesheet">
    <link href="/resources/css/style.css" rel="stylesheet">
    <link href="/resources/css/plugins/slick/slick.css" rel="stylesheet">
    <link href="/resources/css/plugins/slick/slick-theme.css" rel="stylesheet">
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
                                ${book.name }
                            </h5>
                        </div>
                        <div class="ibox-content">
                            <div class="book-view center-block">
                                <div class="book-head">
                                    <div class="panel panel-default">
                                        <div class="panel-body" style="padding: 0;">
                                            <div class="book-icon">
                                                <c:forEach items="${book.icon }" var="icon">
                                                    <img class="img-responsive" src="http://res.kidbridge.org/${icon }">
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="book-body">
                                    <div class="book-richtext">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">绘本赏析</div>
                                            <div class="panel-body book-richtext-body">

                                            </div>
                                        </div>
                                    </div>
                                    <div class="book-outline">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">故事梗概</div>
                                            <div class="panel-body">
                                                ${book.outline }
                                            </div>
                                        </div>
                                    </div>
                                    <div class="book-feeling">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">绘本感悟</div>
                                            <div class="panel-body">
                                                ${book.feeling }
                                            </div>
                                        </div>
                                    </div>
                                    <div class="book-fit">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">适龄</div>
                                            <div class="panel-body">
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
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                    <%--<div class="book-difficulty">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">难度</div>
                                            <div class="panel-body">
                                                ${book.difficulty }
                                            </div>
                                        </div>
                                    </div>--%>
                                    <div class="book-tag">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">关键词</div>
                                            <div class="panel-body">
                                                ${fn:join(book.tag.toArray(), ", ") }
                                            </div>
                                        </div>
                                    </div>
                                    <div class="book-segment">
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
<script src="/resources/js/plugins/slick/slick.min.js"></script>
<script src="/resources/js/plugins/sweetalert/sweetalert.min.js"></script>
<script src="/resources/js/service/base.js"></script>
<script>
    $.get("http://res.kidbridge.org/${book.richText }",function (resp) {
        $(".book-richtext-body").html(resp);
    });
    $('.book-icon').slick({
        arrows: false,
        autoplay: true,
        centerMode: ${book.icon.size() > 1 },
        centerPadding: '80px',
        slidesToShow: 1
    });
    $('.book-segment-list').slick({
        arrows: false,
        centerMode: ${bookSegmentList.size() > 1 },
        centerPadding: '80px',
        slidesToShow: 1
    });

</script>
</body>
</html>