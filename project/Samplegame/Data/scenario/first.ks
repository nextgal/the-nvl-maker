;------------------------------------------------------------
;請不要隨意編輯
;------------------------------------------------------------
[startanchor]
[stoptrans]
[clearvar]
;------------------------------------------------------------
;初始化
;------------------------------------------------------------
[if exp="sf.初始化==false"]
[eval exp="kag.allskip=false"]
[eval exp="kag.bgmvolume=70"]
[eval exp="kag.sevolume=100"]
[eval exp="kag.textspeed=5"]
[eval exp="kag.autospeed=5"]
[eval exp="sf.歷史=[]"]
[eval exp="sf.最近存儲頁=1"]
[eval exp="sf.初始化=true"]
[endif]
;------------------------------------------------------------
;載入宏
;------------------------------------------------------------
[call storage="macro.ks"]
;------------------------------------------------------------
;右鍵菜單及系統按鈕層的處理
;------------------------------------------------------------
[rclick enabled="false" call="true" storage="rclick.ks" target=*隱藏對話框]
[history enabled="false" output="false"]
[system_menu]
;------------------------------------------------------------
;字體設定
;------------------------------------------------------------
;載入配置文件
[eval exp="f.setting=Scripts.evalStorage('setting.tjs')"]

;簡繁字體選擇（繁型字體沒有的情況，強制簡型）
[eval exp="sf.font=f.setting.font.gb" cond="f.setting.font.big5==void"]
;簡繁字體選擇（存在2種字體，要求玩家選擇）
[call storage="selectfont.ks" cond="sf.font==void"]

;強制字體設定
[current layer=message0 page=fore]
[deffont face=&"sf.font"]
[deffont size=&"f.setting.font.size"]
[deffont bold=&"f.setting.font.bold"]
[deffont color=&"f.setting.font.color"]
[deffont edge=&"f.setting.font.edge"]
[deffont edgecolor=&"f.setting.font.edgecolor"]
[deffont shadow=&"f.setting.font.shadow"]
[deffont shadowcolor=&"f.setting.font.shadowcolor"]
[resetfont]
;------------------------------------------------------------
;跳躍到測試處理畫面
;------------------------------------------------------------

[jump storage="start.ks"]
