NoticeConfig = function(){
	
	this._popupStatus = false;
	this._jsonNewNotice;
	
	this.show = function(){
		this.centerPopup();
		this.loadPopup();
	}
	this.close = function(){
		this.disablePopup();
	}
	this.onSubmit;
	
	this.centerPopup = function(){
	  //화면 중앙에 자리잡게 하기 위한 요청 / request data for centering
	  var windowWidth = document.documentElement.clientWidth;
	  var windowHeight = document.documentElement.clientHeight;
	  var popupHeight = $("#form_Notice").height();
	  var popupWidth = $("#form_Notice").width();
	  //중앙에 위치시키기 / centering
	  $("#form_Notice").css({
	    "position": "absolute",
	    "top": windowHeight/2-popupHeight/2,
	    "left": windowWidth/2-popupWidth/2
	  });
	  //IE6 을 위한 핵 / only need force for IE6
	  $("#backgroundPopup").css({
	    "height": windowHeight
	  });
	};
	
	this.loadPopup = function(){
	  //팝업은 popupStatus 가 비활성화되어 있을때만 불러진다. / loads popup only if it is disabled
	  if(this._popupStatus === false){
		  $("#backgroundPopup").css({
		     "opacity": "0.7"
		   });
		   $("#backgroundPopup").fadeIn("slow");
		   $("#form_Notice").fadeIn("slow");
	      this._popupStatus = true;
	   }
	};
	
	//disabling popup with jQuery magic!
	this.disablePopup = function(){
		//popupStatus 가 활성화 되어 있다면 비활성화 시키기 / disables popup only if it is enabled
		if(this._popupStatus === true){
			
			$("#backgroundPopup").fadeOut("fast");
			$("#form_Notice").fadeOut("fast");
			this._popupStatus = false;
			
		}
	};
	
	this.setJsonData = function(jsonData){
		this._jsonNewNotice = jsonData;
		var nowDate = new Date();
		$("#form_Notice input[name='notice_fix']").attr("checked", (jsonData.fixed === "true")? "checked" : null);
	    $("#form_Notice input[name='contentID']").attr("value", jsonData.contentID);
	    $("#form_Notice input[name='type']").attr("value", jsonData.type);
	    $("#form_Notice input[name='subject']").attr("value", jsonData.subject);
	    $("#form_Notice input[name='href']").attr("value", jsonData.href);
	    $("#form_Notice input[name='file']").attr("value", jsonData.file);
	    $("#form_Notice input[name='date']").attr("value", jsonData.date);
	    $("#form_Notice #calendar_Start").attr("value", jsonData.sdate);
	    $("#form_Notice #calendar_End").attr("value", jsonData.edate);
	}
	
	this.getJsonNewNotice = function(){
		return this._jsonNewNotice;
	}
	
	this.submitDataByAjax = function(){
		this._jsonNewNotice.sdate = $("#form_Notice #calendar_Start").attr("value");
		this._jsonNewNotice.edate = $("#form_Notice #calendar_End").attr("value");
		
		// if($("#form_Notice #checkBox_NoticeFixEnable").attr("checked") === "checked"){
			// this._jsonNewNotice.notice_fix = "true";
		// }		
		$.post(
			$("#form_Notice").attr("action"),
			$("#form_Notice").serialize()
		)
		//alert("성공이당");
	}
	
	this.submit_OnClick = function(){
		this.close();
		this.submitDataByAjax();
		this.onSubmit();
		return false;
	}
	
	
	
	this.initEvent = function(noticeConfig){
		$("#notice_close").click(function(){
			noticeConfig.disablePopup();
		});
		// $("#button_NoticeSubmit").click(function(){
			// return noticeConfig.submit_OnClick();
		// });
		$(function() {
		  $( "#calendar_Start, #calendar_End" ).datepicker({
		    dateFormat: 'yy-mm-dd',
		    prevText: '이전 달',
		    nextText: '다음 달',
		    monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		    monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		    dayNames: ['일','월','화','수','목','금','토'],
		    dayNamesShort: ['일','월','화','수','목','금','토'],
		    dayNamesMin: ['일','월','화','수','목','금','토'],
		    showMonthAfterYear: true,
		    yearSuffix: '년'
		  });
		});
	}
}

