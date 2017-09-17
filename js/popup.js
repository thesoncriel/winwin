/*
  * 자바스크립트 쿠키 함수
  * 출처: http://blog.naver.com/PostView.nhn?blogId=devstory&logNo=120008273591
  */
 
 /**
  * 쿠키값 추출
  * @param cookieName 쿠키명
  */
 function Cookie(){
 this.getCookie = function( cookieName )
 {
  var search = cookieName + "=";
  var cookie = document.cookie;
  // 현재 쿠키가 존재할 경우
  if( cookie.length > 0 )
  {
   // 해당 쿠키명이 존재하는지 검색한 후 존재하면 위치를 리턴.
   startIndex = cookie.indexOf( cookieName );
   // 만약 존재한다면
   if( startIndex != -1 )
   {
    // 값을 얻어내기 위해 시작 인덱스 조절
    startIndex += cookieName.length;
    // 값을 얻어내기 위해 종료 인덱스 추출
    endIndex = cookie.indexOf( ";", startIndex );
    // 만약 종료 인덱스를 못찾게 되면 쿠키 전체길이로 설정
    if( endIndex == -1) endIndex = cookie.length;
    // 쿠키값을 추출하여 리턴
    return unescape( cookie.substring( startIndex + 1, endIndex ) );
   }
   else
   {
    // 쿠키 내에 해당 쿠키가 존재하지 않을 경우
    return null;
   }
  }
  else
  {
   // 쿠키 자체가 없을 경우
   return null;
  }
 }
 
 /**
  * 쿠키 설정
  * @param cookieName 쿠키명
  * @param cookieValue 쿠키값
  * @param expireDay 쿠키 유효날짜
  */
 this.setCookie = function( cookieName, cookieValue, expireDate )
 {
  var today = new Date();
  today.setDate( today.getDate() + parseInt( expireDate ) );
  document.cookie = cookieName + "=" + escape( cookieValue ) + "; path=/; expires=" + today.toGMTString() + ";";
 }
 
 /**
  * 쿠키 삭제
  * @param cookieName 삭제할 쿠키명
  */
 this.deleteCookie = function( cookieName )
 {
  var expireDate = new Date();
  
  //어제 날짜를 쿠키 소멸 날짜로 설정한다.
  expireDate.setDate( expireDate.getDate() - 1 );
  document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString() + "; path=/";
 }
};




function Popup(){
	this.NEVER_OPEN_DAY_LIMIT = 1;
	this.NEVER_OPEN_DAY_KEYWORD = "popupUnuse";

	this._imagePath = "";
	this._url = "";
	this._popupStatus = false;
	this._popupNode = $("#popupContact");
	this._configMode = (document.getElementById("isconfig") !== null);
	
	this._cookie = new Cookie();
	
	this.isConfigMode = function(){
		return this._configMode;
	}
	this.setTitle = function(strTitle){
		$("#popup_title").text(strTitle);
	}
	this.setWidth = function(intWidth){ 
		$("#popupContact").css("width", intWidth);
	};
	this.getWidth = function(){ 
		return $("#popupContact").css("width");
	};
	this.setHeight = function(intHeight){ 
		$("#popupContact").css("height", intHeight);
	};
	this.getHeight = function(){ 
		return $("#popupContact").css("height");
	};
	this.setImagePath = function(strPath){
		$("#popupContact #popup_link img").attr("src", strPath);
	};
	this.getImagePath = function(){ 
		return $("#popupContact #popup_link img").attr("src");
	};
	this.setUrl = function(strUrl){ 
		$("#popupContact #popup_link").attr("href", strPath); 
	};
	this.getUrl = function(){ 
		return $("#popupContact #popup_link").attr("href"); 
	};
	
	this.open = function(){
		if (this._configMode === true){
			$("#popupContact").fadeIn("slow");
			return;
		}
		if (this._cookie.getCookie(this.NEVER_OPEN_DAY_KEYWORD) == null){
			
		}
		this.centerPopup();
			this.loadPopup();
	};
	this.close = function(){
		if(this._configMode === false) this.disablePopup();
	}
	this.closeAndNeverOpen = function(){
		this._cookie.setCookie(this.NEVER_OPEN_DAY_KEYWORD, "true", 1);
		this.close();
	}
	
	this.loadPopup = function(){
	  //팝업은 popupStatus 가 비활성화되어 있을때만 불러진다. / loads popup only if it is disabled
	  if(this._popupStatus === false){
		  $("#backgroundPopup").css({
		     "opacity": "0.7"
		   });
		   $("#backgroundPopup").fadeIn("slow");
		   $("#popupContact").fadeIn("slow");
	      this._popupStatus = true;
	   }
	};
	
	//disabling popup with jQuery magic!
	this.disablePopup = function(){
		//popupStatus 가 활성화 되어 있다면 비활성화 시키기 / disables popup only if it is enabled
		if(this._popupStatus === true){
			
			$("#backgroundPopup").fadeOut("slow");
			$("#popupContact").fadeOut("slow");
			this._popupStatus = false;
			
		}
	};
	
	//centering popup
	this.centerPopup = function(){
	  //화면 중앙에 자리잡게 하기 위한 요청 / request data for centering
	  var windowWidth = document.documentElement.clientWidth;
	  var windowHeight = document.documentElement.clientHeight;
	  var popupHeight = $("#popupContact").height();
	  var popupWidth = $("#popupContact").width();
	  //중앙에 위치시키기 / centering
	  $("#popupContact").css({
	    "position": "absolute",
	    "top": windowHeight/2-popupHeight/2,
	    "left": windowWidth/2-popupWidth/2
	  });
	  //IE6 을 위한 핵 / only need force for IE6
	  $("#backgroundPopup").css({
	    "height": windowHeight
	  });
	};
	
	this.clearNeverOpenInfo = function(){
		this._cookie.deleteCookie(this.NEVER_OPEN_DAY_KEYWORD);
	}

	this.initEvent = function(popup){
		$("#popupContactClose").click(function() { popup.close() } );	
		$("#checkBox_neverOpenOnDay").click(function() { popup.closeAndNeverOpen() } );				
	};
	
};

