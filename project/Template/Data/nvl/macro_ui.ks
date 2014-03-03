;-------------------------------------------------------------------------------------------
;系统按钮、标题画面、OPTION画面及其他零碎用的宏
;-------------------------------------------------------------------------------------------
*start
;------------------------------------------------------------------
;系统全屏框宏，用于设置一个等于游戏画面大小的全透明消息层
;过去是用empty这张图片来代替的，现在改掉了
;------------------------------------------------------------------
[macro name="frame"]
[position layer="%layer|message0" page="%page|fore" visible="%visible|true" marginb=0 marginl=0 marginr=0 margint=0 color="0xFFFFFF" opacity="0" width=&"kag.scWidth" height=&"kag.scHeight" left="0" top="0"]
[endmacro]
;------------------------------------------------------------------
;自定按钮宏（对应NVL参数字典,标签，表达式，TICK间隔时间，点击时每TICK执行函数）
;------------------------------------------------------------------
[iscript]

function mybutton(dicname,target,exp,interval,ontimer)
{
	//新建字典并复制一份参数
	var mybutton=new Dictionary(); 
	mybutton=dicname!;

	//假如内容为空，则不发生任何事
	if (mybutton==void) return;
	
	//假如按钮存在并且使用到，则增加其他传入参数
	if (mybutton.use==true)
	{
		kag.tagHandlers.locate(
		%[
			"x" => mybutton.x,
			"y" => mybutton.y
		]);

		mybutton.target=target;
		mybutton.exp=exp;
		
		mybutton.interval=interval;
		mybutton.ontimer=ontimer;

		//删除字典内的空值
		foreach(mybutton,checkdict);
		kag.tagHandlers.button(mybutton);

	}
}
[endscript]

[macro name=mybutton]
	[eval exp="mybutton(mp.dicname,mp.target,mp.exp,mp.interval,mp.ontimer)"]
[endmacro]

;------------------------------------------------------------------
;系统按钮
;------------------------------------------------------------------
[iscript]
//无效化单个系统按钮（foreach循环用）
function oneButtonEnabled(name,value,dict,enabled)
{
	dict[name].enabled=enabled;
}
//将所有系统按钮无效化/有效化的函数
function setSysbuttonEnabled(page,enabled)
{
	var layer;
	
	if (page=="fore") layer=kag.fore.messages[2];
	else layer=kag.back.messages[2];

	//if (layer.buttons[name]!=void) layer.buttons[name].enabled=enabled;//处理单个按钮的范例

	//批量处理当前层上所有按钮
	foreach(layer.buttons,oneButtonEnabled,enabled);
}
[endscript]

[iscript]
//系统按钮函数（系统按钮名字，对应NVL参数字典，表达式，不安定时是否可点）
function mysysbutton(dicname,name,exp,noStable)
{

	var mysysbutton=new Dictionary();
	mysysbutton=dicname!;
	
	//假如不存在对应的参数，则不发生任何事
	if (mysysbutton==void) return;

	//假如按钮存在并且使用到，则增加其他传入参数
	if (mysysbutton.use==true)
	{
		mysysbutton.name=name;
		mysysbutton.exp=exp;
		mysysbutton.noStable=noStable;

		//删除字典内的空值
		foreach(mysysbutton,checkdict);

		kag.tagHandlers.sysbutton(mysysbutton);

	}
}
[endscript]

;系统按钮单个定义
[macro name=mysysbutton]
	[eval exp="mysysbutton(mp.dicname,mp.name,mp.exp,mp.nostable=0)"]
[endmacro]

