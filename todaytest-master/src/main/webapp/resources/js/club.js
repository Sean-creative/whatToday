console.log("club module...");

var clubService = (function(){
	function getList(param, callback, error){
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
	
	return{
		getList : getList
	};
	
})();