;------------------------------------------------------------
;佔位用的系統設定
;------------------------------------------------------------
*start
[locksnapshot]
[tempsave]
;------------------------------------------------------------
*window

[history enabled="false"]

[locklink]
[rclick enabled="true" jump="true" storage="option.ks" target=*返回]

[backlay]
[image layer=14 page=back storage=&"f.config_option.bgd" left=0 top=0 visible="true"]
;隱藏系統按鈕層
[hidesysbutton page="back"]

[current layer="message4" page="back"]
[layopt layer="message4" visible="true" page="back" left=0 top=0]
[er]
;描繪各種ABC
[button_option page=back]
[trans method="crossfade" time=500]
[wt]

[s]

*刷新畫面
[current layer="message4"]
[er]
;描繪各種ABC
[button_option page=fore]
[s]

*返回
[jump storage="main_menu.ks" target=*返回]
