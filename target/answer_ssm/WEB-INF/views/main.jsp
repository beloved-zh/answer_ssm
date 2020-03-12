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

        /**
         * 获取当前时间
         */
        function getDate(){
            var now = new Date();
            var year = now.getFullYear(); //得到年份
            var month = now.getMonth()+1;//得到月份
            var date = now.getDate();//得到日期
            // var day = now.getDay();//得到周几
            var hour= now.getHours();//得到小时数
            var minute= now.getMinutes();//得到分钟数
            var second= now.getSeconds();//得到秒数
            var dStr = year+"-"+month+"-"+date+" "+hour+":"+minute+":"+second;

            return dStr;
        }

        $(function () {

            //为关闭按钮添加滚动条回顶事件
            $('#closeX,#close').click(function(){
                $(".modal-body").scrollTop(0);
                //数据初始化
                initStatistics();
                //删除禁用属性
                $("#submitAnswer").removeAttr("disabled");
            });

            //异步获取科目
            $.post(
                "${pageContext.request.contextPath}/course/findAll",
                function (data) {
                    $.each(data, function(i,c) {

                        if(i%5==0 || i==0){
                            $("#sub_tab").append("<tr></tr>");
                        }
                        $("#sub_tab tbody").append(
                            '<td class="text-right"><input type="checkbox" name="courses" id="c'+i+'" value="'+c.courseId+'"></td><td><label id="courseName'+c.courseId+'" for="c'+i+'">'+c.courseName+'</label></td>'
                        );
                    });
                },
                "json"
            );
        });

        //定义记录数据
        var alltopic = [];//所有的题
        var answernumber = 0;//答题数量
        var subject = [];//所选科目
        var allanswer = [];//正确答案
        var myanswer = [];//自选答案
        var correctanswer = [];//正确的题
        var erroranswer = [];//错误的题
        var fraction = 0;//分数
        var starttime = null;//开始时间
        var endtime = null;//结束时间

        function initStatistics() {
            alltopic = [];//所有的题
            answernumber = 0;//答题数量
            subject = [];//所选科目
            allanswer = [];//正确答案
            myanswer = [];//自选答案
            correctanswer = [];//正确的题
            erroranswer = [];//错误的题
            fraction = 0;//分数
            starttime = null;//开始时间
            endtime = null;//结束时间
        }


        //获取题目
        function goRandomQuestion() {
            var number = $("#number").val();
            //jquery获取复选框值
            //存取所选科目的id
            var courses = new Array();
            //存取所选科目的名字
            var courseNames = [];
            $('input[name="courses"]:checked').each(function(){//遍历每一个名字为courses的复选框，其中选中的执行函数
                courses.push($(this).val());//将选中的值添加到数组courses中
                var courseName = $("#courseName"+$(this).val()+"").html();
                courseNames.push(courseName);
            });


            if (courses.length === 0){
                alert("至少选择一门");
                return false;
            }

            //处理ajax传递数组会自动在参数名后加[]
            jQuery.ajaxSettings.traditional = true;
            $.post(
                "${pageContext.request.contextPath}/question/randomQuestion",
                {
                    "courses":courses,
                    "number":number
                },
                function (data) {
                    //保存所选科目和答题数量
                    subject = courseNames;
                    answernumber = number;
                    //开始时间
                    starttime = getDate();

                    //清空模态框
                    $("#answerMain tr").remove();

                    console.log(data)

                    $.each(data,function (i,q) {
                        //保存所选题目和答案
                        alltopic.push(q.questionId);
                        allanswer.push(q.answer);


                        //判断单选与多选
                        var answer = q.answer;
                        console.log(answer+"===="+answer.length)
                        if (answer.length == 1){//单选
                            $("#answerMain").append(
                                "<tr><td>"+(i+1)+"</td><td>【单选】"+q.questionText+"</td></tr>"
                            );
                            $("#answerMain").append(
                                "<tr><td><input type='radio' id='A"+q.questionId+"' name='answer"+i+"' value='A' /></td><td><label for='A"+q.questionId+"' style='width: 100%;height: 100%;margin: 0'>A："+q.answer_a+"</label></td></tr>"
                            );
                            $("#answerMain").append(
                                "<tr><td><input type='radio' id='B"+q.questionId+"' name='answer"+i+"' value='B' /></td><td><label for='B"+q.questionId+"' style='width: 100%;height: 100%;margin: 0'>B："+q.answer_b+"</label></td></tr>"
                            );
                            $("#answerMain").append(
                                "<tr><td><input type='radio' id='C"+q.questionId+"' name='answer"+i+"' value='C' /></td><td><label for='C"+q.questionId+"' style='width: 100%;height: 100%;margin: 0'>C："+q.answer_c+"</label></td></tr>"
                            );
                            $("#answerMain").append(
                                "<tr><td><input type='radio' id='D"+q.questionId+"' name='answer"+i+"' value='D' /></td><td><label for='D"+q.questionId+"' style='width: 100%;height: 100%;margin: 0'>D："+q.answer_d+"</label></td></tr>"
                            );
                            $("#answerMain").append(
                                "<tr style='background-color: #eceaea'><td></td><td id='td"+q.questionId+"'></td></tr>"
                            );

                        } else {//多选
                            $("#answerMain").append(
                                "<tr><td>"+(i+1)+"</td><td>【多选】"+q.questionText+"</td></tr>"
                            );
                            $("#answerMain").append(
                                "<tr><td><input type='checkbox' id='A"+q.questionId+"' name='answer"+i+"' value='A' /></td><td><label for='A"+q.questionId+"' style='width: 100%;height: 100%;margin: 0'>A："+q.answer_a+"</label></td></tr>"
                            );
                            $("#answerMain").append(
                                "<tr><td><input type='checkbox' id='B"+q.questionId+"' name='answer"+i+"' value='B' /></td><td><label for='B"+q.questionId+"' style='width: 100%;height: 100%;margin: 0'>B："+q.answer_b+"</label></td></tr>"
                            );
                            $("#answerMain").append(
                                "<tr><td><input type='checkbox' id='C"+q.questionId+"' name='answer"+i+"' value='C' /></td><td><label for='C"+q.questionId+"' style='width: 100%;height: 100%;margin: 0'>C："+q.answer_c+"</label></td></tr>"
                            );
                            $("#answerMain").append(
                                "<tr><td><input type='checkbox' id='D"+q.questionId+"' name='answer"+i+"' value='D' /></td><td><label for='D"+q.questionId+"' style='width: 100%;height: 100%;margin: 0'>D："+q.answer_d+"</label></td></tr>"
                            );
                            $("#answerMain").append(
                                "<tr style='background-color: #eceaea'><td></td><td id='td"+q.questionId+"'></td></tr>"
                            );

                        }

                    });
                },
                "json"
            );

            //调用答题模态框
            $("#myModal").modal({backdrop: 'static', keyboard: false});

        }

        //提交答案
        function submitAnswer() {

            //添加禁用属性
            $("#submitAnswer").attr("disabled","disabled");

            //遍历答题数量获取答案
            for (var i = 0;i < answernumber;i++){
                var arr = [];
                $('input[name="answer'+i+'"]:checked').each(function(){
                    arr.push($(this).val());
                });
                var arrStr = arr.toString();
                //判断有没有值，并且去除，
                if(arrStr.length > 0){
                    arrStr = arrStr.replace(",","");
                    arrStr = arrStr.replace(",","");
                    arrStr = arrStr.replace(",","");
                    arrStr = arrStr.replace(",","");
                    myanswer.push(arrStr);
                }
            }

            //判断是否全部做完
            if(myanswer.length < allanswer.length){
                alert("还没有答完哦");
                //删除禁用属性
                $("#submitAnswer").removeAttr("disabled");
                //初始化自选答案
                myanswer = [];
                return false;
            }

            //判断是否重复提交
            if(myanswer.length > allanswer.length){
                alert("请勿重复提交");
                //初始化自选答案
                myanswer = [];
                return false;
            }

            //判断
            for (var i in allanswer) {
                if (allanswer[i] == myanswer[i]) {
                    correctanswer.push(alltopic[i]);
                }else {
                    erroranswer.push(alltopic[i]);
                }
            }

            //结束时间
            endtime = getDate();
            console.log("所选科目："+subject);
            console.log("答题数量："+answernumber);
            console.log("分数："+correctanswer.length*2);
            console.log("正确的题："+correctanswer);
            console.log("错误的题："+erroranswer);
            console.log("开始时间："+starttime);
            console.log("结束时间："+endtime);
            console.log("题的顺序："+alltopic);
            console.log("正确答案："+allanswer);
            console.log("自选答案："+myanswer);


            //记录展示
            $("#subject").val(subject);
            $("#alltopic").val(alltopic);
            $("#answernumber").val(answernumber);
            $("#fraction").val(correctanswer.length*2);
            $("#correctanswer").val(correctanswer);
            $("#erroranswer").val(erroranswer);
            $("#starttime").val(starttime);
            $("#endtime").val(endtime);
            $("#statisticsModel").modal({backdrop: 'static', keyboard: false});

            //异步保存记录
            $.post(
                "${pageContext.request.contextPath}/statistics/addStatistics",
                {
                    "alltopic":alltopic.toString(),
                    "correctanswer":correctanswer.toString(),
                    "erroranswer":erroranswer.toString(),
                    "fraction":correctanswer.length*2,
                    "starttime":starttime,
                    "endtime":endtime,
                    "answernumber":answernumber,
                    "subject":subject.toString(),
                    "myanswer":myanswer.toString(),
                    "allanswer":allanswer.toString(),
                    "userbase.userId":$("#userId").val()
                },
                function (data) {

                },
                "json"
            );
        }

        //查看详情
        function viewDetails() {
            //禁用按钮
            $("#answerMain input").attr("disabled","disabled");

            //遍历输出信息
            $.each(alltopic,function (i,id) {
                if(allanswer[i] == myanswer[i]){
                    $("#td"+id+"").append('<lable style="color: #00dbff;">正确答案：'+allanswer[i]+'   你的答案'+myanswer[i]+'</lable>')
                }else{
                    $("#td"+id+"").append('<lable style="color: red;">正确答案：'+allanswer[i]+'   你的答案'+myanswer[i]+'</lable>')
                }
            });
        }

        //排行榜
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
                <li class="active"><a href="${pageContext.request.contextPath}/user/gotoMain">在线答题</a></li>
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
<%--答题界面模态框--%>
<div>
    <!-- 模态框（Modal） -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content" style="height:95%;">
                <div class="modal-header">
                    <h4 class="modal-title" id="myModalLabel">
                        开始答题
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
                    <button type="button" id="submitAnswer" onclick="submitAnswer()" class="btn btn-primary">
                        提交答案
                    </button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal -->
    </div>
