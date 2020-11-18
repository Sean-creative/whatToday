console.log("category module...");

var categoryService = (function(){
	function getCategorylist(param, callback, error){
		var catClassificationCode = param.catClassificationCode;
		
		$.getJSON("/account/"+catClassificationCode,function(data){
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