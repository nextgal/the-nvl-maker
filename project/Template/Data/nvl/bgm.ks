;------------------------------------------------------------
;非常懒惰的BGM鉴赏系统
;------------------------------------------------------------
*start
[tempsave]
;------------------------------------------------------------
*window
[iscript]
//载入bgm列表
f.bgmlist=[].load("bgmlist.txt");

//这是每页播放12首，分为左右两栏的排版
//具体按钮位置在macro_bgm.ks里可以修改

tf.BGM页数=f.bgmlist.count\12;
if (f.bgmlist.count%12>0) tf.BGM页数++;

tf.当前BGM页=1;
[endscript]
[history enabled="false"]

[locklink]
[rclick enabled="true" jump="true" storage="bgm.ks" target=*返回]

[backlay]
;这里修改背景图片
[image layer=14 page=back storage="Sample_PANEL" left=0 top=0 visible="true"]

[current layer="message4" page="back"]
[layopt layer="message4" visible="true" page="back" left=0 top=0]
[er]
;描绘各种ABC
[draw_bgmlist]
[trans method="crossfade" time=300]
[wt]

[s]
*播放音乐
[playbgm storage=&"tf.当前BGM"]
;------------------------------------------------------------
*刷新画面
[rclick enabled="true" jump="true" storage="bgm.ks" target=*返回]
[current layer="message4"]
[er]
;描绘各种ABC
[draw_bgmlist]
[s]

;------------------------------------------------------------
*返回
[locklink]
[rclick enabled="false"]
[backlay]
[tempload backlay="true" bgm="true" se="false"]
[trans method="crossfade" time=200]
[wt]

[return]