</div>

<main id="main">
<section class="about" data-aos="fade-up">
    <div class="container">
        <div class="row">
            <div class="table-responsive-md">
                <table class="table" id="sub_tab">
                    <thead>
                    <tr>
                        <th>
                            &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                        </th>
                        <th>
                            <select id="number" style="height: 30px" class="form-control input-sm">
                                <option value="10">10</option>
                                <option value="20">20</option>
                                <option value="30">30</option>
                                <option value="40">40</option>
                                <option value="50">50</option>
                            </select>
                        </th>
                        <th colspan="9">
                            <button type="button" onclick="goRandomQuestion()" class="btn btn-info btn-sm">开始答题</button>
                        </th>
                    </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>

    </div>
</section>
</main>



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

<%--答题记录模态框--%>
<div>
    <!-- 模态框 -->
    <div class="modal fade" id="statisticsModel">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <!-- 模态框头部 -->
                <div class="modal-header">
                    <h4 class="modal-title">答题记录</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <!-- 模态框主体 -->
                <div class="modal-body">
                    <table class='table'>
                        <tr>
                            <td>所选科目</td>
                            <td>
                                <textarea disabled style="height: 38px" class="form-control" id="subject" rows="1"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td>题目ID</td>
                            <td>
                                <textarea disabled style="height: 38px" class="form-control" id="alltopic" rows="1"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td>答题数量</td>
                            <td>
                                <input disabled class="form-control" id="answernumber">
                            </td>
                        </tr>
                        <tr>
                            <td>分数</td>
                            <td>
                                <input disabled class="form-control" id="fraction">
                            </td>
                        </tr>
                        <tr>
                            <td>正确的题</td>
                            <td>
                                <textarea disabled style="height: 38px" class="form-control" id="correctanswer" rows="1"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td>错误的题</td>
                            <td>
                                <textarea disabled style="height: 38px" class="form-control" id="erroranswer" rows="1"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td>开始时间</td>
                            <td>
                                <input disabled class="form-control" id="starttime">
                            </td>
                        </tr>
                        <tr>
                            <td>结束时间</td>
                            <td>
                                <input disabled class="form-control" id="endtime">
                            </td>
                        </tr>
                    </table>
                </div>
                <!-- 模态框底部 -->
                <div class="modal-footer">
                    <button onclick="viewDetails()" type="button" class="btn btn-secondary" data-dismiss="modal">关闭查看详情</button>
                </div>

            </div>
        </div>
    </div>
</div>
</body>

</html>