console.log("category module...");

var categoryService = (function(){
	function getCategorylist(param, callback, error){
		var catClassificationCode = param.catClassificationCode;
		
		$.getJSON("/mypage/categorylist/"+catClassificationCode,function(data){
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
	function getCitylist(callback, error){
		
		$.getJSON("/mypage/citylist/",function(data){
			if(callback){
				callback(data);
			}
		}).fail(function(xhr,status,err){
			if(error){
				error();
			}
		});
	}
	function getDistrictlist(param, callback, error){
		var rgName = param.rgName;
		
		$.getJSON("/mypage/districtlist/"+rgName,function(data){
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
		getCitylist : getCitylist,
		getDistrictlist : getDistrictlist
	};
	
})();