;------------------------------------------------------------
;非常懒惰的BGM鉴赏系统
;------------------------------------------------------------
*start
[tempsave]
[iscript]
//载入bgm列表
f.bgmlist=[].load("bgmlist.txt");

//计算页数
tf.BGMPage=f.bgmlist.count\f.config_bgmmode.list.num;
if (f.bgmlist.count%f.config_bgmmode.list.num>0) tf.BGMPage++;
tf.CurrentBGMPage=1;
[endscript]
;------------------------------------------------------------
*window
[history enabled="false"]

[locklink]
[rclick enabled="true" jump="true" storage="bgmmode.ks" target=*return]

[backlay]
;显示背景
[uiback dicname="f.config_bgmmode.bgd"]

[current layer="message4" page="back"]
[layopt layer="message4" visible="true" page="back" left=0 top=0]
[er]
;描绘各种ABC
[draw_bgmlist]
[trans method="crossfade" time=300]
[wt]

[s]
*play
[playbgm storage=&"tf.CurrentBGM"]
;------------------------------------------------------------
*update
[rclick enabled="true" jump="true" storage="bgmmode.ks" target=*return]
[current layer="message4"]
[er]
;描绘各种ABC
[draw_bgmlist]
[s]

;------------------------------------------------------------
*return
;假如当前播放的不是标题背景音乐，恢复标题背景音乐
[if exp="f.config_title.bgm!=void"]
[bgm storage=&"f.config_title.bgm" cond="kag.bgm.playingStorage!=f.config_title.bgm"]
[endif]
[locklink]
[rclick enabled="false"]
[backlay]
[tempload backlay="true" bgm="false" se="false"]
[trans method="crossfade" time=200]
[wt]

[return]
