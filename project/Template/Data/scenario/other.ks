;------------------------------------------------------------
;预留菜单，对话界面和主菜单上的“自定选单”会连接到这里
;你可以用这个格式制作自制选单（例如道具系统）
;------------------------------------------------------------
*start
[locksnapshot]
[tempsave]
;------------------------------------------------------------
*window
[history enabled="false"]
[locklink]
[rclick enabled="true" jump="true" storage="other.ks" target=*返回]

[backlay]
[image layer=14 page=back storage="Sample_PANEL" left=0 top=0 visible="true"]
[current layer="message4" page="back"]
[layopt layer="message4" visible="true" page="back" left=0 top=0]
[er]
;在这里描绘按钮等

[trans method="crossfade" time=300]
[wt]

[s]
;------------------------------------------------------------
*返回
[jump storage="main_menu.ks" target=*返回]
