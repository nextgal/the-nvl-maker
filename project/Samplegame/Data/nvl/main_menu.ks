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
[if exp="f.config_menu.save.use==true"]
[locate x=&"f.config_menu.save.x" y=&"f.config_menu.save.y"]
[mybutton dicname="f.config_menu.save" target=*保存游戏]
[endif]
[if exp="f.config_menu.load.use==true"]
[locate x=&"f.config_menu.load.x" y=&"f.config_menu.load.y"]
[mybutton dicname="f.config_menu.load" target=*读取进度]
[endif]
[if exp="f.config_menu.option.use==true"]
[locate x=&"f.config_menu.option.x" y=&"f.config_menu.option.y"]
[mybutton dicname="f.config_menu.option" target=*系统设定]
[endif]
[if exp="f.config_menu.history.use==true"]
[locate x=&"f.config_menu.history.x" y=&"f.config_menu.history.y"]
[mybutton dicname="f.config_menu.history" exp="kag.onShowHistoryMenuItemClick()"]
[endif]
[if exp="f.config_menu.other.use==true"]
[locate x=&"f.config_menu.other.x" y=&"f.config_menu.other.y"]
[mybutton dicname="f.config_menu.other" target=*自定选单]
[endif]
[if exp="f.config_menu.exit.use==true"]
[locate x=&"f.config_menu.exit.x" y=&"f.config_menu.exit.y"]
[mybutton dicname="f.config_menu.exit" target=*离开游戏]
[endif]
[if exp="f.config_menu.totitle.use==true"]
[locate x=&"f.config_menu.totitle.x" y=&"f.config_menu.totitle.y"]
[mybutton dicname="f.config_menu.totitle" target=*返回标题]
[endif]

;返回按钮
[if exp="f.config_menu.back.use==true"]
[locate x=&"f.config_menu.back.x" y=&"f.config_menu.back.y"]
[mybutton dicname="f.config_menu.back" target=*返回]
[endif]

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

*离开游戏
[close ask="true"]
[jump target=*window]

*返回标题
[gotostart ask="true"]
[jump target=*window]
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
