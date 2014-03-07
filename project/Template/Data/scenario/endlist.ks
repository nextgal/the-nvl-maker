;------------------------------------------------------------
;自制结局收集范例，没事就别改这个了
;可以用地图编辑器修改地图文件endlist.map来修改界面和追加内容
;------------------------------------------------------------
*start
;place=2是因为这里可能会进入剧本，剧本内又有一堆tempsave
[tempsave place=2]
;------------------------------------------------------------
*window
[rclick enabled="false"]
[history enabled="false"]
[locklink]
;------------------------------------------------------------
;调用地图作为结局收集
[sysmap storage="endlist.map"]
;定义并允许右键返回
[rclick enabled="true" jump="true" storage="endlist.ks" target=*返回]
[s]
;------------------------------------------------------------
*结局跳转

;消除标题画面背景等
[backlay]
[image layer=stage page="back" storage="black"]
[freeimage layer=8 page="back"]
[trans method="crossfade" time=100]
[wt]

;然后把结局收集界面给清理了，加上了clbg所以会连地图的背景层一起处理掉
[clsysmap clbg=true]
;设定一下右键功能
[rclick enabled="false" call="true" storage="rclick.ks" target=*隐藏对话框]
;清理一下对话框
[current layer="message0"]
[er]

;开始调用结局
[eval exp="dm('【'+tf.结局+'开始回顾】')"]
[call storage=&"tf.结局+'.ks'"]
[eval exp="dm('【'+tf.结局+'回顾返回】')"]

;从结局回顾返回之后重置各种效果
[backlay]
[tempload backlay="true" place="2"]
[frame layer=message0 page=back]
[trans method="crossfade" time=200]
[wt]

[jump storage="endlist.ks" target="*start"]
;------------------------------------------------------------
*返回
[locklink]
[rclick enabled="false"]

[backlay]
[tempload backlay="true" bgm="true" se="false" place="2"]
[frame layer=message0 page=back]
[trans method="crossfade" time=200]
[wt]
[return]
