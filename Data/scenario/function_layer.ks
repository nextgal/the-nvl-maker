;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;-----------------------------------------------------------------------------------
;界面设定用的显示层(拖拽移动等效果及界面编辑窗口控件)
;-----------------------------------------------------------------------------------
[iscript]
//描绘伪历史记录
function demoHistory()
{
     //描绘边框
     var x1=f.config_history.marginl;
     var x2=kag.fore.layers[4].width-f.config_history.marginr;
     var y1=f.config_history.margint;
     var y2=kag.fore.layers[4].height-f.config_history.marginb;
    
     var width=x2-x1;
     var height=y2-y1;

	var layer=kag.fore.layers[4];
     
     layer.fillRect(x1,y1,width,1,0xCCFFFFFF);
     layer.fillRect(x1,y2,width,1,0xCCFFFFFF);
     layer.fillRect(x1,y1,1,height,0xCCFFFFFF);
     layer.fillRect(x2,y1,1,height,0xCCFFFFFF);
     
    var text_x=x1+5;
    var text_y=y1+5;
    var text=getTransStr("文字显示范围");

    

    //默认字体
	layer.font.face=f.setting.history.face;
    //字体大小
    layer.font.height=f.setting.history.size;
	layer.font.bold=f.setting.history.bold;

	var dic=f.setting.font;
	var text_color=dic.color;

	if (dic.edge)
	{
	    layer.drawText(text_x,text_y,text,text_color,255,true,255,dic.edgecolor,1,0,0);
	}
	else if (dic.shadow)
	{
	    layer.drawText(text_x,text_y,text,text_color,255,true,255,dic.shadowcolor,0,2,2);
	}
	else
	{
	    layer.drawText(text_x,text_y,text,text_color,255,true);
	}

}
[endscript]
;--------------------------------------------------------------
;特殊描绘-显示,隐藏对话框
;--------------------------------------------------------------
[iscript]
function drawView(title,layer,posX,posY,target)
{

	title=getTransStr(title);

  //描绘勾选框
  kag.tagHandlers.locate(%["x"=>posX,"y"=>posY+6]);
  var result=layer!.visible;
  //值为真
  if (result==true)
  {
    kag.tagHandlers.button(%[
    "normal"=>"edit_check_visible",
    "exp"=>layer+".visible=false",
    "target"=>"*window"
    ]);
  }
  //值为假
  else if (result==false)
  {
    kag.tagHandlers.button(%[
    "normal"=>"edit_check_invisible",
    "exp"=>layer+".visible=true",
    "target"=>"*window"
    ]);
  }

	//文字内容修改
	//title=NVL_i18n_translate(title);
	//描绘提示文字
	kag.tagHandlers.locate(%["x"=>posX+25,"y"=>posY]);
	kag.tagHandlers.ch(%["text"=>title]);

  //描绘设定link
if (target!=void) 
  {     //空格
        kag.tagHandlers.ch(%["text"=>" "]);
       //连接
        var setting=new Dictionary();
        setting.target=target;
        setting.hint=getTransStr("点此打开对话框详细设定窗口");
        kag.tagHandlers.link(setting);
        //方块
        kag.tagHandlers.ch(%["text"=>"□"]);
        kag.tagHandlers.endlink(%[]);
    }
}
[endscript]
;--------------------------------------------------------------
;特殊描绘:地图按钮设定
;--------------------------------------------------------------
[iscript]
function drawMapButtonSetting(title,layer,x,y)
{
       //勾选框
       drawCheck(title,layer+".visible",x,y);
       //空格
        kag.tagHandlers.ch(%["text"=>" "]);
       //连接
        var setting=new Dictionary();
        setting.target="*按钮设定";
        setting.hint=getTransStr("点此打开地图按钮设定窗口");
        //将值传递给f.参数并记录当前层的名字以便之后reset
        setting.exp="f.参数="+layer+".ButtonElm(),tf.当前操作层=\'"+layer+"\'";
        kag.tagHandlers.link(setting);
        //方块
        kag.tagHandlers.ch(%["text"=>"□"]);
        kag.tagHandlers.endlink(%[]);
}
[endscript]
;--------------------------------------------------------------
;特殊描绘:系统按钮设定
;--------------------------------------------------------------
[iscript]
function drawButtonSetting(title,layer,x,y)
{
       //勾选框
       drawCheck(title,layer+".visible",x,y);
       //空格
        kag.tagHandlers.ch(%["text"=>" "]);
       //连接
        var setting=new Dictionary();
        setting.target="*按钮设定";
        setting.hint=getTransStr("点此打开按钮详细设定窗口");
        //将值传递给f.参数并记录当前层的名字以便之后reset
        setting.exp="f.参数="+layer+".ButtonElm(),tf.当前操作层=\'"+layer+"\'";
        kag.tagHandlers.link(setting);
        //方块
        kag.tagHandlers.ch(%["text"=>"□"]);
        kag.tagHandlers.endlink(%[]);
}
[endscript]
;--------------------------------------------------------------
;特殊描绘:滑动槽设定
;--------------------------------------------------------------
[iscript]
function drawSliderSetting(title,layer,x,y)
{
       //勾选框
       drawCheck(title,layer+".visible",x,y);
       //空格
        kag.tagHandlers.ch(%["text"=>" "]);
       //连接
        var setting=new Dictionary();
        setting.target="*滑动槽设定";
        setting.hint=getTransStr("点此打开滑动槽详细设定窗口");
        //将值传递给f.参数并记录当前层的名字以便之后reset
        setting.exp="f.参数="+layer+".SliderElm(),tf.当前操作层=\'"+layer+"\'";
        kag.tagHandlers.link(setting);
        //方块
        kag.tagHandlers.ch(%["text"=>"□"]);
        kag.tagHandlers.endlink(%[]);
}
[endscript]
;--------------------------------------------------------------------------------------------------------------
;自定义用于调整窗口margin的层
;--------------------------------------------------------------------------------------------------------------
[iscript]
class getMarginLayer extends Layer
{
   //左上/右下点坐标定义
   var x1;
   var y1;
   var x2;
   var y2;
   //是否拖动中
   var pick;
   //父层
   var parent=kag.fore.layers[8];
   var frame;
   
function finalize() 
{
	this.visible=false;
	super.finalize(...);
}
//创建层
      function getMarginLayer(frame)
  {
     super.Layer(kag, parent);
     left=0;
	 top=0;
	 this.frame=frame;
	 loadImages(frame);
	 setSizeToImageSize();
	 
	 x1=f.参数.marginl;
	 y1=f.参数.margint;
	 x2=this.width-f.参数.marginr;
	 y2=this.height-f.参数.marginb;
	 
	 drawMargin();
	 visible=true;
	 
	 hitType = htMask;
	 hitThreshold =0;

  }
//按下
   function onMouseDown(x, y, button, shift)
{
   if (button==mbLeft)
   {
     x1=this.cursorX;
     y1=this.cursorY;
     pick=true;
     drawMargin();
    }
}
//抬起
function onMouseUp(x, y, button, shift)
{
   if (button==mbLeft)
   {
      pick=false;
      drawMargin();
    }
}
//移动
  function onMouseMove(x, y, shift)
  {
    if (pick)
    {
        x2=this.cursorX;
        y2=this.cursorY;
        drawMargin();
    }
  }
//描绘
   function drawMargin()
   {
	 loadImages(frame);
     var width=x2-x1;
     var height=y2-y1;
     fillRect(x1,y1,width,1,0xFFFF0000);
     fillRect(x1,y2,width,1,0xFFFF0000);
     fillRect(x1,y1,1,height,0xFFFF0000);
     fillRect(x2,y1,1,height,0xFFFF0000);
     drawMarginXY();
   }

//坐标
function drawMarginXY()
{
   with(kag.fore.layers[7])
   {
      .fillRect(sf.gs.width+55,75,120,80,0xFFD4D0C8);
      .font.height=16;
      .drawText(sf.gs.width+55,75,"marginl = "+x1 , 0x000000);
      .drawText(sf.gs.width+55,95,"marginr = "+(width-x2) , 0x000000);
      .drawText(sf.gs.width+55,115,"margint = "+y1 , 0x000000);
      .drawText(sf.gs.width+55,135,"marginb = "+(height-y2) , 0x000000);
   }
}
//输出
   function MarginElm()
   {
      f.参数.marginl=x1;
      f.参数.margint=y1;
      f.参数.marginr=this.width-x2;
      f.参数.marginb=this.height-y2;
   }
}
[endscript]
;--------------------------------------------------------------------------------------------------------------
;自定义的用于界面设定的层-总类
;传入参数为字典类
;--------------------------------------------------------------------------------------------------------------
[iscript]
class uiLayer extends Layer
{
  //是否选中
  var select=false;
  //是否拖拽中
  var pick=false;
  //和鼠标游标的相对距离
  var disX;
  var disY;
  //图片
  var frame;
  //父层
  var parent=kag.fore.layers[4];
  //---------------------------------------------------创建---------------------------------------------------
  function uiLayer(elm)
  {
     	super.Layer(kag, parent); 
		frame=elm.frame;
		if (Storages.isExistentStorage(frame+".png") || Storages.isExistentStorage(frame+".jpg"))
		{
			loadImages(frame);
		}
		else
		{
			loadImages("edit_button_close");
		}

		setSizeToImageSize();
		left=elm.left;
		top=elm.top;
		visible=true;

		hitType = htMask;
		hitThreshold =0;
		focusable=true;
  }
  //---------------------------------------------------消除---------------------------------------------------
   function finalize() 
   {
      this.visible=false;
      super.finalize(...);
   }
  //---------------------------------------------------按下---------------------------------------------------
  function onMouseDown(x, y, button, shift)
  {
     if (button==mbLeft)
     {

        disX=this.cursorX;
        disY=this.cursorY;
        setselect();
        drawSelect();
        pick=true;
      //描绘坐标
      drawXY();
     }
   }
   //---------------------------------------------------抬起---------------------------------------------------
  function onMouseUp(x, y, button, shift)
  {
     if (button==mbLeft)
     {
        pick=false;
      }
   }
 //---------------------------------------------------拖动---------------------------------------------------
  function onMouseMove(x, y, shift)
  {
    if (pick && kag.fore.layers[5].visible==false && kag.fore.layers[7].visible==false)
    {
      this.left=kag.fore.base.cursorX-parent.left-disX;
      this.top=kag.fore.base.cursorY-parent.top-disY;
      //描绘坐标
      drawXY();
    }
  }
 //---------------------------------------------------键盘---------------------------------------------------
 function onKeyDown(key, shift)
 {
   if (select && kag.fore.layers[5].visible==false && kag.fore.layers[7].visible==false)
   {
      if (key==VK_LEFT && shift==void) left--;
      if (key==VK_RIGHT && shift==void) left++;
      if (key==VK_UP && shift==void) top--;
      if (key==VK_DOWN && shift==void) top++;
      
      if (key==VK_LEFT && shift==ssRepeat) left--;
      if (key==VK_RIGHT && shift==ssRepeat) left++;
      if (key==VK_UP && shift==ssRepeat) top--;
      if (key==VK_DOWN && shift==ssRepeat) top++;
      
      if (key==VK_LEFT && shift==ssShift) left-=10;
      if (key==VK_RIGHT && shift==ssShift) left+=10;
      if (key==VK_UP && shift==ssShift) top-=10;
      if (key==VK_DOWN && shift==ssShift) top+=10;
      drawXY();
   }
 }
  //---------------------------------------------------描绘---------------------------------------------------
  function drawSelect()
  {
    this.loadImages(frame);
    this.setSizeToImageSize();
    //假如选中,带边框
    if (select)
    {
      fillRect(0,0,width,1,0xCCFF0000);
      fillRect(0,0,1,height,0xCCFF0000);
      fillRect(0,height-1,width,1,0xCCFF0000);
      fillRect(width-1,0,1,height,0xCCFF0000);
    }
  }
  //---------------------------------------------------坐标---------------------------------------------------
function drawXY()
{
 with(kag.fore.layers[3])
 {
   .font.height=16;
   .fillRect(sf.gs.width+70,565,100,20,0xFFD4D0C8);
   .drawText(sf.gs.width+70,565, "("+left+","+top+")", 0x000000);
 }
}
   //---------------------------------------------------选中---------------------------------------------------
   function setselect()
   {
      //所有层全部unset
      for (var i=0;i<f.uilayer.count;i++)
      {
         if (f.uilayer[i].select)
         {
           f.uilayer[i].select=false;
           f.uilayer[i].drawSelect();
         }
      }
      this.select=true;
      this.drawSelect();
      this.focus();
   }
   //---------------------------------------------------输出---------------------------------------------------
   function LayerElm()
   {
      var dic=new Dictionary();
      //将该层的位置输出，供字典保存用
      dic.left=this.left;
      dic.top=this.top;
      return dic;
   }
}
[endscript]
;--------------------------------------------------------------------------------------------------------------
;scroll层
;--------------------------------------------------------------------------------------------------------------
[iscript]
class uiScrollLayer extends uiLayer
{
    var width;
    var height;
    var normal;
    var over;
	var back;
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
     	//按钮层
        var tabImage=new global.Layer(window, parent);
		if (Storages.isExistentStorage(normal+".png") || Storages.isExistentStorage(normal+".jpg"))
		{
			tabImage.loadImages(normal);
		}
		else
		{
			tabImage.loadImages("edit_button_close");
		}
        tabImage.setSizeToImageSize();
        var twidth  = tabImage.width;
        var theight = tabImage.height;
        operateRect(0, height-theight, tabImage, 0, 0, twidth, theight);
        
