;------------------------------------------------------------
;右键显示、隐藏对话框
;------------------------------------------------------------
*hidemes
[hidemes]
[rclick enabled="true" jump="true" storage="rclick.ks" target=*showmes]
[eval exp="kag.leftClickHook.add(onLeftClick)"]
[s]

*showmes
[eval exp="kag.leftClickHook.remove(onLeftClick)"]
[showmes]
[rclick enabled="true" call="true" storage="rclick.ks" target=*hidemes]
[eval exp="tf.clicked=System.getTickCount()"]
[return]
