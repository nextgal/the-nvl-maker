;------------------------------------------------------------
;預留菜單，對話界面上的「自定選單」會連接到這裡
;你可以用這個格式製作自製選單（例如道具系統）
;------------------------------------------------------------
*start
[iscript]
//默認不選中任何筆記
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
;調用養成面板作為界面（範例：查看主角信息）
;這裡是直接從對話框調用的
;因為養成面板的默認圖層順序比主菜單低，如果從主菜單上調用，請將layer設為14
;------------------------------------------------------------
[edu storage="herodata.edu" layer=14]
[rclick enabled="true" jump="true" storage="other.ks" target=*return]
[s]

;------------------------------------------------------------
;從自定選單連接到筆記收集
;養成面板可以配合自定義代碼使用
;------------------------------------------------------------
*note
[backlay]
;養成面板的內容
[loadedu storage="notebook.edu" layer=14]
;自定義代碼（顯示筆記按鈕列表）
[draw_note]
[trans method=crossfade time=300]
[wt]
[rclick enabled="true" jump="true" storage="other.ks" target=*return]
[s]

;------------------------------------------------------------
;從自定選單連接到道具收集
;------------------------------------------------------------
*item
[sysmap storage="item.map" layer=14]
[rclick enabled="true" jump="true" storage="other.ks" target=*return]
[s]

;------------------------------------------------------------
*return
[jump storage="main_menu.ks" target=*return]