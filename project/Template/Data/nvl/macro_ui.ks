;-------------------------------------------------------------------------------------------
;系统按钮、标题画面、OPTION画面用的宏
;-------------------------------------------------------------------------------------------
*start
;------------------------------------------------------------------
;自定按钮宏（添加音效用）
;------------------------------------------------------------------
[iscript]

function mybutton(elm,target,exp,interval,ontimer)
{
	var dic=new Dictionary(); 
	var mybutton=new Dictionary();
	
	dic=elm!;
	
	mybutton.normal=dic.normal;
	if (dic.over!=void) mybutton.over=dic.over;
	if (dic.on!=void) mybutton.on=dic.on;
	
	if (dic.clickse!=void) mybutton.clickse=dic.clickse;
	if (dic.enterse!=void) mybutton.enterse=dic.enterse;
	
	if (target!=void) mybutton.target=target;
	if (exp!=void) mybutton.exp=exp;
	
	if (interval!=void) mybutton.interval=interval;
	if (ontimer!=void) mybutton.ontimer=ontimer;
	
	kag.tagHandlers.button(mybutton);
}
[endscript]

[macro name=mybutton]
[eval exp="mybutton(mp.dicname,mp.target,mp.exp,mp.interval,mp.ontimer)"]
[endmacro]

;------------------------------------------------------------------
;系统按钮
;------------------------------------------------------------------
[iscript]
//将所有系统按钮无效化/有效化的函数
function setSysbuttonEnabled(page,enabled)
{
	var layer;
	
	if (page=="fore") layer=kag.fore.messages[2];
	else layer=kag.back.messages[2];

	//if (layer.buttons[name]!=void) layer.buttons[name].enabled=enabled;

	if (layer.buttons["save"]!=void) layer.buttons["save"].enabled=enabled;
	if (layer.buttons["load"]!=void) layer.buttons["load"].enabled=enabled;
	if (layer.buttons["skip"]!=void) layer.buttons["skip"].enabled=enabled;

	if (layer.buttons["auto"]!=void) layer.buttons["auto"].enabled=enabled;
	if (layer.buttons["hide"]!=void) layer.buttons["hide"].enabled=enabled;
	if (layer.buttons["history"]!=void) layer.buttons["history"].enabled=enabled;

	if (layer.buttons["option"]!=void) layer.buttons["option"].enabled=enabled;
	if (layer.buttons["menu"]!=void) layer.buttons["menu"].enabled=enabled;
	if (layer.buttons["other"]!=void) layer.buttons["other"].enabled=enabled;

}
[endscript]

[iscript]
//系统按钮函数（系统按钮名字，对应NVL参数字典，表达式，不安定时是否可点）
function mysysbutton(name,elm,exp,noStable)
{
	var dic=new Dictionary(); 
	var mysysbutton=new Dictionary();
	
	dic=elm!;
	
	//假如使用到这个按钮，则开始取得参数
	if (dic.use==true)
	{
		mysysbutton.name=name;
		
		mysysbutton.normal=dic.normal;

		if (dic.over!=void) mysysbutton.over=dic.over;
		if (dic.on!=void) mysysbutton.on=dic.on;
	
		mysysbutton.x=dic.x;
		mysysbutton.y=dic.y;
		
		if (dic.clickse!=void) mysysbutton.clickse=dic.clickse;
		if (dic.enterse!=void) mysysbutton.enterse=dic.enterse;
		
		mysysbutton.exp=exp;
		mysysbutton.noStable=noStable;
		
		kag.tagHandlers.sysbutton(mysysbutton);
	}
}
[endscript]

;系统按钮单个定义
[macro name=mysysbutton]
[eval exp="mysysbutton(mp.name,mp.dicname,mp.exp,mp.nostable=0)"]
[endmacro]

;系统按钮全部定义
[macro name=defsysbutton]

[position layer="message2" visible="false" frame="empty" left=0 top=0 marginb=0 marginl=0 marginr=0 margint=0 page="fore"]
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
[if exp="f.config_title.start.use==true"]
[locate x=&"f.config_title.start.x" y=&"f.config_title.start.y"]
[mybutton dicname="f.config_title.start" target=*开始游戏]
[endif]

[if exp="f.config_title.load.use==true"]
[locate x=&"f.config_title.load.x" y=&"f.config_title.load.y"]
[mybutton dicname="f.config_title.load" target=*读取进度]
[endif]

[if exp="f.config_title.option.use==true"]
[locate x=&"f.config_title.option.x" y=&"f.config_title.option.y"]
[mybutton dicname="f.config_title.option" target=*系统设定]
[endif]

