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

[rclick enabled="true" jump="true" storage="save.ks" target=*返回]
[backlay]
[image layer=14 page=back storage=&"f.config_sl.bgd" left=0 top=0 visible="true"]

;无效化系统按钮层
[disablesysbutton page=back]

;用message4描绘
[current layer="message4" page="back"]
[layopt layer="message4" visible="true" page="back" left=0 top=0]
[er]

[eval exp="drawslbutton('back')"]

[trans method="crossfade" time=300]
[wt]

[s]
;------------------------------------------------------------
*刷新画面
[current layer="message4"]
[er]
[eval exp="drawslbutton()"]
[s]

;------------------------------------------------------------
*存取游戏
[save ask="true" place="&tf.最近档案"]
[s]
;------------------------------------------------------------
*返回
[jump storage="main_menu.ks" target=*返回]
