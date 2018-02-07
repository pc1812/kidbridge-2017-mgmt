<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<nav class="navbar-default navbar-static-side" role="navigation">
    <div class="sidebar-collapse">
        <ul class="nav metismenu" id="side-menu">
            <li class="nav-header">
                <div class="dropdown profile-element">
                    <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                            <span class="clear"> <span class="block m-t-xs"> <strong class="font-bold">超级管理员</strong>
                             </span>  </span> </a>
                    <ul class="dropdown-menu m-t-xs">
                        <li><a href="/">首　　页</a></li>
                        <li><a href="/logout">退出登录</a></li>
                    </ul>
                </div>
                <div class="logo-element">
                    IN-
                </div>
            </li>
            <li${fn:contains(requestScope["javax.servlet.forward.servlet_path"].toString(), "/user/") ? " class=\"active\"" : ""}>
                <a href="javascript:">
                    <i class="fa fa-user-circle-o"></i>
                    <span class="nav-label">用户管理</span>
                    <span class="fa arrow"></span>
                </a>
                <ul class="nav nav-second-level collapse">
                    <li${fn:contains(requestScope["javax.servlet.forward.servlet_path"].toString(), "/user/list") ? " class=\"active\"" : "" }><a href="/user/list"><i class="fa fa-list"></i>用户列表</a></li>
                </ul>
            </li>
            <li${fn:contains(requestScope["javax.servlet.forward.servlet_path"].toString(), "/teacher/") ? " class=\"active\"" : ""}>
                <a href="javascript:">
                    <i class="fa fa-user-circle-o"></i>
                    <span class="nav-label">教师管理</span>
                    <span class="fa arrow"></span>
                </a>
                <ul class="nav nav-second-level collapse">
                    <li${fn:contains(requestScope["javax.servlet.forward.servlet_path"].toString(), "/teacher/list") ? " class=\"active\"" : "" }><a href="/teacher/list"><i class="fa fa-list"></i>教师列表</a></li>
                </ul>
            </li>
            <li${fn:contains(requestScope["javax.servlet.forward.servlet_path"].toString(), "/book/") ? " class=\"active\"" : ""}>
                <a href="javascript:">
                    <i class="fa fa-book"></i>
                    <span class="nav-label">绘本管理</span>
                    <span class="fa arrow"></span>
                </a>
                <ul class="nav nav-second-level collapse">
                    <li${fn:contains(requestScope["javax.servlet.forward.servlet_path"].toString(), "/book/list") ? " class=\"active\"" : "" }><a href="/book/list"><i class="fa fa-list"></i>绘本列表</a></li>

                    <c:if test="${fn:contains(requestScope['javax.servlet.forward.servlet_path'],'/book/detail' ) }">
                        <li class="active"><a href="javascript:"><i class="fa fa-list"></i>绘本详情</a></li>
                    </c:if>

                    <li${requestScope["javax.servlet.forward.servlet_path"] eq "/book/add" ? " class=\"active\"" : "" }><a href="/book/add"><i class="fa fa-file"></i>绘本新增</a></li>

                    <c:if test="${fn:contains(requestScope['javax.servlet.forward.servlet_path'], '/book/edit') }">
                        <li class="active"><a href="javascript:"><i class="fa fa-edit"></i>绘本编辑</a></li>
                    </c:if>
                </ul>
            </li>
            <li${fn:contains(requestScope["javax.servlet.forward.servlet_path"].toString(), "/course/") ? " class=\"active\"" : ""}>
                <a href="javascript:">
                    <i class="fa fa-book"></i>
                    <span class="nav-label">课程管理</span>
                    <span class="fa arrow"></span>
                </a>
                <ul class="nav nav-second-level collapse">
                    <li${fn:contains(requestScope["javax.servlet.forward.servlet_path"].toString(), "/course/list") ? " class=\"active\"" : "" }><a href="/course/list"><i class="fa fa-list"></i>课程列表</a></li>

                    <c:if test="${fn:contains(requestScope['javax.servlet.forward.servlet_path'], '/course/detail') }">
                        <li class="active"><a href="javascript:"><i class="fa fa-list"></i>课程详情</a></li>
                    </c:if>

                    <li${requestScope["javax.servlet.forward.servlet_path"] eq "/course/add" ? " class=\"active\"" : "" }><a href="/course/add"><i class="fa fa-file"></i>课程新增</a></li>

                    <c:if test="${fn:contains(requestScope['javax.servlet.forward.servlet_path'],'/course/edit' ) }">
                        <li class="active"><a href="javascript:"><i class="fa fa-edit"></i>课程编辑</a></li>
                    </c:if>
                </ul>
            </li>
            <li${fn:contains(requestScope["javax.servlet.forward.servlet_path"].toString(), "/bookshelf/") ? " class=\"active\"" : ""}>
                <a href="javascript:">
                    <i class="fa fa-book"></i>
                    <span class="nav-label">书单管理</span>
                    <span class="fa arrow"></span>
                </a>
                <ul class="nav nav-second-level collapse">
                    <li${fn:contains(requestScope["javax.servlet.forward.servlet_path"].toString(), "/bookshelf/list") ? " class=\"active\"" : "" }><a href="/bookshelf/list"><i class="fa fa-list"></i>书单列表</a></li>

                    <c:if test="${fn:contains(requestScope['javax.servlet.forward.servlet_path'], '/bookshelf/detail') }">
                        <li class="active"><a href="javascript:"><i class="fa fa-list"></i>书单详情</a></li>
                    </c:if>

                    <li${requestScope["javax.servlet.forward.servlet_path"] eq "/bookshelf/add" ? " class=\"active\"" : "" }><a href="/bookshelf/add"><i class="fa fa-file"></i>书单新增</a></li>

                    <c:if test="${fn:contains(requestScope['javax.servlet.forward.servlet_path'],'/bookshelf/edit' ) }">
                        <li class="active"><a href="javascript:"><i class="fa fa-edit"></i>书单编辑</a></li>
                    </c:if>
                </ul>
            </li>
            <li${fn:contains(requestScope["javax.servlet.forward.servlet_path"].toString(), "/article/") ? " class=\"active\"" : ""}>
                <a href="javascript:">
                    <i class="fa fa-book"></i>
                    <span class="nav-label">文章管理</span>
                    <span class="fa arrow"></span>
                </a>
                <ul class="nav nav-second-level collapse">
                    <li${fn:contains(requestScope["javax.servlet.forward.servlet_path"].toString(), "/article/list") ? " class=\"active\"" : "" }><a href="/article/list"><i class="fa fa-list"></i>文章列表</a></li>

                    <li${requestScope["javax.servlet.forward.servlet_path"] eq "/article/add" ? " class=\"active\"" : "" }><a href="/article/add"><i class="fa fa-file"></i>文章新增</a></li>

                    <c:if test="${fn:contains(requestScope['javax.servlet.forward.servlet_path'],'/article/edit' ) }">
                        <li class="active"><a href="javascript:"><i class="fa fa-edit"></i>文章编辑</a></li>
                    </c:if>
                </ul>
            </li>
            <li${fn:contains(requestScope["javax.servlet.forward.servlet_path"].toString(), "/whirligig/") ? " class=\"active\"" : ""}>
                <a href="/whirligig/list">
                    <i class="fa fa-book"></i>
                    <span class="nav-label">首页轮播</span>
                </a>
            </li>
            <li${fn:contains(requestScope["javax.servlet.forward.servlet_path"].toString(), "/feedback/") ? " class=\"active\"" : ""}>
                <a href="/feedback/list">
                    <i class="fa fa-book"></i>
                    <span class="nav-label">意见反馈</span>
                </a>
            </li>
            <li${fn:contains(requestScope["javax.servlet.forward.servlet_path"].toString(), "/setting/") ? " class=\"active\"" : ""}>
                <a href="/setting/list">
                    <i class="fa fa-gear"></i>
                    <span class="nav-label">系统设置</span>
                </a>
            </li>
        </ul>

    </div>
</nav>

