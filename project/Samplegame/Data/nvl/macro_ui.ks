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
	mybutton.over=dic.over;
	mybutton.on=dic.on;
	
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
;系统按钮无效化
[macro name=disablesysbutton]
[image layer=10 page=%page storage=sysmenu_frame left=0 top=0]
[layopt layer=10 page=%page visible="true" cond="kag.fore.messages[2].visible || kag.fore.layers[10].visible"]
;隐藏真的系统按钮
[layopt layer=message2 page=%page|back visible=false]
;显示造型一样的图
[if exp="f.config_dia.save.use==true"]
[pimage layer=10 page=%page storage=&"f.config_dia.save.normal" dx=&"f.config_dia.save.x" dy=&"f.config_dia.save.y"]
[endif]
[if exp="f.config_dia.load.use==true"]
[pimage layer=10 page=%page storage=&"f.config_dia.load.normal" dx=&"f.config_dia.load.x" dy=&"f.config_dia.load.y"]
[endif]
[if exp="f.config_dia.skip.use==true"]
[pimage layer=10 page=%page storage=&"f.config_dia.skip.normal" dx=&"f.config_dia.skip.x" dy=&"f.config_dia.skip.y"]
[endif]
[if exp="f.config_dia.auto.use==true"]
[pimage layer=10 page=%page storage=&"f.config_dia.auto.normal" dx=&"f.config_dia.auto.x" dy=&"f.config_dia.auto.y"]
[endif]
[if exp="f.config_dia.hide.use==true"]
[pimage layer=10 page=%page storage=&"f.config_dia.hide.normal" dx=&"f.config_dia.hide.x" dy=&"f.config_dia.hide.y"]
[endif]
[if exp="f.config_dia.history.use==true"]
[pimage layer=10 page=%page storage=&"f.config_dia.history.normal" dx=&"f.config_dia.history.x" dy=&"f.config_dia.history.y"]
[endif]
[if exp="f.config_dia.option.use==true"]
[pimage layer=10 page=%page storage=&"f.config_dia.option.normal" dx=&"f.config_dia.option.x" dy=&"f.config_dia.option.y"]
[endif]
[if exp="f.config_dia.menu.use==true"]
[pimage layer=10 page=%page storage=&"f.config_dia.menu.normal" dx=&"f.config_dia.menu.x" dy=&"f.config_dia.menu.y"]
[endif]
[if exp="f.config_dia.other.use==true"]
[pimage layer=10 page=%page storage=&"f.config_dia.other.normal" dx=&"f.config_dia.other.x" dy=&"f.config_dia.other.y"]
[endif]
[endmacro]

;显示系统按钮
[macro name=showsysbutton]
[layopt layer=message2 page=%page|back visible=true]
[freeimage layer=10 page=%page|back]
[endmacro]

;隐藏系统按钮
[macro name=hidesysbutton]
[layopt layer=message2 page=%page|back visible=false]
[freeimage layer=10 page=%page|back]
[endmacro]

;系统按钮单个定义
[macro name=mysysbutton]
[if exp="mp.enterse!=void && mp.clickse!=void"]
[sysbutton enterse=%enterse clickse=%clickse name=%name normal=%normal over=%over on=%on x=%x y=%y exp=%exp noStable=%nostable|0]
[elsif exp="mp.enterse!=void"]
[sysbutton enterse=%enterse name=%name normal=%normal over=%over on=%on x=%x y=%y exp=%exp noStable=%nostable|0]
[elsif exp="mp.clickse!=void"]
[sysbutton clickse=%clickse name=%name normal=%normal over=%over on=%on x=%x y=%y exp=%exp noStable=%nostable|0]
[else]
[sysbutton name=%name normal=%normal over=%over on=%on x=%x y=%y exp=%exp noStable=%nostable|0]
[endif]
[endmacro]

;系统按钮定义
[macro name=defsysbutton]

[position layer="message2" visible="false" frame="sysmenu_frame" left=0 top=0 marginb=0 marginl=0 marginr=0 margint=0 page="fore"]
[current layer="message2" page="fore"]

