<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>书单新增 | kidbridge manage</title>
    <link href="/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="/resources/font-awesome/css/font-awesome.css" rel="stylesheet">
    <link href="/resources/css/animate.css" rel="stylesheet">
    <link href="/resources/css/style.css" rel="stylesheet">
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
                                书单新增
                            </h5>
                        </div>
                        <div class="ibox-content">
                            <div class="bookshelf-view center-block">
                                <input type="hidden" name="bookshelf-id" value="${bookshelf.id }">
                                <div class="bookshelf-head">
                                    <div class="panel panel-default">
                                        <div class="panel-body" style="padding: 0;">
                                            <div class="bookshelf-icon">
                                                <div class="view">
                                                    <c:choose>
                                                        <c:when test="${not empty bookshelf.icon }">
                                                            <div style="position: relative;">
                                                                <img class="img-responsive bookshelf-add-icon-file" data-key="${bookshelf.icon }" src="http://res.kidbridge.org/${bookshelf.icon }">
                                                                <div class="bookshelf-icon-edit" style="display: none;">
                                                                    <button type="button" class="btn btn-primary">修改</button>
                                                                </div>
                                                            </div>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <i class="fa fa-plus bookshelf-add-icon"></i>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <input type="file" style="display: none;" class="bookshelf-add-icon-upload" name="upload" accept="image/jpg,image/jpeg,image/png" >
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="bookshelf-body">
                                    <div class="bookshelf-outline">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">书单名称</div>
                                            <div class="panel-body">
                                                <input value="${bookshelf.name }" class="form-control" name="bookshelf-name" type="text" placeholder="叫什么名字好呢 ~" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="bookshelf-fit">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">适合年龄</div>
                                            <div class="panel-body">
                                                <select class="form-control" name="bookshelf-fit">
                                                    <option value="0"${bookshelf.fit eq 0 ? " selected=\"selected\"" : "" }>3-5岁</option>
                                                    <option value="1"${bookshelf.fit eq 1 ? " selected=\"selected\"" : "" }>6-8岁</option>
                                                    <option value="2"${bookshelf.fit eq 2 ? " selected=\"selected\"" : "" }>9-12岁</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="bookshelf-tag">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">关键词</div>
                                            <div class="panel-body">
                                                <input value="${fn:join(bookshelf.tag.toArray(), ", ") }" class="bookshelf-tag-input" type="text" placeholder="${empty bookshelf.tag ? "多个关键词输入“,”间隔" : "" }" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="bookshelf-cover">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">导航封面</div>
                                            <div class="panel-body">
                                                <div class="view" style="margin-bottom: 10px;display: ${empty bookshelf.cover ? "none" : "block" }">
                                                    <a target="_blank" href="">
                                                        <img data-link="${bookshelf.cover.link }" data-key="${bookshelf.cover.icon }" class="img-responsive" src="http://res.kidbridge.org/${bookshelf.cover.icon }">
                                                    </a>
                                                </div>
                                                <button type="button" class="btn btn-default btn-block" data-toggle="modal" data-backdrop="static" data-target="#bookshelf-cover"><i class="fa fa-search-plus"></i></button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="bookshelf-book">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">绘本目录</div>
                                            <div class="panel-body">
                                                <div class="bookshelf-book-list" style="margin: 0 auto;">
                                                    <div class="list-group" style="display: ${empty bookshelf.bookList ? "none" : "block" }">
                                                        <c:forEach items="${bookshelf.bookList }" var="book" varStatus="status">
                                                            <div class="list-group-item" data-id="${book.id }">
                                                                <div class="text_1">${status.index + 1 }. ${book.name }</div>
                                                                <div class="control">
                                                                    <a href="javascript:" class="del">删除</a>
                                                                </div>
                                                            </div>
                                                        </c:forEach>
                                                    </div>
                                                    <div>
                                                        <button type="button" class="btn btn-default btn-block" data-toggle="modal" data-backdrop="static" data-target="#bookshelf-book-add"><i class="fa fa-plus"></i></button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <button type="button" class="btn btn-primary btn-block save">保　　存</button>
                                    <div class="modal fade" id="bookshelf-book-add" tabindex="-1" role="dialog">
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
                                    <div class="modal fade" id="bookshelf-cover" tabindex="-1" role="dialog">
                                        <div class="modal-dialog" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                    <h4 class="modal-title">封面添加</h4>
                                                </div>
                                                <div class="modal-body body" style="padding-bottom: 20px;">
                                                    <div class="bookshelf-cover-link">
                                                        <div class="panel panel-default">
                                                            <div class="panel-heading">链接地址</div>
                                                            <div class="panel-body">
                                                                <input class="form-control" type="text" placeholder="输入点击封面跳转的链接地址，示例：http://www.51zhiyuan.net" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="bookshelf-cover-icon">
                                                        <div class="panel panel-default">
                                                            <div class="panel-heading">封面图片</div>
                                                            <div class="panel-body">
                                                                <div class="view">
                                                                    <i class="fa fa-plus bookshelf-cover-add-icon"></i>
                                                                </div>
                                                                <input type="file" style="display: none;" class="bookshelf-cover-icon-upload" name="upload" accept="image/jpg,image/jpeg,image/png" >
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-default" data-dismiss="modal" style="margin-bottom: 0;">关闭</button>
                                                    <button type="button" class="btn btn-primary bookshelf-cover-save">保存</button>
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
<script src="/resources/js/plugins/bootstrap-tagsinput/bootstrap-tagsinput.js"></script>
<script src="/resources/js/plugins/sweetalert/sweetalert.min.js"></script>
<script src="/resources/js/plugins/cropper/cropper.min.js"></script>
<script src="/resources/js/service/base.js"></script>
<script>
    $(".save").on("click",function () {
        var bookshelf = {};
        bookshelf.id = $("input[name='bookshelf-id']").val();
        bookshelf.icon = $(".bookshelf-add-icon-file").length == 0 ? "" : $(".bookshelf-add-icon-file").data("key");
        bookshelf.name = $("input[name='bookshelf-name']").val();
        bookshelf.fit = $("select[name='bookshelf-fit']").val();
        bookshelf.tag = $(".bookshelf-tag-input").tagsinput("items");
        bookshelf.cover = {};
        bookshelf.cover.icon = $(".bookshelf-cover .view img").data("key");
        bookshelf.cover.link = $(".bookshelf-cover .view img").data("link");
        bookshelf.book = [];
        $(".bookshelf-book-list .list-group-item").each(function () {
            bookshelf.book.push($(this).data("id"));
        });
        $.ajax({
            url: "/bookshelf/${empty bookshelf.id ? "add" : "edit" }",
            type:"POST",
            data:JSON.stringify(bookshelf),
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
                window.location.href = "/bookshelf/list";
            }
        });
    });
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
        var len = $(".bookshelf-book-list .list-group .list-group-item").length;
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
        $(".bookshelf-book-list .list-group").append(html);
        $(".bookshelf-book-list .list-group").show();
    });
    $(".bookshelf-book-list .list-group").on("click",".del",function () {
        $(this).parents(".list-group-item").remove();
        if($(".bookshelf-book-list .list-group .list-group-item").length == 0){
            $(".bookshelf-book-list .list-group").hide();
        }
    });
    $('#bookshelf-book-add').on('hidden.bs.modal', function () {
        $(".book-search input").val("");
        $(".book-search-result table tbody").html("");
        $(".book-search-result table").hide();
        $(".book-search-result .pageblock").hide();
        $(".book-search-result .pageblock .pagination").html('');
    });
    $(".bookshelf-cover-save").on("click",function () {
        var l = $(".bookshelf-cover-link input").val();
        if(l == undefined || l == ''){
            swal({
                title: "错误提示",
                text: "请输入链接地址 ~",
                type: "error",
                cancelButtonText: "关闭",
                showCancelButton: true,
                showConfirmButton: false
            });
            return;
        }
        $.ajax({
            url: "/file/token",
            async: false,
            contentType: "application/json",
            dataType: "json",
            success: function(resp){
                if(resp.event != "SUCCESS"){
                    return;
                }
                var img = $("#bookshelf-cover-icon-cut").cropper("getCroppedCanvas",{
                    width:540,
                    height:300
                });
                if(!(typeof img.toBlob === "function")){
                    swal({
                        title: "错误提示",
                        text: "请上传缩略图 ~",
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
                        async: false,
                        url: 'http://upload.qiniu.com/' ,
                        type: 'POST',
                        data: formData,
                        async: false,
                        cache: false,
                        contentType: false,
                        processData: false,
                        success: function (resp) {
                            var link = $(".bookshelf-cover-link input").val();
                            var icon =  resp.key;
                            if(link == '' || icon == ''){
                                return;
                            }
                            var html = "";
                            html += "<a target=\"_blank\" href=\""+link+"\">";
                            html += "<img data-link=\""+link+"\" data-key=\""+icon+"\" class=\"img-responsive\" src=\"http://res.kidbridge.org/"+icon+"\">";
                            html += "</a>";
                            $(".bookshelf-cover .view").html(html);
                            $("#bookshelf-cover").modal("hide");
                            $(".bookshelf-cover .view").show();
                        }
                    });
                },'image/jpeg',0.7);
            }
        });
    });
    $('#bookshelf-cover').on("hidden.bs.modal", function () {
        var html = "";
        html += "<div class=\"bookshelf-cover-link\">";
        html += "<div class=\"panel panel-default\">";
        html += "<div class=\"panel-heading\">链接地址</div>";
        html += "<div class=\"panel-body\">";
        html += "<input class=\"form-control\" type=\"text\" placeholder=\"输入点击封面跳转的链接地址，示例：http://www.51zhiyuan.net\" />";
        html += "</div>";
        html += "</div>";
        html += "</div>";
        html += "<div class=\"bookshelf-cover-icon\">";
        html += "<div class=\"panel panel-default\">";
        html += "<div class=\"panel-heading\">封面图片</div>";
        html += "<div class=\"panel-body\">";
        html += "<div class=\"view\">";
        html += "<i class=\"fa fa-plus bookshelf-cover-add-icon\"></i>";
        html += "</div>";
        html += "<input type=\"file\" style=\"display: none;\" class=\"bookshelf-cover-icon-upload\" name=\"upload\" accept=\"image/jpg,image/jpeg,image/png\" >";
        html += "</div>";
        html += "</div>";
        html += "</div>";
        $("#bookshelf-cover .body").html(html);
    });
    $(".bookshelf-icon .view").on("mouseover mouseout",function (e) {
        if(e.type === "mouseover"){
            $(".bookshelf-icon-edit").show();
        }else{
            $(".bookshelf-icon-edit").hide();
        }
    });
    $(".bookshelf-tag-input").tagsinput({
        tagClass: 'label label-primary',
        maxChars:32,
        trimValue: true
    });
    $(".bookshelf-tag-input").on('itemAdded', function(event) {
        if($(this).tagsinput("items").length > 0){
            $(".bootstrap-tagsinput input").attr("placeholder",null);
        }
    });
    $(".bookshelf-tag-input").on('itemRemoved', function(event) {
        if($(this).tagsinput("items").length == 0){
            $(".bootstrap-tagsinput input").attr("placeholder","多个关键词输入“,”间隔");
        }
    });
    $(".bookshelf-icon .view").on("click",".bookshelf-add-icon, .bookshelf-icon-edit button",function () {
        $(".bookshelf-add-icon-upload").trigger("click");
    });
    $("#bookshelf-cover .body").on("click",".bookshelf-cover-add-icon, .bookshelf-cover-icon-edit-o",function () {
        $(".bookshelf-cover-icon-upload").trigger("click");
    });
    $("#bookshelf-cover").on("change",".bookshelf-cover-icon-upload", function () {
        var reader = new FileReader();
        reader.onload = function(e) {
            var data = e.target.result;
            $(".bookshelf-cover-icon-upload").val('');
            var html = "";
            html += "<div>";
            html += "<img id=\"bookshelf-cover-icon-cut\">";
            html += "<button type=\"button\" class=\"btn btn-default btn-block bookshelf-cover-icon-edit-o\" style=\"margin-top: 5px;\">更换图片</button>";
            html += "</div>";
            $(".bookshelf-cover-icon .view").html(html);
            $('#bookshelf-cover-icon-cut').cropper("destroy").attr('src', data).cropper({
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
        reader.readAsDataURL($(this).prop('files')[0]);
    });
    $(".image-cut-save").on("click",function () {
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
                            var html = "";
                            html += "<div style=\"position: relative;\">";
                            html += "<img class=\"img-responsive bookshelf-add-icon-file\" data-key=\""+resp.key+"\" src=\"http://res.kidbridge.org/"+resp.key+"\">";
                            html += "<div class=\"bookshelf-icon-edit\" style=\"display: none;\">";
                            html += "<button type=\"button\" class=\"btn btn-primary\">修改</button>";
                            html += "</div>";
                            html += "</div>";
                            $(".bookshelf-icon .view").html(html);
                            $(".book-add-icon-upload").val('');
                            $("#image-cut").modal("hide");
                        }
                    });
                },'image/jpeg',0.7);
            }
        });
    });
    $(".bookshelf-add-icon-upload").on("change",function () {
        var reader = new FileReader();
        reader.onload = function(e) {
            var data = e.target.result;
            $(".bookshelf-add-icon-upload").val('');
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
</script>
</body>
</html>