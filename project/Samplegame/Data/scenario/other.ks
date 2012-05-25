;------------------------------------------------------------
;物品系統範例
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
;隱藏系統按鈕層
[hidesysbutton page="back"]
[current layer="message4" page="back"]
[layopt layer="message4" visible="true" page="back" left=0 top=0]
[er]

;描繪物品按鈕
[eval exp="draw_item()"]
;描繪翻頁按鈕
[item_page page="back"]

[trans method="crossfade" time=500]
[wt]

[s]


*刷新畫面
[current layer="message4"]
[er]

;描繪物品按鈕
[eval exp="draw_item()"]
;描繪翻頁按鈕
[item_page page="fore"]

[s]
;------------------------------------------------------------
*使用物品
[iscript]
//在控制台輸出物品名稱
dm("選擇使用物品："+f.item[f.選擇物品編號].name);
[endscript]

;可以在這裡寫一些判斷

;【例如】假如物品可以吃，那麼每次點擊減少一個物品
[if exp="f.item[f.選擇物品編號].eat==true"]
[subitem num=1 name=&"f.item[f.選擇物品編號].name"]
[endif]

;【例如】假如物品名稱是XXX，那麼……
[if exp="f.item[f.選擇物品編號].name=='羊毛'"]
;是羊毛的處理

[elsif exp="f.item[f.選擇物品編號].name=='黃金'"]
;是黃金的處理

[elsif exp="f.item[f.選擇物品編號].name=='秘銀'"]
;是秘銀的處理

[endif]

[jump target=*刷新畫面]


*返回
[jump storage="main_menu.ks" target=*返回]
