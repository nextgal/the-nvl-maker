;------------------------------------------------------------
;非常懒惰的save画面
;------------------------------------------------------------
*start
[locksnapshot]
[tempsave]
;------------------------------------------------------------
*window
;载入配置文件
[iscript]
f.config_sl=f.config_save;
[endscript]
[history enabled="false"]

*firstpage
[locklink]

[rclick enabled="true" jump="true" storage="save.ks" target=*return]
[backlay]
[image layer=14 page=back storage=&"f.config_sl.bgd" left=0 top=0 visible="true"]

;无效化系统按钮层
[disablesysbutton page="back"]

;用message4描绘
[layopt layer="message4" visible="true" page="back" left=0 top=0]
[current layer="message4" page="back"]
[er]
[eval exp="drawslbutton('back')"]
;--------------------------------------
;用message5描绘
[layopt layer="message5" visible="true" page="back" left=0 top=0]
[current layer="message5" page="back"]
[er]
[eval exp="drawslpage()"]
[trans method="crossfade" time=300]
[wt]
[s]
;------------------------------------------------------------
*update
[current layer="message4"]
[er]
[eval exp="drawslbutton()"]
[unlocklink]
[s]

;------------------------------------------------------------
*saveload
[save ask="true" place="&tf.RecentSaveNum"]
[s]
;------------------------------------------------------------
*return
[jump storage="main_menu.ks" target=*return]
