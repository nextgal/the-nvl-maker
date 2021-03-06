;------------------------------------------------------------
;预留菜单，对话界面上的“自定选单”会连接到这里
;你可以用这个格式制作自制选单（例如道具系统）
;------------------------------------------------------------
*start
[iscript]
//默认不选中任何笔记
f.selected_note=-1;
[endscript]
[locksnapshot]
[tempsave]
;------------------------------------------------------------
*window
[history enabled="false"]
[locklink]
[rclick enabled="false"]
;------------------------------------------------------------
;调用养成面板作为界面（范例：查看主角信息）
;这里是直接从对话框调用的
;因为养成面板的默认图层顺序比主菜单低，如果从主菜单上调用，请将layer设为14
;------------------------------------------------------------
[edu storage="herodata.edu" layer=14]
[rclick enabled="true" jump="true" storage="other.ks" target=*return]
[s]

;------------------------------------------------------------
;从自定选单连接到笔记收集
;养成面板可以配合自定义代码使用
;------------------------------------------------------------
*note
[backlay]
;养成面板的内容
[loadedu storage="notebook.edu" layer=14]
;自定义代码（显示笔记按钮列表）
[draw_note]
[trans method=crossfade time=300]
[wt]
[rclick enabled="true" jump="true" storage="other.ks" target=*return]
[s]

;------------------------------------------------------------
;从自定选单连接到道具收集
;------------------------------------------------------------
*item
[sysmap storage="item.map" layer=14]
[rclick enabled="true" jump="true" storage="other.ks" target=*return]
[s]

;------------------------------------------------------------
*return
[jump storage="main_menu.ks" target=*return]
