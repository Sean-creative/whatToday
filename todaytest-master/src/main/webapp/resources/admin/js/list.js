console.log("club module...");

var userService = (function(){
	function getUserList(callback, error){
		
		$.getJSON("/admin/usermanage/userlist",function(data){
			if(callback){
				callback(data);
			}
		}).fail(function(xhr,status,err){
			if(error){
				error();
			}
		});
	}

			
	return{
		getUserList : getUserList
	};
	

	
})();