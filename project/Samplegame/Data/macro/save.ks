;------------------------------------------------------------
;非常懒惰的save显示
;------------------------------------------------------------
*start
[locksnapshot]
[tempsave]
;------------------------------------------------------------
*window
;载入配置文件
[iscript]
f.config_sl=Scripts.evalStorage("uisave.tjs");
[endscript]
[history enabled="false"]

*firstpage
[locklink]
[rclick enabled="true" jump="true" storage="save.ks" target=*返回]
[backlay]
[image layer=14 page=back storage=&"f.config_sl.bgd" left=0 top=0 visible="true"]

;隐藏系统按钮层
[hidesysbutton page="back"]
;用message4描绘
[current layer="message4" page="back"]
[layopt layer="message4" visible="true" page="back" left=0 top=0]
[er]

[eval exp="drawslbutton('back')"]

[trans method="crossfade" time=500]
[wt]

[s]
;------------------------------------------------------------
*刷新画面
[current layer="message4"]
[er]
[eval exp="drawslbutton()"]
[s]

;------------------------------------------------------------
*存取游戏
[eval exp="tf.返回值=kag.saveBookMarkWithAsk(tf.最近档案)"]
;如果进行了记录
[if exp="tf.返回值==true"]
[eval exp="sf.最近档案=tf.最近档案"]
[eval exp="sf.历史[sf.最近档案]=&kag.historyLayer.data[kag.historyLayer.dataPos-1]"]
[eval exp="kag.saveSystemVariables()"]

;假如存档了，刷新缩略图
[iscript]
if (checkdata(sf.最近档案))
{
kag.fore.layers[17].loadImages(%[
      'storage'=>storagedata(sf.最近档案),
      'visible'=>f.config_slpos.snapshot.visible,
      'left'=>f.config_slpos.snapshot.x,
      'top'=>f.config_slpos.snapshot.y
     ]);
}
[endscript]
[endif]
[jump target=*刷新画面]
;------------------------------------------------------------
*返回
[jump storage="main_menu.ks" target=*返回]
