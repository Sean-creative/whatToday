console.log("club module...");

var clubService = (function(){
	function getMyCreateClubList(param, callback, error){
		var cbLeaderNum = param.cbLeaderNum;
		
		$.getJSON("/account/myclub/"+cbLeaderNum,function(data){
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
	
	$.getJSON("/account/myclub/joinclub/"+cbNum,function(data){
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