<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>课程新增 | kidbridge manage</title>
    <link href="/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="/resources/font-awesome/css/font-awesome.css" rel="stylesheet">
    <link href="/resources/css/animate.css" rel="stylesheet">
    <link href="/resources/css/style.css" rel="stylesheet">
    <link href="/resources/css/plugins/slick/slick.css" rel="stylesheet">
    <link href="/resources/css/plugins/slick/slick-theme.css" rel="stylesheet">
    <link href="/resources/css/plugins/summernote/summernote.css" rel="stylesheet">
    <link href="/resources/css/plugins/bootstrap-tagsinput/bootstrap-tagsinput.css" rel="stylesheet">
    <link href="/resources/css/plugins/datepicker/bootstrap-datepicker.min.css" rel="stylesheet">
    <link href="/resources/css/plugins/sweetalert/sweetalert.css" rel="stylesheet">
    <link href="/resources/css/plugins/cropper/cropper.min.css" rel="stylesheet">
    <link href="/resources/css/service/base.css" rel="stylesheet">
    <style type="text/css">
        .cropper-view-box {
            outline: none;
        }
        .cropper-line {
            opacity:1;
            background: #ffffff url("/resources/css/plugins/jcrop/Jcrop.gif");
        }
        .cropper-line.line-n {
            top:0;
            height: 1px !important;;
        }
        .cropper-line.line-s {
            bottom: 0;
            height: 1px;
        }
        .cropper-line.line-w {
            left: 0;
            width: 1px;
        }
        .cropper-line.line-e {
            right: 0;
            width: 1px;
        }
        .cropper-point {
            background-color:#333333;
            opacity:0.8;
            height: 7px;
            width: 7px;
        }
        .cropper-point.point-se {
            background-color:#333333;
            opacity:0.8;
            height: 7px;
            width: 7px;
        }
    </style>
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
                                课程新增
                            </h5>
                        </div>
                        <div class="ibox-content">
                            <div class="course-view center-block">
                                <input type="hidden" name="course-id" value="${course.id }">
                                <div class="course-head">
                                    <div class="panel panel-default">
                                        <div class="panel-body" style="padding: 0;">
                                            <i class="fa fa-plus course-add-icon"></i>
                                            <input type="file" style="display: none;" class="course-add-icon-upload" name="upload" accept="image/jpg,image/jpeg,image/png" >
                                        </div>
                                    </div>
                                    <div class="panel image-upload panel-default" style="display: ${not empty course.icon ? "block" : "none" }">
                                        <div class="panel-body image-upload-list" style="padding: 0;">
                                            <c:forEach items="${course.icon }" var="icon" varStatus="status">
                                                <div data-id="${status.index }" class="detail text-center" data-icon="http://res.kidbridge.org/${icon }">
                                                    <input type="hidden" name="course-icon" value="${icon }" />
                                                    <img src="http://res.kidbridge.org/${icon }" class="thumbnail img-responsive" />
                                                    <a href="http://res.kidbridge.org/${icon }" target='_blank' class="btn btn-primary btn-xs view">查</a>
                                                    <a href="javascript:" class="btn btn-danger btn-xs book-add-icon-delete">删</a>
                                                    <a href="javascript:" class="btn btn-primary btn-xs book-add-icon-edit">改</a>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                                <div class="course-body">
                                    <div class="course-price">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">出售价格</div>
                                            <div class="panel-body">
                                                <input value="${empty course.price ? "10" : fn:substring(course.price, 0, fn:indexOf(course.price, '.') ) }" name="course-price" class="course-price form-control" type="text" placeholder="限整数输入，输入“0”则免费" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="course-name">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">课程名称</div>
                                            <div class="panel-body">
                                                <input value="${course.name }" name="course-name" class="course-name form-control" type="text" placeholder="叫什么名字呢？" />
                                            </div>
                                        </div>
                                    </div>
                                    <%--<div class="course-add-user">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">被打赏用户(可空)</div>
                                            <div class="panel-body">
                                                <input value="${course.copyright.user.id }" data-id="${course.copyright.user.id }" readonly="readonly" name="user-id" style="display: ${empty course.copyright.user.id or course.copyright.user.id eq '-1' ? "none" : "block" };margin-bottom: 10px;" class="user-teacher form-control" type="text" placeholder="被打赏用户" />
                                                <button type="button" class="btn btn-default btn-block" data-toggle="modal" data-backdrop="static" data-target="#user-search"><i class="fa fa-search-plus"></i></button>
                                            </div>
                                        </div>
                                    </div>--%>
                                    <div class="course-sort">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">排　　序</div>
                                            <div class="panel-body">
                                                <input value="${empty course.sort ? "0" : course.sort }" class="book-sort form-control" name="course-sort" type="text" placeholder="数值越大排序越靠前" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="course-teacher">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">所属教师</div>
                                            <div class="panel-body">
                                                <input value="${course.teacher.realname }" data-id="${course.teacher.id }" readonly="readonly" name="course-teacher" style="display: ${empty course.teacher ? "none" : "block" };margin-bottom: 10px;" class="course-teacher form-control" type="text" placeholder="该课程所属教师" />
                                                <button type="button" class="btn btn-default btn-block" data-toggle="modal" data-backdrop="static" data-target="#teacher-search"><i class="fa fa-search-plus"></i></button>
                                            </div>
                                        </div>
                                    </div>
                                    <%--<div class="course-copyright">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">版权用户</div>
                                            <div class="panel-body">
                                                <input value="${course.copyright.user.id }" data-id="${course.copyright.user.id }" readonly="readonly" name="course-copyright" style="display: ${empty course.copyright.user.id ? "none" : "block" };margin-bottom: 10px;" class="course-copyright form-control" type="text" placeholder="被打赏用户信息" />
                                                <button type="button" class="btn btn-default btn-block" data-toggle="modal" data-backdrop="static" data-target="#course-copyright"><i class="fa fa-search-plus"></i></button>
                                            </div>
                                        </div>
                                    </div>--%>
                                    <div class="course-richtext">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">课程赏析</div>
                                            <div class="panel-body">
                                                <div id="summernote"></div>
                                            </div>
                                        </div>
                                    </div>
                                    <%--<div class="course-outline">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">故事梗概</div>
                                            <div class="panel-body">
                                                <textarea class="form-control" name="course-outline" rows="3" placeholder="什么梗？">${course.outline }</textarea>
                                            </div>
                                        </div>
                                    </div>--%>
                                    <div class="course-fit">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">适龄</div>
                                            <div class="panel-body">
                                                <select class="form-control" name="course-fit">
                                                    <option value="0"${course.fit eq 0 ? " selected=\"selected\"" : "" }>3-5岁</option>
                                                    <option value="1"${course.fit eq 1 ? " selected=\"selected\"" : "" }>6-8岁</option>
                                                    <option value="2"${course.fit eq 2 ? " selected=\"selected\"" : "" }>9-12岁</option>
                                                    <option value="3"${course.fit eq 3 ? " selected=\"selected\"" : "" }>4-7岁</option>
                                                    <option value="4"${course.fit eq 4 ? " selected=\"selected\"" : "" }>8-10岁</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="course-tag">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">关键词</div>
                                            <div class="panel-body">
                                                <input value="${fn:join(course.tag.toArray(), ", ") }" class="course-tag-input" type="text" placeholder="${empty course.tag ? "多个关键词输入“,”间隔" : "" }" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="course-limit">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">报名人数</div>
                                            <div class="panel-body">
                                                <input value="${course.limit }" name="course-limit" class="course-limit form-control" type="text" placeholder="课程报名人数限制" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="course-startTime">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">开课时间</div>
                                            <div class="panel-body">
                                                <div class="input-group date">
                                                    <input readonly="readonly" placeholder="选择课程的开课时间" type="text" name="course-startTime-input" class="course-startTime-input form-control"><span class="input-group-addon"><i class="glyphicon glyphicon-th"></i></span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="course-book">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">绘本目录</div>
                                            <div class="panel-body">
                                                <div class="course-book-list" style="margin: 0 auto;">
                                                    <div class="list-group" style="display: ${empty course.bookList ? "none" : "block" }">
                                                        <c:forEach items="${course.bookList }" var="book">
                                                            <div class="list-group-item" data-id="${book.id }">
                                                                <div class="text_1">${book.name }</div>
                                                                <div class="control">
                                                                    <a href="javascript:" class="del">删除</a>
                                                                </div>
                                                            </div>
                                                        </c:forEach>
                                                    </div>
                                                    <div>
                                                        <button type="button" class="btn btn-default btn-block" data-toggle="modal" data-backdrop="static" data-target="#course-book-add"><i class="fa fa-plus"></i></button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <button type="button" class="btn btn-primary btn-block save">保　　存</button>
                                    <div class="modal fade" id="course-book-add" tabindex="-1" role="dialog">
                                        <div class="modal-dialog" role="document">
                                            <div class="modal-content book-segment-add-body">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                    <h4 class="modal-title">绘本检索</h4>
                                                </div>
                                                <div class="modal-body" style="padding-bottom: 20px;">
                                                    <div class="book-search form-inline">
                                                        <div class="form-group input-group input-group-xs">
                                                            <span class="input-group-addon" id="sizing-addon1">绘本名称</span>
                                                            <input type="text" class="form-control" style="width: 399px;" placeholder="输入绘本编号或名称进行查询" aria-describedby="sizing-addon1">
                                                        </div>
                                                        <div class="form-group">
                                                            <button type="button" class="btn btn-primary">搜索</button>
                                                        </div>
                                                    </div>
                                                    <%--<div class="result list-group" style="margin-top: 10px;margin-bottom: 0;">

                                                    </div>--%>
                                                    <div class="book-search-result" style="margin-top: 10px;margin-bottom: 10px;">
                                                        <table class="table table-striped" style="margin-bottom: 0;border: 1px solid #ddd;display: none;">
                                                            <thead>
                                                            <tr>
                                                                <th>编号</th>
                                                                <th>绘本名称</th>
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
                                                    </div>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-default" data-dismiss="modal" style="margin-bottom: 0;">关闭</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal fade" id="teacher-search" tabindex="-1" role="dialog">
                                        <div class="modal-dialog" role="document">
                                            <div class="modal-content book-segment-add-body">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                    <h4 class="modal-title">教师检索</h4>
                                                </div>
                                                <div class="modal-body" style="padding-bottom: 10px;">
                                                    <div class="teacher-search form-inline">
                                                        <div class="form-group input-group input-group-xs">
                                                            <span class="input-group-addon">教师姓名</span>
                                                            <input type="text" class="form-control" style="width: 399px;" placeholder="输入教师真实姓名或用户编号查询" aria-describedby="sizing-addon1">
                                                        </div>
                                                        <div class="form-group">
                                                            <button type="button" class="btn btn-primary">搜索</button>
                                                        </div>
                                                    </div>
                                                    <div class="teacher-search-result" style="margin-top: 10px;margin-bottom: 10px;">
                                                        <table class="table table-striped" style="margin-bottom: 0;border: 1px solid #ddd;display: none;">
                                                            <thead>
                                                            <tr>
                                                                <th>用户编号</th>
                                                                <th>用户昵称</th>
                                                                <th>教师姓名</th>
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
                                    <div class="modal fade" id="course-copyright" tabindex="-1" role="dialog">
                                        <div class="modal-dialog" role="document">
                                            <div class="modal-content book-segment-add-body">
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
                                                    </div>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-default" data-dismiss="modal" style="margin-bottom: 0;">关闭</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal fade" id="wechat-article" tabindex="-1" role="dialog">
                                        <div class="modal-dialog" role="document">
                                            <div class="modal-content book-segment-add-body">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                    <h4 class="modal-title">赏析导入</h4>
                                                </div>
                                                <div class="modal-body" style="padding-bottom: 20px;">
                                                    <div class="form-inline">
                                                        <div class="form-group input-group input-group-xs">
                                                            <span class="input-group-addon">文章链接</span>
                                                            <input type="text" style="width: 399px;" class="form-control wechat-article-input" placeholder="输入正确的微信文章链接，以http(s)协议开头" aria-describedby="sizing-addon1">
                                                        </div>
                                                        <div class="form-group">
                                                            <button type="button" class="btn btn-primary wechat-article-button">导入</button>
                                                        </div>
                                                    </div>
                                                    <div class="alert alert-warning text-center wechat-article-tip" style="margin-top: 10px;margin-bottom:0; display: none;" role="alert">
                                                        内容解析中，视内容中图片转存数量的不同，速度有所差异;请勿关闭本窗口 ..
                                                    </div>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-default" data-dismiss="modal" style="margin-bottom: 0;">关闭</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal fade" id="image-cut" tabindex="-1" role="dialog">
                                        <div class="modal-dialog" role="document">
                                            <div class="modal-content book-segment-add-body">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                    <h4 class="modal-title">图片裁剪</h4>
                                                </div>
                                                <div class="modal-body" style="padding-bottom: 20px;">
                                                    <div>
                                                        <img id="image-cut-a">
                                                    </div>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-default" data-dismiss="modal" style="margin-bottom: 0;">关闭</button>
                                                    <button type="button" class="btn btn-primary image-cut-save">保存</button>
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
<script src="/resources/js/plugins/summernote/summernote.min.js"></script>
<script src="/resources/js/plugins/summernote/summernote-zh-CN.js"></script>
<script src="/resources/js/plugins/bootstrap-tagsinput/bootstrap-tagsinput.js"></script>
<script src="/resources/js/plugins/datepicker/bootstrap-datepicker.min.js"></script>
<script src="/resources/js/plugins/datepicker/bootstrap-datepicker.zh-CN.min.js"></script>
<script src="/resources/js/plugins/moment/moment.min.js"></script>
<script src="/resources/js/plugins/sweetalert/sweetalert.min.js"></script>
<script src="/resources/js/plugins/cropper/cropper.min.js"></script>
<script src="/resources/js/service/base.js"></script>
<script>
    $(".user-search button").on("click",function () {
        var keyword = $(".user-search input").val();
        $.ajax({
            url: "/user/search",
            type:"POST",
            data:JSON.stringify({"keyword":keyword,"filter":1}),
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
                var userList = resp.data;
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
                }
                $(".user-search-result table tbody").html(html);
                $(".user-search-result table").show();
            }
        });
    });
    $(".user-search-result table tbody").on("click","a",function () {
        var id = $(this).data("id");
        $("#user-search").modal("hide");
        $("input[name='user-id']").val(id);
        $("input[name='user-id']").show();
    });
    $('#user-search').on('hidden.bs.modal', function () {
        $(".user-search input").val("");
        $(".user-search-result table tbody").html("");
        $(".user-search-result table").hide();
    });
    if(${not empty course.richText }){
        $.get("http://res.kidbridge.org/${course.richText }",function (resp) {
            $("#summernote").summernote("code", resp);
        });
    }
    var getWechatArticle = function (context) {
        var ui = $.summernote.ui;
        // create button
        var button = ui.button({
            contents: '<i class="fa fa-wechat"/>',
            tooltip: '导入微信文章',
            click: function () {
                $("#wechat-article").modal({
                    backdrop: "static"
                },"show");
            }
        });

        return button.render();   // return button as jquery object
    };
    $(".wechat-article-button").on("click",function () {
        var url = $(".wechat-article-input").val();
        $.ajax({
            type:"POST",
            url:"/tool/wechat/article",
            data:JSON.stringify({"url":url}),
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
                    $(".wechat-article-tip").hide();
                    return;
                }
                $("#summernote").summernote("code", resp.data.body);
                $("#wechat-article").modal("hide");
            },
            beforeSend: function () {
                $(".wechat-article-tip").show();
            }
        });
    });
    $('#wechat-article').on('hidden.bs.modal', function () {
        $(".wechat-article-input").val(null);
        $(".wechat-article-tip").hide();
    });
    $(".user-search button").on("click",function () {
        var keyword = $(".user-search input").val();
        $.ajax({
            url: "/user/search",
            type:"POST",
            data:JSON.stringify({"keyword":keyword}),
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
                var userList = resp.data;
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
                }
                $(".user-search-result table tbody").html(html);
                $(".user-search-result table").show();
            }
        });
    });
    $(".user-search-result table tbody").on("click","a",function () {
       var id = $(this).data("id");
       var target = $("input[name='course-copyright']");
        target.val(id);
        target.data("id",id);
        $('#course-copyright').modal("hide");
        target.show();
    });
    $('#course-copyright').on('hidden.bs.modal', function () {
        $(".user-search input").val(null);
        $(".user-search-result table tbody").html("");
        $(".user-search-result table").hide();
    });
    $('#summernote').summernote({
        lang:'zh-CN',
        tabsize: 2,
        height: 200,
        disableDragAndDrop: true,
        placeholder:"这里是富文本 ~",
        toolbar:[
            ['font', ['fontsize', 'color', 'bold', 'italic', 'underline', 'strikethrough', 'clear']],
            ['paragraph', ['style', 'ol', 'ul', 'paragraph', 'height']],
            ['insert', ['hr','picture']],
            ['misc', ['codeview','wechatArticle']]
        ],
        buttons: {
            wechatArticle: getWechatArticle
        },
        callbacks: {
            onImageUpload: function(files) {
                $.ajax({
                    url: "/file/token",
                    async: false,
                    contentType: "application/json",
                    dataType: "json",
                    success: function(resp){
                        if(resp.event != "SUCCESS"){
                            return;
                        }
                        var formData = new FormData();
                        formData.append("token",resp.data.token);
                        formData.append("file",files[0]);
                        $.ajax({
                            url: 'http://upload.qiniu.com/' ,
                            type: 'POST',
                            data: formData,
                            async: false,
                            cache: false,
                            contentType: false,
                            processData: false,
                            success: function (resp) {
                                $('#summernote').summernote('insertImage', 'http://res.kidbridge.org/' + resp.key, function ($image) {
                                    $image.attr('class', 'img-responsive');
                                });
                            }
                        });
                    }
                });
            }
        }
    });
    $('.course-tag-input').tagsinput({
        tagClass: 'label label-primary',
        maxChars:32,
        trimValue: true
    });
    $('.course-tag-input').on('itemAdded', function(event) {
        if($(this).tagsinput("items").length > 0){
            $(".bootstrap-tagsinput input").attr("placeholder",null);
        }
    });
    $('.course-tag-input').on('itemRemoved', function(event) {
        if($(this).tagsinput("items").length == 0){
            $(".bootstrap-tagsinput input").attr("placeholder","多个关键词输入“,”间隔");
        }
    });
    $(".input-group.date").datepicker({
        language: "zh-CN",
        format:"yyyy-mm-dd",
        autoclose: true,
        todayHighlight: true
    });
    if(${not empty course.startTime }){
        <fmt:formatDate value="${course.startTime }" pattern="yyyy-MM-dd" var="startTime" />
        $(".input-group.date").datepicker('setDate', moment("${startTime }","YYYY-MM-DD").toDate());
    }
    $(".book-search button").on("click",function () {
        var keyword = $(".book-search input").val();
        $(".book-search-result .pageblock").hide();
        $(".book-search-result .pageblock .pagination").html('');
        bookPagination(1,keyword);
    });
    function bookPagination(cpage,keyword) {
        $.ajax({
            url: "/book/search",
            type:"POST",
            data:JSON.stringify({"keyword":keyword,"page":cpage}),
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
                var bookList = resp.data.dataList;
                var html = "";
                if(bookList.length == 0){
                    html = "<tr><td colspan=\"2\">无检索结果内容 ~</td></tr>";
                }else{
                    for(var i=0;i<bookList.length;i++){
                        var book = bookList[i];
                        html += "<tr>";
                        html += "<td>"+book.id+"</td>";
                        html += "<td>"+book.name+"</td>";
                        html += "<td>";
                        html += "<a target='_blank' href=\"/book/detail/"+book.id+"\">详情</a>&nbsp;&nbsp;";
                        if(!($(".course-book-list .list-group-item[data-id='"+book.id+"']").length > 0)){
                            html += "<a class=\"result-add\" data-id=\""+book.id+"\" data-name=\""+book.name+"\" href=\"javascript:;\">";
                            html += "添加";
                            html += "</a>";
                        }else{
                            html += "<span>存在</span>";
                        }
                        html += "</td>";
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
                    $(".book-search-result .pageblock .pagination").html(pageHtml);
                    $(".book-search-result .pageblock").show();
                }
                $(".book-search-result table tbody").html(html);
                $(".book-search-result table").show();
            }
        });
    }
    $(".book-search-result .pageblock .pagination").on("click","li a",function () {
        var page = $(this).data("page");
        var keyword = $(this).data("keyword");
        if(page != undefined && page != null && page != ''){
            bookPagination(page,keyword);
        }
    });
    $(".book-search-result table tbody").on("click",".result-add",function () {
        var id = $(this).data("id");
        var name = $(this).data("name");
        var len = $(".course-book-list .list-group .list-group-item").length;
        var html = "";
        html += "<div class=\"list-group-item\" data-id=\""+id+"\">";
        html += "<div class=\"text_1\">"+(len+1)+". "+name+"</div>";
        html += "<div class=\"control\">";
        html += "<a href=\"javascript:;\" class=\"del\">删除</a>";
        html += "</div>";
        html += "</div>";
        /*$('#course-book-add').modal('hide');*/
        var h = $($(this).parent().children()[0]).prop("outerHTML") + "&nbsp;&nbsp;<span>存在</span>";
        $(this).parent().html(h);
        $(".course-book-list .list-group").append(html);
        $(".course-book-list .list-group").show();
    });
    $('#course-book-add').on('hidden.bs.modal', function () {
        $(".book-search input").val("");
        $(".book-search-result table tbody").html("");
        $(".book-search-result table").hide();
        $(".book-search-result .pageblock").hide();
        $(".book-search-result .pageblock .pagination").html('');
    });
    $('#teacher-search').on('hidden.bs.modal', function () {
        $(".teacher-search input").val("");
        $(".teacher-search-result table tbody").html("");
        $(".teacher-search-result table").hide();
        $(".teacher-search-result .pageblock").hide();
        $(".teacher-search-result .pageblock .pagination").html('');
    });
    $(".teacher-search-result table tbody").on("click","a",function () {
        var id = $(this).data("id");
        var name = $(this).data("name");
        $("input[name='course-teacher']").data("id",id);
        $("input[name='course-teacher']").val(name);
        $('#teacher-search').modal('hide');
        $("input[name='course-teacher']").show();
    });
    $(".teacher-search button").on("click",function () {
        var keyword = $(".teacher-search input").val();
        $(".teacher-search-result .pageblock").hide();
        $(".teacher-search-result .pageblock .pagination").html('');
        teacherPagination(1,keyword);
    });
    $(".teacher-search-result .pageblock .pagination").on("click","li a",function () {
        var page = $(this).data("page");
        var keyword = $(this).data("keyword");
        if(page != undefined && page != null && page != ''){
            teacherPagination(page,keyword);
        }
    });
    function teacherPagination(cpage,keyword) {
        $.ajax({
            url: "/teacher/search",
            type:"POST",
            data:JSON.stringify({"keyword":keyword,"page":cpage}),
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
                var teacherList = resp.data.dataList;
                var html = "";
                if(teacherList.length == 0){
                    html = "<tr><td colspan=\"4\">无检索结果内容 ~</td></tr>";
                }else{
                    for(var i=0;i<teacherList.length;i++){
                        var teacher = teacherList[i];

                        html += "<tr>";
                        html += "<td>"+teacher.user.id+"</td>";
                        html += "<td>"+(teacher.user.nickname.trim() == "" ? "未知" : (teacher.user.nickname.length > 9 ? (teacher.user.nickname.substring(0,9) + "...") : teacher.user.nickname) )+"</td>";
                        html += "<td>"+teacher.realname+"</td>";
                        html += "<td><a data-name=\""+teacher.realname+"\" data-id=\""+teacher.id+"\" href=\"javascript:;\">添加</a></td>";
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
                    $(".teacher-search-result .pageblock .pagination").html(pageHtml);
                    $(".teacher-search-result .pageblock").show();
                }
                $(".teacher-search-result table tbody").html(html);
                $(".teacher-search-result table").show();
            }
        });
    }
    $(".course-add-icon").on("click",function () {
        $(".course-add-icon-upload").trigger("click");
    });
    $(".image-upload-list").on("click",".book-add-icon-delete",function () {
        if(($(".image-upload-list").find(".detail").length) == 1){
            $(".image-upload").hide();
        }
        $(this).parents(".detail").remove();
    });
    $(".image-upload-list").on("click",".book-add-icon-edit",function () {
        var id = $(this).parent().data("id");
        var icon = $(this).parent().data("icon");
        $('#image-cut-a').cropper("destroy").attr('src', icon).cropper({
            aspectRatio: 4 / 3,
            zoomable: false,
            dragMode:'none',
            minCropBoxWidth:80,
            autoCropArea:1,
            viewMode:1,
            minContainerWidth:540,
            minContainerHeight:405
        });
        $("#image-cut .image-cut-save").data("id",id);
        $("#image-cut").modal({
            backdrop: "static"
        },"show");
    });
    $(".course-add-icon-upload").on("change",function () {
        var reader = new FileReader();
        reader.onload = function(e) {
            var data = e.target.result;
            $(".course-add-icon-upload").val('');
            $('#image-cut-a').cropper("destroy").attr('src', data).cropper({
                aspectRatio: 9 / 5,
                zoomable: false,
                dragMode:'none',
                minCropBoxWidth:80,
                autoCropArea:1,
                viewMode:1,
                minContainerWidth:540,
                minContainerHeight:300
            });
            $("#image-cut").modal({
                backdrop: "static"
            },"show");
        };
        reader.readAsDataURL($(this).prop('files')[0]);
    });
    $(".image-cut-save").on("click",function () {
        var id = $(this).data("id");
        $.ajax({
        url: "/file/token",
        async: false,
        contentType: "application/json",
        dataType: "json",
        success: function(resp){
            if(resp.event != "SUCCESS"){
                return;
            }
            var img = $("#image-cut-a").cropper("getCroppedCanvas",{
                width:400,
                height:300
            });
            img.toBlob(function (blob) {
                var formData = new FormData();
                formData.append("token",resp.data.token);
                formData.append("file",blob);
                $.ajax({
                    async: false,
                    url: 'http://upload.qiniu.com/' ,
                    type: 'POST',
                    data: formData,
                    async: false,
                    cache: false,
                    contentType: false,
                    processData: false,
                    success: function (resp) {
                        var len = $(".image-upload-list .detail").length;
                        if(id == undefined){
                            var html = "";
                            html += "<div class=\"detail text-center\" data-id=\""+len+"\" data-icon=\"http://res.kidbridge.org/"+resp.key+"\">";
                            html += "<input type=\"hidden\" name=\"course-icon\" value=\""+resp.key+"\" />";
                            html += "<img src=\"http://res.kidbridge.org/"+resp.key+"\" class=\"thumbnail img-responsive\" />";
                            html += "<a href=\"http://res.kidbridge.org/"+resp.key+"\" target='_blank' class=\"btn btn-primary btn-xs\">查</a>";
                            html += "<a href=\"javascript:;\" class=\"btn btn-danger btn-xs book-add-icon-delete\">删</a>";
                            html += "<a href=\"javascript:;\" class=\"btn btn-primary btn-xs book-add-icon-edit\">改</a>";
                            html += "</div>";
                            $(".image-upload-list").append(html);
                            $(".image-upload").show();
                            $(".course-add-icon-upload").val('');
                        }else{
                            var editnode = $(".image-upload-list .detail[data-id="+id+"]");
                            $(editnode).data("icon","http://res.kidbridge.org/"+resp.key);
                            $(editnode).find("input[name='course-icon']").val(resp.key);
                            $(editnode).find("img").attr("src","http://res.kidbridge.org/"+resp.key);
                            $(editnode).find(".view").attr("href","http://res.kidbridge.org/"+resp.key);
                        }
                        $(".image-upload").show();
                        $("#image-cut").modal("hide");
                        $(this).data("id",null);
                    }
                });
            },'image/jpeg',0.7);
        }
    });
    });
    $(".save").on("click",function () {
        var course = {};
        course.id = $("input[name=course-id]").val();
        course.copyright = {};
        course.copyright.user = {};
        course.copyright.user.id = $("input[name='course-copyright']").val();
        course.icon = [];
        $("[name='course-icon']").each(function (i) {
            course.icon.push($(this).val());
        });
        $.ajax({
            url: "/file/token",
            async: false,
            data: "",
            contentType: "application/json",
            dataType: "json",
            success: function(resp){
                if(resp.event != "SUCCESS"){
                    return;
                }
                var formData = new FormData();
                formData.append("token",resp.data.token);
                formData.append("file",$('#summernote').summernote('code'));
                $.ajax({
                    url: 'http://upload.qiniu.com/',
                    type: 'POST',
                    data: formData,
                    async: false,
                    cache: false,
                    contentType: false,
                    processData: false,
                    success: function (resp) {
                        course.richtext = resp.key;
                    }
                });
            }
        });
        course.price = $("[name='course-price']").val();
        course.name= $("[name='course-name']").val();
        course.sort= $("[name='course-sort']").val();
        course.teacher = {};
        course.teacher.id = $("[name='course-teacher']").data("id");
        course.outline = $("[name='course-outline']").val();
        course.fit = $("[name='course-fit']").val();
        course.tag = $(".course-tag-input").tagsinput("items");
        course.limit = $("[name='course-limit']").val();
        course.startTime = $("[name='course-startTime-input']").val();
        /*course.copyright = {};
        course.copyright.user = {};
        course.copyright.user.id = $("input[name='user-id']").val();*/
        course.book = [];
        $(".course-book-list .list-group-item").each(function () {
           course.book.push($(this).data("id"));
        });
        $.ajax({
            url: "/course/${empty course.id ? "add" : "edit" }",
            type:"POST",
            data:JSON.stringify(course),
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
                window.location.href = "/course/list";
            }
        });
        console.log(course);
    });
    $(".course-book-list").on("click"," .del", function () {
        $(this).parents(".list-group-item").remove();
        if($(".course-book-list .list-group .list-group-item").length == 0){
            $(".course-book-list .list-group").hide();
        }
    });







</script>
</body>
</html>