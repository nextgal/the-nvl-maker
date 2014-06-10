;------------------------------------------------------------
;预留菜单，对话界面上的“自定选单”会连接到这里
;你可以用这个格式制作自制选单（例如道具系统）
;------------------------------------------------------------
*start
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
;因为养成面板的默认图层顺序比主菜单低，如果从主菜单上调用，记得手动调整养成面板的图层顺序
;------------------------------------------------------------
[edu storage="herodata.edu"]
[rclick enabled="true" jump="true" storage="other.ks" target=*返回]
[s]

;------------------------------------------------------------
;从主角介绍的面板连接到笔记系统
;------------------------------------------------------------
*note
;默认不显示任何笔记内容
[eval exp="f.notebook=''"]
;调用笔记系统面板
[edu storage="notebook.edu"]
;将右键设定为返回到主角介绍面板
[rclick enabled="true" jump="true" storage="other.ks" target=*window]
[s]
;------------------------------------------------------------
;当点下某个按钮之后，刷新笔记画面以显示不同文字
*updatenote
;刷新笔记画面时间为0毫秒（无淡入特效）
[edu storage="notebook.edu" time=0]
[rclick enabled="true" jump="true" storage="other.ks" target=*window]
[s]


;------------------------------------------------------------
*返回
[jump storage="main_menu.ks" target=*返回]
