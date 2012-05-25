;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;--------------------------------------------------------------
;特殊描繪:edu圖形設定
;--------------------------------------------------------------
[iscript]
function drawEduPicSetting(title,layer,x,y)
{
       //勾選框
       drawCheck(title,layer+".visible",x,y);
       //空格
        kag.tagHandlers.ch(%["text"=>" "]);
       //連接
        var setting=new Dictionary();
        setting.target="*圖形設定";
        setting.hint="點此打開養成面板圖形&數值設定窗口";
        //將值傳遞給f.參數並記錄當前層的名字以便之後reset
        setting.exp="f.參數="+layer+".PicElm(),tf.當前操作層=\'"+layer+"\'";
        kag.tagHandlers.link(setting);
        //方塊
        kag.tagHandlers.ch(%["text"=>"□"]);
        kag.tagHandlers.endlink(%[]);
}
[endscript]
;--------------------------------------------------------------
;特殊描繪:edu文字設定
;--------------------------------------------------------------
[iscript]
function drawEduTextSetting(title,layer,x,y)
{
       //勾選框
       drawCheck(title,layer+".visible",x,y);
       //空格
        kag.tagHandlers.ch(%["text"=>" "]);
       //連接
        var setting=new Dictionary();
        setting.target="*文字設定";
        setting.hint="點此打開養成面板文字設定窗口";
        //將值傳遞給f.參數並記錄當前層的名字以便之後reset
        setting.exp="f.參數="+layer+".TextElm(),tf.當前操作層=\'"+layer+"\'";
        kag.tagHandlers.link(setting);
        //方塊
        kag.tagHandlers.ch(%["text"=>"□"]);
        kag.tagHandlers.endlink(%[]);
}
[endscript]
;--------------------------------------------------------------
;特殊描繪:edu按鈕設定
;--------------------------------------------------------------
[iscript]
function drawEduButtonSetting(title,layer,x,y)
{
       //勾選框
       drawCheck(title,layer+".visible",x,y);
       //空格
        kag.tagHandlers.ch(%["text"=>" "]);
       //連接
        var setting=new Dictionary();
        setting.target="*按鈕設定";
        setting.hint="點此打開養成按鈕設定窗口";
        //將值傳遞給f.參數並記錄當前層的名字以便之後reset
        setting.exp="f.參數="+layer+".ButtonElm(),tf.當前操作層=\'"+layer+"\'";
        kag.tagHandlers.link(setting);
        //方塊
        kag.tagHandlers.ch(%["text"=>"□"]);
        kag.tagHandlers.endlink(%[]);
}
[endscript]

