*start

;------------------------------------------------------------
;選擇字體
;------------------------------------------------------------
[menu]
[style align="center"]
[nowait]
[eval exp="sf.font=f.setting.font.gb"]
[deffont face="&sf.font"][resetfont][font color=0xFFFFFF]
[locate y=200]
請選擇習慣使用的文字樣式：[r][r]
[link exp="sf.font=f.setting.font.gb" target=*刷新畫面]簡體中文[endlink]       
[link exp="sf.font=f.setting.font.big5" target=*刷新畫面]繁體中文[endlink][r]
[r]
[link target=*return]開始遊戲[endlink]
[r]
[endnowait]
[style align="left"]
[s]

*刷新畫面
[current layer="message0" page="fore"]
[er]
[deffont face="&sf.font"][resetfont][font color=0xFFFFFF]
[style align="center"]
[r]
[nowait]
[locate y=200]
假如設定完畢，就請點下「開始遊戲」吧：[r][r]
[link exp="sf.font=f.setting.font.gb" target=*刷新畫面]簡體中文[endlink]       
[link exp="sf.font=f.setting.font.big5" target=*刷新畫面]繁體中文[endlink][r]
[r]
[link target=*return]開始遊戲[endlink]
[r]
[endnowait]
[style align="left"]
[s]

*return
[menu]
[return]
