*start

;--------------------------------------------------------------------------------------------------------------
;带悬停效果的地图按钮层,输出x,y,normal,over,on,use(visible),place,storage,target,cond
;--------------------------------------------------------------------------------------------------------------
[iscript]
class uiMapButtonLayer extends uiLayer
{
	var normal;
	var over;
	var on;
	
	var place;
	var storage;
	var target;
	var cond;
	var exp;
	
	var enterse;
	var clickse;
	
	var onenter;
	var onleave;

	var usetext;
	var fontface;
	var text;
	var textsize;
	var normalcolor;
	var overcolor;
	var oncolor;


	var btntype;

  //---------------------------------------------------创建---------------------------------------------------
  function uiMapButtonLayer(elm)
  {
     	super.Layer(kag, parent);

		hitType = htMask;
		hitThreshold =0;
		focusable=true;

		//描绘
		visible=elm.use;
		Reset(elm);
  }
  //---------------------------------------------------描绘---------------------------------------------------
  function drawSelect(state=normal,stnum=0)
  {
    this.loadImages(state);
    this.setSizeToImageSize();

	//额外描绘文字
	if (usetext && text!=void)
	{
		//文字大小
		this.font.height=(int)textsize;
		//坐标
		var x=(this.width-font.getTextWidth(text))/2;
		var y=(this.height-font.getTextHeight(text))/2;
	
		//颜色
		var cur_color;
		if (stnum==0) cur_color=normalcolor;
		else if (stnum==1) cur_color=overcolor;
		else cur_color=oncolor;
	
		drawText(x,y,text,cur_color);
	}

    //假如选中,带边框
    if (select)
    {
      fillRect(0,0,width,1,0xCCFF0000);
      fillRect(0,0,1,height,0xCCFF0000);
      fillRect(0,height-1,width,1,0xCCFF0000);
      fillRect(width-1,0,1,height,0xCCFF0000);
    }
  }
   //---------------------------------------------------悬停---------------------------------------------------
   function onMouseEnter()
   {
      drawSelect(over,1);
      if (enterse!=void && kag.fore.layers[5].visible==false && kag.fore.layers[7].visible==false) 
      {
         kag.tagHandlers.playse(%[
         "storage" => enterse,
         "loop" => false
         ]);}
   }
   function onMouseLeave()
   {
      drawSelect(normal,0);
   }
   function onClick()
   {
      drawSelect(on,2);
      if (clickse!=void && kag.fore.layers[5].visible==false && kag.fore.layers[7].visible==false) 
      {
         kag.tagHandlers.playse(%[
         "storage" => clickse,
         "loop" => false
         ]);}
   }
   //---------------------------------------------------输出---------------------------------------------------
   function ButtonElm()
   {
      var dic=new Dictionary();
      //将该层的各数据输出，供字典保存用
      dic.normal=this.normal;
      dic.over=this.over;
      dic.on=this.on;
      dic.x=this.left;
      dic.y=this.top;
      dic.use=this.visible;
      
      dic.place=this.place;
      dic.storage=this.storage;
      dic.target=this.target;
      dic.cond=this.cond;
      dic.exp=this.exp;

      dic.enterse=this.enterse;
      dic.clickse=this.clickse;
	  
      dic.onenter=this.onenter;
      dic.onleave=this.onleave;

      dic.usetext=this.usetext;
      dic.fontface=this.fontface;
      dic.textsize=this.textsize;
      dic.text=this.text;

      dic.normalcolor=this.normalcolor;
      dic.overcolor=this.overcolor;
      dic.oncolor=this.oncolor;

	  dic.btntype=this.btntype;

      return dic;
   }
   //----------------------------------根据传入参数重设层的值---------------------------------------------------
   function Reset(elm)
   {
    this.normal=elm.normal;
    this.over=elm.over;
    this.on=elm.on;
    this.left=elm.x;
    this.top=elm.y;
    
    this.place=elm.place;
    this.storage=elm.storage;
    this.target=elm.target;
    this.cond=elm.cond;
    this.exp=elm.exp;

	this.enterse=elm.enterse;
	this.clickse=elm.clickse;
	
	this.onenter=elm.onenter;
	this.onleave=elm.onleave;

	//设定使用文字
	this.usetext=elm.usetext;
	this.fontface=elm.fontface;
	this.textsize=elm.textsize;
	this.text=elm.text;

	this.normalcolor=elm.normalcolor;
	this.overcolor=elm.overcolor;
	this.oncolor=elm.oncolor;

	this.btntype=elm.btntype;

    this.drawSelect();
   }
}
[endscript]
;-----------------------------------------------------------------------------------
[return]