;--------------------------------------------------------------------------------------------------------------
;可選擇顯示圖形的面板x,y,name,use(visible),flagname,cond
;類型pic/num,數值演示圖形num,字間距space
;--------------------------------------------------------------------------------------------------------------
[iscript]
class uiEduPicLayer extends uiLayer
{
var name;
var flagname;
var pic;
var num;
var space;
var cond;
  //---------------------------------------------------坐標---------------------------------------------------
function drawXY()
{
 with(kag.fore.layers[3])
 {
   .font.height=18;
   .fillRect(sf.gs.width+230,565,100,20,0xFFD4D0C8);
   .drawText(sf.gs.width+230,565, "("+left+","+top+")", 0x000000);
 }
}
 //---------------------------------------------------創建---------------------------------------------------
   function uiEduPicLayer(name,elm)
  {
         super.Layer(kag, parent);

	  left=elm.x;
	  top=elm.y;
	  visible=elm.use;
	  
         this.name=name;
         this.flagname=elm.flagname;
         this.pic=elm.pic;
         this.num=elm.num;
         this.space=elm.space;
         this.cond=elm.cond;
         
		hitType = htMask;
		hitThreshold =0;
		focusable=true;
		
	drawSelect();
		
  }
 //---------------------------------------------------描繪---------------------------------------------------
  function drawSelect()
  {

    this.name=name;
    this.flagname=flagname;
    
    //根據不同類型描繪演示圖形或者描繪數字
    if (pic!=void)
    {
      loadImages(pic);
      setSizeToImageSize();
    }
    else
    {
      //讀取數字圖片大小
      var sizelayer=new global.Layer(window, parent);
      sizelayer.loadImages(num+0);
      sizelayer.setSizeToImageSize();
      
      this.width=space*3;
      this.height=sizelayer.height;
      
      //設定圖層本身大小
      var sw=sizelayer.width;
      var sh=sizelayer.height;
      this.fillRect(0,0,width,height,0x00FFFFFF);
      
      //在圖片上進行描繪
      this.operateRect(0, 0, sizelayer, 0, 0, sw, sh);
      sizelayer.loadImages(num+1);
      this.operateRect(space, 0, sizelayer, 0, 0, sw, sh);
      sizelayer.loadImages(num+2);
      this.operateRect(space*2, 0, sizelayer, 0, 0, sw, sh);
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
   //---------------------------------------------------輸出---------------------------------------------------
   function PicElm()
   {
      var dic=new Dictionary();
      //將該層的位置輸出，供字典保存用
      dic.use=this.visible;
      
      dic.x=this.left;
      dic.y=this.top;

      dic.name=this.name;
      dic.flagname=this.flagname;
      dic.cond=this.cond;
      
      dic.pic=this.pic;
      dic.num=this.num;
      dic.space=this.space;
      
      return dic;

   }
   //----------------------------------根據傳入參數重設層的值---------------------------------------------------
   function Reset(elm)
   {
   
   this.visible=elm.use;
   this.left=elm.x;
   this.top=elm.y;
   
   this.name=elm.name;
   this.flagname=elm.flagname;
   this.cond=elm.cond;
   
   this.pic=elm.pic;
   this.num=elm.num;
   this.space=elm.space;
   
    this.drawSelect();
   }
   
   

}
[endscript]
;--------------------------------------------------------------------------------------------------------------
;可選擇文字描繪效果的面板x,y,name,use(visible),flagname,cond
;color,fontname,size,bold,shadow,shadowcolor,edge,edgecolor
;--------------------------------------------------------------------------------------------------------------
[iscript]
class uiEduTextLayer extends uiLayer
{

var name;
var flagname;
var fontname;
var size;
var color;
var bold;
var shadow;
var shadowcolor;
var edge;
var edgecolor;
var cond;
  //---------------------------------------------------坐標---------------------------------------------------
function drawXY()
{
 with(kag.fore.layers[3])
 {
   .font.height=18;
   .fillRect(sf.gs.width+230,565,100,20,0xFFD4D0C8);
   .drawText(sf.gs.width+230,565, "("+left+","+top+")", 0x000000);
 }
}
 //---------------------------------------------------創建---------------------------------------------------
  function uiEduTextLayer(name,elm)
  {
        super.Layer(kag, parent);

	  left=elm.x;
	  top=elm.y;
	  visible=elm.use;
         this.name=elm.name;
         this.flagname=elm.flagname;
         this.cond=elm.cond;
         
	  //設定文字默認高度
         this.font.height=f.setting.selfont.height;

        //改變設定
        fontname=elm.fontname;
        size=elm.size;
        color=elm.color;
        bold=elm.bold;
        shadow=elm.shadow;
        shadowcolor=elm.shadowcolor; 
        edge=elm.edge;
        edgecolor=elm.edgecolor; 
        
    //取得寬度
    width=this.font.getTextWidth(name);
    height=this.font.getTextHeight(name);
    
		hitType = htMask;
		hitThreshold =0;
		focusable=true;
		drawSelect();
  }
  
 //---------------------------------------------------描繪---------------------------------------------------
  function drawSelect()
  {

    this.name=name;
    this.flagname=flagname;
    
    this.font.face=fontname;
    this.font.height=size;
    this.font.bold=bold;

    //取得寬度
    width=this.font.getTextWidth(name);
    height=this.font.getTextHeight(name);
    
    fillRect(0,0,width,height,0x00FFFFFF);
    
    if (shadow)
    {
      drawText(0,0, name, color,255,true,255,shadowcolor,0,2,2);
    }
    else if (edge)
    {
      drawText(0,0, name, color,255,true,255,edgecolor,1,0,0);
    }
    else
    {
      drawText(0, 0, name,color);
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
   //----------------------------------根據傳入參數重設層的值---------------------------------------------------
   function Reset(elm)
   {
        name=elm.name;
        left=elm.x;
        top=elm.y;
        flagname=elm.flagname;
        cond=elm.cond;
     
        fontname=elm.fontname;
        size=elm.size;
        color=elm.color;
        bold=elm.bold;
        shadow=elm.shadow;
        shadowcolor=elm.shadowcolor; 
        edge=elm.edge;
        edgecolor=elm.edgecolor;
        
    this.drawSelect();
   }
 //---------------------------------------------------輸出---------------------------------------------------
 function TextElm()
 {
      var dic=new Dictionary();
      //將該層的位置輸出，供字典保存用
      dic.use=this.visible;
      
      dic.x=this.left;
      dic.y=this.top;

      dic.name=this.name;
      dic.flagname=this.flagname;
      dic.cond=this.cond;
      
      dic.fontname=this.fontname;      
      dic.size=this.size;
      dic.color=this.color;
      
      dic.bold=this.bold;
      dic.shadow=this.shadow;
      dic.shadowcolor=this.shadowcolor;
      dic.edge=this.edge;
      dic.edgecolor=this.edgecolor;
      
      return dic;
      
 }
}
[endscript]

;--------------------------------------------------------------------------------------------------------------
;帶懸停效果的養成按鈕層,輸出x,y,normal,over,on,use(visible),name,storage,target,cond
;--------------------------------------------------------------------------------------------------------------
[iscript]
class uiEduButtonLayer extends uiLayer
{
var normal;
var over;
var on;

var name;
var storage;
var target;
var cond;
var exp;
  //---------------------------------------------------坐標---------------------------------------------------
function drawXY()
{
 with(kag.fore.layers[3])
 {
   .font.height=18;
   .fillRect(sf.gs.width+230,565,100,20,0xFFD4D0C8);
   .drawText(sf.gs.width+230,565, "("+left+","+top+")", 0x000000);
 }
}
  //---------------------------------------------------創建---------------------------------------------------
  function uiEduButtonLayer(elm)
  {
     	super.Layer(kag, parent); 
     	normal=elm.normal;
     	over=elm.over;
     	on=elm.on;
		loadImages(normal);
		setSizeToImageSize();
		left=elm.x;
		top=elm.y;
		visible=elm.use;
    //附加參數
    name=elm.name;
    storage=elm.storage;
    target=elm.target;
    cond=elm.cond;
    exp=elm.exp;
    
		hitType = htMask;
		hitThreshold =0;
		focusable=true;
  }
  //---------------------------------------------------描繪---------------------------------------------------
  function drawSelect(state=normal)
  {
    this.loadImages(state);
    this.setSizeToImageSize();
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
      drawSelect(over);
   }
   function onMouseLeave()
   {
      drawSelect(normal);
   }
   function onClick()
   {
      drawSelect(on);
   }
   //---------------------------------------------------輸出---------------------------------------------------
   function ButtonElm()
   {
      var dic=new Dictionary();
      //將該層的各數據輸出，供字典保存用
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
      return dic;
   }
   //----------------------------------根據傳入參數重設層的值---------------------------------------------------
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
      
    this.drawSelect();
   }
}
[endscript]
;-----------------------------------------------------------------------------------
[return]
