;------------------------------------------------------------
;非常懶惰的歷史記錄顯示
;------------------------------------------------------------
*start
[locksnapshot]
[tempsave]
;------------------------------------------------------------
*window
[eval exp="f.history=true"]

[locklink]
[rclick enabled="true" jump="true" storage="history.ks" target=*返回]
;--------------------------------
;計算頁數
[iscript]
tf.歷史行數=kag.historyLayer.dataPos;
tf.歷史頁數=tf.歷史行數\f.config_history.line;
if (tf.歷史行數%f.config_history.line>0) tf.歷史頁數++;
tf.當前歷史頁=tf.歷史頁數;
[endscript]
;--------------------------------
[backlay]
[image layer=14 page=back storage=&"f.config_history.bgd" left=0 top=0 visible="true"]
;隱藏系統按鈕層
[hidesysbutton page="back"]
;用message4描繪
[current layer="message4" page="back"]
[layopt layer="message4" visible="true" page="back" left=0 top=0]
[er]

[button_history]

[iscript]
draw_history("back");
[endscript]

[trans method="crossfade" time=500]
[wt]
[s]

*刷新腳本顯示
[current layer="message4"]
[er]

[button_history]

[iscript]
draw_history();
[endscript]
[s]

*返回
[eval exp="f.history=false"]
[jump storage="main_menu.ks" target=*返回]
