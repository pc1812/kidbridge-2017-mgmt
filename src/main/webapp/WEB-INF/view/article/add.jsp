<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>文章新增 | kidbridge manage</title>
    <link href="/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="/resources/font-awesome/css/font-awesome.css" rel="stylesheet">
    <link href="/resources/css/animate.css" rel="stylesheet">
    <link href="/resources/css/style.css" rel="stylesheet">
    <link href="/resources/css/plugins/summernote/summernote.css" rel="stylesheet">
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
                                文章新增
                            </h5>
                        </div>
                        <div class="ibox-content">
                            <div class="article-view center-block">
                                <input type="hidden" name="article-id" value="${article.id }">
                                <div class="title">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">文章标题</div>
                                        <div class="panel-body">
                                            <input value="${article.title }" name="article-title" class="form-control" type="text" placeholder="起个名字吧 ~" />
                                        </div>
                                    </div>
                                </div>
                                <div class="article-content">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">文章正文</div>
                                        <div class="panel-body">
                                            <div id="summernote"></div>
                                        </div>
                                    </div>
                                </div>
                                <button type="button" class="btn btn-primary btn-block save">保　　存</button>
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
<script src="/resources/js/plugins/summernote/summernote.min.js"></script>
<script src="/resources/js/plugins/summernote/summernote-zh-CN.js"></script>
<script src="/resources/js/plugins/sweetalert/sweetalert.min.js"></script>
<script src="/resources/js/service/base.js"></script>
<script>
    if(${not empty article.content }){
        $.get("http://res.kidbridge.org/${article.content }",function (resp) {
            $("#summernote").summernote("code", resp);
        });
    }
    $(".save").on("click",function () {
        var article = {};
        article.id = $("input[name='article-id']").val();
        article.title = $("input[name='article-title']").val();
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
                        article.content = resp.key;
                    }
                });
            }
        });
        $.ajax({
            url: "/article/${empty article.id ? "add" : "edit" }",
            type:"POST",
            data:JSON.stringify(article),
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
                window.location.href = "/article/list";
            }
        });
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
    $('#summernote').summernote({
        lang:'zh-CN',
        tabsize: 2,
        height: 400,
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
</script>
</body>
</html>