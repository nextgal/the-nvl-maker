;------------------------------------------------------------
;自制结局收集范例
;------------------------------------------------------------
*start
[tempsave place=2]
;------------------------------------------------------------
*window
[rclick enabled="false"]
[history enabled="false"]
[locklink]
;------------------------------------------------------------
;调用地图作为结局收集
[map_sys storage="endlist.map"]
;定义并允许右键返回
[rclick enabled="true" jump="true" storage="endlist.ks" target=*返回]
[s]
;------------------------------------------------------------
*结局跳转
[clmap_sys]

[rclick enabled="false" call="true" storage="rclick.ks" target=*隐藏对话框]

[eval exp="dm('【'+tf.结局+'开始回顾】')"]
[call storage=&"tf.结局+'.ks'"]
[eval exp="dm('【'+tf.结局+'回顾返回】')"]

;从结局回顾返回之后重置各种效果
[menu]

[backlay]
[tempload backlay="true" place="2"]
[trans method="crossfade" time=200]
[wt]

[jump storage="endlist.ks" target="*start"]
;------------------------------------------------------------
*返回
[locklink]
[rclick enabled="false"]
[backlay]
[tempload backlay="true" bgm="true" se="false" place="2"]
[trans method="crossfade" time=200]
[wt]
[return]
