;------------------------------------------------------------
;预留菜单，标题画面上的“自定选单”会连接到这里
;你可以用这个格式制作自制系统（例如音乐鉴赏模式）
;------------------------------------------------------------
*start
[locksnapshot]
[tempsave]
;------------------------------------------------------------
*window
[history enabled="false"]
[locklink]
[rclick enabled="true" jump="true" storage="title_other.ks" target=*返回]
;------------------------------------------------------------
;如果是要调用地图或者养成面板作为特别界面，加在这里

;------------------------------------------------------------
;如果是要自己定义界面，加在这下面
[backlay]
;界面背景图
[image layer=14 page=back storage="Sample_PANEL" left=0 top=0 visible="true"]
[current layer="message4" page="back"]
[layopt layer="message4" visible="true" page="back" left=0 top=0]
[er]
;这里是显示按钮和图片的位置

[trans method="crossfade" time=300]
[wt]

[s]
;------------------------------------------------------------
*返回
[jump storage="main_menu.ks" target=*返回]
