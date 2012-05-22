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
;封装的人物姓名宏相关
;-------------------------------------------------------------------------------------------
*start
[iscript]
//按照配置表的内容设定字体
function setfont()
{
   //var arr=Scripts.evalStorage("namelist.tjs");
    kag.tagHandlers.font(%["color"=>f.config_name[1].color]);
   //if (dic[name]!=void) kag.tagHandlers.font(dic[name]);
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
	button.font.face = sf.font;
	button.font.bold = f.setting.font.bold;
	button.font.height = f.setting.selfont.height;
	
	//sel颜色设定
	var normal=f.setting.selfont.normal;
	var read=f.setting.selfont.read;
	var over=f.setting.selfont.over;
	var on=f.setting.selfont.on;
	var edgecolor=f.setting.font.edgecolor;
	var shadowcolor=f.setting.font.shadowcolor;

	var w = button.font.getTextWidth(caption); // 取得要描绘文字的宽度
	var x = (button.width - w) \ 2;    // 在按钮中央显示文字
	var y = (button.height - button.font.getTextHeight(caption)) \ 2;   //   文字在按钮上的y位置（左上角起算）

	//取得既读设定
	var target_name=target.substring(1,target.length-1); //去掉星号
	var checklabel="sf.trail_"+Storages.chopStorageExt(storage)+"_"+target_name;
	var sel_color;

	// 既读文字颜色设定
	if ((checklabel!)>0 && read!=void) {sel_color=read;}
	else {sel_color=normal;}

	if (f.setting.font.edge) //默认设置带有描边
	{
		// 按钮「通常状態」部分文字显示
		button.drawText(x,y, caption, sel_color, 255, true, 255, edgecolor, 1, 0, 0);
		// 按钮「按下状態」部分文字显示
		button.drawText(x+button.width, y, caption, on ,255, true, 255, edgecolor, 1, 0, 0);
		// 按钮「选中状態」部分文字显示
		button.drawText(x+button.width+button.width, y, caption, over ,255, true, 255, edgecolor, 1, 0, 0);
	}
	else if (f.setting.font.shadow)//默认设置带有阴影
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
;历史记录相关
;------------------------------------------------------------
[iscript]
//-----------------------------翻页-----------------------------
function history_page()
{
   if (kag.fore.base.cursorY<kag.fore.layers[16].top && tf.当前历史页>1)
     history_up();
   if (kag.fore.base.cursorY>(int)kag.fore.layers[16].top+(int)kag.fore.layers[16].height && tf.当前历史页<tf.历史页数)
     history_down();
}
//-----------------------------向上翻页-----------------------------
function history_up()
{
  if (tf.当前历史页>1) 
  {
    tf.当前历史页--;
    //刷新画面
    draw_history();
  }
}
//-----------------------------向下翻页-----------------------------
function history_down()
{
  if (tf.当前历史页<tf.历史页数) 
  {
    tf.当前历史页++;
    //刷新画面
    draw_history();
  }
}
//-----------------------------描绘-----------------------------
function draw_history(page="fore")
{
var slider;
var draw;
var slider_y;
//设定用于显示的层
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
  //滑动条按钮位置
   if (tf.历史页数>1) slider_y=(int)f.config_history.slider.y+(int)(tf.当前历史页-1)*f.config_history.slider.length/(tf.历史页数-1);
   else slider_y=f.config_history.slider.y;
  //重新载入滑动条按钮
   slider.loadImages(%['storage'=>f.config_history.slider.button, 'visible'=>f.config_history.slider.use,'left'=>f.config_history.slider.x,'top' =>slider_y]);
  //重载描绘用背景
    draw.loadImages(%['storage'=>'empty', 'visible'=>true,'left'=>0,'top' =>0]);
  //描绘文字
    for (var i=0; i< f.config_history.line; i++)
   {
     var line=i+(tf.当前历史页-1)*f.config_history.line;
     //如果超过总行数则中断循环
     if (line>tf.历史行数) break;
     //未超过则取得行文字
      var curline=kag.historyLayer.data[line];
      //去掉无用的空格
      if (curline!='') curline=curline.trim();
      var color=history_color(curline);
      var pos=f.config_history.left+10;
      if (color!=0xFFFFFF){ pos=f.config_history.left;}
      //描绘用数组
      var setting=new Dictionary();
      //取得配置表里的值
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
//-----------------------------颜色-----------------------------
function history_color(text)
{
       if (text!=void && text.charAt(0)=="【")
       {
         var name=text.substring(1,text.length-2);
         var arr=f.config_name;
         
         //为主角
         if (name==f.姓+f.名) return arr[0].color;
         //否则
         //有颜色记录,使用颜色
           for (var i=2;i<arr.count;i++)
          {
             if (arr[i].name==name) return arr[i].color;
           }
           
         //无颜色记录,使用路人颜色
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
