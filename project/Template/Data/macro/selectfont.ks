*start

;------------------------------------------------------------
;选择字体
;------------------------------------------------------------
[menu]
[style align="center"]
[nowait]
[eval exp="sf.font=f.setting.font.gb"]
[deffont face="&sf.font"][resetfont][font color=0xFFFFFF]
[locate y=200]
请选择习惯使用的文字样式：[r][r]
[link exp="sf.font=f.setting.font.gb" target=*刷新画面]简体中文[endlink]       
[link exp="sf.font=f.setting.font.big5" target=*刷新画面]繁体中文[endlink][r]
[r]
[link target=*return]开始游戏[endlink]
[r]
[endnowait]
[style align="left"]
[s]

*刷新画面
[current layer="message0" page="fore"]
[er]
[deffont face="&sf.font"][resetfont][font color=0xFFFFFF]
[style align="center"]
[r]
[nowait]
[locate y=200]
假如设定完毕，就请点下“开始游戏”吧：[r][r]
[link exp="sf.font=f.setting.font.gb" target=*刷新画面]简体中文[endlink]       
[link exp="sf.font=f.setting.font.big5" target=*刷新画面]繁体中文[endlink][r]
[r]
[link target=*return]开始游戏[endlink]
[r]
[endnowait]
[style align="left"]
[s]

*return
[menu]
[return]