[if exp="f.config_title.extra.use==true"]
[locate x=&"f.config_title.extra.x" y=&"f.config_title.extra.y"]
[mybutton dicname="f.config_title.extra" target=*自定选单]
[endif]

[if exp="f.config_title.exit.use==true"]
[locate x=&"f.config_title.exit.x" y=&"f.config_title.exit.y"]
[mybutton dicname="f.config_title.exit" target=*离开游戏]
[endif]

;omake(CG模式)
[if exp="f.config_title.omake.use==true"]
[locate x=&"f.config_title.omake.x" y=&"f.config_title.omake.y"]
[mybutton dicname="f.config_title.omake" target=*CG模式]
[endif]

[endmacro]

;------------------------------------------------------------
;系统设定
;------------------------------------------------------------
[macro name=button_option]
;----------------------滚动条----------------------
;文字速度
[if exp="f.config_option.textspeed.use==true"]
[locate x=&"f.config_option.textspeed.x" y=&"f.config_option.textspeed.y"]
[slider nofixpos=true nohilight=true value="kag.textspeed" base=&"f.config_option.textspeed.base" normal=&"f.config_option.textspeed.normal" over=&"f.config_option.textspeed.over" on=&"f.config_option.textspeed.on" max=10 min=0]
[endif]
;自动前进速度
[if exp="f.config_option.autospeed.use==true"]
[locate x=&"f.config_option.autospeed.x" y=&"f.config_option.autospeed.y"]
[slider nofixpos=true nohilight=true value="kag.autospeed" base=&"f.config_option.autospeed.base" normal=&"f.config_option.autospeed.normal" over=&"f.config_option.autospeed.over" on=&"f.config_option.autospeed.on" max=10 min=0]
[endif]
;音乐音量
[if exp="f.config_option.bgmvolume.use==true"]
[locate x=&"f.config_option.bgmvolume.x" y=&"f.config_option.bgmvolume.y"]
[slider nofixpos=true nohilight=true value="kag.bgmvolume" base=&"f.config_option.bgmvolume.base" normal=&"f.config_option.bgmvolume.normal" over=&"f.config_option.bgmvolume.over" on=&"f.config_option.bgmvolume.on" max=100 min=0]
[endif]
;音效音量
[if exp="f.config_option.sevolume.use==true"]
[locate x=&"f.config_option.sevolume.x" y=&"f.config_option.sevolume.y"]
[slider nofixpos=true nohilight=true value="kag.sevolume" base=&"f.config_option.sevolume.base" normal=&"f.config_option.sevolume.normal" over=&"f.config_option.sevolume.over" on=&"f.config_option.sevolume.on" max=100 min=0]
[endif]
;----------------------checkbox----------------------
;画面模式
[if exp="f.config_option.fullscreen.use==true"]
[locate x=&"f.config_option.fullscreen.x" y=&"f.config_option.fullscreen.y"]
[mybutton dicname="f.config_option.fullscreen" target=*刷新画面 exp="kag.onFullScreenMenuItemClick()" cond="kag.fullScreen==false"]
[endif]
[if exp="f.config_option.window.use==true"]
[locate x=&"f.config_option.window.x" y=&"f.config_option.window.y"]
[mybutton dicname="f.config_option.window" target=*刷新画面 exp="kag.onWindowedMenuItemClick()" cond="kag.fullScreen==true"]
[endif]
;略过模式
[if exp="f.config_option.allskip.use==true"]
[locate x=&"f.config_option.allskip.x" y=&"f.config_option.allskip.y"]
[mybutton dicname="f.config_option.allskip" target=*刷新画面 exp="kag.allskip=true" cond="kag.allskip==false"]
[endif]
[if exp="f.config_option.readskip.use==true"]
[locate x=&"f.config_option.readskip.x" y=&"f.config_option.readskip.y"]
[mybutton dicname="f.config_option.readskip" target=*刷新画面 exp="kag.allskip=false" cond="kag.allskip==true"]
[endif]
;----------------------按钮----------------------
;返回标题
[if exp="f.config_option.totitle.use==true"]
[locate x=&"f.config_option.totitle.x" y=&"f.config_option.totitle.y"]
[mybutton dicname="f.config_option.totitle" exp="kag.goToStartWithAsk()"]
[endif]
;关闭游戏
[if exp="f.config_option.endgame.use==true"]
[locate x=&"f.config_option.endgame.x" y=&"f.config_option.endgame.y"]
[mybutton dicname="f.config_option.endgame" exp="kag.close()"]
[endif]
;返回按钮
[if exp="f.config_option.back.use==true"]
[locate x=&"f.config_option.back.x" y=&"f.config_option.back.y"]
[mybutton dicname="f.config_option.back" target=*返回]
[endif]
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
