;------------------------------------------------------------
;非常懒惰的CG显示
;------------------------------------------------------------
*start
[locksnapshot]
[tempsave]
;------------------------------------------------------------
*window
;载入配置文件
[iscript]
//假如是第一次登录CG
if (sf.cglist==void) sf.cglist=%[];

//载入CG界面配置表
f.config_cgmode=Scripts.evalStorage("uicgmode.tjs");

//载入cg列表
f.cglist=[].load("cglist.txt");

//计算页数
tf.CG页数=f.cglist.count\f.config_cgmode.locate.count;
if (f.cglist.count%f.config_cgmode.locate.count>0) tf.CG页数++;
tf.当前CG页=1;
[endscript]

[history enabled="false"]

[locklink]
[rclick enabled="true" jump="true" storage="cgmode.ks" target=*返回]

[backlay]
[image layer=14 page=back storage=&"f.config_cgmode.bgd" left=0 top=0 visible="true"]

[current layer="message4" page="back"]
[layopt layer="message4" visible="true" page="back" left=0 top=0]
[er]
;描绘各种ABC
[draw_cglist]
[trans method="crossfade" time=300]
[wt]

[s]
;------------------------------------------------------------
*刷新画面
[locklink]
[rclick enabled="true" jump="true" storage="cgmode.ks" target=*返回]
;避免按键太快，等待100毫秒
[wait time=100]
[current layer="message4"]
[er]
;描绘各种ABC
[draw_cglist]
[s]

*显示CG
[locklink]
[backlay]
[image layer=15 storage=&tf.当前CG left=0 top=0 page="back" visible="true"]
[trans method="crossfade" time=100]
[wt]
[waitclick]

*消除CG
[stoptrans]
[backlay]
[freeimage layer=15 page="back"]
[trans method="crossfade" time=100]
[wt]
[jump target=*刷新画面]
;------------------------------------------------------------
*返回
[jump storage="main_menu.ks" target=*返回]
