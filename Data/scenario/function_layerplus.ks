;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;--------------------------------------------------------------
;特殊描繪:使用/不使用設定(+標籤自定義)
;--------------------------------------------------------------
[iscript]
function drawSLsetting(title,layer,x,y,target)
{
       //勾選框
       drawCheck(title,layer+".visible",x,y);
       if (target!=void)
       {
         //空格
          kag.tagHandlers.ch(%["text"=>" "]);
         //連接
          var setting=new Dictionary();
          setting.target=target;
          setting.hint="點此打開詳細設定窗口";
          kag.tagHandlers.link(setting);
          //方塊
          kag.tagHandlers.ch(%["text"=>"□"]);
          kag.tagHandlers.endlink(%[]);
       }
}
[endscript]
;-----------------------------------------------------------------------------------
;界面設定用的顯示層2-SL系統用
;包含：
;只有位置顯示的上下翻按鈕及返回按鈕
;懸停顯示的圖片位置
;懸停顯示的文字位置
;獨立ＳＬ按鈕（上面會根據樣式描繪文字並可以刷新）
;-----------------------------------------------------------------------------------
;SL按鈕
;-----------------------------------------------------------------------------------
[iscript]
class uiSLButton extends uiButtonLayer
{
   var normal;
   var over;
   var on;
   var num;
   
   function uiSLButton(num)
   {
      super.Layer(kag, parent);
      //圖像
      normal=f.config_sl.button.normal;
      over=f.config_sl.button.over;
      on=f.config_sl.button.on;
      //編號
      this.num=num;
      //載入圖片
	  loadImages(normal);
      setSizeToImageSize();
      
	  //根據locate顯示位置
	  left=f.config_slpos.locate[num][0];
	  top=f.config_slpos.locate[num][1];
	  visible=true;
	  
	  hitType = htMask;
	  hitThreshold =0;
	  focusable=true;
   }
  //---------------------------------------------------描繪---------------------------------------------------
  function drawSelect(state=normal,color="normal")
  {
    this.loadImages(state);
    this.setSizeToImageSize();
//默認字體

    this.font.bold=f.config_slpos.pagefont.bold;
    this.font.italic=f.config_slpos.pagefont.italic;
    var sha=f.config_slpos.pagefont.shadow;
    var shac=f.config_slpos.pagefont.shadowcolor;
    var edg=f.config_slpos.pagefont.edge;
    var edgc=f.config_slpos.pagefont.edgecolor;
    
//默認顏色
    var color1=f.config_sl.num.normal;
    var color2=f.config_sl.bookmark.normal;
    var color3=f.config_sl.date.normal;
    var color4=f.config_sl.history.normal;
//其他顏色
if (color=="over")
{
       color1=f.config_sl.num.over;
       color2=f.config_sl.bookmark.over;
       color3=f.config_sl.date.over;
       color4=f.config_sl.history.over;
}
if (color=="on")
{
       color1=f.config_sl.num.on;
       color2=f.config_sl.bookmark.on;
       color3=f.config_sl.date.on;
       color4=f.config_sl.history.on;
}
//--------------------------------------------
    if (f.config_slpos.num.use)
{
    //描繪檔案名
   this.font.height=f.config_slpos.num.height;
   var x=(int)f.config_slpos.num.x;
   var y=(int)f.config_slpos.num.y;
   var str=f.config_slpos.num.pre+(num*1+1)+f.config_slpos.num.after;
   if (sha) drawText(x,y, str, color1,255,true,255,shac,0,2,2);
   else if (edg) drawText(x,y, str, color1,255,true,255,edgc,1,0,0);
   else drawText(x,y, str, color1);
 }
 //--------------------------------------------
    if (f.config_slpos.bookmark.use)
{
    //描繪章節名
   this.font.height=f.config_slpos.bookmark.height;
   var x=(int)f.config_slpos.bookmark.x;
   var y=(int)f.config_slpos.bookmark.y;
   var str="第"+num+"章 章節名稱";
   if (sha) drawText(x,y, str, color2,255,true,255,shac,0,2,2);
   else if (edg) drawText(x,y, str, color2,255,true,255,edgc,1,0,0);
   else drawText(x,y, str, color2);
 }
 //--------------------------------------------
    if (f.config_slpos.date.use)
{
    //描繪日期
   this.font.height=f.config_slpos.date.height;
   var x=(int)f.config_slpos.date.x;
   var y=(int)f.config_slpos.date.y;
   var str="0000/00/00 00:00";
   if (sha) drawText(x,y, str, color3,255,true,255,shac,0,2,2);
   else if (edg) drawText(x,y, str, color3,255,true,255,edgc,1,0,0);
   else drawText(x,y, str, color3);
 }
    if (f.config_slpos.history.use)
{
    //描繪對話記錄
   this.font.height=f.config_slpos.history.height;
   var x=(int)f.config_slpos.history.x;
   var y=(int)f.config_slpos.history.y;
   var str="對話記錄……";
   if (sha) drawText(x,y, str, color4,255,true,255,shac,0,2,2);
   else if (edg) drawText(x,y, str, color4,255,true,255,edgc,1,0,0);
   else drawText(x,y, str, color4);
 }
    if (f.config_slpos.smallsnap.use)
{
   //描繪按鈕小截圖
   var width=f.setting.savedata.thumbnailwidth;
   var height=width*3/4;
   fillRect(f.config_slpos.smallsnap.x,f.config_slpos.smallsnap.y,width,height,0xFFFFFFFF);
}

 //--------------------------------------------
    //假如選中,帶邊框
    if (select)
    {
      fillRect(0,0,width,1,0xCCFF0000);
      fillRect(0,0,1,height,0xCCFF0000);
      fillRect(0,height-1,width,1,0xCCFF0000);
      fillRect(width-1,0,1,height,0xCCFF0000);
    }
  }
   //---------------------------------------------------懸停---------------------------------------------------
   function onMouseEnter()
   {
      drawSelect(over,"over");

      if (f.config_sl.button.enterse!=void && kag.fore.layers[5].visible==false && kag.fore.layers[7].visible==false) 
      {
         kag.tagHandlers.playse(%[
         "storage" => f.config_sl.button.enterse,
         "loop" => false
         ]);
      }

   }
   function onMouseLeave()
   {
      drawSelect(normal,"normal");
   }
   function onClick()
   {
      drawSelect(on,"on");

      if (f.config_sl.button.clickse!=void && kag.fore.layers[5].visible==false && kag.fore.layers[7].visible==false) 
      {
         kag.tagHandlers.playse(%[
         "storage" => f.config_sl.button.clickse,
         "loop" => false
         ]);
      }

   }
   //----------------------------------根據傳入參數重設層的值---------------------------------------------------
   function Reset(num)
   {
      normal=f.config_sl.button.normal;
      over=f.config_sl.button.over;
      on=f.config_sl.button.on;
      this.num=num;
	  drawSelect();
   }
}
[endscript]
;-----------------------------------------------------------------------------------
;只有位置顯示的上下翻按鈕及返回按鈕
;-----------------------------------------------------------------------------------
[iscript]
class uiSLLayer extends uiButtonLayer
{
    var normal;
    var over;
    var on;

