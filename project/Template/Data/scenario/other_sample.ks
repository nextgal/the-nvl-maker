;------------------------------------------------------------
;預留菜單，主菜單上的「自定選單」會連接到這裡
;你可以用這個格式製作自製選單（例如道具系統）
;使用養成面板的寫法可以查看範例腳本other.ks
;------------------------------------------------------------
*start
[locksnapshot]
[tempsave]
;------------------------------------------------------------
*window
[history enabled="false"]
[locklink]
[rclick enabled="true" jump="true" storage="other_sample.ks" target=*return]
;------------------------------------------------------------
;自己定義界面，加在這下面
[backlay]
;界面背景圖
[image layer=14 page=back storage="Sample_PANEL" left=0 top=0 visible="true"]
;無效化系統按鈕層
[disablesysbutton page="back"]

[current layer="message4" page="back"]
[layopt layer="message4" visible="true" page="back" left=0 top=0]
[er]
;這裡是顯示按鈕和圖片的位置

;例如：添加一個返回按鈕
;[locate x=0 y=0]
;[button normal="xxxx" target=*return]

[trans method="crossfade" time=300]
[wt]

[s]
;------------------------------------------------------------
*return
[jump storage="main_menu.ks" target=*return]
