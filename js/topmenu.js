function TopMenu(){
    this._menuCount = 0;
    this._menuJqNodeList;
    this._subMenuJqNodeList;
    
    this.readAllMenuJqNodeList = function(){
        var index = 0;
        var node;
        var sNodeSelector = "";
        var sNodeSelectorSub = "";

        while(true){
            index++;
            node = document.getElementById("menu" + index);
            if (node !== null){
                if (index > 1){
                    sNodeSelector += ",";
                    sNodeSelectorSub += ",";
                }
                sNodeSelector += "#menu" + index;
                sNodeSelectorSub += "#menu" + index + "_sub";
            }
            else{
                break;
            }

            if (node.id === undefined) break;
        }
        
        this._menuCount = index;
        this._menuJqNodeList = $(sNodeSelector);
        this._subMenuJqNodeList = $(sNodeSelectorSub);
    }
    
    this.getAllMenuJqNodeList = function(){
        return this._menuJqNodeList;
    }
    
    this.hiddenAllMenu = function(){
        this._menuJqNodeList.removeClass("hover");
        this._subMenuJqNodeList.css("display", "none");
    }
    this.visibleAllMenu = function(){
        //this._menuJqNodeList.removeClass("hover");
        this._subMenuJqNodeList.css("display", "block");
    }

    this.topMenu_OnHover = function(nodeAnchor){
    	if ($("#top_nav>div").hasClass("menu_normal") === false) return;
    	
        var sSubMenuNodeName = nodeAnchor.id + "_sub";

        this.hiddenAllMenu();
        if (nodeAnchor.className !== "hover"){
            nodeAnchor.className = "hover";
            document.getElementById(sSubMenuNodeName).style.display = "inline-block";
        }
    }
    this.topMenu_OnAllMenuOpen = function(){
    	if ($("#top_nav>div").hasClass("menu_normal") === true){
    		$("#top_nav>div").removeClass("menu_normal");
    		$("#top_nav>div").addClass("menu_allmenu");
    		this.visibleAllMenu();
    	}
    	else{
    		this.topMenu_OnAllMenuClose();
    	}
    }
    this.topMenu_OnAllMenuClose = function(){
    	$("#top_nav>div").removeClass("menu_allmenu");
		$("#top_nav>div").addClass("menu_normal");
		this.hiddenAllMenu();
    }
    
    this.initEvent = function(topMenu){
        this._menuJqNodeList.hover(function() { 
               topMenu.topMenu_OnHover(this)
            }, null);
        $("#allmenu_close").click(function() {
        	topMenu.topMenu_OnAllMenuClose()
        });
        $("#allmenu").click(function() {
        	topMenu.topMenu_OnAllMenuOpen()
        });
    }
}

var topMenu;

(function(){
    $(document).ready(function(){
        topMenu = new TopMenu();
        topMenu.readAllMenuJqNodeList();
        topMenu.initEvent(topMenu);
    });
    $(window).load(function(){
	// Carousel > Demo #2
		$("#slide_icon").sliderkit({
			shownavitems:2,
			scroll:1,
			mousewheel:true,
			circular:true,
			start:2
		});

	});	
})();