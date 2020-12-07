console.log("club module...");

var clubService = (function(){
	function getMyCreateClubList(param, callback, error){
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
	
	function getJoinClub(param, callback, error){
		var cbNum = param.cbNum; 
	
	$.getJSON("/mypage/myclub/joinclub/"+cbNum,function(data){
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
		getMyCreateClubList : getMyCreateClubList,
		getJoinClub : getJoinClub
	};
	

	
})();