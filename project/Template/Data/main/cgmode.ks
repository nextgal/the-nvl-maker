;------------------------------------------------------------
;非常懒惰的CG显示
;------------------------------------------------------------
*start
[tempsave]
;------------------------------------------------------------
*window

[iscript]
//假如是第一次登录CG，建立空白的CG登陆记录
if (sf.cglist==void) sf.cglist=%[];

//设定CG列表文件
f.cginfo="cglist.txt";

//根据CG列表文件，载入作为缩略图的CG图片文件名称列表
f.cglist=getThumList();

//根据f.cglist的CG图片数，计算需要的翻页数
tf.CGPage=f.cglist.count\f.config_cgmode.locate.count;
if (f.cglist.count%f.config_cgmode.locate.count>0) tf.CGPage++;
tf.CurrentCGPage=1;

[endscript]

[history enabled="false"]

[locklink]
[rclick enabled="true" jump="true" storage="cgmode.ks" target=*return]

[backlay]
;显示背景
[uiback dicname="f.config_cgmode.bgd"]

[current layer="message4" page="back"]
[layopt layer="message4" visible="true" page="back" left=0 top=0]
[er]
;描绘各种ABC
[draw_cglist]
[trans method="crossfade" time=300]
[wt]

[s]
;------------------------------------------------------------
*update
[locklink]
[rclick enabled="true" jump="true" storage="cgmode.ks" target=*return]
;避免按键太快，等待100毫秒
[wait time=100]
[current layer="message4"]
[er]
;描绘各种ABC
[draw_cglist]
[s]

*showcg
[locklink]
[rclick enabled="true" jump="true" storage="cgmode.ks" target=*freecg]
;取得CG文件名
[iscript]
tf.CGFile=tf.CGDiff[tf.CGNum];
[endscript]

;显示CG
[backlay]
[image layer=16 storage=&tf.CGFile left=0 top=0 page="back" visible="true"]
[trans method="crossfade" time=100]
[wt]
[waitclick]

;假如还有CG差分，取得下一个差分的编号
[if exp="tf.CGNum<tf.CGDiff.count-1"]
[eval exp="tf.CGNum++"]
[jump target="*showcg"]
[endif]

*freecg
[rclick enabled="true" jump="true" storage="cgmode.ks" target=*return]
[stoptrans]
[backlay]
[freeimage layer=16 page="back"]
[trans method="crossfade" time=100]
[wt]
[jump target=*update]
;------------------------------------------------------------
*return
[locklink]
[rclick enabled="false"]
[backlay]
[tempload backlay="true" bgm="false" se="false"]
[trans method="crossfade" time=200]
[wt]

[return]
