;------------------------------------------------------------
;非常懒惰的load画面
;------------------------------------------------------------
*start
[locksnapshot]
[tempsave]

;------------------------------------------------------------
*window

;载入配置文件
[iscript]
f.config_sl=f.config_load;
[endscript]
[history enabled="false"]

*firstpage
[locklink]
[rclick enabled="true" jump="true" storage="load.ks" target=*return]
[backlay]
;显示背景
[uiback dicname="f.config_sl.bgd"]

;无效化系统按钮层
[disablesysbutton page="back"]

;用message4描绘
[current layer="message4" page="back"]
[layopt layer="message4" visible="true" page="back" left=0 top=0]
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
[locklink]
[current layer="message4"]
[er]
[eval exp="drawslbutton()"]
[current layer="message5"]
[er]
[eval exp="drawslpage()"]
[s]

;------------------------------------------------------------
*saveload
[if exp="checkdata(tf.RecentSaveNum)"]
[load ask="true" place="&tf.RecentSaveNum"]
[else]
[jump target=*update]
[end]
[s]
;------------------------------------------------------------
*return
[jump storage="main_menu.ks" target=*return]
