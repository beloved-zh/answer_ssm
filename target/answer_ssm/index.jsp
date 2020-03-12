<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <title>巴学园</title>
    <meta content="" name="descriptison">
    <meta content="" name="keywords">



    <!-- css文件 -->
    <link href="${pageContext.request.contextPath}/static/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/assets/vendor/animate.css/animate.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/assets/vendor/icofont/icofont.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/assets/vendor/venobox/venobox.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/assets/vendor/owl.carousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/assets/vendor/aos/aos.css" rel="stylesheet">
    <!-- css主文件 -->
    <link href="${pageContext.request.contextPath}/static/assets/css/style.css" rel="stylesheet">

    <style>
        .nav-menu img{
            width: 30px;
            height: 30px;
        }
    </style>
    <script src="${pageContext.request.contextPath}/static/js/jquery-3.4.1.js"></script>

    <script>
        //调用提示模态框方法
        function alert(data){
            $("#alert").html(data);
            $("#alertModel").modal({backdrop: 'static', keyboard: false});
        }

        $(function () {
            <%--bootstrap提示工具--%>
            $("[data-toggle='tooltip']").tooltip();

            <%-- 获取session中的提示信息 --%>
            var msg  = '<%= session.getAttribute("msg")%>';

            if (msg !== "null"){
                alert(msg);
            }

            <%--获取必应每日一图接口--%>
            $.post(
                "${pageContext.request.contextPath}/getImage",
                function (data) {
                    console.log(data);
                    $("body").css("background-image","url("+data.url+")");
                },
                "json"
            );
        });
    </script>
</head>

<body>

<!-- ======= 导航栏 ======= -->
<header id="header" class="fixed-top header-transparent">
    <div class="container">
        <div class="logo float-left">
            <h1 class="text-light">
                <a href="${pageContext.request.contextPath}/index.jsp">
                    <span>巴学园</span>
                </a>
            </h1>
        </div>

        <nav class="nav-menu float-right d-none d-lg-block">
            <ul>
                <li>
                    <a data-toggle="modal" data-target="#exampleModal" >
                        <img src="${pageContext.request.contextPath}/static/image/logo/login.png">
                    </a>
                </li>
                <li>
                    <a href="#">
                        <img src="${pageContext.request.contextPath}/static/image/logo/QQ.png">
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/github/gotoGithubLogin" data-toggle="tooltip" data-placement="right" title="GitHub登录，有几率网络问题，登录失败">
                        <img src="${pageContext.request.contextPath}/static/image/logo/github.png">
                    </a>
                </li>
            </ul>
        </nav>
    </div>
</header>

<!-- ======= main ======= -->
<section id="hero" class="d-flex justify-cntent-center align-items-center">
    <div id="heroCarousel" class="container carousel carousel-fade" data-ride="carousel">

        <!--  1 -->
        <div class="carousel-item active">
            <div class="carousel-container">
                <h1><p class="text-left">人人都爱小豆豆</p></h1>
                <h1><p class="text-left">人人都渴望拥有巴学园</p></h1>
                <p class="text-right">____黑柳彻子
                    <a href="https://www.sbkk88.com/mingzhu/waiguowenxuemingzhu/chuangbiandexiaodoudou/">
                        《窗边的小豆豆》
                    </a>
                </p>
            </div>
        </div>
    </div>
</section>

<%--登录模态框--%>
<div>
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <%--关闭--%>
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            </div>
            <form action="${pageContext.request.contextPath}/user/login/" method="post">
                <div class="modal-body">
                        <div class="form-group">
                            <label for="recipient-name" class="control-label">用户名</label>
                            <input type="text" name="userNo" class="form-control" id="recipient-name">
                        </div>
                        <div class="form-group">
                            <label for="password-text" class="control-label">密码</label>
                            <input type="password" name="password" class="form-control" id="password-text"></input>
                        </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="submit" class="btn btn-primary">登录</button>
                </div>
            </form>
        </div>
    </div>
</div>
</div>
<%--回顶--%>
<a href="#" class="back-to-top"><i class="icofont-simple-up"></i></a>

<!-- js文件 -->
<script src="${pageContext.request.contextPath}/static/assets/vendor/jquery/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/static/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/static/assets/vendor/jquery.easing/jquery.easing.min.js"></script>
<script src="${pageContext.request.contextPath}/static/assets/vendor/php-email-form/validate.js"></script>
<script src="${pageContext.request.contextPath}/static/assets/vendor/venobox/venobox.min.js"></script>
<script src="${pageContext.request.contextPath}/static/assets/vendor/waypoints/jquery.waypoints.min.js"></script>
<script src="${pageContext.request.contextPath}/static/assets/vendor/counterup/counterup.min.js"></script>
<script src="${pageContext.request.contextPath}/static/assets/vendor/owl.carousel/owl.carousel.min.js"></script>
<script src="${pageContext.request.contextPath}/static/assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
<script src="${pageContext.request.contextPath}/static/assets/vendor/aos/aos.js"></script>
<!-- js主文件 -->
<script src="${pageContext.request.contextPath}/static/assets/js/main.js"></script>
<%--
提示信息模态框
放在最后解决多级模态框优先级冲突问题
--%>
<div>
    <!-- 模态框 -->
    <div class="modal fade" id="alertModel">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <!-- 模态框头部 -->
                <div class="modal-header">
                    <h4 class="modal-title">错误</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <!-- 模态框主体 -->
                <div class="modal-body" id="alert">
                </div>
                <!-- 模态框底部 -->
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                </div>

            </div>
        </div>
    </div>
</div>
</body>

</html>