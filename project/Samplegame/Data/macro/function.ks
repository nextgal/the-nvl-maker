*start
;------------------------------------------------------------
;快捷鍵操作
;------------------------------------------------------------
;使用ALT+ENTER切換全屏/窗口
[iscript]
function changeScreenMode(key, shift)
{
  if (key != VK_RETURN || !(shift & ssAlt))
    return false;
  if (global.kag.fullScreen)
    global.kag.onWindowedMenuItemClick(global.kag);
  else
    global.kag.onFullScreenMenuItemClick(global.kag);
  return true;
}
// 押下時登錄
kag.keyDownHook.add(changeScreenMode);
[endscript]

;------------------------------------------------------------
;左鍵點擊顯示對話框
;------------------------------------------------------------
[iscript]
function onLeftClick()
{
  kag.process("rclick.ks", "*顯示對話框");
  return true;
}
[endscript]
;-------------------------------------------------------------------------------------------
;封裝的人物姓名宏相關
;-------------------------------------------------------------------------------------------
*start
[iscript]
//按照配置表的內容設定字體
function setfont()
{
   //var arr=Scripts.evalStorage("namelist.tjs");
    kag.tagHandlers.font(%["color"=>f.config_name[1].color]);
   //if (dic[name]!=void) kag.tagHandlers.font(dic[name]);
}
[endscript]
;------------------------------------------------------------
;描繪選擇按鈕
;------------------------------------------------------------
[iscript]
//描繪按鈕文字用函數
function drawSelButton(caption, storage, target)
{
	var button;
	button=kag.current.links[kag.current.links.count-1].object;

	//默認文字樣式設定
	button.font.face = sf.font;
	button.font.bold = f.setting.font.bold;
	button.font.height = f.setting.selfont.height;
	
	//sel顏色設定
	var normal=f.setting.selfont.normal;
	var read=f.setting.selfont.read;
	var over=f.setting.selfont.over;
	var on=f.setting.selfont.on;
	var edgecolor=f.setting.font.edgecolor;
	var shadowcolor=f.setting.font.shadowcolor;

	var w = button.font.getTextWidth(caption); // 取得要描繪文字的寬度
	var x = (button.width - w) \ 2;    // 在按鈕中央顯示文字
	var y = (button.height - button.font.getTextHeight(caption)) \ 2;   //   文字在按鈕上的y位置（左上角起算）

	//取得既讀設定
	var target_name=target.substring(1,target.length-1); //去掉星號
	var checklabel="sf.trail_"+Storages.chopStorageExt(storage)+"_"+target_name;
	var sel_color;

	// 既讀文字顏色設定
	if ((checklabel!)>0 && read!=void) {sel_color=read;}
	else {sel_color=normal;}

	if (f.setting.font.edge) //默認設置帶有描邊
	{
		// 按鈕「通常狀態」部分文字顯示
		button.drawText(x,y, caption, sel_color, 255, true, 255, edgecolor, 1, 0, 0);
		// 按鈕「按下狀態」部分文字顯示
		button.drawText(x+button.width, y, caption, on ,255, true, 255, edgecolor, 1, 0, 0);
		// 按鈕「選中狀態」部分文字顯示
		button.drawText(x+button.width+button.width, y, caption, over ,255, true, 255, edgecolor, 1, 0, 0);
	}
	else if (f.setting.font.shadow)//默認設置帶有陰影
	{
		// 按鈕「通常狀態」部分文字顯示
		button.drawText(x,y, caption, sel_color, 255, true, 255, shadowcolor, 0, 2, 2);
		// 按鈕「按下狀態」部分文字顯示
		button.drawText(x+button.width, y, caption, on ,255, true, 255, shadowcolor, 0, 2, 2);
		// 按鈕「選中狀態」部分文字顯示
		button.drawText(x+button.width+button.width, y, caption, over ,255, true, 255, shadowcolor, 0, 2, 2);
	}
	else //無任何效果
	{
		// 按鈕「通常狀態」部分文字顯示
		button.drawText(x,y, caption, sel_color, 255, true);
		// 按鈕「按下狀態」部分文字顯示
		button.drawText(x+button.width, y, caption, on ,255, true);
		// 按鈕「選中狀態」部分文字顯示
		button.drawText(x+button.width+button.width, y, caption, over ,255, true);
	}

}
[endscript]
;------------------------------------------------------------
;歷史記錄相關
;------------------------------------------------------------
[iscript]
//-----------------------------翻頁-----------------------------
function history_page()
{
   if (kag.fore.base.cursorY<kag.fore.layers[16].top && tf.當前歷史頁>1)
     history_up();
   if (kag.fore.base.cursorY>(int)kag.fore.layers[16].top+(int)kag.fore.layers[16].height && tf.當前歷史頁<tf.歷史頁數)
     history_down();
}
//-----------------------------向上翻頁-----------------------------
function history_up()
{
  if (tf.當前歷史頁>1) 
  {
    tf.當前歷史頁--;
    //刷新畫面
    draw_history();
  }
}
//-----------------------------向下翻頁-----------------------------
function history_down()
{
  if (tf.當前歷史頁<tf.歷史頁數) 
  {
    tf.當前歷史頁++;
    //刷新畫面
    draw_history();
  }
}
//-----------------------------描繪-----------------------------
function draw_history(page="fore")
{
var slider;
var draw;
var slider_y;
//設定用於顯示的層
  if (page=="fore") 
  {
    slider=kag.fore.layers[16];
    draw=kag.fore.layers[15];
  }
  else
  {
    slider=kag.back.layers[16];
    draw=kag.back.layers[15];
  }
  //滑動條按鈕位置
   if (tf.歷史頁數>1) slider_y=(int)f.config_history.slider.y+(int)(tf.當前歷史頁-1)*f.config_history.slider.length/(tf.歷史頁數-1);
   else slider_y=f.config_history.slider.y;
  //重新載入滑動條按鈕
   slider.loadImages(%['storage'=>f.config_history.slider.button, 'visible'=>f.config_history.slider.use,'left'=>f.config_history.slider.x,'top' =>slider_y]);
  //重載描繪用背景
    draw.loadImages(%['storage'=>'empty', 'visible'=>true,'left'=>0,'top' =>0]);
  //描繪文字
    for (var i=0; i< f.config_history.line; i++)
   {
     var line=i+(tf.當前歷史頁-1)*f.config_history.line;
     //如果超過總行數則中斷循環
     if (line>tf.歷史行數) break;
     //未超過則取得行文字
      var curline=kag.historyLayer.data[line];
      //去掉無用的空格
      if (curline!='') curline=curline.trim();
      var color=history_color(curline);
      var pos=f.config_history.left+10;
      if (color!=0xFFFFFF){ pos=f.config_history.left;}
      //描繪用數組
      var setting=new Dictionary();
      //取得配置表裡的值
      (Dictionary.assign incontextof setting)(f.config_history.font);
      setting.text=curline;
      setting.layer="15";
      setting.face=sf.font;
      setting.page=page;
      setting.color=color;
      setting.face=sf.font;
      setting.x=pos;
      setting.y=f.config_history.top+i*f.config_history.linespace;
      kag.tagHandlers.ptext(setting);
   }
}
//-----------------------------顏色-----------------------------
function history_color(text)
{
       if (text!=void && text.charAt(0)=="【")
       {
         var name=text.substring(1,text.length-2);
         var arr=f.config_name;
         
         //為主角
         if (name==f.姓+f.名) return arr[0].color;
         //否則
         //有顏色記錄,使用顏色
           for (var i=2;i<arr.count;i++)
          {
             if (arr[i].name==name) return arr[i].color;
           }
           
         //無顏色記錄,使用路人顏色
         return arr[1].color;
        // var dic=Scripts.evalStorage("namelist.tjs");
        //  if (dic[name]!=void) return dic[name]["color"];
        //  else return dic["default"]["color"];
       }
       return f.setting.font.color;
}
[endscript]
;------------------------------------------------------------
[return]