    var enterse;
    var clickse;

   //---------------------------------------------------創建---------------------------------------------------
   function uiSLLayer(pic,pos)
   {
      super.Layer(kag, parent);
      //圖像描繪
      normal=pic.normal;
      over=pic.over;
      on=pic.on;

      //音聲讀取
      enterse=pic.enterse;
      clickse=pic.clickse;

      //位置
      left=pos[0];
      top=pos[1];
      visible=pos[2];
      hitType = htMask;
	  hitThreshold =0;
	  focusable=true;
      drawSelect();
   }
   //---------------------------------------------------輸出---------------------------------------------------
      function SLlayerElm()
   {
      var array=[];
      array[0]=this.left;
      array[1]=this.top;
      array[2]=this.visible;
      return array;
   }
   //----------------------------------根據傳入參數重設層的值---------------------------------------------------
   function Reset(pic)
   {
    this.normal=pic.normal;
    this.over=pic.over;
    this.on=pic.on;
    this.drawSelect();
   }
}
[endscript]

;-----------------------------------------------------------------------------------
;懸停顯示的圖片位置
;-----------------------------------------------------------------------------------
[iscript]
class uiSnapLayer extends uiLayer
{
  //---------------------------------------------------創建---------------------------------------------------
  function uiSnapLayer(elm)
  {
        super.Layer(kag, parent);
        width=f.setting.savedata.thumbnailwidth;
        height=width*3/4;
        fillRect(0,0,width,height,0xFFFFFFFF);
		left=elm.x;
		top=elm.y;
		visible=elm.visible;

		hitType = htMask;
		hitThreshold =0;
		focusable=true;
  }
    //---------------------------------------------------描繪---------------------------------------------------
  function drawSelect()
  {
    width=f.setting.savedata.thumbnailwidth;
    height=width*3/4;
    fillRect(0,0,width,height,0xFFFFFFFF);
    //假如選中,帶邊框
    if (select)
    {
      fillRect(0,0,width,1,0xCCFF0000);
      fillRect(0,0,1,height,0xCCFF0000);
      fillRect(0,height-1,width,1,0xCCFF0000);
      fillRect(width-1,0,1,height,0xCCFF0000);
    }
  }
   //---------------------------------------------------輸出---------------------------------------------------
      function SnapElm()
   {
      var dic=new Dictionary();
      //將該層的位置輸出，供字典保存用
      dic.x=this.left;
      dic.y=this.top;
      dic.visible=this.visible;
      return dic;
   }
}
[endscript]

