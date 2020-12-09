console.log("club module...");

var clubService = (function(){
	function getLeaderClubList(param, callback, error){
		var cbLeaderNum = param.cbLeaderNum;
		
		$.getJSON("/mypage/createclub/"+cbLeaderNum,function(data){
			if(callback){
				callback(data);
			}
		}).fail(function(xhr,status,err){
			if(error){
				error();
			}
		});
	}
	
	function getMyClubList(param, callback, error){
		var usrNum = param.usrNum; 
	
	$.getJSON("/mypage/myclub/getMyClubList/"+usrNum,function(data){
			if(callback){
				callback(data);
			}
			
			}).fail(function(xhr,status,err){
			if(error){
				error();
			}
		});
	}
	
	function getPrevClubList(param, callback, error){
		var usrNum = param.usrNum; 
	
	$.getJSON("/mypage/myclub/getPrevClubList/"+usrNum,function(data){
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
		getLeaderClubList : getLeaderClubList ,
		getPrevClubList : getPrevClubList,
		getMyClubList : getMyClubList
	};
	

	
})();