            //假如选中,带边框
            if (select)
         {
              fillRect(0,0,width,1,0xCCFF0000);
              fillRect(0,0,1,height,0xCCFF0000);
              fillRect(0,height-1,width,1,0xCCFF0000);
              fillRect(width-1,0,1,height,0xCCFF0000);
          }
   }
   //----------------------------------根据传入参数重设层的值---------------------------------------------------
   function Reset(elm)
   {
    this.normal=elm.normal;
    this.over=elm.over;
    this.back=elm.back;
    this.height=elm.height;
    this.width=elm.width;
    this.left=elm.x;
    this.top=elm.y;
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
      dic.height=this.height;
      dic.width=this.width;
      
      return dic;
   }
}
[endscript]
;--------------------------------------------------------------------------------------------------------------
;带有拖动按钮(伪)的slider层
;--------------------------------------------------------------------------------------------------------------
[iscript]
class uiSliderLayer extends uiLayer
{
   var base;
   var normal;
   var over;
   var on;
  //---------------------------------------------------创建---------------------------------------------------
  function uiSliderLayer(elm)
  {
     	super.Layer(kag, parent);
     	base=elm.base;
     	normal=elm.normal;
     	over=elm.over;
     	on=elm.on;
		left=elm.x;
		top=elm.y;
		visible=elm.use;
		//复制图片层及按钮
              drawSelect();

		hitType = htMask;
		hitThreshold =0;
		focusable=true;
  }
  //---------------------------------------------------描绘---------------------------------------------------
  function drawSelect(state=normal)
  {
  //清空图层
    fillRect(0,0,width,height,0x00FFFFFF);
    //重载数据
        var baseImage=new global.Layer(window, parent);
        baseImage.loadImages(base);
        baseImage.setSizeToImageSize();
        width= baseImage.width;
        height=baseImage.height;
        this.operateRect(0, 0, baseImage, 0, 0, width, height);
        
        var tabImage=new global.Layer(window, parent);
        tabImage.loadImages(state);
        tabImage.setSizeToImageSize();
        var twidth  = tabImage.width;
        var theight = tabImage.height;
        this.operateRect((width - twidth) / 2, (height - theight) / 2, tabImage, 0, 0, twidth, theight);
    //假如选中,带边框
    if (select)
    {
      fillRect(0,0,width,1,0xCCFF0000);
      fillRect(0,0,1,height,0xCCFF0000);
      fillRect(0,height-1,width,1,0xCCFF0000);
      fillRect(width-1,0,1,height,0xCCFF0000);
    }
  }
   //----------------------------------根据传入参数重设层的值---------------------------------------------------
   function Reset(elm)
   {
    this.normal=elm.normal;
    this.over=elm.over;
    this.on=elm.on;
    this.base=elm.base;
    this.left=elm.x;
    this.top=elm.y;
    this.drawSelect();
   }
   //---------------------------------------------------输出---------------------------------------------------
   function SliderElm()
   {
      var dic=new Dictionary();
      //将该层的位置输出，供字典保存用
      dic.x=this.left;
      dic.y=this.top;
      dic.base=this.base;
      dic.normal=this.normal;
      dic.over=this.over;
      dic.on=this.on;
      dic.use=this.visible;
      return dic;
   }
}
[endscript]
;--------------------------------------------------------------------------------------------------------------
;带有margin数据输出的对话框层
;--------------------------------------------------------------------------------------------------------------
[iscript]
class uiMessageLayer extends uiLayer
{
var marginl;
var marginr;
var margint;
var marginb;
  //---------------------------------------------------创建---------------------------------------------------
  function uiMessageLayer(elm)
  {
    super.uiLayer(elm);
    this.marginl=elm.marginl;
    this.marginr=elm.marginr;
    this.margint=elm.margint;
    this.marginb=elm.marginb;

	this.drawMargin();

  }