;-----------------------------------------------------------------------------------
;懸停顯示的文字位置
;-----------------------------------------------------------------------------------
[iscript]
class uiTextLayer extends uiLayer
{
var str;
var color;
 //---------------------------------------------------創建---------------------------------------------------
  function uiTextLayer(str,elm,color)
  {
        super.Layer(kag, parent);
        font.height=elm.size;
		left=elm.x;
		top=elm.y;
		visible=elm.use;
		
    //字體
    font.bold=f.config_slpos.pagefont.bold;
    font.italic=f.config_slpos.pagefont.italic;
    this.str=str;
    this.color=color;
    
    //取得寬度
    width=this.font.getTextWidth(str);
    height=this.font.getTextHeight(str);
    
		hitType = htMask;
		hitThreshold =0;
		focusable=true;
		drawSelect();
  }
  
 //---------------------------------------------------描繪---------------------------------------------------
  function drawSelect()
  {
    //字體
    font.bold=f.config_slpos.pagefont.bold;
    font.italic=f.config_slpos.pagefont.italic;
    this.str=str;
    this.color=color;
    
    //取得寬度
    width=this.font.getTextWidth(str);
    height=this.font.getTextHeight(str);
    
    fillRect(0,0,width,height,0x00FFFFFF);
    
    if (f.config_slpos.pagefont.shadow)
    {
      drawText(0,0, str, color,255,true,255,f.config_slpos.pagefont.shadowcolor,0,2,2);
    }
    else if (f.config_slpos.pagefont.edge)
    {
      drawText(0,0, str, color,255,true,255,f.config_slpos.pagefont.edgecolor,1,0,0);
    }
    else
    {
      drawText(0, 0, str,color);
    }
     //假如選中,帶邊框
    if (select)
    {
      fillRect(0,0,width,1,0xCCFF0000);
      fillRect(0,0,1,height,0xCCFF0000);
      fillRect(0,height-1,width,1,0xCCFF0000);
      fillRect(width-1,0,1,height,0xCCFF0000);
    }
  }
 //---------------------------------------------------重設---------------------------------------------------
 function Reset(color)
 {
       this.color=color;
       drawSelect();
 }
 //---------------------------------------------------輸出---------------------------------------------------
 function TextElm()
 {
      var dic=new Dictionary();
      //將該層的位置輸出，供字典保存用
      dic.x=this.left;
      dic.y=this.top;
      dic.use=this.visible;
      dic.size=this.font.height;
      return dic;
 }
}
[endscript]
;-----------------------------------------------------------------------------------

;-----------------------------------------------------------------------------------
;懸停顯示的圖片位置
;-----------------------------------------------------------------------------------
[iscript]
class uiCgThumLayer extends uiLayer
{
  //---------------------------------------------------創建---------------------------------------------------
  function uiCgThumLayer(elm)
  {
        super.Layer(kag, parent);

        loadImages(f.config_cgmode.thum.normal);
        setSizeToImageSize();
        
        fillRect(0,0,width,height,0xFFFFFFFF);
        
		left=elm[0];
		top=elm[1];
		visible=true;

		hitType = htMask;
		hitThreshold =0;
		focusable=true;
  }
    //---------------------------------------------------描繪---------------------------------------------------
  function drawSelect()
  {
  
    width=this.width;
    height=this.height;
    
    fillRect(0,0,width,height,0xFFFFFFFF);
    //假如選中,帶邊框
    if (select)
    {
      fillRect(0,0,width,1,0xCCFF0000);
      fillRect(0,0,1,height,0xCCFF0000);
      fillRect(0,height-1,width,1,0xCCFF0000);
      fillRect(width-1,0,1,height,0xCCFF0000);
    }
  }

}
[endscript]
[return]
