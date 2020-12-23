$(document).ready(function(){
	
	

	

/*-------------------탑버튼---------------------------------*/		
	
	$(window).scroll(function(){
		
		if($(this).scrollTop()<=200){ 
			$("#topbtn").hide();
        }else{
            $("#topbtn").show();
        }
				
	});
    
	
	$("#topbtn").click(function(){
		$("body,html").animate({scrollTop:"0"},3000);
		return false;
	});
	
/*-------------------비주얼---------------------------------*/	
	
 var oldidx=0;
 var idx=0;
    
    function changeImg(idx){
        
        if(oldidx!=idx){
            $(".back_visual li").eq(idx).stop(true,true).fadeIn(300); 
            $(".back_visual li").eq(oldidx).stop(true,true).fadeOut(300);
			$(".front_visual li").eq(idx).stop(true,true).fadeIn(300); 
            $(".front_visual li").eq(oldidx).stop(true,true).fadeOut(300); 
        }
        oldidx=idx; 
    }
   
    function changeAuto(){
        idx++;
        if(idx>2){ 
            idx=0;
        }
        changeImg(idx);
    }
    timer=setInterval(changeAuto,3000);	
     
});

