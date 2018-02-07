<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>课程详情 | kidbridge manage</title>
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
                                ${course.name }
                            </h5>
                        </div>
                        <div class="ibox-content">
                            <div class="course-view center-block">
                                <div class="course-head">
                                    <div class="panel panel-default">
                                        <div class="panel-body" style="padding: 0;">
                                            <div class="course-icon">
                                                <c:forEach items="${course.icon }" var="icon">
                                                    <img class="img-responsive" src="http://res.kidbridge.org/${icon }">
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="course-body">
                                    <div class="course-price">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">课程价格</div>
                                            <div class="panel-body">
                                                ${course.price }
                                            </div>
                                        </div>
                                    </div>
                                    <div class="course-richtext">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">课程赏析</div>
                                            <div class="panel-body course-richtext-body">

                                            </div>
                                        </div>
                                    </div>
                                    <%--<div class="course-outline">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">故事梗概</div>
                                            <div class="panel-body">
                                                <pre>${course.outline }</pre>
                                            </div>
                                        </div>
                                    </div>--%>
                                    <div class="course-fit">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">适龄</div>
                                            <div class="panel-body">
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
                                            </div>
                                        </div>
                                    </div>
                                    <div class="course-tag">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">关键词  ${course.teacher.realname} </div>
                                            <div class="panel-body">
                                                ${fn:join(course.tag.toArray(), ", ") }
                                            </div>
                                        </div>
                                    </div>
                                    <div class="course-enter">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">报名人数</div>
                                            <div class="panel-body">
                                                ${course.enter } / ${course.limit }
                                            </div>
                                        </div>
                                    </div>
                                    <div class="course-startTime">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">开课时间</div>
                                            <div class="panel-body">
                                                <fmt:formatDate value="${course.startTime }" pattern="yyyy-MM-dd" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="course-cycle">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">课程周期</div>
                                            <div class="panel-body">
                                                ${course.cycle } 天
                                            </div>
                                        </div>
                                    </div>
                                    <div class="course-status">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">目前状态</div>
                                            <div class="panel-body">
                                                <c:choose>
                                                    <c:when test="${course.status eq '0' }">
                                                        未开课
                                                    </c:when>
                                                    <c:when test="${course.status eq '1' }">
                                                        开课中
                                                    </c:when>
                                                    <c:when test="${course.status eq '2' }">
                                                        已结束
                                                    </c:when>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="course-user">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">报名用户</div>
                                            <div class="panel-body">
                                                <c:choose>
                                                    <c:when test="${not empty course.userList and course.userList.size() > 0}">
                                                        <table class="table table-striped" style="margin-bottom: 0;border: 1px solid #ddd;">
                                                            <thead>
                                                            <tr>
                                                                <th>用户编号</th>
                                                                <th>用户昵称</th>
                                                            </tr>
                                                            </thead>
                                                            <tbody>
                                                                <c:forEach items="${course.userList }" var="user">
                                                                    <tr>
                                                                        <td>${user.id }</td>
                                                                        <td>${user.nickname }</td>
                                                                    </tr>
                                                                </c:forEach>
                                                            </tbody>
                                                        </table>
                                                    </c:when>
                                                    <c:otherwise>
                                                        暂无
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="course-book">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">绘本目录</div>
                                            <div class="panel-body text-center">
                                                <div class="course-book-list" style="margin: 0 auto;">
                                                    <div class="list-group" style="margin-bottom: 0;">
                                                        <c:forEach items="${course.bookList }" var="b" varStatus="status">
                                                            <a class="list-group-item" href="/book/detail/${b.id }" style="outline: none;" target="_blank" data-id="${b.id }">
                                                                ${status.index + 1}. ${b.name }
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
<script src="/resources/js/plugins/slick/slick.min.js"></script>
<script src="/resources/js/plugins/sweetalert/sweetalert.min.js"></script>
<script src="/resources/js/service/base.js"></script>
<script>
    $.get("http://res.kidbridge.org/${course.richText }",function (resp) {
        $(".course-richtext-body").html(resp);
    });
    $('.course-icon').slick({
        arrows: false,
        autoplay: true,
        centerMode: ${course.icon.size() > 1 },
        centerPadding: '80px',
        slidesToShow: 1
    });
    $('.course-book-list').slick({
        prevArrow:$(".icon-prev"),
        nextArrow:$(".icon-next"),
        infinite: false
    });
</script>
</body>
</html>