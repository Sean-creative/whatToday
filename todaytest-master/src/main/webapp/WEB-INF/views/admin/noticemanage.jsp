<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<style>
input[name=ntTitle]{
	width:100%;
}
textarea[name=ntContent]{
	width:100%;
}
</style>

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
                <li class="nav-item active">
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
                    <h1 class="h3 mb-2 text-gray-800">NoticeTables</h1>

                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">Notice</h6>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="noticeTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>번호</th>
                                            <th>제목</th>
                                            <th>날짜</th>
                                        </tr>
                                    </thead>
                                    <tfoot>
                                        <tr>
                                            <th>번호</th>
                                            <th>제목</th>
                                            <th>날짜</th>
                                        </tr>
                                    </tfoot>
                                </table>
                                <div class="float-right">
                                <button class="btn btn-primary" id="writeNotice" data-toggle='modal' data-target='#noticeWriteModal'>글쓰기</button>
                                </div>
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

    <!-- 글쓰기 모달 -->
    <div class="modal fade" id="noticeWriteModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">글쓰기</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                제목 <br> <input id="writeNtTitle" name="ntTitle"> <br>
                내용 <br> <textarea id="writeNtContent" name="ntContent"rows="5" cols="33"></textarea>
                </div>
                <div class="modal-footer">
                	<button class="btn btn-secondary" type="button" data-dismiss="modal">닫기</button>
                    <button class="btn btn-primary" id="write" type='button' data-dismiss="modal">등록</button>
                </div>
            </div>
        </div>
    </div>
    
        <!-- 글 수정 모달 -->
    <div class="modal fade" id="noticeModifyModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">글수정</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                제목 <br> <input id="modifyNtTitle" name="ntTitle"> <br>
                내용 <br> <textarea id="modifyNtContent" name="ntContent"rows="5" cols="33"></textarea>
                <input type="hidden" name="ntNum">
                </div>
                <div class="modal-footer">
                	<button class="btn btn-secondary" type="button" data-dismiss="modal">닫기</button>
                	<button class="btn btn-danger" id="delete" type="button" data-dismiss="modal">삭제</button>
                    <button class="btn btn-primary" id="modify" type='button' data-dismiss="modal">수정</button>
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
			var data;
			table = $('#noticeTable').DataTable({
			 "createdRow": function( row, data, dataIndex ) {
		        	$(row).attr("data-toggle","modal");
		        	$(row).attr("data-target","#noticeModifyModal");
		        	$(row).css("transition","1s")
		        },
		        "order": [],
			
		     ajax: {
		        'url':'/admin/noticemanage/noticelist.json',
		        
		        //'type': 'POST',
		        'dataSrc':''
		     },
		    columns: [
		        {"data": "ntNum"},
		        {"data": "ntTitle"},
		        {"data": "ntDate"},    
		    ]
		});
		 
		 $('#noticeTable tbody').on('click', 'tr', function (){
			data = table.row(this).data();
			console.log(data);
			$("#modifyNtTitle").val(data.ntTitle);
			$("#modifyNtContent").val(data.ntContent);
			
		 });
		 $('#noticeTable tbody').on('mouseover', 'tr', function (){
				$(this).css("background-color","#4e73df");
				$(this).css("color","#fff");
		 });
	 	$('#noticeTable tbody').on('mouseleave', 'tr', function (){
			$(this).css("background-color","#fff");
			$(this).css("color","#858796");
	 	});
		 
		 const modifyNotice = function(){
			 
			
			 let ntTitle = $('#modifyNtTitle').val();
			 let ntContent = $('#modifyNtContent').val();
			 
			 console.log(ntTitle);
			 
			  $.ajax({
					 url: "/admin/noticemanage/updateNotice/",
					 type:"PUT",
					 data: JSON.stringify({ntTitle:ntTitle,ntContent:ntContent,ntNum:data.ntNum}),
					 dataType: "json",
					 contentType : "application/json; charset=utf-8",
					 success: function(data){ 
						 console.log(data);
						 
						 },
				 	 complete : function(com){
				 		table.ajax.reload();
						},
					 }); 
		 
		 }
		 

		 const writeNotice = function(){

			 let ntTitle = $('#writeNtTitle').val();
			 let ntContent = $('#writeNtContent').val();
			 
			 console.log(ntTitle);
			 console.log(ntContent);
			 
			 $.ajax({
				 type : 'post',
				 url : "/admin/noticemanage/writeNotice/",
				 data : JSON.stringify({ntTitle:ntTitle,ntContent:ntContent}),
				 dataType: "json",
				 contentType: "application/json; charset=utf-8",
				 success : function(result, status, xhr){
					if(callback){
					 callback(result);
					}
					
				 },
				 complete : function(result, status, xhr){
					 table.ajax.reload();
					}
			 })
		 }
		 
		 const deleteNotice = function(){
			 
		
			  $.ajax({
				   type : 'delete',
				   url : "/admin/noticemanage/deleteNotice/" + data.ntNum,
				   success : function(result, status, xhr) {
				    
				   },
				   complete : function(result, status, xhr){
					   table.ajax.reload();
					   }
				   })
			  }

		 $('#write').on("click",function(){
			 writeNotice();
		 })
		 $('#modify').on("click",function(){
			 modifyNotice();
		 })
		 $('#delete').on("click",function(){
			 deleteNotice();
		 })
		 
		 
		 $('#noticeWriteModal').on('hidden.bs.modal', function () {
			 let ntTitle = $('input[name=ntTitle]').val("");
			 let ntContent = $('textarea[name=ntContent]').val("");
			 
		 })
		
		
	

	});
	
		
	</script>
	
</body>

</html>