;系统按钮全部定义
[macro name=defsysbutton]

	[frame layer="message2" visible="false"]
	[current layer="message2" page="fore"]

	[csysbutton]

	[mysysbutton name="save" dicname="f.config_dia.save" exp="kag.callExtraConductor('save.ks', '*start')"]
	[mysysbutton name="load" dicname="f.config_dia.load" exp="kag.callExtraConductor('load.ks', '*start')"]

	[mysysbutton name="skip" dicname="f.config_dia.skip" exp="kag.onSkipToNextStopMenuItemClick()" nostable=true]
	[mysysbutton name="auto" dicname="f.config_dia.auto" exp="kag.onAutoModeMenuItemClick()" nostable=true]

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
	[mybutton dicname="f.config_title.start" target=*开始游戏]
	[mybutton dicname="f.config_title.load" target=*读取进度]
	[mybutton dicname="f.config_title.option" target=*系统设定]
	[mybutton dicname="f.config_title.extra" target=*自定选单]
	[mybutton dicname="f.config_title.exit" target=*离开游戏]
	[mybutton dicname="f.config_title.omake" target=*CG模式]

	;想要自己追加标题按钮，可以这样：
	;[locate x=100 y=100]
	;[button normal="一般图片" over="选中图片" on="按下图片" target="*标签名"]

[endmacro]
;------------------------------------------------------------------
;主选单按钮
;------------------------------------------------------------------
[macro name=button_menu]

	[mybutton dicname="f.config_menu.save" target=*保存游戏]
	[mybutton dicname="f.config_menu.load" target=*读取进度]
	[mybutton dicname="f.config_menu.option" target=*系统设定]
	[mybutton dicname="f.config_menu.history" exp="kag.onShowHistoryMenuItemClick()"]
	[mybutton dicname="f.config_menu.other" target=*自定选单]
	[mybutton dicname="f.config_menu.exit" exp="kag.close()"]
	[mybutton dicname="f.config_menu.totitle" exp="kag.goToStartWithAsk()"]
	[mybutton dicname="f.config_menu.back" target=*返回]

	;想要自己追加主选单按钮，可以这样：
	;[locate x=100 y=100]
	;[button normal="一般图片" over="选中图片" on="按下图片" target="*标签名"]

[endmacro]
;------------------------------------------------------------
;系统设定
;------------------------------------------------------------
[iscript]
//即时调整音效和语音音量的函数
function setSeVolume()
{
    kag.se[0].volume=sf.sevolume;
	dm("Se Volume="+kag.se[0].volume);
}

function setVoiceVolume()
{
	kag.se[1].volume=sf.voicevolume;
	dm("Voice Volume="+kag.se[1].volume);
}
[endscript]

[iscript]
//滑动槽定义
function myslider(dicname,value,max,min,mychangefunc)
{

	var myslider=new Dictionary();	
	myslider=dicname!;

	//假如不存在对应的参数，则不发生任何事
	if (myslider==void) return;

	//假如Slider存在并且使用到，则增加其他传入参数
	if (myslider.use==true)
	{

		kag.tagHandlers.locate(
		%[
			"x" => myslider.x,
			"y" => myslider.y
		]);

		myslider.nofixpos=true;
		myslider.nohilight=true;

		myslider.value=value;
		myslider.max=max;
		myslider.min=min;

		myslider.mychangefunc=mychangefunc;

		//删除字典内的空值
		foreach(myslider,checkdict);
		//创建滑动槽
		kag.tagHandlers.slider(myslider);

	}
}
[endscript]

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
	[mybutton dicname="f.config_option.fullscreen" target=*刷新画面 exp="kag.onFullScreenMenuItemClick()" cond="kag.fullScreen==false"]
	[mybutton dicname="f.config_option.window" target=*刷新画面 exp="kag.onWindowedMenuItemClick()" cond="kag.fullScreen==true"]
	;略过模式
	[mybutton dicname="f.config_option.allskip" target=*刷新画面 exp="kag.allskip=true" cond="kag.allskip==false"]
	[mybutton dicname="f.config_option.readskip" target=*刷新画面 exp="kag.allskip=false" cond="kag.allskip==true"]
	;----------------------按钮----------------------
	;返回标题
	[mybutton dicname="f.config_option.totitle" exp="kag.goToStartWithAsk()"]
	;关闭游戏
	[mybutton dicname="f.config_option.endgame" exp="kag.close()"]
	;返回按钮
	[mybutton dicname="f.config_option.back" target=*返回]
	;恢复默认
	[mybutton dicname="f.config_option.reset" target=*默认]
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
