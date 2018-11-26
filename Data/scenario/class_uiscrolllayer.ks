*start
;--------------------------------------------------------------------------------------------------------------
;自定义的用于界面设定的层
;滚动条
;--------------------------------------------------------------------------------------------------------------
[iscript]
class uiScrollLayer extends uiLayer
{
    var width;
    var height;

	var opacity;
	var color;

    var normal;
    var over;
	var on;

	var back;

	var button_w;
	var button_h;
	var button_color;
	var button_opacity;

   //---------------------------------------------------创建---------------------------------------------------
   function uiScrollLayer(elm)
   {
           	super.Layer(kag, parent);
              //loadImages("empty");
              //setSizeToImageSize();
           	left=elm.x;
           	top=elm.y;
           	height=elm.height;
           	width=elm.width;
			back=elm.back;

           	setSize(width, height);

			if (back!=void)
			{
				if (Storages.isExistentStorage(back+".png") || Storages.isExistentStorage(back+".jpg"))
				{
					loadImages(back);
					setSizeToImageSize();
					width=this.width;
					height=this.height;
				}
			}
				normal=elm.normal;
				over=elm.over;
				on=elm.on;

				opacity=elm.opacity;
				color=elm.color;

				button_w=elm.button_w;
				button_h=elm.button_h;
				button_color=elm.button_color;
				button_opacity=elm.button_opacity;
				
				visible=elm.use;
				  hitType = htMask;
				hitThreshold =0;
				focusable=true;
				drawSelect();
   }
   //---------------------------------------------------描绘---------------------------------------------------
   function drawSelect()
   {

       //底	
       	fillRect(0,0,width,height,0xCCFFFFFF);
		if (back!=void)
		{
			if (Storages.isExistentStorage(back+".png") || Storages.isExistentStorage(back+".jpg"))
			{
				loadImages(back);
				setSizeToImageSize();
			}
		}
		else
		{
			if (color!=void && opacity>0)
			{
       			fillRect(0,0,width,height,"0x"+global.d2x(opacity)+color.substr(2,6));
			}
		}

     	//按钮层
        var tabImage=new global.Layer(window, parent);
		if (Storages.isExistentStorage(normal+".png") || Storages.isExistentStorage(normal+".jpg"))
		{
			tabImage.loadImages(normal);
	        tabImage.setSizeToImageSize();
		}
		else
		{
			//tabImage.loadImages("edit_button_close");
			tabImage.width=button_w;
			tabImage.height=button_h;

			tabImage.fillRect(0,0,button_w,button_h,"0x"+global.d2x(button_opacity)+button_color.substr(2,6));
		}
	        var twidth  = tabImage.width;
	        var theight = tabImage.height;
        operateRect(0, height-theight, tabImage, 0, 0, twidth, theight);
        
	//描绘边框
	DrawSelectFrame();
   }
   //----------------------------------根据传入参数重设层的值---------------------------------------------------
   function Reset(elm)
   {
    this.normal=elm.normal;
    this.over=elm.over;
    this.on=elm.on;

    this.back=elm.back;
    this.height=elm.height;
    this.width=elm.width;

    this.color=elm.color;
    this.opacity=elm.opacity;

    this.left=elm.x;
    this.top=elm.y;

    this.button_w=elm.button_w;
    this.button_h=elm.button_h;

    this.button_color=elm.button_color;
    this.button_opacity=elm.button_opacity;


    this.drawSelect();
   }
   //---------------------------------------------------输出---------------------------------------------------
   function ScrollElm()
   {
      var dic=new Dictionary();
      //将该层的位置输出，供字典保存用
		dic.x=this.left;
		dic.y=this.top;
		dic.use=this.visible;
		dic.back=this.back;
		
		dic.normal=this.normal;
		dic.over=this.over;
		dic.on=this.on;
		
		dic.color=this.color;
		dic.opacity=this.opacity;
		
		dic.height=this.height;
		dic.width=this.width;
		
		dic.button_w=this.button_w;
		dic.button_h=this.button_h;
		
		dic.button_opacity=this.button_opacity;
		dic.button_color=this.button_color;
      
      return dic;
   }
}
[endscript]
[return]
