<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>UserManageTable</title>

    <!-- Custom fonts for this template -->
    <link href="/resources/admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="/resources/admin/css/sb-admin-2.min.css" rel="stylesheet">

    <!-- Custom styles for this page -->
    <link href="/resources/admin/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">

</head>

<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">

        <!-- Sidebar -->
        <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

            <!-- Sidebar - Brand -->
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="index.html">
                <div class="sidebar-brand-icon rotate-n-15">
                    <i class="fas fa-laugh-wink"></i>
                </div>
                <div class="sidebar-brand-text mx-3">오늘뭐하지 <sup>?</sup></div>
            </a>

            <!-- Divider -->
            <hr class="sidebar-divider my-0">



            <!-- Heading -->
            <div class="sidebar-heading">
                Addons
            </div>


            <!-- Nav Item - Charts -->
            <li class="nav-item active">
                <a class="nav-link" href="/admin/chart">
                    <i class="fas fa-fw fa-chart-area"></i>
                    <span>차트</span></a>
            </li>

            <!-- Nav Item - Tables -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages"
                 	aria-expanded="true" aria-controls="collapsePages">
                    <i class="fas fa-fw fa-table"></i>
                    <span>회원</span></a>
                    <div id="collapsePages" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">회원:</h6>
                        <a class="collapse-item" href="/admin/usermanage">회원목록</a>
                        <a class="collapse-item" href="/admin/banLeaveUser">강퇴/탈퇴회원</a>
                        </div>
                    </div>
                </li>
                <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages2"
                 	aria-expanded="true" aria-controls="collapsePages">
                    <i class="fas fa-fw fa-folder"></i>
                    <span>모임</span></a>
                    <div id="collapsePages2" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">모임:</h6>
                        <a class="collapse-item" href="/admin/clubmanage">모임목록</a>
						<a class="collapse-item" href="/admin/closeClub">폐쇄모임목록</a>
                        </div>
                    </div>
                </li>
                <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages3"
                 	aria-expanded="true" aria-controls="collapsePages">
                    <i class="fas fa-fw fa-folder"></i>
                    <span>공지사항</span></a>
                    <div id="collapsePages3" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">공지사항:</h6>
                        <a class="collapse-item" href="/admin/noticemanage">공지사항관리</a>
                        </div>
                    </div>
                </li>

            <!-- Divider -->
            <hr class="sidebar-divider d-none d-md-block">

            <!-- Sidebar Toggler (Sidebar) -->
            <div class="text-center d-none d-md-inline">
                <button class="rounded-circle border-0" id="sidebarToggle"></button>
            </div>

        </ul>
        <!-- End of Sidebar -->

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                <!-- Topbar -->
                <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">


                </nav>
                <!-- End of Topbar -->

                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->
                    <h1 class="h3 mb-2 text-gray-800">ChartPage</h1>
                    
                              <div class="row">

            <div class="col-xl-8 col-lg-7">

              <!-- Area Chart -->
              <div class="card shadow mb-4">
                <div class="card-header py-3">
                  <h6 class="m-0 font-weight-bold text-primary">시간대별 로그인한 인원</h6>
                </div>
                <div class="card-body">
                <div class="chart-bar">
                    <div id="columnchart_values2" style="width: 100%; height: 100%;"></div>
                  </div>
                  <hr>
                  시간대별 로그인한 인원

                </div>
              </div>
              
              <div class="card shadow mb-4">
                <div class="card-header py-3">
                  <h6 class="m-0 font-weight-bold text-primary">일별 가입 인원</h6>
                </div>
                <div class="card-body">
                  <div class="chart-bar">
                    <div id="columnchart_values" style="width: 100%; height: 100%;"></div>
                  </div>
                  <hr>
                  일주일간 가입한 사람 인원
                </div>
              </div>
              </div>
                   
                    <div class="col-xl-4 col-lg-5">
              <div class="card shadow mb-4">
                <!-- Card Header - Dropdown -->
                <div class="card-header py-3">
                  <h6 class="m-0 font-weight-bold text-primary">남/녀 회원비율</h6>
                </div>
                <!-- Card Body -->
                <div class="card-body">
                  
                                    <div class="chart-area">
                    <div id="piechart" style="width: 100%; height: 100%;"></div>
                  </div>
                  <hr>
                  회원가입된 사람들의 남자/여자 비율
                </div>
              </div>
            </div>
                    
                <!-- /.container-fluid -->

            </div>
            <!-- End of Main Content -->

            <!-- Footer -->
            <footer class="sticky-footer bg-white">
                <div class="container my-auto">
                    <div class="copyright text-center my-auto">
                        <span>Copyright &copy; Your Website 2020</span>
                    </div>
                </div>
            </footer>
            <!-- End of Footer -->

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

    

    <!-- Bootstrap core JavaScript-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="/resources/admin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	
    <!-- Core plugin JavaScript-->
    <script src="/resources/admin/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="/resources/admin/js/sb-admin-2.min.js"></script>

    <!-- Page level plugins -->
    <script src="/resources/admin/vendor/datatables/jquery.dataTables.min.js"></script>
    <script src="/resources/admin/vendor/datatables/dataTables.bootstrap4.min.js"></script>

    <!-- Page level custom scripts -->
    <script src="/resources/admin/js/demo/datatables-demo.js"></script>
	<script src="/resources/admin/js/list.js"></script>
	
	<!-- 구글 차트 scripts -->
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	<script type="text/javascript">
	$(document).ready(function() {
		google.charts.load('current', {'packages':['corechart']});
	    google.charts.setOnLoadCallback(drawChartPie);
	    
	      function drawChartPie() {  	
	    	let womanCnt = 0;
	    	let manCnt = 0;

	    	for(let i = 0; i < getUserList().length; i ++){
	    		if(getUserList()[i].usrGender == '남'){
	    			manCnt++;
	    		}else if(getUserList()[i].usrGender == '여'){
	    			womanCnt++;
	    		}
	    		
	    	} 
	    	
	        let data = google.visualization.arrayToDataTable([
	          ['GENDER', 'COUNT',{ role: "style" }],
	          ['남자',     manCnt,'#60c5ba'],
	          ['여자',   womanCnt,'#ef5285']
	        ]);

	        let options = {
	        		width: '100%',
	        		height: '100%',
	        };

	        let chart = new google.visualization.PieChart(document.getElementById('piechart'));

	        chart.draw(data, options);
	        window.addEventListener('resize',drawChartPie,false);
	      }
	      
	      google.charts.load("current", {packages:['corechart']});
	      google.charts.setOnLoadCallback(drawChartBar);
	      function drawChartBar() {
	    	let date = new Date();
	    	let dateArr = [];
	    	let countArr = [0,0,0,0,0,0,0];
	    	let joinCountList =	getJoinWeek();
	    	
	    	
	    	
	    	for(let x = 0; x<7; x++){
	    		
	    		date.setDate(date.getDate()-x);
	    		dateArr.push(getDateStr(date))
	    		date.setDate(date.getDate()+x);
	    		
	    		for(let y = 0; y<joinCountList.length; y++){
	    			if(dateArr[x] == joinCountList[y].weekDate){
	    				countArr[x] = joinCountList[y].memberCount;
	    				break;
	    			}
	    			
	    		}
	    	}
	    	console.log(dateArr);
	    	
	        let data = google.visualization.arrayToDataTable([
	          ["Element", "명", { role: "style" } ],
	          [dateArr[6], countArr[6], "#D1B6E1"],
	          [dateArr[5], countArr[5], "#519D9E"],
	          [dateArr[4], countArr[4], "#58C9B9"],
	          [dateArr[3], countArr[3], "#9DC8C8"],
	          [dateArr[2], countArr[2], "#D499B9"],
	          [dateArr[1], countArr[1], "#9055A2"],
	          [dateArr[0], countArr[0], "#2E294E"]
	        ]);

	        let view = new google.visualization.DataView(data);
	        view.setColumns([0, 1,
	                         { calc: "stringify",
	                           sourceColumn: 1,
	                           type: "string",
	                           role: "annotation" },
	                         2]);

	        let options = {
	          width: '100%',
      		 height: '100%',
	          bar: {groupWidth: "95%"},
	          legend: { position: "none" },
	        };
	        let chart = new google.visualization.ColumnChart(document.getElementById("columnchart_values"));
	        chart.draw(view, options);
	        window.addEventListener('resize',drawChartBar,false);
	    }
	     
/* 	      function drawChartBar2() {
	    	  
	    	  let memberCount;
	    	  let cnt;
	    	  if('${userVO.memberCount}' == ''){
		    		memberCount = 0;
		    		cnt = 10;
		    	}else{
		    		memberCount = parseInt('${userVO.memberCount}');
		    	}

		    	cnt = memberCount * 2;
		        let data = google.visualization.arrayToDataTable([
		          ["Element", "명", { role: "style" } ],
		          ['${userVO.usrLoginDate}', memberCount, "red"]
		        ]);

		        let view = new google.visualization.DataView(data);
		        view.setColumns([0, 1,
		                         { calc: "stringify",
		                           sourceColumn: 1,
		                           type: "string",
		                           role: "annotation" },
		                         2]);

		        let options = {
		          width: '100%',
	      		 height: '100%',
		          bar: {groupWidth: "95%"},
		          legend: { position: "none" },
		             vAxis: {
		                 viewWindowMode:'explicit',
		                 viewWindow: {
		                   min:0,
		                   max:cnt
		                 }
		             },
		        }
		        let chart = new google.visualization.ColumnChart(document.getElementById("columnchart_values2"));
		        chart.draw(view, options);
		        window.addEventListener('resize',drawChartBar2,false);
		    } */
		    
		      google.charts.load('current', {'packages':['line']});
		      google.charts.setOnLoadCallback(drawChartBar2);

		    function drawChartBar2() {

		      var data = new google.visualization.DataTable();
		      data.addColumn('string', '시간');
		      data.addColumn('number', '로그인 인원');

		      data.addRows([
		        ['00:00',  2],
		        ['02:00',  1],
		        ['04:00',  3],
		        ['08:00',  6],
		        ['10:00',  3],
		        ['12:00',  10],
		        ['14:00',  6],
		        ['16:00',  null],
		        ['18:00',  null],
		        ['20:00',  null],
		        ['22:00',  null]
		      ]);

		      var options = {
		        chart: {
		        },
        		width: '100%',
        		height: '100%',
        		vAxis: {
	                 viewWindowMode:'explicit',
	                 viewWindow: {
	                   min:0
	                 }
	             },
		      };

		      var chart = new google.charts.Line(document.getElementById('columnchart_values2'));
		      chart.draw(data, google.charts.Line.convertOptions(options));;
		        window.addEventListener('resize',drawChartBar2,false);
		    }
	      
	      const getUserList = function(){
	    	let userInfo;
			 $.ajax({
				 type : 'get',
				 url : "/admin/usermanage/userlist.json",
				 async: false,
				 success : function(list){
					 userInfo = list;
					}
			 })
			 return userInfo;
			 
		 }
	      const getJoinWeek = function(){
	    	let joinCountList;
			 $.ajax({
				 type : 'get',
				 url : "/admin/chart/getJoinWeek.json",
				 async: false,
				 success : function(list){
					joinCountList = list;
				 }
			 })
			 return joinCountList;
			 
		 }
  
	      const getDateStr = function(myDate){
	    
	    	  var year;
	    	  var month = (myDate.getMonth() + 1);
	    	  var day = myDate.getDate();
	    	  
	    	  year = myDate.getFullYear().toString().substring(2,4);
	    	  month = (month < 10) ? "0" + String(month) : month;
	    	  day = (day < 10) ? "0" + String(day) : day;
	    	  
	    	  return  (year + '/' + month + '/' + day );
	}
		
		
	

	});
	
		
	</script>
	
</body>

</html>