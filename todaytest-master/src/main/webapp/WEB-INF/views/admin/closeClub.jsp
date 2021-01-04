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
                                <table class="table table-bordered" id="closeTable" width="100%" cellspacing="0">
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
                                            <th>상태</th>
                                            <th>폐쇄일</th>  
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
                                            <th>상태</th>
                                            <th>폐쇄일</th>    
                                        </tr>
                                    </tfoot>
                                    <tbody>
                                    
                                     <c:forEach var="clubVO" items="${clubVO}">
                                    <tr>
                                    	<td>${clubVO.cbNum }</td>
                                    	<td>${clubVO.cbName }</td>
                                    	<td>${clubVO.cbType }</td>
                                    	<td>${clubVO.cbLeaderName }</td>
                                    	<td>${clubVO.cbCategory }</td>
                                    	<td>${clubVO.cbSubcat }</td>
                                    	<td>${clubVO.cbCity }</td>
                                    	<td>${clubVO.cbDistrict }</td>
                                    	<td>${clubVO.cbFinalState }</td>
                                    	<td>${clubVO.cbShutDate }</td>
                                    </tr>
                                    </c:forEach>
                                    </tbody>
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
    <div class="modal fade" id="userInfoModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">모임 정보</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                	<img id="usrImg" name="usrImg" alt="없어" style="width: 100px; height: 100px"><br>
                	아이디 <input type="text" id="usrId" name="usrId" style="border:none" readonly="readonly"><br>
                	이름 <input type="text" id="usrName" name="usrName" style="border:none" readonly="readonly"><br>
                	휴대전화 <input type="text" id="usrPhone" name="usrPhone" style="border:none" readonly="readonly"><br>
                	성별 <input type="text" id="usrGender" name="usrGender" style="border:none" readonly="readonly"><br>
                	생일 <input type="text" id="usrBirth" name="usrBirth" style="border:none" readonly="readonly"><br>
                	가입일 <input type="text" id="usrJoinDate" name="usrJoinDate" style="border:none" readonly="readonly"><br>
                	최근 로그인<input type="text" id="usrLoginDate" name="usrLoginDate" style="border:none" readonly="readonly"><br>
                	회원상태<input type="text" id="usrState" name="usrState" style="border:none" readonly="readonly"><br>

                </div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">닫기</button>
                    <form action="/admin/banAction">
                    <button class="btn btn-primary">강퇴</button>
                    <input type="hidden" id="usrNum" name="usrNum">
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
		
		$('#closeTable').DataTable({
			  "order": [],
		});
		
	

	});
	
		
	</script>
	
</body>

</html>