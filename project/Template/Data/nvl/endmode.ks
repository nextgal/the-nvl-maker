[iscript]
//载入结局列表
f.endlist=[].load("endlist.txt");

//根据结局数，计算需要的翻页数
tf.END页数=f.endlist.count\f.config_endmode.locate.count;
if (f.endlist.count%f.config_endmode.locate.count>0) tf.END页数++;
tf.当前END页=1;
[endscript]

[history enabled="false"]

[locklink]
[rclick enabled="true" jump="true" storage="endmode.ks" target=*返回]

[backlay]

[image layer=14 page=back storage=&f.config_endmode.bgd left=0 top=0 visible="true"]

[current layer="message4" page="back"]
[layopt layer="message4" visible="true" page="back" left=0 top=0]
[er]
;描绘各种ABC
[draw_endlist]
[trans method="crossfade" time=300]
[wt]

[s]

;------------------------------------------------------------
*刷新画面
[image layer=14 page=fore storage=&f.config_endmode.bgd left=0 top=0 visible="true"]

[locklink]
[rclick enabled="true" jump="true" storage="endmode.ks" target=*返回]
;避免按键太快，等待100毫秒
[wait time=100]
[current layer="message4"]
[er]
;描绘各种ABC
[draw_endlist]
[s]


*结局跳转
[locklink]
[rclick enabled="false"]
[fadeoutbgm time="1000"]

[backlay]
[tempload backlay="true" bgm="false" se="false"]
[trans method="crossfade" time=200]
[wt]

[history enabled="true" output="true"]
[eval exp="dm('【'+tf.结局+'开始回顾】')"]
[call storage=&"tf.结局+'.ks'"]
[eval exp="dm('【'+tf.结局+'结束回顾】')"]
[history enabled="false" output="false"]

;背景音乐
@fadeinbgm time="1000" storage=&"f.config_title.bgm"
[jump target="*start"]

;------------------------------------------------------------
*返回
[locklink]
[rclick enabled="false"]
[backlay]
[tempload backlay="true" bgm="false" se="false"]
[trans method="crossfade" time=200]
[wt]

[return]