	function drawSelect()
	{
		super.drawSelect();
		this.drawMargin();
	}
   //----------------------------------根据传入参数重设层的值---------------------------------------------------
   function Reset(elm)
   {
    this.marginl=elm.marginl;
    this.marginr=elm.marginr;
    this.margint=elm.margint;
    this.marginb=elm.marginb;
    this.left=elm.left;
    this.top=elm.top;
    this.frame=elm.frame;

    this.drawSelect();
   }
	//描绘文字显示范围
	function drawMargin()
	{
		fillRect(marginl,margint,1,height-margint-marginb,0xFFFFFF);
		fillRect(width-marginr,margint,1,height-margint-marginb,0xFFFFFF);
		fillRect(marginl,margint,width-marginl-marginr,1,0xFFFFFF);
		fillRect(marginl,height-marginb,width-marginl-marginr,1,0xFFFFFF);

		//取得字体字号
		font.height=f.setting.font.size;
		font.face=f.setting.font.face;

		//翻译
		var text=getTransStr("文字显示范围");

		//drawText((int)marginl+(int)1,(int)margint+(int)1,text,0xFFFFFF,255,true);


		if (f.setting.font.edge)
		{
			drawText((int)marginl+(int)1,(int)margint+(int)1,text,f.setting.font.color, 255, true, 255, f.setting.font.edgecolor, 1, 0, 0);
		}
		else if (f.setting.font.shadow)
		{
			drawText((int)marginl+(int)1,(int)margint+(int)1,text,f.setting.font.color,255, true, 255, f.setting.font.shadowcolor, 0, 2, 2);
		}
		else
		{
			drawText((int)marginl+(int)1,(int)margint+(int)1,text,f.setting.font.color,255,true);
		}

	}
   //---------------------------------------------------输出---------------------------------------------------
   function MessageElm()
   {
      var dic=new Dictionary();
      //将该层的各数据输出，供字典保存用
      dic.frame=this.frame;
      dic.left=this.left;
      dic.top=this.top;
      dic.marginl=this.marginl;
      dic.marginr=this.marginr;
      dic.margint=this.margint;
      dic.marginb=this.marginb;
      return dic;
   }
}
[endscript]
;--------------------------------------------------------------------------------------------------------------
;带悬停效果的伪按钮层,输出x,y,normal,over,on,use(visible)
;--------------------------------------------------------------------------------------------------------------
[iscript]
class uiButtonLayer extends uiLayer
{
	var normal;
	var over;
	var on;
	var enterse;
	var clickse;
	
