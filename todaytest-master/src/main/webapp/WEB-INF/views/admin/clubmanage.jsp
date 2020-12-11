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
            <li class="nav-item">
                <a class="nav-link" href="charts.html">
                    <i class="fas fa-fw fa-chart-area"></i>
                    <span>Charts</span></a>
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
                <li class="nav-item active">
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

                    <!-- Sidebar Toggle (Topbar) -->
                    <form class="form-inline">
                        <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                            <i class="fa fa-bars"></i>
                        </button>
                    </form>

                    <!-- Topbar Search -->
                    <form
                        class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
                        <div class="input-group">
                            <input type="text" class="form-control bg-light border-0 small" placeholder="Search for..."
                                aria-label="Search" aria-describedby="basic-addon2">
                            <div class="input-group-append">
                                <button class="btn btn-primary" type="button">
                                    <i class="fas fa-search fa-sm"></i>
                                </button>
                            </div>
                        </div>
                    </form>

                    <!-- Topbar Navbar -->
                    <ul class="navbar-nav ml-auto">

                        <!-- Nav Item - Search Dropdown (Visible Only XS) -->
                        <li class="nav-item dropdown no-arrow d-sm-none">
                            <a class="nav-link dropdown-toggle" href="#" id="searchDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fas fa-search fa-fw"></i>
                            </a>
                            <!-- Dropdown - Messages -->
                            <div class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in"
                                aria-labelledby="searchDropdown">
                                <form class="form-inline mr-auto w-100 navbar-search">
                                    <div class="input-group">
                                        <input type="text" class="form-control bg-light border-0 small"
                                            placeholder="Search for..." aria-label="Search"
                                            aria-describedby="basic-addon2">
                                        <div class="input-group-append">
                                            <button class="btn btn-primary" type="button">
                                                <i class="fas fa-search fa-sm"></i>
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </li>

                        <!-- Nav Item - Alerts -->
                        <li class="nav-item dropdown no-arrow mx-1">
                            <a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fas fa-bell fa-fw"></i>
                                <!-- Counter - Alerts -->
                                <span class="badge badge-danger badge-counter">3+</span>
                            </a>
                            <!-- Dropdown - Alerts -->
                            <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                aria-labelledby="alertsDropdown">
                                <h6 class="dropdown-header">
                                    Alerts Center
                                </h6>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="mr-3">
                                        <div class="icon-circle bg-primary">
                                            <i class="fas fa-file-alt text-white"></i>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="small text-gray-500">December 12, 2019</div>
                                        <span class="font-weight-bold">A new monthly report is ready to download!</span>
                                    </div>
                                </a>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="mr-3">
                                        <div class="icon-circle bg-success">
                                            <i class="fas fa-donate text-white"></i>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="small text-gray-500">December 7, 2019</div>
                                        $290.29 has been deposited into your account!
                                    </div>
                                </a>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="mr-3">
                                        <div class="icon-circle bg-warning">
                                            <i class="fas fa-exclamation-triangle text-white"></i>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="small text-gray-500">December 2, 2019</div>
                                        Spending Alert: We've noticed unusually high spending for your account.
                                    </div>
                                </a>
                                <a class="dropdown-item text-center small text-gray-500" href="#">Show All Alerts</a>
                            </div>
                        </li>

                        <!-- Nav Item - Messages -->
                        <li class="nav-item dropdown no-arrow mx-1">
                            <a class="nav-link dropdown-toggle" href="#" id="messagesDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fas fa-envelope fa-fw"></i>
                                <!-- Counter - Messages -->
                                <span class="badge badge-danger badge-counter">7</span>
                            </a>
                            <!-- Dropdown - Messages -->
                            <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                aria-labelledby="messagesDropdown">
                                <h6 class="dropdown-header">
                                    Message Center
                                </h6>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="dropdown-list-image mr-3">
                                        <img class="rounded-circle" src="/resources/admin/img/undraw_profile_1.svg"
                                            alt="">
                                        <div class="status-indicator bg-success"></div>
                                    </div>
                                    <div class="font-weight-bold">
                                        <div class="text-truncate">Hi there! I am wondering if you can help me with a
                                            problem I've been having.</div>
                                        <div class="small text-gray-500">Emily Fowler · 58m</div>
                                    </div>
                                </a>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="dropdown-list-image mr-3">
                                        <img class="rounded-circle" src="/resources/admin/img/undraw_profile_2.svg"
                                            alt="">
                                        <div class="status-indicator"></div>
                                    </div>
                                    <div>
                                        <div class="text-truncate">I have the photos that you ordered last month, how
                                            would you like them sent to you?</div>
                                        <div class="small text-gray-500">Jae Chun · 1d</div>
                                    </div>
                                </a>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="dropdown-list-image mr-3">
                                        <img class="rounded-circle" src="/resources/admin/img/undraw_profile_3.svg"
                                            alt="">
                                        <div class="status-indicator bg-warning"></div>
                                    </div>
                                    <div>
                                        <div class="text-truncate">Last month's report looks great, I am very happy with
                                            the progress so far, keep up the good work!</div>
                                        <div class="small text-gray-500">Morgan Alvarez · 2d</div>
                                    </div>
                                </a>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="dropdown-list-image mr-3">
                                        <img class="rounded-circle" src="https://source.unsplash.com/Mv9hjnEUHR4/60x60"
                                            alt="">
                                        <div class="status-indicator bg-success"></div>
                                    </div>
                                    <div>
                                        <div class="text-truncate">Am I a good boy? The reason I ask is because someone
                                            told me that people say this to all dogs, even if they aren't good...</div>
                                        <div class="small text-gray-500">Chicken the Dog · 2w</div>
                                    </div>
                                </a>
                                <a class="dropdown-item text-center small text-gray-500" href="#">Read More Messages</a>
                            </div>
                        </li>

                        <div class="topbar-divider d-none d-sm-block"></div>

                        <!-- Nav Item - User Information -->
                        <li class="nav-item dropdown no-arrow">
                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <span class="mr-2 d-none d-lg-inline text-gray-600 small">Douglas McGee</span>
                                <img class="img-profile rounded-circle"
                                    src="/resources/admin/img/undraw_profile.svg">
                            </a>
                            <!-- Dropdown - User Information -->
                            <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                aria-labelledby="userDropdown">
                                <a class="dropdown-item" href="#">
                                    <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Profile
                                </a>
                                <a class="dropdown-item" href="#">
                                    <i class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Settings
                                </a>
                                <a class="dropdown-item" href="#">
                                    <i class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Activity Log
                                </a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="#" data-toggle="modal" data-target="#clubInfoModal">
                                    <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Logout
                                </a>
                            </div>
                        </li>

                    </ul>

                </nav>
                <!-- End of Topbar -->

                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->
                    <h1 class="h3 mb-2 text-gray-800">ClubTables</h1>

                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">Club</h6>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="clubTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>번호</th>
                                            <th>모임명</th>
                                            <th>타입</th>
                                            <th>모임장</th>
                                            <th>카테고리</th>
                                            <th>세부카테고리</th>
                                            <th>지역</th>
                                            <th>세부지역</th>
                                            <th>정원</th> 
                                            <th>현재원</th> 
                                            <th>생성일</th> 
                                        </tr>
                                    </thead>
                                    <tfoot>
                                        <tr>
                                            <th>번호</th>
                                            <th>모임명</th>
                                            <th>타입</th>
                                            <th>모임장</th>
                                            <th>카테고리</th>
                                            <th>세부카테고리</th>
                                            <th>지역</th>
                                            <th>세부지역</th>
                                            <th>정원</th> 
                                            <th>현재원</th> 
                                            <th>생성일</th>
                                        </tr>
                                    </tfoot>
                                   
                                </table>
                            </div>
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

    <!-- Logout Modal-->
    <div class="modal fade" id="clubInfoModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">유저 정보</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                
                	<input type="hidden" id="cbNum" name="cbNum" style="border:none" readonly="readonly"><br>
                	모임명 <input type="text" id="cbName" name="cbName" style="border:none" readonly="readonly"><br>
                	타입 <input type="text" id="cbType" name="cbType" style="border:none" readonly="readonly"><br>
                	모임장 <input type="text" id="cbLeaderName" name="cbLeaderName" style="border:none" readonly="readonly"><br>
                	카테고리 <input type="text" id="cbCategory" name="cbCategory" style="border:none" readonly="readonly"><br>
                	세부카테고리 <input type="text" id="cbSubcat" name="cbSubcat" style="border:none" readonly="readonly"><br>
                	지역 <input type="text" id="cbCity" name="cbCity" style="border:none" readonly="readonly"><br>
                	세부지역<input type="text" id="cbDistrict" name="cbDistrict" style="border:none" readonly="readonly"><br>
                	정원<input type="text" id="cbMbNum" name="cbMbNum" style="border:none" readonly="readonly"><br>
                	현재원<input type="text" id="cbCurMbNum" name="cbCurMbNum" style="border:none" readonly="readonly"><br>
                	생성일<input type="text" id=cbMakeDate name="cbMakeDate" style="border:none" readonly="readonly"><br>
                </div>
                <div class="modal-member"></div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">닫기</button>
                    <form action="#">
                    <button name ="shutClub" class="btn btn-danger" type="button" data-dismiss="modal">폐쇄</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

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
	<script type="text/javascript">
	$(document).ready(function() {

		
		var table;
		table = $('#clubTable').DataTable({
			 "createdRow": function( row, data, dataIndex ) {
		        	$(row).attr("data-toggle","modal");
		        	$(row).attr("data-target","#clubInfoModal");
		        	
		        },
		     bAutoWidth: true,
		     ajax: {
		        'url':'/admin/clubmanage/clublist.json',
		        
		        //'type': 'POST',
		        'dataSrc':''
		     },
		     columnDefs: [
		         { targets: [11], visible: false, searchable: false}
		         
		     ],
		    columns: [
		        {"data": "cbNum"},
		        {"data": "cbName"},
		        {"data": "cbType"}, 
		        {"data": "cbLeaderName"},
		        {"data": "cbCategory"},
		        {"data": "cbSubcat"},
		        {"data": "cbCity"},
		        {"data": "cbDistrict"},
		        {"data": "cbMbNum"},
		        {"data": "cbCurMbNum"},
		        {"data": "cbMakeDate"},
		        {"data": "cbLeaderNum"}
		    ]
		     
		});
		
		let udata;
		 $('#clubTable tbody').on('click', 'tr', function (){
				udata = table.row(this).data();
				console.log(udata);
				
				$("#cbNum").val(udata.cbNum);
				$("#cbName").val(udata.cbName);	
				$("#cbType").val(udata.cbType);
				$("#cbLeaderName").val(udata.cbLeaderName);
				$("#cbCategory").val(udata.cbCategory);
				$("#cbSubcat").val(udata.cbSubcat);
				$("#cbCity").val(udata.cbCity);
				$("#cbDistrict").val(udata.cbDistrict);
				$("#cbMbNum").val(udata.cbMbNum);
				$("#cbCurMbNum").val(udata.cbCurMbNum);
				$("#cbMakeDate").val(udata.cbMakeDate);
				
				getClubMember(udata);
				
		 });
		 
		 const getClubMember = function(e){
		 
		 $.ajax({
	           type:"GET",

	           url:"/admin/clubmanage/clubmemberlist/"+e.cbNum+".json",
	           
	           dataType:"JSON",

	           success : function(list) {
	        	   console.log(list);
	        	   let str = "";
	        	   for(let i = 0; i < list.length; i++){
	        		   if(e.cbLeaderNum == list[i].usrNum){
	        			   continue;
	        		   }
	        		   str += list[i].usrName+ "<button name='updateLeader'class='btn btn-primary' type='button' data-dismiss='modal' data-cbnum='"+e.cbNum+"' data-usrname='"+list[i].usrName+"' data-usrnum='"+list[i].usrNum+"'>모임장위임</button><br>";
	        	   }
	       		

	        	   $(".modal-member").empty();
	        	   $(".modal-member").append(str);
	        	   
	           },

	           complete : function(list) {

	           },

	           error : function(xhr, status, error) {

	                 alert("에러발생");

	           }
		});
		};
		
		
		const shutClub = function(e){
		
			console.log(e);
			$.ajax({
				url: "/admin/clubmanage/shutClub",
				type:"PUT",
				data: JSON.stringify({cbNum:e}),
				dataType: "json",
				contentType : "application/json; charset=utf-8",
				success: function(data){ 
					
				},
				complete: function(list){
					console.log(list);
					table.ajax.reload();
				}
				});
			};  
			
			
  		const updateClubLeader = function(e){		
				console.log(e.cbnum);
				console.log(e.usrname);
				console.log(e.usrnum);
				
				$.ajax({
					url: "/admin/clubmanage/updateClubLeader",
					type:"PUT",
					data: JSON.stringify({cbNum:e.cbnum, usrName:e.usrname, usrNum:e.usrnum}),
					dataType: "json",
					contentType : "application/json; charset=utf-8",
					success: function(data){ 
						console.log(data);	
						
					},
					complete : function(list){
						 table.ajax.reload(); 
					}
					});
				};  
  		
  		
 		$('.modal').on('hidden.bs.modal', function (e) {
 			console.log('modal close');
 			
 		});
 		
 		$(document).on("click", "button[name=shutClub]", function(){
 			
 			shutClub($("#cbNum").val());
 			
 		});
 		
		$(document).on("click", "button[name=updateLeader]", function(){
 			
			updateClubLeader(this.dataset);
			
 			
 		});

	});
	
		
	</script>
	
</body>

</html>