[csysbutton]
[if exp="f.config_dia.save.use==true"]
[mysysbutton name=save normal=&"f.config_dia.save.normal" over=&"f.config_dia.save.over" on=&"f.config_dia.save.on" x=&"f.config_dia.save.x" y=&"f.config_dia.save.y" exp="kag.callExtraConductor('save.ks', '*start')" enterse=&"f.config_dia.save.enterse" clickse=&"f.config_dia.save.clickse"]
[endif]
[if exp="f.config_dia.load.use==true"]
[mysysbutton name=load normal=&"f.config_dia.load.normal" over=&"f.config_dia.load.over" on=&"f.config_dia.load.on" x=&"f.config_dia.load.x" y=&"f.config_dia.load.y" exp="kag.callExtraConductor('load.ks', '*start')" enterse=&"f.config_dia.load.enterse" clickse=&"f.config_dia.load.clickse"]
[endif]
[if exp="f.config_dia.skip.use==true"]
[mysysbutton name=skip normal=&"f.config_dia.skip.normal" over=&"f.config_dia.skip.over" on=&"f.config_dia.skip.on" x=&"f.config_dia.skip.x" y=&"f.config_dia.skip.y" exp="kag.onSkipToNextStopMenuItemClick()" nostable=true enterse=&"f.config_dia.skip.enterse" clickse=&"f.config_dia.skip.clickse"]
[endif]
[if exp="f.config_dia.auto.use==true"]
[mysysbutton name=auto normal=&"f.config_dia.auto.normal" over=&"f.config_dia.auto.over" on=&"f.config_dia.auto.on" x=&"f.config_dia.auto.x" y=&"f.config_dia.auto.y" exp="kag.onAutoModeMenuItemClick()" nostable=true enterse=&"f.config_dia.auto.enterse" clickse=&"f.config_dia.auto.clickse"]
[endif]
[if exp="f.config_dia.hide.use==true"]
[mysysbutton name=hide normal=&"f.config_dia.hide.normal" over=&"f.config_dia.hide.over" on=&"f.config_dia.hide.on" x=&"f.config_dia.hide.x" y=&"f.config_dia.hide.y" exp="kag.onRightClickMenuItemClick() if (System.getTickCount()-tf.clicked>150)" enterse=&"f.config_dia.hide.enterse" clickse=&"f.config_dia.hide.clickse"]
[endif]
[if exp="f.config_dia.history.use==true"]
[mysysbutton name=history normal=&"f.config_dia.history.normal" over=&"f.config_dia.history.over" on=&"f.config_dia.history.on" x=&"f.config_dia.history.x" y=&"f.config_dia.history.y" exp="kag.onShowHistoryMenuItemClick()" enterse=&"f.config_dia.history.enterse" clickse=&"f.config_dia.history.clickse"]
[endif]
[if exp="f.config_dia.option.use==true"]
[mysysbutton name=option normal=&"f.config_dia.option.normal" over=&"f.config_dia.option.over" on=&"f.config_dia.option.on" x=&"f.config_dia.option.x" y=&"f.config_dia.option.y" exp="kag.callExtraConductor('option.ks', '*start')" enterse=&"f.config_dia.option.enterse" clickse=&"f.config_dia.option.clickse"]
[endif]
[if exp="f.config_dia.menu.use==true"]
[mysysbutton name=menu normal=&"f.config_dia.menu.normal" over=&"f.config_dia.menu.over" on=&"f.config_dia.menu.on" x=&"f.config_dia.menu.x" y=&"f.config_dia.menu.y" exp="kag.callExtraConductor('main_menu.ks', '*start')" enterse=&"f.config_dia.menu.enterse" clickse=&"f.config_dia.menu.clickse"]
[endif]
[if exp="f.config_dia.other.use==true"]
[mysysbutton name=other normal=&"f.config_dia.other.normal" over=&"f.config_dia.other.over" on=&"f.config_dia.other.on" x=&"f.config_dia.other.x" y=&"f.config_dia.other.y" exp="kag.callExtraConductor('other.ks', '*start')" enterse=&"f.config_dia.other.enterse" clickse=&"f.config_dia.other.clickse"]
[endif]
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
