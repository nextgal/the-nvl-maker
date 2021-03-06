;------------------------------------------------------------
;物品系统范例
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

;描绘物品按钮
[eval exp="draw_item(f.物品类型)"]
;描绘翻页按钮
[item_page page="back"]

[trans method="crossfade" time=500]
[wt]

[s]


*刷新画面
[current layer="message4"]
[er]

;描绘物品按钮
[eval exp="draw_item(f.物品类型)"]
;描绘翻页按钮
[item_page page="fore"]

[s]
;------------------------------------------------------------
*使用物品
[iscript]
//在控制台输出物品名称
dm("选择使用物品："+f.item[f.选择物品编号].name);
[endscript]

;可以在这里写一些判断

;【例如】假如物品可以吃，那么每次点击减少一个物品
[if exp="f.item[f.选择物品编号].eat==true"]
[subitem num=1 name=&"f.item[f.选择物品编号].name"]
[endif]

;【例如】假如物品名称是XXX，那么……
[if exp="f.item[f.选择物品编号].name=='羊毛'"]
;是羊毛的处理

[elsif exp="f.item[f.选择物品编号].name=='黄金'"]
;是黄金的处理

[elsif exp="f.item[f.选择物品编号].name=='秘银'"]
;是秘银的处理

[endif]

[jump target=*刷新画面]


*返回
[jump storage="main_menu.ks" target=*返回]
