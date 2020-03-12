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

        $(function () {

            $.post(
                "${pageContext.request.contextPath}/getImages",
                function (data) {
                    console.log(data);

                    $.each(data,function (i, image) {
                        var div = '<div class="col-lg-4 col-md-6 filter-card">\n' +
                        '            <div class="portfolio-item">\n' +
                        '              <img src="'+image.url+'" class="img-fluid" alt="">\n' +
                        '              <div class="portfolio-info">\n' +
                        '                <h3><a href="'+image.url+'" data-gall="portfolioGallery" class="venobox">'+image.copyright+'</a></h3>\n' +
                        '                <a href="'+image.url+'" data-gall="portfolioGallery" class="venobox" ><i class="icofont-plus"></i></a>\n' +
                        '              </div>\n' +
                        '            </div>\n' +
                        '          </div>';

                        $("#images").append(div);
                    });
                },
                "json"
            );

        });

        function Ranking(type,time) {
            //清空模态框
            $("#RankingTab tr").remove();
            $("#RankingTab").append('<tr>\n' +
                '            <th>名次</th>\n' +
                '            <th>用户名</th>\n' +
                '            <th>来源</th>\n' +
                '            <th>数据</th>\n' +
                '            </tr>');


            $.post(
                "${pageContext.request.contextPath}/statistics/Ranking",
                {
                    "type":type,
                    "time":time
                },
                function (data) {
                    console.log(data)
                    $.each(data,function (i,ranking) {
                        $("#RankingTab tbody").append(
                            "<tr>" +
                            "<td>第"+(i+1)+"名</td>" +
                            "<td>"+ranking.userName+"</td>" +
                            "<td>"+ranking.source+"</td>" +
                            "<td>"+ranking.val+"</td>" +
                            "</tr>"
                        );
                    });
                },
                "json"
            );

            //调用排行榜模态框
            $("#RankingModel").modal({backdrop: 'static', keyboard: false});

        }

    </script>
</head>

<body>

<!-- ======= 导航栏 ======= -->
<header id="header" class="fixed-top ">
    <div class="container">
        <div class="logo float-left">
            <h1 class="text-light"><a href="${pageContext.request.contextPath}/user/gotoMain"><span>巴学园</span></a></h1>
        </div>

        <nav class="nav-menu float-right d-none d-lg-block">
            <ul>
                <li><a href="${pageContext.request.contextPath}/user/gotoMain">在线答题</a></li>
                <li class="drop-down"><a href="">排行榜</a>
                    <ul>
                        <li class="drop-down"><a href="#">今日排行</a>
                            <ul>
                                <li><a onclick="Ranking('Number','today')">按数量</a></li>
                                <li><a onclick="Ranking('Score','today')">按总分</a></li>
                                <li><a onclick="Ranking('Correct','today')">按正确率</a></li>
                            </ul>
                        </li>
                        <li class="drop-down"><a href="#">历史排行</a>
                            <ul>
                                <li><a onclick="Ranking('Number','History')">按数量</a></li>
                                <li><a onclick="Ranking('Score','History')">按总分</a></li>
                                <li><a onclick="Ranking('Correct','History')">按正确率</a></li>
                            </ul>
                        </li>
                    </ul>
                </li>
                <li class="active"><a href="${pageContext.request.contextPath}/gotoPortfolio">美图分享</a></li>
                <li><a href="#">反馈</a></li>
                <li class="drop-down">
                    <a href="">
                        <img style="width: 30px;height: 30px" src="${user.headSculpture}">
                    </a>
                    <ul>
                        <li>
                            <a data-toggle="modal" data-target="#exampleModal">
                                <img src="${pageContext.request.contextPath}/static/image/logo/home.png">
                                个人信息
                            </a>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/statistics/gotoRecord/${user.userId}">
                                <img src="${pageContext.request.contextPath}/static/image/logo/eye.png">
                                个人记录
                            </a>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/statistics/findStatisticsAll">
                                <img src="${pageContext.request.contextPath}/static/image/logo/record.png">
                                全部记录
                            </a>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/user/exit">
                                <img src="${pageContext.request.contextPath}/static/image/logo/detrusion.png">
                                退出
                            </a>
                        </li>
                    </ul>
                </li>
            </ul>
        </nav>

    </div>
</header>

<%--排行榜模态框--%>
<div>
    <!-- 模态框（Modal） -->
    <div class="modal fade" id="RankingModel"  tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" >
                        排行榜仅展示前十名数据
                    </h4>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                </div>
                <div class="modal-body">
                    <table id="RankingTab" class="table table-hover">
                        <tbody>
                        </tbody>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                    </button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal -->
    </div>
</div>


<%--个人信息模态框--%>
<div>
    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <%--关闭--%>
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label class="control-label">用户名</label>
                        <input type="text" class="form-control" value="${user.userName}" disabled >
                    </div>
                    <div class="form-group">
                        <label class="control-label">来源</label>
                        <input type="text" class="form-control" value="${user.source}" disabled >
                    </div>
                    <div class="form-group">
                        <label class="control-label">权限</label>
                        <input type="text" class="form-control" value="${user.grade == 0 ? '管理员':'普通用户'}" disabled >
                        <%--用户id--%>
                        <input type="hidden" id="userId" value="${user.userId}" >
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<main id="main">

    <section class="portfolio">
        <div class="container">
            <div id="images" class="row portfolio-container" data-aos="fade-up" data-aos-easing="ease-in-out" data-aos-duration="500">
                <div class="col-lg-4 col-md-6 filter-app">
                    <div class="portfolio-item">

                    </div>
                </div>
            </div>
        </div>
    </section>

</main><!-- End #main -->



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

</body>

</html>