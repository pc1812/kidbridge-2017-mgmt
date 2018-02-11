<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>意见反馈 | kidbridge manage</title>
    <link href="/resources/css/service/base.css" rel="stylesheet">
    <link href="/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="/resources/font-awesome/css/font-awesome.css" rel="stylesheet">
    <link href="/resources/css/animate.css" rel="stylesheet">
    <link href="/resources/css/style.css" rel="stylesheet">
    <link href="/resources/css/plugins/sweetalert/sweetalert.css" rel="stylesheet">
    <link href="/resources/css/service/base.css" rel="stylesheet">
    <link href="/resources/css/ydui.css" rel="stylesheet">
    <style type="text/css">
        .m-toast.none-icon {
            padding-top:20px;
        }
    </style>
</head>
<body>
<div id="wrapper">

    <jsp:include page="/WEB-INF/view/templet/navigation.jsp" />

    <div id="page-wrapper" class="gray-bg">
        <div class="wrapper wrapper-content" style="max-width: 600px;margin: 0 auto;">
            <div class="row">
                <div class="col-lg-12">
                    <div class="ibox float-e-margins">
                        <div class="ibox-title">
                            <h5>版本管理</h5>
                        </div>
                        <div class="ibox-content">
                            <div class="panel panel-default">
                                <div class="panel-heading">IOS端</div>
                                <div class="panel-body">
                                    IOS端会自动获取App Store中的最新版本信息，进行提示更新。
                                </div>
                            </div>
                            <div class="panel panel-default" style="margin-bottom: 0;">
                                <div class="panel-heading">Android端</div>
                                <div class="panel-body">
                                    <div class="input-group">
                                        <span class="input-group-addon">版本编号</span>
                                        <input type="text" class="form-control" placeholder="请选择APK文件" value="${version.number }" readonly>
                                    </div>
                                    <div class="input-group" style="margin-top: 10px;">
                                        <input type="file" accept="application/vnd.android.package-archive" style="display: none;" id="file" name="file">
                                        <div class="input-group-addon">版本文件</div>
                                        <input type="text" class="form-control" value="http://res.kidbridge.org/${version.content }" placeholder="请选择APK文件" readonly>
                                        <a class="input-group-addon" id="select-file">
                                            选择
                                        </a>
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
<script src="/resources/js/service/base.js"></script>
<script src="/resources/js/ydui.js"></script>
<script>
    //YDUI.dialog.loading.open('很快加载好了');
    $(".feedback-detail").on("click",function () {
        var content = $(this).data("content");
        $("#feedback-detail .content").html(content);
        $("#feedback-detail").modal({
            backdrop: "static"
        },"show");
    });
    $("#select-file").on("click",function () {
        $("#file").trigger("click");
    });
    $("#file").on("change",function (e) {
        var file = e.target.files[0];
        var formData = new FormData();
        formData.append("file",file);
        YDUI.dialog.loading.open('上传中，请稍后 ~');
        $.ajax({
            url: '/file/apkUpload' ,
            type: 'POST',
            data: formData,
            cache: false,
            contentType: false,
            processData: false,
            success: function (resp) {
                YDUI.dialog.loading.close();
                window.location.reload();
            }
        });
    });
</script>
</body>
</html>