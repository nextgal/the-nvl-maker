;------------------------------------------------------------
;非常懒惰的历史记录显示
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
;计算页数
[iscript]
tf.历史行数=kag.historyLayer.dataPos;
tf.历史页数=tf.历史行数\f.config_history.line;
if (tf.历史行数%f.config_history.line>0) tf.历史页数++;
tf.当前历史页=tf.历史页数;
[endscript]
;--------------------------------
[backlay]
[image layer=14 page=back storage=&"f.config_history.bgd" left=0 top=0 visible="true"]
;隐藏系统按钮层
[hidesysbutton page="back"]
;用message4描绘
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

*刷新脚本显示
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
