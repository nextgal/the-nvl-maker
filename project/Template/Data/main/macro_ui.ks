;-------------------------------------------------------------------------------------------
;系统按钮、标题画面、OPTION画面及其他零碎用的宏
;对应函数在function.ks里
;-------------------------------------------------------------------------------------------
*start
;------------------------------------------------------------------
;系统全屏框宏，用于设置一个等于游戏画面大小的全透明消息层
;过去是用empty这张图片来代替的，现在改掉了
;------------------------------------------------------------------
[macro name="frame"]
	[position frame="" layer="%layer|message0" page="%page|fore" visible="%visible|true" marginb=0 marginl=0 marginr=0 margint=0 color="0xFFFFFF" opacity="0" width=&"kag.scWidth" height=&"kag.scHeight" left="0" top="0"]
[endmacro]
;------------------------------------------------------------------
;自定界面按钮
;------------------------------------------------------------------
[iscript]
function getUIBack(dicname)
{
	var mydic=%[];
	var dic=dicname!;

	if (typeof dic== "String")
	{
		mydic.frame=dic;
	}
	else
	{
		mydic.frame=dic.frame;
		mydic.stitle=dic.stitle;
		mydic.stitle_x=dic.stitle_x;
		mydic.stitle_y=dic.stitle_y;
	}

	return mydic;
}
[endscript]
[macro name="uiback"]
[eval exp="tf.UIBack=getUIBack(mp.dicname)"]
[image layer=%layer|14 page=%page|back storage=&"tf.UIBack.frame" left=0 top=0 visible="true"]
;叠加小图
[if exp="tf.UIBack.stitle!=void"]
[pimage layer=%layer|14 page=%page|back storage=&"tf.UIBack.stitle" dx=&"tf.UIBack.stitle_x" dy=&"tf.UIBack.stitle_y"]
[endif]
[endmacro]
;------------------------------------------------------------------
;自定界面按钮
;------------------------------------------------------------------
[macro name=mybutton]
	[eval exp="mybutton(mp.dicname,mp.target,mp.exp,mp.interval,mp.ontimer)"]
[endmacro]
;------------------------------------------------------------------
;系统按钮
;------------------------------------------------------------------
;系统按钮单个定义
[macro name=mysysbutton]
	[eval exp="mysysbutton(mp.dicname,mp.name,mp.exp,mp.nostable)"]
[endmacro]

;系统按钮全部定义
[macro name=defsysbutton]

	[frame layer="message2" visible="false"]
	[current layer="message2" page="fore"]

	[csysbutton]

	[mysysbutton name="save" dicname="f.config_dia.save" exp="kag.callExtraConductor('save.ks', '*start')"]
	[mysysbutton name="load" dicname="f.config_dia.load" exp="kag.callExtraConductor('load.ks', '*start')"]

	[mysysbutton name="skip" dicname="f.config_dia.skip" exp="dm('skip'),kag.onSkipToNextStopMenuItemClick()" nostable=true]
	[mysysbutton name="auto" dicname="f.config_dia.auto" exp="dm('auto'),kag.onAutoModeMenuItemClick()" nostable=true]

	[mysysbutton name="hide" dicname="f.config_dia.hide" exp="kag.onRightClickMenuItemClick() if (System.getTickCount()-tf.clicked>150)"]
	[mysysbutton name="history" dicname="f.config_dia.history" exp="kag.onShowHistoryMenuItemClick()"]

	[mysysbutton name="option" dicname="f.config_dia.option" exp="kag.callExtraConductor('option.ks', '*start')"]
	[mysysbutton name="menu" dicname="f.config_dia.menu" exp="kag.callExtraConductor('main_menu.ks', '*start')"]

	[mysysbutton name="other" dicname="f.config_dia.other" exp="kag.callExtraConductor('other.ks', '*start')"]

	;想要自己追加系统按钮，可以这样：
	;[sysbutton name="按钮名" normal="一般图片" over="选中图片" on="按下图片" x=100 y=100 exp="kag.callExtraConductor('文件名.ks', '*标签名')"]

[endmacro]

;系统按钮无效化
[macro name=disablesysbutton]
	[eval exp="setSysbuttonEnabled(mp.page,0)"]
[endmacro]

;系统按钮有效化
[macro name=enablesysbutton]
	[eval exp="setSysbuttonEnabled(mp.page,1)"]
[endmacro]

;显示系统按钮
[macro name=showsysbutton]
	[layopt layer=message2 page=%page|back visible=true]
[endmacro]

;隐藏系统按钮
[macro name=hidesysbutton]
	[layopt layer=message2 page=%page|back visible=false]
[endmacro]