Forum = function(){
	
	this._noticeConfig = new NoticeConfig();
	
	this.checkAll = function(){
		if ($("#checkBox_allCheck").attr("checked") === "checked"){
			$("#forum input:checkbox").attr("checked", "checked");
		}
		else{
			$("#forum input:checkbox").attr("checked", null);
		}
	}
	
	this.showNoticeConfig = function(nodeAnchor){
	    this._noticeConfig.setJsonData(this.getJsonDataByAnchor(nodeAnchor));
		this._noticeConfig.show();
	}
	
	this.getJsonDataByAnchor = function(nodeAnchor){
		var nodeTr = nodeAnchor.parentNode.parentNode;
		var nowDate = new Date();
		
		if (nodeTr.className !== "notice_fix"){
			return {
				fixed : "false", 
		        contentID : nodeTr.childNodes[1].firstChild.value,
		        type : nodeTr.childNodes[7].firstChild.nodeValue,
		        subject : nodeTr.childNodes[9].childNodes[1].childNodes[0].nodeValue,
		        href : nodeTr.childNodes[9].childNodes[1].href,
		        file : nodeTr.childNodes[11].childNodes[0].nodeValue,
		        date : nodeTr.childNodes[13].childNodes[0].nodeValue,
		        sdate : nodeTr.childNodes[13].childNodes[0].nodeValue,
		        edate : nowDate.getFullYear() + "-" + (nowDate.getMonth() + 1) + "-" + nowDate.getDate()
		   };
	  	}
	  	else{
	  		return {
	  			fixed : "true",
	  			contentID : nodeTr.childNodes[1].childNodes[1].value,
		        type : nodeTr.childNodes[5].firstChild.nodeValue,
		        subject : nodeTr.childNodes[7].childNodes[1].childNodes[0].nodeValue,
		        href : nodeTr.childNodes[7].childNodes[1].href,
		        file : nodeTr.childNodes[9].childNodes[0].nodeValue,
		        date : nodeTr.childNodes[11].childNodes[0].nodeValue,
		        sdate : nodeTr.childNodes[1].childNodes[3].value,
		        edate : nodeTr.childNodes[1].childNodes[5].value
	  		};
	  	}
	}
	
	this.removeLastNoticeFix = function(){
		var jqNodeList = $("#forum tr.notice_fix");
		if(jqNodeList.length === 5){
			jqNodeList.last().remove();
		}
	}
	this.removeNewMark = function(){
		$("#forum strong.new").remove();
	}
	this.addNewNoticeFix = function(jsonData){
		var jqNode1stNoticeFix = $("#forum table tr.notice_fix:first-child");
		
		$(this.createNoticeFix(jsonData)).insertBefore(jqNode1stNoticeFix);
		$("#forum table tbody:first-child")
	}

	this.applyNoticeFix = function(jsonData){
		// contentID
		var jqNode = $("#forum table tbody input[value='" + jsonData.contentID + "']");
		
		// 하나도 없으면 추가다.
		if ((jqNode != null) && 
			(jqNode.length === 0)){
			
		}
		// 하나 있을 경우엔 변경
		else{
			// 적용 여부 체크가 되어 있다면 변경
			if (jsonData.notice_fix == "true"){
				
			}
			// 적용 여부 체크 해제 되어 있다면 제거
			else{
				
			}
		}
	}
	this.createNoticeFix = function(jsonData){
		var sNoticeFixHtml = "<tr class=\"notice_fix\">" + 
			"<td>" +
				"<input type=\"hidden\" name=\"contentID\" value=\"" + jsonData.contentID + "\" />" +
				"<input type=\"hidden\" name=\"sdate\" value=\"" + jsonData.sdate + "\" />" +
				"<input type=\"hidden\" name=\"edate\" value=\"" + jsonData.edate + "\" />" +
			"</td>" +
			"<td><a href=\"#\" class=\"notice_config\">설정</a></td>" +
            "<td class=\"type_notice\">" + jsonData.type + "</td>" +
            "<td class=\"subject_notice\" colspan=\"2\">" +
            	"<a href=\"" + jsonData.href + "\">" + jsonData.subject + "</a> <strong class=\"new\">New</strong></td>" +
            "<td class=\"file\">" + jsonData.file + "</td>" +
            "<td class=\"date\">" + jsonData.date + "</td></tr>";
        return sNoticeFixHtml;
	}
	
	this.initEvent = function(forum){
		$("#checkBox_allCheck").click(function(){
			forum.checkAll();
		});
		$("#forum table tbody a.notice_config").click(function(){
			forum.showNoticeConfig(this);
		});
		$("#forum table tbody input:checkbox").click(function(){
		    
		});
		this._noticeConfig.initEvent(this._noticeConfig);
		//this._noticeConfig.onSubmit = function(){alert("하하")};
	}
}



var forum;

$(document).ready(function(){
	forum = new Forum();
	forum.initEvent(forum);
	//forum.removeLastNoticeFix();
});