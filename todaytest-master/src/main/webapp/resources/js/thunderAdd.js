  $(document).ready(
			function() {
				var categoryArr = [ '관심분야선택', '아웃도어/여행', '문화/공연/축제',
						'운동/스포츠', '음악/악기', '외국/언어', '게임/오락', '기타' ];
				for (var i = 0; i < categoryArr.length; i++) {
					document.getElementById("category")[i] = new Option(
							categoryArr[i], categoryArr[i]);					
				}
			});			   
	
	
    $(function() {
		$('#city').change(function() {
			console.log("이건 되나?");
			region(this, $("#district"));
		});
	});
    
	
	function region(o, d) {
		var city = [ "지역 선택", "서울특별시", "경기도" ];

		var seoul = ["세부지역 선택", "강남구", "강동구", "강북구", "강서구", "관악구", "광진구", "구로구",
				"금천구", "노원구", "도봉구", "동대문구", "동작구", "마포구", "서대문구", "서초구",
				"성동구", "성북구", "송파구", "양천구", "영등포구", "용산구", "은평구", "종로구",
				"중구", "중랑구" ];

		var gyeonggi = ["세부지역 선택", "고양시", "과천시", "광명시", "광주시", "구리시", "군포시", "김포시",
				"남양주시", "동두천시", "부천시", "성남시", "수원시", "시흥시", "안산시", "안성시",
				"안양시", "양주시", "여주시", "오산시", "용인시", "의왕시", "의정부시", "이천시",
				"파주시", "평택시", "포천시", "하남시", "화성시", "가평군", "양평군", "연천군" ];
		
		let district;

		
		// change(function(){$( ':selected', o).val() => this }
		if ($(':selected', o).val() == "서울특별시") {
			console.log(1);
			district = seoul;
		} else if ($(':selected', o).val() == "경기도") {
			console.log(2);
			district = gyeonggi;
		} else {
			console.log(3);
			//다시 '시/도 선택'을 누르면 리턴
			return;
		}

		d.empty();

		for (var i = 0; i < district.length; i++) {
			var option = $("<option value=" + district[i] +">"
					+ district[i] + "</option>");
			d.append(option);
		}
	} 
	
	
	
	

function inputCheck(){
    	var clubname = document.add.cbName;
    	var intro = document.add.cbIntro;
    	
    	var date = $('#cbDate').val();
    	
    	var category = document.add.cbCategory;
    	var subcat = document.add.cbSubcat;
    	var mbnum = document.add.cbMbnum;
    	var appPeriod = $('#cbAppPeriod').val();  
    	var hashtag = document.add.cbHashtag;
    	var city = document.add.cbCity;
    	var district = document.add.cbDistrict;
    	var place = $('#cbPlace').val(); 
    	var supplies = $('#cbSupplies').val();  
    	
  		console.log(mbnum.value);
    	
    	if(!clubname.value || clubname.value.length>30){
    		alert("모임명을 다시 입력해주세요.");
    		return false;
    	}
    	    	
    	if(!intro.value || intro.value.length>30){
    		alert("모임소개를 다시 입력해주세요.");
    		return false;
    	}
    	if(!date ){
    		alert("모임날짜를 입력해주세요.");
    		return false;
    	}
    	
    	if(!category.value ){
    		alert("카테고리를 입력해주세요.");
    		return false;
    	}
    	
    	if(!subcat.value ){
    		alert("모임을 다시 입력해주세요.");
    		return false;
    	}
    	
    	if(!mbnum.value || mbnum.value < 0){
    		alert("모임인원을 다시 입력해주세요.");
    		return false;
    	}
    	
    	if(!appPeriod){
    		alert("모임 신청기간 다시 입력해주세요.");
    		return false;
    	}
    	
    	if(!hashtag.value || hashtag.value.length>30){
    		alert("해시태그를 다시 입력해주세요.");
    		return false;
    	}
    	
    	if(!city.value){
    		alert("지역을  입력해주세요.");
    		return false;
    	}
    	
    	if(!district.value){
    		alert("세부지역을  입력해주세요.");
    		return false;
    	}
    	
    	if(!place || place.length>30){
    		alert("모임장소를 다시 입력해주세요.");
    		return false;
    	}
    	
    	if(!supplies || supplies.length>30){
    		alert("모임 준비물을 다시 입력해주세요.");
    		return false;
    	}
    	
 
    	alert('개설되었습니다.');    	    
    }
    