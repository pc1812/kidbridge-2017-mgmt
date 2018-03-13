<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>首页轮播 | kidbridge manage</title>
    <link href="/resources/css/service/base.css" rel="stylesheet">
    <link href="/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="/resources/font-awesome/css/font-awesome.css" rel="stylesheet">
    <link href="/resources/css/animate.css" rel="stylesheet">
    <link href="/resources/css/style.css" rel="stylesheet">
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
        table {
            table-layout:fixed;
        }
        table tr td {
            white-space:nowrap;
            overflow:hidden;
            text-overflow:ellipsis;
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
                            <h5>首页轮播</h5>
                        </div>
                        <div class="ibox-content">
                            <table class="table table-striped whirligig">
                                <thead>
                                <tr>
                                    <th width="100">编号</th>
                                    <th>图片</th>
                                    <th>跳转链接</th>
                                    <th>添加时间</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:choose>
                                    <c:when test="${not empty whirligigList }">
                                        <c:forEach items="${whirligigList }" var="whirligig">
                                            <tr>
                                                <td width="100">${whirligig.id }</td>
                                                <td>
                                                    <img class="img-responsive center-block img-rounded" src="http://res.kidbridge.org/${whirligig.icon }"/>
                                                </td>
                                                <td>
                                                    <a target="_blank" href="${whirligig.link }">${whirligig.link }</a>
                                                </td>
                                                <td>
                                                    <fmt:formatDate value="${whirligig.createTime }" pattern="yyyy-MM-dd HH:mm:ss" />
                                                </td>
                                                <td>
                                                    <button type="button" data-id="${whirligig.id }" class="btn btn-primary btn-xs whirligig-edit">编辑</button>
                                                    <button type="button" data-id="${whirligig.id }" class="btn btn-danger btn-xs whirligig-del">删除</button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="5">暂无数据 ~</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                                <tfoot>
                                <tr>
                                    <td colspan="5">
                                        <button type="button" class="btn btn-primary pull-left" data-toggle="modal" data-backdrop="static" data-target="#whirligig-edit"><i class="fa fa-plus"></i></button>
                                    </td>
                                </tr>
                                </tfoot>
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
                                                    <a href="/whirligig/list/?page=${page.min }" aria-label="Previous"><i class="fa fa-angle-double-left" aria-hidden="true"></i></a>
                                                </li>
                                                <li>
                                                    <a href="/whirligig/list/?page=${param.page - 1 }" aria-label="Previous"><i class="fa fa-angle-left" aria-hidden="true"></i></a>
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
                                                        <a href="/whirligig/list/?page=${number }">
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
                                                    <a href="/whirligig/list/?page=${empty param.page ? param.page + 1 + 1 : param.page + 1 }" aria-label="Next"><i class="fa fa-angle-right" aria-hidden="true"></i></a>
                                                </li>
                                                <li>
                                                    <a href="/whirligig/list/?page=${page.max }" aria-label="Next"><i class="fa fa-angle-double-right" aria-hidden="true"></i></a>
                                                </li>
                                            </c:otherwise>
                                        </c:choose>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="modal fade" id="whirligig-edit" tabindex="-1" role="dialog">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                        <h4 class="modal-title">新增轮播</h4>
                                    </div>
                                    <div class="modal-body" style="padding-bottom: 10px;">
                                        <input type="hidden" name="whirligig-id" >
                                        <div class="panel panel-default">
                                            <div class="panel-body" style="padding: 0;">
                                                <div class="whirligig-icon">
                                                    <div class="view">
                                                        <i class="fa fa-plus whirligig-add-icon"></i>
                                                    </div>
                                                    <input type="file" style="display: none;" class="whirligig-add-icon-upload" name="upload" accept="image/jpg,image/jpeg,image/png" >
                                                </div>
                                            </div>
                                        </div>
                                        <div class="whirligig-icon-edit" style="margin-bottom: 20px;display: none;">
                                            <button type="button" class="btn btn-block btn-default">修改图片</button>
                                        </div>
                                        <div class="whirligig-link">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">跳转链接</div>
                                                <div class="panel-body">
                                                    <input value="${book.repeatActiveTime }" name="whirligig-link" class="form-control" type="text" placeholder="输入正确的页面链接，以http(s)协议开头 ~" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default" data-dismiss="modal" style="margin-bottom: 0;">关闭</button>
                                        <button type="button" class="btn btn-primary save">保存</button>
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
<script src="/resources/js/plugins/moment/moment.min.js"></script>
<script src="/resources/js/plugins/sweetalert/sweetalert.min.js"></script>
<script src="/resources/js/plugins/cropper/cropper.min.js"></script>
<script src="/resources/js/service/base.js"></script>
<script>
    $(".whirligig-del").on("click",function () {
        var id = $(this).data("id");
        $.ajax({
            type:"POST",
            url:"/whirligig/del",
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
    $(".whirligig-edit").on("click",function () {
        var id = $(this).data("id");
        $.ajax({
            async: false,
            type:"POST",
            url:"/whirligig/get",
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
                var data = resp.data;
                var html = "";
                html += "<img class=\"img-responsive whirligig-add-icon-file\" data-key=\"\" src=\"\">";
                $(".whirligig-icon .view").html(html);
                $('.whirligig-add-icon-file').cropper("destroy").attr('src', "http://res.kidbridge.org/" + data.icon).cropper({
                    aspectRatio: 9 / 5,
                    zoomable: false,
                    dragMode:'none',
                    minCropBoxWidth:80,
                    autoCropArea:1,
                    viewMode:1,
                    minContainerWidth:536,
                    minContainerHeight:298
                });
                $(".whirligig-icon-edit").show();
                $("#whirligig-edit").modal({
                    backdrop: "static"
                },"show");
                $(".whirligig-icon-edit").show();
                $("input[name='whirligig-id']").val(data.id);
                $("input[name='whirligig-link']").val(data.link);
            }
        });
    });
    $(".whirligig-icon").on("click",".whirligig-add-icon",function () {
        $(".whirligig-add-icon-upload").trigger("click");
    });
    $(".whirligig-icon-edit").on("click",function () {
        $(".whirligig-add-icon-upload").trigger("click");
    });
    $('#whirligig-edit').on('hidden.bs.modal', function () {
        var html = "";
        html += "<i class=\"fa fa-plus whirligig-add-icon\"></i>";
        $(".whirligig-icon .view").html(html);
        $("input[name='whirligig-id']").val('');
        $("input[name='whirligig-link']").val('');
        $(".whirligig-icon-edit").hide();
    });
    $(".whirligig-add-icon-upload").on("change",function () {
        var reader = new FileReader();
        reader.onload = function(e) {
            var data = e.target.result;
            $(".whirligig-add-icon-upload").val('');
            var html = "";
            html += "<img class=\"img-responsive whirligig-add-icon-file\" data-key=\"\" src=\"\">";
            $(".whirligig-icon .view").html(html);
            $('.whirligig-add-icon-file').cropper("destroy").attr('src', data).cropper({
                aspectRatio: 9 / 5,
                zoomable: false,
                dragMode:'none',
                minCropBoxWidth:80,
                autoCropArea:1,
                viewMode:1,
                minContainerWidth:536,
                minContainerHeight:298
            });
            $(".whirligig-icon-edit").show();
        };
        reader.readAsDataURL($(this).prop('files')[0]);
    });
    $(".save").on("click",function () {
        var whirligig = {};
        whirligig.id = $("input[name='whirligig-id']").val();
        whirligig.link = $("input[name='whirligig-link']").val();
        whirligig.icon = "";
        $.ajax({
            url: "/file/token",
            async: false,
            contentType: "application/json",
            dataType: "json",
            success: function(resp){
                if(resp.event != "SUCCESS"){
                    return;
                }
                var img = $(".whirligig-add-icon-file").cropper("getCroppedCanvas",{
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
                            whirligig.icon =  resp.key;
                            $.ajax({
                                async: false,
                                url: "/whirligig/" + (whirligig.id == ''? "add":"edit"),
                                type:"POST",
                                data:JSON.stringify(whirligig),
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
                                    window.location.href = "/whirligig/list";
                                }
                            });
                        }
                    });
                },'image/jpeg',0.7);
            }
        });
    });
</script>
</body>
</html>