	var usetext;
	var fontface;
	var text;
	var textsize;
	var normalcolor;
	var overcolor;
	var oncolor;
  //---------------------------------------------------创建---------------------------------------------------
  function uiButtonLayer(elm)
  {
     	super.Layer(kag, parent); 

		visible=elm.use;
		
		hitType = htMask;
		hitThreshold =0;
		focusable=true;
		//读取参数
		Reset(elm);

  }
  //---------------------------------------------------描绘---------------------------------------------------
  function drawSelect(state=normal,stnum=0)
  {
	dm(state);

	if (Storages.isExistentStorage(state+".png") || Storages.isExistentStorage(state+".jpg"))
	{
	    this.loadImages(state);
	}
	else
	{
	    this.loadImages("edit_button_close");
	}
    this.setSizeToImageSize();

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
		//去掉扩展名
		enterse=Storages.chopStorageExt(enterse);
		if (Storages.isExistentStorage(enterse+".wav") || Storages.isExistentStorage(enterse+".ogg") || Storages.isExistentStorage(enterse+".mp3"))
		{
	         kag.tagHandlers.playse(%[
	         "storage" => enterse,
	         "loop" => false
	         ]);
		}
      }
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
		//去掉扩展名
		clickse=Storages.chopStorageExt(clickse);
		if (Storages.isExistentStorage(clickse+".wav") || Storages.isExistentStorage(clickse+".ogg") || Storages.isExistentStorage(clickse+".mp3"))
		{
	         kag.tagHandlers.playse(%[
	         "storage" => clickse,
	         "loop" => false
	         ]);
		}
      }
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

      dic.enterse=this.enterse;
      dic.clickse=this.clickse;

      dic.usetext=this.usetext;
      dic.fontface=this.fontface;
      dic.textsize=this.textsize;
      dic.text=this.text;

      dic.normalcolor=this.normalcolor;
      dic.overcolor=this.overcolor;
      dic.oncolor=this.oncolor;

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
	    this.enterse=elm.enterse;
	    this.clickse=elm.clickse;
	
		//设定使用文字
		this.usetext=elm.usetext;
		this.fontface=elm.fontface;
		this.textsize=elm.textsize;
		this.text=elm.text;
	
		this.normalcolor=elm.normalcolor;
		this.overcolor=elm.overcolor;
		this.oncolor=elm.oncolor;
	
	    this.drawSelect();
   }
}
[endscript]

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