function PopupConfig(popup){
	this._popup = popup;
	this._uploadStatus = false;
	
	this.initEvent = function(popupConfig){
		$("#form_PopupConfig input").change(function(){
			popupConfig.inputBox_OnChange(this);
		});
		$("#fileBox_Image").change(function(){
			popupConfig.inputBox_OnChange(this);
		});
		$("#form_ImgUpload").ajaxForm({
			url : "controller/file_uploader.jsp",
			type : "post",
			dataType : "text",
			beforeSerialize: function(){
				
			},
			beforeSubmit : function(){
				
			},
			success : function(data){
				//data = data.replace("/[<][^>]*[>]/gi", "");
			},
			handleError : function(){
				alert("에러났다 -_-");
			}
		});
		// $(function(){
			// var frm = $("#form_ImgUpload");
			// frm.ajaxForm(fileUploadCallback);
			// frm.submit(function(){return false;});
		// }); 
	}
	
	this.inputBox_OnChange = function(nodeInput){
		if 		(nodeInput.name === "title"){
			this._popup.setTitle( $("#textBox_Title").attr("value") );
		}
		else if (nodeInput.name === "width"){
			this._popup.setWidth( $("#textBox_Width").attr("value") );
		}
		else if (nodeInput.name === "height"){
			this._popup.setHeight( $("#textBox_Height").attr("value") );
		}
		else if (nodeInput.name === "imgFile"){
			this.fileUpload();
			var sFileName = $("#fileBox_Image").attr("value");
			sFileName = sFileName.substring(12);
			this._popup.setImagePath("http://www.winwingrowth.or.kr/upload/popup/" + sFileName);
		}
		else if (nodeInput.name === "linkPath"){
			this._popup.setUrl( $("#textBox_LinkPath").attr("value") );
		}
	}
	
	this.fileUpload = function(){
		if(this._uploadStatus === false){
			this._uploadStatus = true;
			try{
				$("#form_ImgUpload").submit();
			}
			catch(e){
				
			}
		}
	}
}

function fileUploadCallback(data, state){
		//alert(data);
	}


var popup = null;
var popupConfig = null;
	    	
$(document).ready(function(){
	popup = new Popup();
	popup.setWidth(430);
	popup.setHeight(400);
	popup.initEvent(popup);
	//popup.clearNeverOpenInfo();
	popup.open();
	
	if (popup.isConfigMode() === true){
		popupConfig = new PopupConfig(popup);
		popupConfig.initEvent(popupConfig);
	}
});