;------------------------------------------------------------------
;标题画面按钮
;------------------------------------------------------------------
[macro name=button_title]

	[mybutton dicname="f.config_title.start" target=*newgame]
	[mybutton dicname="f.config_title.load" target=*load]

	[mybutton dicname="f.config_title.option" target=*option]

	[mybutton dicname="f.config_title.exit" target=*exit]

	[mybutton dicname="f.config_title.omake" target=*cgmode]
	[mybutton dicname="f.config_title.extra" target=*extra]

	;想要自己追加标题按钮，可以这样：
	;[locate x=100 y=100]
	;[button normal="一般图片" over="选中图片" on="按下图片" target="*标签名"]

[endmacro]
;------------------------------------------------------------------
;主选单按钮
;------------------------------------------------------------------
[macro name=button_menu]

	[mybutton dicname="f.config_menu.save" target=*save]
	[mybutton dicname="f.config_menu.load" target=*load]

	[mybutton dicname="f.config_menu.option" target=*option]
	[mybutton dicname="f.config_menu.history" exp="kag.onShowHistoryMenuItemClick()"]

	[mybutton dicname="f.config_menu.other" target=*user]

	[mybutton dicname="f.config_menu.exit" exp="kag.close()"]
	[mybutton dicname="f.config_menu.totitle" exp="kag.goToStartWithAsk()"]
	[mybutton dicname="f.config_menu.back" target=*return]

	;想要自己追加主选单按钮，可以这样：
	;[locate x=100 y=100]
	;[button normal="一般图片" over="选中图片" on="按下图片" target="*标签名"]

[endmacro]
;------------------------------------------------------------
;系统设定
;------------------------------------------------------------
;简化滑动槽宏
[macro name=myslider]
	[eval exp="myslider(mp.dicname,mp.value,mp.max,mp.min,mp.mychangefunc)"]
[endmacro]

[macro name=button_option]
	;----------------------滚动条----------------------
	;文字速度
	[myslider value="kag.textspeed" dicname="f.config_option.textspeed" max=10 min=0]
	;自动前进速度
	[myslider value="kag.autospeed" dicname="f.config_option.autospeed" max=10 min=0]
	;音乐音量
	[myslider value="kag.bgmvolume" dicname="f.config_option.bgmvolume" max=100 min=0]
	;音效音量
	[myslider mychangefunc="setSeVolume" value="sf.sevolume" dicname="f.config_option.sevolume" max=100 min=0]
	;语音音量
	[myslider mychangefunc="setVoiceVolume" value="sf.voicevolume" dicname="f.config_option.cvvolume" max=100 min=0]
	;----------------------checkbox----------------------
	;画面模式
	[mybutton dicname="f.config_option.fullscreen" target=*update exp="kag.onFullScreenMenuItemClick()" cond="kag.fullScreen==false"]
	[mybutton dicname="f.config_option.window" target=*update exp="kag.onWindowedMenuItemClick()" cond="kag.fullScreen==true"]
	;略过模式
	[mybutton dicname="f.config_option.allskip" target=*update exp="kag.allskip=true" cond="kag.allskip==false"]
	[mybutton dicname="f.config_option.readskip" target=*update exp="kag.allskip=false" cond="kag.allskip==true"]
	;----------------------按钮----------------------
	;返回标题
	[mybutton dicname="f.config_option.totitle" exp="kag.goToStartWithAsk()"]
	;关闭游戏
	[mybutton dicname="f.config_option.endgame" exp="kag.close()"]
	;返回按钮
	[mybutton dicname="f.config_option.back" target=*return]
	;恢复默认
	[mybutton dicname="f.config_option.reset" target=*reset]
	;----------------------补充描绘当前高亮状态----------------------
	[image layer=15 page=%page storage=empty visible=true left="0" top="0"]
	[if exp="(f.config_option.fullscreen.use==true) && kag.fullScreen==true"]
	[pimage layer=15 page=%page storage=&"f.config_option.fullscreen.over" dx=&"f.config_option.fullscreen.x" dy=&"f.config_option.fullscreen.y"]
	[endif]
	[if exp="(f.config_option.window.use==true) && kag.fullScreen==false"]
	[pimage layer=15 page=%page storage=&"f.config_option.window.over" dx=&"f.config_option.window.x" dy=&"f.config_option.window.y"]
	[endif]
	[if exp="(f.config_option.allskip.use==true) && kag.allskip==true"]
	[pimage layer=15 page=%page storage=&"f.config_option.allskip.over" dx=&"f.config_option.allskip.x" dy=&"f.config_option.allskip.y"]
	[endif]
	[if exp="(f.config_option.readskip.use==true) && kag.allskip==false"]
	[pimage layer=15 page=%page storage=&"f.config_option.readskip.over" dx=&"f.config_option.readskip.x" dy=&"f.config_option.readskip.y"]
	[endif]
	[endmacro]
;------------------------------------------------------------
[return]
