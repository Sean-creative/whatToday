console.log("category module...");

var categoryService = (function(){
	function getCategorylist(param, callback, error){
		var catClassificationCode = param.catClassificationCode;
		
		$.getJSON("/account/categorylist/"+catClassificationCode,function(data){
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
		getCategorylist : getCategorylist
	};
	
})();


var cityService = (function(){
	function getCitylist(param, callback, error){
		var catClassificationCode = param.catClassificationCode;
		
		$.getJSON("/account/citylist/"+catClassificationCode,function(data){
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
		getCitylist : getCitylist
	};
	
})();