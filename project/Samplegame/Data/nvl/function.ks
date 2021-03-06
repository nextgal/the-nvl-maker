*start
;------------------------------------------------------------
;快捷键操作
;------------------------------------------------------------
;使用ALT+ENTER切换全屏/窗口
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
// キー押下時のハンドラを登録
kag.keyDownHook.add(changeScreenMode);
[endscript]
;------------------------------------------------------------
;左键点击显示对话框
;------------------------------------------------------------
[iscript]
function onLeftClick()
{
  kag.process("rclick.ks", "*显示对话框");
  return true;
}
[endscript]
;-------------------------------------------------------------------------------------------
;封装的人物姓名宏，字体设置
;-------------------------------------------------------------------------------------------
[iscript]
//按照配置表的内容设定字体，默认只是改变字体颜色
function setfont()
{
  kag.tagHandlers.font(%["color"=>f.config_name[1].color]);
}
[endscript]
;------------------------------------------------------------
;描绘选择按钮
;------------------------------------------------------------
[iscript]
//描绘按钮文字用函数
function drawSelButton(caption, storage, target)
{
	var button;
	button=kag.current.links[kag.current.links.count-1].object;

	//默认文字样式设定
	button.font.face = kag.fore.messages[0].userFace;
	button.font.bold = kag.fore.messages[0].defaultBold;
	button.font.height = f.setting.selfont.height;
	
	//sel颜色设定
	var normal=f.setting.selfont.normal;
	var read=f.setting.selfont.read;
	var over=f.setting.selfont.over;
	var on=f.setting.selfont.on;
	
	var edgecolor=kag.fore.messages[0].defaultEdgeColor;
	var shadowcolor=kag.fore.messages[0].defaultShadowColor;

	var w = button.font.getTextWidth(caption); // 取得要描绘文字的宽度
	var x = (button.width - w) \ 2;    // 在按钮中央显示文字
	var y = (button.height - button.font.getTextHeight(caption)) \ 2;   //   文字在按钮上的y位置（左上角起算）

	//取得既读设定
	var target_name=target.substring(1,target.length-1); //去掉星号
	var labelname="trail_"+Storages.chopStorageExt(storage)+"_"+target_name;
	var checklabel="sf[\""+labelname+"\"]";
	var sel_color;

	// 既读文字颜色设定
	if ((checklabel!)>0 && read!=void) {sel_color=read;}
	else {sel_color=normal;}

	if (kag.fore.messages[0].defaultEdge) //默认设置带有描边
	{
		// 按钮「通常状態」部分文字显示
		button.drawText(x,y, caption, sel_color, 255, true, 255, edgecolor, 1, 0, 0);
		// 按钮「按下状態」部分文字显示
		button.drawText(x+button.width, y, caption, on ,255, true, 255, edgecolor, 1, 0, 0);
		// 按钮「选中状態」部分文字显示
		button.drawText(x+button.width+button.width, y, caption, over ,255, true, 255, edgecolor, 1, 0, 0);
	}
	else if (kag.fore.messages[0].defaultShadow)//默认设置带有阴影
	{
		// 按钮「通常状態」部分文字显示
		button.drawText(x,y, caption, sel_color, 255, true, 255, shadowcolor, 0, 2, 2);
		// 按钮「按下状態」部分文字显示
		button.drawText(x+button.width, y, caption, on ,255, true, 255, shadowcolor, 0, 2, 2);
		// 按钮「选中状態」部分文字显示
		button.drawText(x+button.width+button.width, y, caption, over ,255, true, 255, shadowcolor, 0, 2, 2);
	}
	else //无任何效果
	{
		// 按钮「通常状態」部分文字显示
		button.drawText(x,y, caption, sel_color, 255, true);
		// 按钮「按下状態」部分文字显示
		button.drawText(x+button.width, y, caption, on ,255, true);
		// 按钮「选中状態」部分文字显示
		button.drawText(x+button.width+button.width, y, caption, over ,255, true);
	}

}
[endscript]
;------------------------------------------------------------
;历史记录里，识别人名并自动返回对应颜色
;------------------------------------------------------------
[iscript]
function history_color(text)
{
       if (text!=void && text.charAt(0)=="【")
       {
	         var name=text.substring(1,text.length-2);
	         var arr=f.config_name;
         
	         //为主角，使用主角的颜色
	         if (name==f.姓+f.名) return arr[0].color;
	         //否则
	         //是姓名列表里的角色，使用列表里设置的颜色
	           for (var i=2;i<arr.count;i++)
	          {
	             if (arr[i].name==name) return arr[i].color;
	           }
           
	         //无颜色记录,使用路人的颜色
	         return arr[1].color;

       }
       //不是人名，返回对话默认字体颜色
       return kag.fore.messages[0].defaultChColor;
}
[endscript]
;------------------------------------------------------------
[return]
