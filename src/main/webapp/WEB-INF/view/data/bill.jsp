<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户余额明细列表 | kidbridge manage</title>
    <link href="/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="/resources/font-awesome/css/font-awesome.css" rel="stylesheet">
    <link href="/resources/css/animate.css" rel="stylesheet">
    <link href="/resources/css/style.css" rel="stylesheet">
    <link href="/resources/css/plugins/sweetalert/sweetalert.css" rel="stylesheet">
    <link href="/resources/css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="/resources/css/plugins/datepicker/bootstrap-datepicker.min.css" rel="stylesheet">
    <link href="/resources/css/service/base.css" rel="stylesheet">
</head>
<body>
<div id="wrapper">

    <jsp:include page="/WEB-INF/view/templet/navigation.jsp" />

    <div id="page-wrapper" class="gray-bg">
        <div class="row border-bottom">
            <nav class="navbar navbar-static-top white-bg" role="navigation" style="margin-bottom: 0">
                <div class="navbar-header" style="margin: 10px 24px;">
                    <form method="get" action="/data/user/bill/detail/list">
                        <div class="input-group" style="width: 200px;float: left;">
                            <span class="input-group-addon">跟读时间</span>
                            <input type="text" readonly="readonly" id="begin-date" placeholder="起始日期" value="${param.beginDate }" class="form-control" name="beginDate" style="width: 150px;">
                            <span class="input-group-addon">-</span>
                            <input type="text" readonly="readonly" id="end-date" placeholder="截止日期" value="${param.endDate }" class="form-control" name="endDate" style="width: 150px;">
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
                            <h5>用户余额明细列表</h5>
                        </div>
                        <div class="ibox-content">

                            <table class="table table-striped">
                                <thead>
                                <tr>
                                    <th>明细编号</th>
                                    <th>用户编号</th>
                                    <th>用户昵称</th>
                                    <th>收件信息</th>
                                    <th>余额类别</th>
                                    <th>收支金额</th>
                                    <th>收支类别</th>
                                    <th>收支时间</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:choose>
                                    <c:when test="${not empty detailList }">
                                        <c:forEach items="${detailList }" var="detail">
                                            <tr>
                                                <td>${detail.bill_id }</td>
                                                <td>${detail.user.user_id }</td>
                                                <td>${empty detail.user.user_nickname ? "未知" : detail.user.user_nickname }</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${not empty detail.user.user_receiving_contact and not empty detail.user.user_receiving_phone and not empty detail.user.user_receiving_region and not empty detail.user.user_receiving_street }">
                                                            ${detail.user.user_receiving_contact } ${detail.user.user_receiving_phone } ${detail.user.user_receiving_region } ${detail.user.user_receiving_street }
                                                        </c:when>
                                                        <c:otherwise>
                                                            未知
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>${detail.bill_fee_type }</td>
                                                <td>${detail.bill_fee }</td>
                                                <td>${detail.bill_bill_type }</td>
                                                <td>
                                                    <fmt:formatDate value="${detail.bill_create_time }" pattern="yyyy-MM-dd HH:mm:ss" />
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="8">暂无数据 ~</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                            </table>
                            <div style="height: 35px;">
                                <div style="float: left;">
                                    <a href="/data/user/bill/detail/export/?beginDate=${param.beginDate }&endDate=${param.endDate }" class="btn btn-primary">生成报表</a>
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
                                                    <a href="/data/user/bill/detail/list/?beginDate=${param.beginDate }&endDate=${param.endDate }&page=${page.min }" aria-label="Previous"><i class="fa fa-angle-double-left" aria-hidden="true"></i></a>
                                                </li>
                                                <li>
                                                    <a href="/data/user/bill/detail/list/?beginDate=${param.beginDate }&endDate=${param.endDate }&page=${param.page - 1 }" aria-label="Previous"><i class="fa fa-angle-left" aria-hidden="true"></i></a>
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
                                                        <a href="/data/user/bill/detail/list/?beginDate=${param.beginDate }&endDate=${param.endDate }&page=${number }">
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
                                                    <a href="/data/user/bill/detail/list/?beginDate=${param.beginDate }&endDate=${param.endDate }&page=${empty param.page ? param.page + 1 + 1 : param.page + 1 }" aria-label="Next"><i class="fa fa-angle-right" aria-hidden="true"></i></a>
                                                </li>
                                                <li>
                                                    <a href="/data/user/bill/detail/list/?beginDate=${param.beginDate }&endDate=${param.endDate }&page=${page.max }" aria-label="Next"><i class="fa fa-angle-double-right" aria-hidden="true"></i></a>
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
<script src="/resources/js/plugins/iCheck/icheck.min.js"></script>
<script src="/resources/js/plugins/datepicker/bootstrap-datepicker.min.js"></script>
<script src="/resources/js/plugins/datepicker/bootstrap-datepicker.zh-CN.min.js"></script>
<script src="/resources/js/service/base.js"></script>
<script>
    $('#begin-date').datepicker({
        language: "zh-CN",
        autoclose: true,
        format: "yyyy-mm-dd",
        todayHighlight: true
    });
    $('#end-date').datepicker({
        language: "zh-CN",
        autoclose: true,
        format: "yyyy-mm-dd",
        todayHighlight: true
    });
    $('#begin-date').on("changeDate",function (e) {
        $('#end-date').datepicker('setStartDate', e.date);
    });
    $('#end-date').on("changeDate",function (e) {
        $('#begin-date').datepicker('setEndDate', e.date);
    });
</script>
</body>
</html>