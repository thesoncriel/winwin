
function Main(){
	
	
	this.initEvent = function(main){
		$("#left_slide_menu img").click(function(){
			main.m_change(parseInt(this.id.substring(2,3)), this.src);
		});
		$("#left_slide_menu img").focus(function(){
			main.m_change(parseInt(this.id.substring(2,3)), this.src);
		});
		$("a[class^='tab_']").click(function(){
			main.tableCaption_OnClick(this);
		});
	}
	
	/*왼쪽 슬라이드 메뉴 이미지 온오프 */
	this.m_change = function(m_id, m_src) {
		if (-1 == m_src.indexOf("_on")) {
			for (var i = 1; i < 7; i++) {
				var UpMid = "m_" + i;
				var ObjUpImg = document.getElementById(UpMid);
				ObjUpImg.src = ObjUpImg.src.replace("_on", "_off");
			}

			var ClickMid = "m_" + m_id;
			var ObjClickImg = document.getElementById(ClickMid);

			ObjClickImg.src = ObjClickImg.src.replace("_off", "_on");
		}
	}
	
	this.tableCaption_OnClick = function(nodeAnchor){
		var sName = nodeAnchor.className;
		var sSpec = sName.replace("tab_", "").replace("_selected", "");
		var sAlt = this.changeTabName(sSpec);
		var bSelected = (sName.replace("tab_", "").replace(sSpec, "") === "_selected");
		var jqNodeAlt = $("#preview .tab_" + sAlt + "_selected");
		
		if (bSelected === false){
			$("#preview ." + sAlt + " table tbody").css("visibility", "hidden");
			jqNodeAlt.removeClass("tab_" + sAlt + "_selected");
			jqNodeAlt.addClass("tab_" + sAlt);
			$("#preview ." + sSpec + " table tbody").css("visibility", "visible");
			nodeAnchor.className = "tab_" + sSpec + "_selected";
		}
	}
	
	this.changeTabName = function(sSpec){
		if(sSpec === "notice") return "chairman";
		if(sSpec === "chairman") return "notice";
		if(sSpec === "report") return "commmittee";
		if(sSpec === "commmittee") return "report";
	}
}

var main;

$(document).ready(function(){
	main = new Main();
	main.initEvent(main);
});
