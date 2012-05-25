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
	button.font.face = kag.scflags.chDefaultFace;
	button.font.bold = kag.fore.messages[0].defaultBold;
	button.font.height = f.setting.selfont.height;
	
	//sel顏色設定
	var normal=f.setting.selfont.normal;
	var read=f.setting.selfont.read;
	var over=f.setting.selfont.over;
	var on=f.setting.selfont.on;
	
	var edgecolor=kag.fore.messages[0].defaultEdgeColor;
	var shadowcolor=kag.fore.messages[0].defaultShadowColor;

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

	if (kag.fore.messages[0].defaultEdge) //默認設置帶有描邊
	{
		// 按鈕「通常狀態」部分文字顯示
		button.drawText(x,y, caption, sel_color, 255, true, 255, edgecolor, 1, 0, 0);
		// 按鈕「按下狀態」部分文字顯示
		button.drawText(x+button.width, y, caption, on ,255, true, 255, edgecolor, 1, 0, 0);
		// 按鈕「選中狀態」部分文字顯示
		button.drawText(x+button.width+button.width, y, caption, over ,255, true, 255, edgecolor, 1, 0, 0);
	}
	else if (kag.fore.messages[0].defaultShadow)//默認設置帶有陰影
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
       //返回對話默認字體顏色
       return kag.fore.messages[0].defaultChColor;
}
[endscript]
;------------------------------------------------------------
[return]
