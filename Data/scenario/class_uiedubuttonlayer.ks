*start
;--------------------------------------------------------------------------------------------------------------
;带悬停效果的地图按钮层,输出x,y,normal,over,on,use(visible),place,storage,target,cond
;--------------------------------------------------------------------------------------------------------------
[iscript]
class uiEduButtonLayer extends uiButtonLayer
{

	var name;
	var storage;
	var target;
	var cond;
	var exp;

	var onenter;
	var onleave;

	var btntype;
	var ctype="btn";

  //---------------------------------------------------创建---------------------------------------------------
  function uiEduButtonLayer(elm)
  {
     	super.Layer(kag, parent);

		hitType = htMask;
		hitThreshold =0;
		focusable=true;

		//描绘
		visible=elm.use;
		Reset(elm);
  }
  //---------------------------------------------------坐标---------------------------------------------------
function drawXY()
{
 with(kag.fore.layers[3])
 {
   .font.height=16;
   .fillRect(sf.gs.width+230,725,100,20,0xFFD4D0C8);
   .drawText(sf.gs.width+230,725, "("+left+","+top+")", 0x000000);
 }
}
   //---------------------------------------------------输出---------------------------------------------------
   function LayerElm()
   {
      var dic=new Dictionary();
      //将该层的各数据输出，供字典保存用
      dic.normal=this.normal;
      dic.over=this.over;
      dic.on=this.on;
      dic.x=this.left;
      dic.y=this.top;
      dic.use=this.visible;
      
      dic.name=this.name;
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
	  dic.ctype="btn";

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
    
    this.name=elm.name;
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
