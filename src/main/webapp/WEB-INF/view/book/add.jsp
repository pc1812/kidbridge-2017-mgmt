<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>绘本新增 | kidbridge manage</title>
    <link href="/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="/resources/font-awesome/css/font-awesome.css" rel="stylesheet">
    <link href="/resources/css/animate.css" rel="stylesheet">
    <link href="/resources/css/style.css" rel="stylesheet">
    <link href="/resources/css/plugins/slick/slick.css" rel="stylesheet">
    <link href="/resources/css/plugins/slick/slick-theme.css" rel="stylesheet">
    <link href="/resources/css/plugins/summernote/summernote.css" rel="stylesheet">
    <link href="/resources/css/plugins/bootstrap-tagsinput/bootstrap-tagsinput.css" rel="stylesheet">
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
                                ${book.name }
                            </h5>
                        </div>
                        <div class="ibox-content">
                            <div class="book-add-view center-block">
                                <form id="form">
                                    <input type="hidden" name="book-id" value="${book.id }">
                                    <div class="book-add-head">
                                        <div class="panel panel-default">
                                            <div class="panel-body" style="padding: 0;">
                                                <i class="fa fa-plus book-add-icon"></i>
                                                <input type="file" style="display: none;" class="book-add-icon-upload" name="upload" accept="image/jpg,image/jpeg,image/png" >
                                            </div>
                                        </div>
                                        <div class="panel image-upload panel-default" style="display: ${not empty book.icon ? "block" : "none" }">
                                            <div class="panel-body image-upload-list" style="padding: 0;">
                                                <c:forEach items="${book.icon }" var="icon" varStatus="status">
                                                    <div data-id="${status.index }" class="detail text-center" data-icon="http://res.kidbridge.org/${icon }">
                                                        <input type="hidden" name="book-icon" value="${icon }" />
                                                        <img src="http://res.kidbridge.org/${icon }" class="thumbnail img-responsive" />
                                                        <a href="http://res.kidbridge.org/${icon }" target='_blank' class="btn btn-primary btn-xs view">查</a>
                                                        <a href="javascript:" class="btn btn-danger btn-xs book-add-icon-delete">删</a>
                                                        <a href="javascript:" class="btn btn-primary btn-xs book-add-icon-edit">改</a>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="book-add-body">
                                        <div class="book-add-name">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">绘本名称</div>
                                                <div class="panel-body">
                                                    <input value="${book.name }" class="book-name form-control" name="book-name" type="text" placeholder="叫什么名字好呢 ~" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="book-add-user">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">被打赏用户(可空)</div>
                                                <div class="panel-body">
                                                    <input value="${book.copyright.user.id }" data-id="${book.copyright.user.id }" readonly="readonly" name="user-id" style="display: ${empty book.copyright.user.id or book.copyright.user.id eq '-1' ? "none" : "block" };margin-bottom: 10px;" class="user-teacher form-control" type="text" placeholder="被打赏用户" />
                                                    <button type="button" class="btn btn-default btn-block" data-toggle="modal" data-backdrop="static" data-target="#user-search"><i class="fa fa-search-plus"></i></button>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="book-add-name">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">排　　序</div>
                                                <div class="panel-body">
                                                    <input value="${empty book.sort ? "0" : book.sort }" class="book-sort form-control" name="book-sort" type="text" placeholder="数值越大排序越靠前" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="book-add-richtext">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">绘本赏析</div>
                                                <div class="panel-body">
                                                    <div id="summernote"></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="book-add-outline">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">故事梗概</div>
                                                <div class="panel-body">
                                                    <textarea class="form-control" name="book-outline" rows="3" placeholder="什么梗？">${book.outline }</textarea>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="book-add-feeling">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">绘本感悟</div>
                                                <div class="panel-body">
                                                    <textarea class="form-control" name="book-feeling" rows="3" placeholder="谈谈这篇绘本对你的启发吧 ~">${book.feeling }</textarea>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="book-add-fit">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">适龄</div>
                                                <div class="panel-body">
                                                    <select class="form-control" name="book-fit">
                                                        <option value="0"${book.fit eq 0 ? " selected=\"selected\"" : "" }>3-5岁</option>
                                                        <option value="1"${book.fit eq 1 ? " selected=\"selected\"" : "" }>6-8岁</option>
                                                        <option value="2"${book.fit eq 2 ? " selected=\"selected\"" : "" }>9-12岁</option>
                                                        <option value="3"${book.fit eq 3 ? " selected=\"selected\"" : "" }>4-7岁</option>
                                                        <option value="4"${book.fit eq 4 ? " selected=\"selected\"" : "" }>8-10岁</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="book-add-difficulty" style="display: none;" >
                                            <div class="panel panel-default">
                                                <div class="panel-heading">难度</div>
                                                <div class="panel-body">
                                                    <input value="${book.difficulty }" type="text" class="form-control" name="book-difficulty" placeholder="一般? 困难 or 究极" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="book-add-tag">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">关键词</div>
                                                <div class="panel-body">
                                                    <input value="${fn:join(book.tag.toArray(), ", ") }" class="book-tag" type="text" placeholder="${empty book.tag ? "多个关键词输入“,”间隔" : "" }" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="book-add-price">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">出售价格</div>
                                                <div class="panel-body">
                                                    <input value="${empty book.price ? "10" : fn:substring(book.price, 0, fn:indexOf(book.price, '.') ) }" name="book-price" class="book-price form-control" type="text" placeholder="限整数输入，输入“0”则免费" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="book-add-repeat-active-time">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">限制跟读时间(单位:秒)</div>
                                                <div class="panel-body">
                                                    <input value="${empty book.repeatActiveTime ? "600" : book.repeatActiveTime }" name="book-repeat-active-time" class="book-repeat-active-time form-control" type="text" placeholder="单位：秒" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="book-add-active">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">在绘本馆进行展示</div>
                                                <div class="panel-body">
                                                    <select class="form-control" name="book-active" title="否则只在课程捆绑中展示">
                                                        <c:choose>
                                                            <c:when test="${empty book.active }">
                                                                <option value="1">是</option>
                                                                <option value="0">否</option>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <option value="1"${book.active ? " selected=\"selected\"" : "" }>是</option>
                                                                <option value="0"${book.active ? "" : " selected=\"selected\"" }>否</option>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="book-add-audio">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">完整音频</div>
                                                <div class="panel-body" style="padding-bottom: 0px;">
                                                    <input type="file" accept="audio/mpeg" name="book-add-audio-file" id="book-add-audio-file" data-key="${book.audio }" style="display: none;">
                                                    <a href="http://res.kidbridge.org/${book.audio }" target="_blank" id="book-add-audio-file-show" class="btn btn-default btn-block" style="margin-bottom: 10px;display: ${empty book.audio ? "none" : "block" };">
                                                        预览
                                                    </a>
                                                    <div class="add" style="margin-bottom: 15px;">
                                                        <button type="button" class="btn btn-default btn-block btn-book-add-audio-file">
                                                            <i class="fa fa-plus"></i>
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="book-add-segment">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">段落信息</div>
                                                <div class="panel-body" style="padding-bottom: 0px;">
                                                    <div class="book-add-segment-list">
                                                        <div class="list-group" style="display: ${empty bookSegmentList ? "none" : "block" }; margin-bottom:15px;">
                                                            <c:forEach items="${bookSegmentList }" var="bookSegment" varStatus="status">
                                                                <div data-id="${status.index + 1 }" data-icon="${bookSegment.icon }" data-audio="${bookSegment.audio }" class="list-group-item">
                                                                    <div class="num">
                                                                            ${status.index + 1 }
                                                                    </div>
                                                                    <div class="text">${bookSegment.text }</div>
                                                                    <div class="control">
                                                                            <a href="javascript:" class="edit">修改</a> | <a href="javascript:" class="del">删除</a>
                                                                    </div>
                                                                </div>
                                                            </c:forEach>
                                                        </div>
                                                        <div class="add" style="margin-bottom: 15px;">
                                                            <button type="button" class="btn btn-default btn-block" data-backdrop="static" data-toggle="modal" data-target="#book-segment-add">
                                                                <i class="fa fa-plus"></i>
                                                            </button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="book-add-tool">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">辅助录入</div>
                                                <div class="panel-body">
                                                    <div class="alert alert-danger text-center tip" role="alert" style="display: none;margin-bottom: 0;">文件上传解析中，切勿关闭或刷新本页面，请耐心等待 ...</div>
                                                    <div class="add" style="margin-bottom: 15px;">

                                                    </div>
                                                    <div class="alert alert-info result alert-dismissible" style="display: none;margin-top: 15px;margin-bottom: 0;" role="alert">
                                                        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                        <div class="text">

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <button type="button" class="btn btn-primary btn-block save">保　　存</button>
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
                                        <div class="modal fade" id="book-segment-add" tabindex="-1" role="dialog">
                                            <div class="modal-dialog" role="document">
                                                <input type="file" name="book-segment-icon-edit" class="book-segment-icon-file" style="display: none;" accept="image/jpg,image/jpeg,image/png">
                                                <input type="file" name="book-segment-audio-edit" data-key="" class="book-segment-audio-file" style="display: none;" accept="audio/mpeg">
                                                <div class="modal-content book-segment-add-body">
                                                    <div class="modal-header">
                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                        <h4 class="modal-title">段落新增</h4>
                                                    </div>
                                                    <div class="modal-body" style="padding-bottom: 20px;">
                                                        <div class="book-segment-icon add">
                                                            <div class="view">
                                                                <span class="fa fa-plus book-segment-add-icon-add"></span>
                                                            </div>
                                                        </div>
                                                        <div class="content">
                                                            <textarea class="form-control" name="book-segment-text-edit" rows="7" placeholder="请输入跟读章节内容 ~"></textarea>
                                                        </div>
                                                        <div class="audio">
                                                            <button type="button" class="btn btn-default btn-block btn-audio-upload">音频</button>
                                                        </div>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-default" data-dismiss="modal" style="margin-bottom: 0;">关闭</button>
                                                        <button type="button" class="btn btn-primary book-segment-add-save">保存</button>
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
                                </form>
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
<script src="/resources/js/plugins/sweetalert/sweetalert.min.js"></script>
<script src="/resources/js/plugins/cropper/cropper.min.js"></script>
<script src="/resources/js/plugins/uploadifive/jquery.uploadifive.js"></script>
<script src="/resources/js/plugins/moment/moment.min.js"></script>
<script src="/resources/js/service/base.js"></script>
<script>
    $(".btn-book-add-audio-file").on("click",function () {
       $("#book-add-audio-file").trigger("click");
    });
    $("#book-add-audio-file").on("change",function (e) {
        var file = e.target.files[0];
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
                formData.append("file",file);
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
                        $("#book-add-audio-file").data("key",resp.key);
                        $("#book-add-audio-file-show").attr("href","http://res.kidbridge.org/" + resp.key);
                        $("#book-add-audio-file-show").show();
                    }
                });
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
        $("input[name='user-id']").show();
    });
    $('#user-search').on('hidden.bs.modal', function () {
        $(".user-search input").val("");
        $(".user-search-result table tbody").html("");
        $(".user-search-result table").hide();
        $(".user-search-result .pageblock").hide();
        $(".user-search-result .pageblock .pagination").html('');
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
    $(".book-add-tool .add").uploadifive({
        'multi'            : false,
        'auto'             : true,
        'fileType'         : 'application/zip',
        'buttonText'   : '<button type="button" class="btn btn-default btn-block"><i class="fa fa-file-zip-o"></i></button>',
        'uploadScript'     : '/file/upload',
        'onUpload'      : function (file) {
            $(".uploadifive-button").hide();
            $(".book-add-tool .tip").show();
            $(".book-add-tool .result").hide();
        },
        'onUploadComplete' : function(file, data) {
            $(".uploadifive-button").show();
            $(".book-add-tool .tip").hide();
            $(".book-add-tool .result").show();
            $(".book-add-tool .result .text").text(data);
            var book = JSON.parse(data).book;

            $("#book-add-audio-file").data("key",book.audio);
            $("#book-add-audio-file-show").attr("href","http://res.kidbridge.org/" + book.audio);
            $("#book-add-audio-file-show").show();

            $("input[name='book-name']").val(book.name);
            $("input[name='book-price']").val(0.00);
            $("textarea[name='book-outline']").val(book.outline);
            $("textarea[name='book-feeling']").val(book.feeling);
            $("input[name='book-repeat-active-time']").val(600);
            try{
                for(var i=0;i<book.tag.length;i++){
                    $('.book-tag').tagsinput('add',book.tag[i]);
                }
            }catch (e){

            }
            for(var i=0;i<book.bookSegmentList.length;i++){
                var icon = book.bookSegmentList[i].icon;
                var audio = book.bookSegmentList[i].audio;
                var text = book.bookSegmentList[i].text;
                var html = "";
                html += "<div data-id=\""+(i + 1)+"\" data-icon=\""+icon+"\" data-audio=\""+audio+"\" class=\"list-group-item\">";
                html += "<div class=\"num\">";
                html += (i + 1);
                html += "</div>";
                html += "<div class=\"text\">"+text+"</div>";
                html += "<div class=\"control\">";
                html += "<a href=\"javascript:;\" class=\"edit\">修改</a> | <a href=\"javascript:;\" class=\"del\">删除</a>";
                html += "</div>";
                html += "</div>";
                $(".book-add-segment-list .list-group").show().append(html);
            }
            for(var i = 0;i<book.icon.length;i++){
                var len = $(".image-upload-list .detail").length;
                var icon = book.icon[i];
                var html = "";
                html += "<div class=\"detail text-center\" data-id=\""+len+"\" data-icon=\"http://res.kidbridge.org/"+icon+"\">";
                html += "<input type=\"hidden\" name=\"book-icon\" value=\""+icon+"\" />";
                html += "<img src=\"http://res.kidbridge.org/"+icon+"\" class=\"thumbnail img-responsive\" />";
                html += "<a href=\"http://res.kidbridge.org/"+icon+"\" target='_blank' class=\"btn btn-primary btn-xs view\">查</a>";
                html += "<a href=\"javascript:;\" class=\"btn btn-danger btn-xs book-add-icon-delete\">删</a>";
                html += "<a href=\"javascript:;\" class=\"btn btn-primary btn-xs book-add-icon-edit\">改</a>";
                html += "</div>";
                $(".image-upload-list").append(html);
                $(".image-upload").show();
            }

        }
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
                                html += "<input type=\"hidden\" name=\"book-icon\" value=\""+resp.key+"\" />";
                                html += "<img src=\"http://res.kidbridge.org/"+resp.key+"\" class=\"thumbnail img-responsive\" />";
                                html += "<a href=\"http://res.kidbridge.org/"+resp.key+"\" target='_blank' class=\"btn btn-primary btn-xs view\">查</a>";
                                html += "<a href=\"javascript:;\" class=\"btn btn-danger btn-xs book-add-icon-delete\">删</a>";
                                html += "<a href=\"javascript:;\" class=\"btn btn-primary btn-xs book-add-icon-edit\">改</a>";
                                html += "</div>";
                                $(".image-upload-list").append(html);
                                $(".book-add-icon-upload").val('');
                            }else{
                                var editnode = $(".image-upload-list .detail[data-id="+id+"]");
                                $(editnode).data("icon","http://res.kidbridge.org/"+resp.key);
                                $(editnode).find("input[name='book-icon']").val(resp.key);
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
    $(".book-add-icon-upload").on("change",function () {
        var reader = new FileReader();
        reader.onload = function(e) {
            var data = e.target.result;
            $(".book-add-icon-upload").val('');
            $('#image-cut-a').cropper("destroy").attr('src', data).cropper({
                aspectRatio: 4 / 3,
                zoomable: false,
                dragMode:'none',
                minCropBoxWidth:80,
                autoCropArea:1,
                viewMode:1,
                minContainerWidth:540,
                minContainerHeight:405
            });
            $("#image-cut").modal({
                backdrop: "static"
            },"show");
        };
        reader.readAsDataURL($(this).prop('files')[0]);
    });
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
    if(${not empty book.richText }){
        $.get("http://res.kidbridge.org/${book.richText }",function (resp) {
            $("#summernote").summernote("code", resp);
        });
    }
    $(".book-segment-add-body").on("click",".btn-audio-upload",function () {
        $(".book-segment-audio-file").trigger("click");
    });
    $(".book-segment-audio-file").on("change",function () {
        var $file = $(this);
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
                formData.append("file",$file.prop('files')[0]);
                $.ajax({
                    url: 'http://upload.qiniu.com/' ,
                    type: 'POST',
                    data: formData,
                    async: false,
                    cache: false,
                    contentType: false,
                    processData: false,
                    success: function (resp) {
                        $file.data("key",resp.key);
                    }
                });
            }
        });
    });
    $(".book-segment-add-body").on("click",".book-segment-add-icon-add,.book-segment-icon-edit-o",function () {
        $(".book-segment-icon-file").trigger("click");
    });
    $(".book-segment-icon-file").on("change",function () {
        var $file = $(this);
        var reader = new FileReader();
        reader.onload = function(e) {
            var data = e.target.result;
            $(".book-segment-icon-file").val('');
            var html = "";
            html += "<div>";
            html += "<img id=\"book-segment-icon-cut\">";
            html += "<button type=\"button\" class=\"btn btn-default btn-block book-segment-icon-edit-o\" style=\"margin-top: 5px;\">更换图片</button>";
            html += "</div>";
            $(".book-segment-icon .view").html(html);

            $('#book-segment-icon-cut').cropper("destroy").attr('src', data).cropper({
                aspectRatio: 9 / 5,
                zoomable: false,
                dragMode:'none',
                minCropBoxWidth:80,
                autoCropArea:1,
                viewMode:1,
                minContainerWidth:540,
                minContainerHeight:300
            });

        };
        reader.readAsDataURL($file.prop('files')[0]);


    });
    $(".save").on("click",function () {
        var book = {};
        book.id = $("input[name='book-id']").val();
        book.icon = [];
        $("[name='book-icon']").each(function (i) {
            book.icon.push($(this).val());
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

                        book.richtext = resp.key;
                    }
                });
            }
        });
        book.audio = $("#book-add-audio-file").data("key");
        book.name = $("[name='book-name']").val();
        book.sort = $("[name='book-sort']").val();
        book.outline = $("[name='book-outline']").val();
        book.feeling = $("[name='book-feeling']").val();
        book.fit = $("[name='book-fit']").val();
        book.difficulty = $("[name='book-difficulty']").val();
        book.tag = $('.book-tag').tagsinput('items');
        book.price = $("[name='book-price']").val();
        book.active = $("[name='book-active']").val();
        book.repeatActiveTime = $("[name='book-repeat-active-time']").val();
        book.copyright = {};
        book.copyright.user = {};
        book.copyright.user.id = $("input[name='user-id']").val();
        book.segment = [];
        $(".list-group-item").each(function (i,e) {
            var temp = {};
            temp.icon = $(this).data("icon");
            temp.text = $(this).find(".text").text();
            temp.audio = $(this).data("audio");
            book.segment.push(temp);
        });
        console.log(book);
        $.ajax({
            url :"/book/${empty book.id ? "add" : "edit" }",
            type:"POST",
            async: false,
            data:JSON.stringify(book),
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
                window.location.href = "/book/list";
            }
        });
    });
    $('#book-segment-add').on('hidden.bs.modal', function () {
        var html = "";
        html += "<div class=\"modal-header\">";
        html += "<button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>";
        html += "<h4 class=\"modal-title\">段落新增</h4>";
        html += "</div>";
        html += "<div class=\"modal-body\" style=\"padding-bottom: 20px;\">";
        html += "<div class=\"book-segment-icon add\">";
        html += "<div class=\"view\">";
        html += "<span class=\"fa fa-plus book-segment-add-icon-add\"></span>";
        html += "</div>";
        html += "</div>";
        html += "<div class=\"content\">";
        html += "<textarea class=\"form-control\" name=\"book-segment-text-edit\" rows=\"7\" placeholder=\"请输入跟读章节内容 ~\"></textarea>";
        html += "</div>";
        html += "<div class=\"audio\">";
        html += "<button type=\"button\" class=\"btn btn-default btn-block btn-audio-upload\">音频</button>";
        html += "</div>";
        html += "</div>";
        html += "<div class=\"modal-footer\">";
        html += "<button type=\"button\" class=\"btn btn-default\" data-dismiss=\"modal\" style=\"margin-bottom: 0;\">关闭</button>";
        html += "<button type=\"button\" class=\"btn btn-primary book-segment-add-save\">保存</button>";
        html += "</div>";
        $(".book-segment-add-body").html(html);
    });
    $("#book-segment-add .book-segment-icon").on("mouseover mouseout",function (e) {
        if(e.type === "mouseover"){
            $(".book-segment-icon-edit").show();
        }else{
            $(".book-segment-icon-edit").hide();
        }
    });
    /*$(".book-segment-detail").idleTimer(2000);
    $(".book-segment-detail").on("idle.idleTimer",function(event, elem, obj){
//        if(e.type === "mouseover"){
//            $(this).find(".edit").show();
//        }else{
//            $(this).find(".edit").hide();
//        }
        alert(0);
    });
    $(".book-segment-detail").on("active.idleTimer",function(event, elem, obj, triggerevent){
        alert(1);
    });*/
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
    $('.book-tag').tagsinput({
        tagClass: 'label label-primary',
        maxChars:32,
        trimValue: true
    });
    $('.book-tag').on('itemAdded', function(event) {
        if($(this).tagsinput("items").length > 0){
            $(".bootstrap-tagsinput input").attr("placeholder",null);
        }
    });
    $('.book-tag').on('itemRemoved', function(event) {
        if($(this).tagsinput("items").length == 0){
            $(".bootstrap-tagsinput input").attr("placeholder","多个关键词输入“,”间隔");
        }
    });
    $(".book-add-icon").on("click",function () {
        $(".book-add-icon-upload").trigger("click");
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


    $(".book-segment-add-body").on("click",".book-segment-add-save",function () {
        $.ajax({
            url: "/file/token",
            async: false,
            contentType: "application/json",
            dataType: "json",
            success: function(resp){
                if(resp.event != "SUCCESS"){
                    return;
                }
                var img = $("#book-segment-icon-cut").cropper("getCroppedCanvas",{
                    width:540,
                    height:300
                });
                if(!(typeof img.toBlob === "function")){
                    swal({
                        title: "错误提示",
                        text: "请上传段落缩略图 ~",
                        type: "error",
                        cancelButtonText: "关闭",
                        showCancelButton: true,
                        showConfirmButton: false
                    });
                    return;
                }
                img.toBlob(function (blob) {
                    var formData = new FormData();
                    formData.append("token",resp.data.token);
                    formData.append("file",blob);
                    $.ajax({
                        url: 'http://upload.qiniu.com/' ,
                        type: 'POST',
                        data: formData,
                        async: false,
                        cache: false,
                        contentType: false,
                        processData: false,
                        success: function (resp) {
                            var icon = resp.key;
                            var text = $("[name='book-segment-text-edit']").val();
                            var audio = $("[name='book-segment-audio-edit']").data("key");
                            var len = $(".list-group-item").length;
                            if(text == null || text.trim() == ''){
                                swal({
                                    title: "错误提示",
                                    text: "请输入段落内容 ~",
                                    type: "error",
                                    cancelButtonText: "关闭",
                                    showCancelButton: true,
                                    showConfirmButton: false
                                });
                                return;
                            }
                            if(audio == null || audio.trim() == ''){
                                swal({
                                    title: "错误提示",
                                    text: "请上传段落音频 ~",
                                    type: "error",
                                    cancelButtonText: "关闭",
                                    showCancelButton: true,
                                    showConfirmButton: false
                                });
                                return;
                            }
                            var id = $("#book-segment-add .modal-header").data("id");
                            if(id != undefined){
                                var n = $(".list-group-item[data-id="+id+"]");
                                $(n).data("icon",icon);
                                $(n).data("text",text);
                                $(n).data("audio",audio);
                                $(n).find(".text").text(text);
                            }else{
                                var html = "";
                                html += "<div data-id=\""+(len + 1)+"\" data-icon=\""+icon+"\" data-audio=\""+audio+"\" class=\"list-group-item\">";
                                html += "<div class=\"num\">";
                                html += (len + 1);
                                html += "</div>";
                                html += "<div class=\"text\">"+text+"</div>";
                                html += "<div class=\"control\">";
                                html += "<a href=\"javascript:;\" class=\"edit\">修改</a> | <a href=\"javascript:;\" class=\"del\">删除</a>";
                                html += "</div>";
                                html += "</div>";
                                $(".book-add-segment-list .list-group").show().append(html);
                            }
                            $('#book-segment-add').modal('hide');
                        }
                    });
                },'image/jpeg',0.7);
            }
        });
    });
    $(".book-add-segment-list .list-group").on("click",".control .del",function () {
       $(this).parents(".list-group-item").remove();
       var n =$(".list-group-item");
       if(n.length == 0){
           $(".book-add-segment-list .list-group").hide();
           return;
       }
       for(var i=0;i<n.length;i++){
           $(n[i]).data("id",(i + 1));
           $(n[i]).find(".num").text((i + 1));
       }
    });
    $(".book-add-segment-list .list-group").on("click",".control .edit",function () {
        var t = $(this).parents(".list-group-item");
        var id = $(t).data("id");
        var icon = $(t).data("icon");
        var text = $(t).find(".text").text();
        var audio = $(t).data("audio");
        var html = "";
        html += "<div>";
        html += "<img id=\"book-segment-icon-cut\">";
        html += "<button type=\"button\" class=\"btn btn-default btn-block book-segment-icon-edit-o\" style=\"margin-top: 5px;\">更换图片</button>";
        html += "</div>";
        $(".book-segment-icon .view").html(html);
        $('#book-segment-icon-cut').cropper("destroy").attr('src', "http://res.kidbridge.org/" + icon).cropper({
            aspectRatio: 9 / 5,
            zoomable: false,
            dragMode:'none',
            minCropBoxWidth:80,
            autoCropArea:1,
            viewMode:1,
            minContainerWidth:540,
            minContainerHeight:300
        });
        $("#book-segment-add .modal-header").data("id",id);
        $("#book-segment-add").find("[name='book-segment-text-edit']").val(text);
        $("#book-segment-add").find("[name='book-segment-audio-edit']").data("key",audio);
        $("#book-segment-add").modal({
            backdrop: "static"
        },"show");
    });

</script>
</body>
</html>