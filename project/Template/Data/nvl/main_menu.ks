;------------------------------------------------------------
;主菜单
;------------------------------------------------------------
*start
[locksnapshot]
[tempsave]
;------------------------------------------------------------
*window
;载入配置文件
[history enabled="false"]

[locklink]
[rclick enabled="true" jump="true" storage="main_menu.ks" target=*返回]

[backlay]
[image layer=14 page=back storage=&"f.config_menu.bgd" left=0 top=0 visible="true"]
;隐藏系统按钮层
[disablesysbutton page="back"]
;用message4描绘
[current layer="message4" page="back"]
[layopt layer="message4" visible="true" page="back" left=0 top=0]
[er]

	;这里显示按钮
	[mybutton dicname="f.config_menu.save" target=*保存游戏]
	[mybutton dicname="f.config_menu.load" target=*读取进度]
	[mybutton dicname="f.config_menu.option" target=*系统设定]
	[mybutton dicname="f.config_menu.history" exp="kag.onShowHistoryMenuItemClick()"]
	[mybutton dicname="f.config_menu.other" target=*自定义选单]
	[mybutton dicname="f.config_menu.exit" exp="kag.close()"]
	[mybutton dicname="f.config_menu.totitle" exp="kag.goToStartWithAsk()"]
	
	;返回按钮
	[mybutton dicname="f.config_menu.back" target=*返回]

[trans method="crossfade" time=200]
[wt]

[s]

;都是跳转到window标签

*保存游戏
[jump storage="save.ks" target=*window]

*读取进度
[jump storage="load.ks" target=*window]

*系统设定
[jump storage="option.ks" target=*window]

*自定选单
[jump storage="other.ks" target=*window]
;------------------------------------------------------------
*返回
[locklink]
[rclick enabled="false"]
[backlay]
[tempload backlay="true" bgm="false" se="false"]
[trans method="crossfade" time=200]
[wt]

[unlocksnapshot]
[return]
