;------------------------------------------------------------
;配方系统范例
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
[image layer=14 page=back storage="item_bgd" left=0 top=0 visible="true"]
;隐藏系统按钮层
[hidesysbutton page="back"]
[current layer="message4" page="back"]
[layopt layer="message4" visible="true" page="back" left=0 top=0]
[er]

;描绘配方按钮
[eval exp="draw_recipe()"]
;描绘翻页按钮
[recipe_page page="back"]

[trans method="crossfade" time=500]
[wt]

[s]


*刷新画面
[current layer="message4"]
[er]

;描绘配方按钮
[eval exp="draw_recipe()"]
;描绘翻页按钮
[recipe_page page="fore"]

[s]
;------------------------------------------------------------
*合成
[iscript]
dm("选择了配方："+f.recipe[f.选择配方编号].name);

[endscript]

*返回
[jump storage="main_menu.ks" target=*返回]
