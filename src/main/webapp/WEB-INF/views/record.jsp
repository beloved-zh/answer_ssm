<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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


        function findByQids(data,sid) {
            console.log(data.value);
            var qidStr = data.value;
            var qids = qidStr.split(",");
            console.log(qids);
            //处理ajax传递数组会自动在参数名后加[]
            jQuery.ajaxSettings.traditional = true;
            $.post(
                "${pageContext.request.contextPath}/question/findByQids",
                {"qids":qids},
                function (data) {
                    console.log(data)
                    //清空模态框
                    $("#answerMain tr").remove();

                    //获取自选答案
                    var myanswerStr = $("#myanswer"+sid+"").val();
                    var myanswer = myanswerStr.split(",");

                    $.each(data,function (i,q) {

                        if (myanswer[i] == q.answer) {
                            $("#answerMain").append(
                                "<tr><td>"+(i+1)+"</td><td>"+q.questionText+"</td></tr>"
                            );
                            $("#answerMain").append(
                                "<tr><td></td><td><label for='A"+q.questionId+"' style='width: 100%;height: 100%;margin: 0'>A："+q.answer_a+"</label></td></tr>"
                            );
                            $("#answerMain").append(
                                "<tr><td></td><td><label for='B"+q.questionId+"' style='width: 100%;height: 100%;margin: 0'>B："+q.answer_b+"</label></td></tr>"
                            );
                            $("#answerMain").append(
                                "<tr><td></td><td><label for='C"+q.questionId+"' style='width: 100%;height: 100%;margin: 0'>C："+q.answer_c+"</label></td></tr>"
                            );
                            $("#answerMain").append(
                                "<tr><td></td><td><label for='D"+q.questionId+"' style='width: 100%;height: 100%;margin: 0'>D："+q.answer_d+"</label></td></tr>"
                            );
                            $("#answerMain").append(
                                "<tr style='background-color: #eceaea'><td></td><td><span style='color: #007bff'>【回答正确】正确答案:"+q.answer+"&emsp;&emsp;&emsp;自选答案:"+myanswer[i]+"</span></td></tr>"
                            );
                        }else {
                            $("#answerMain").append(
                                "<tr><td>"+(i+1)+"</td><td>"+q.questionText+"</td></tr>"
                            );
                            $("#answerMain").append(
                                "<tr><td></td><td><label for='A"+q.questionId+"' style='width: 100%;height: 100%;margin: 0'>A："+q.answer_a+"</label></td></tr>"
                            );
                            $("#answerMain").append(
                                "<tr><td></td><td><label for='B"+q.questionId+"' style='width: 100%;height: 100%;margin: 0'>B："+q.answer_b+"</label></td></tr>"
                            );
                            $("#answerMain").append(
                                "<tr><td></td><td><label for='C"+q.questionId+"' style='width: 100%;height: 100%;margin: 0'>C："+q.answer_c+"</label></td></tr>"
                            );
                            $("#answerMain").append(
                                "<tr><td></td><td><label for='D"+q.questionId+"' style='width: 100%;height: 100%;margin: 0'>D："+q.answer_d+"</label></td></tr>"
                            );
                            $("#answerMain").append(
                                "<tr style='background-color: #eceaea'><td></td><td><span style='color: red'>【回答错误】正确答案:"+q.answer+"&emsp;&emsp;&emsp;自选答案:"+myanswer[i]+"</span></td></tr>"
                            );
                        }
                    });

                    //调用答题模态框
                    $("#myModal").modal({backdrop: 'static', keyboard: false});

                },
                "json"
            );
        }

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
                <li><a href="${pageContext.request.contextPath}/gotoPortfolio">美图分享</a></li>
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


<main id="main">
    <section class="about" data-aos="fade-up">
        <div class="container" style="max-width: 1300px;">
            <div class="row">
                <div class="table-responsive">

                    <table class="table table-hover table-responsive" width="100%">
                        <tr>
                            <%----%>
                            <th></th>
                            <th>答题编号</th>
                            <th>用户名</th>
                            <th>来源</th>
                            <th>科目</th>
                            <th>选题数量（道）</th>
                            <th>得分(2分/题)</th>
                            <th>开始时间</th>
                            <th>结束时间</th>
                            <th>查看详情</th>
                        </tr>

                        <c:forEach items="${userStatistics}" var="statistics">
                            <tr>
                                <td>
                                    <%--自选答案--%>
                                    <input id="myanswer${statistics.sid}" type="hidden" value="${statistics.myanswer}">
                                </td>
                                <td>${statistics.sid}</td>
                                <td>${statistics.userbase.userName}</td>
                                <td>${statistics.userbase.source}</td>
                                <td>
                                    <textarea disabled class="form-control" style="border: 0;overflow:hidden" rows="1" >${statistics.subject}</textarea>
                                </td>
                                <td>${statistics.answernumber}</td>
                                <td>${statistics.fraction}</td>
                                <td>${statistics.starttime}</td>
                                <td>${statistics.endtime}</td>
                                <td>
                                    <button onclick="findByQids(this,${statistics.sid})" type="button" value="${statistics.alltopic}" class="btn btn-sm btn-primary">查看详情</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
            </div>
        </div>
    </section>
</main>

<%--答题界面模态框--%>
<div>
    <!-- 模态框（Modal） -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content" style="height:95%;">
                <div class="modal-header">
                    <h4 class="modal-title" id="myModalLabel">
                        详情信息
                    </h4>
                    <button type="button" id="closeX" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                </div>
                <div class="modal-body" style="overflow:scroll;">
                    <table id="answerMain" class="table table-hover">
                        <tbody>
                        </tbody>
                    </table>
                </div>
                <div class="modal-footer">
                    <%--回顶--%>
                    <div style="margin-right: auto">
                        <img onclick="$('.modal-body').scrollTop(0);" src="${pageContext.request.contextPath}/static/image/logo/top.png">
                    </div>
                    <button type="button" class="btn btn-default" id="close" data-dismiss="modal">关闭
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