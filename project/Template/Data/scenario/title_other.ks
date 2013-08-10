;------------------------------------------------------------
;自制特别模式范例
;------------------------------------------------------------
*start
[tempsave place="1"]
;------------------------------------------------------------
*window
[history enabled="false"]
[locklink]
;------------------------------------------------------------
;调用地图作为特别模式的选单，地图上包含【CG模式、结局收集、音乐鉴赏、返回四个据点】
[map_sys storage="omake.map"]
;定义并允许右键返回
[rclick enabled="true" jump="true" storage="title_other.ks" target=*返回]
[s]
;------------------------------------------------------------
;CG模式
*cgmode
[clmap_sys]
[call storage="cgmode.ks"]
[jump storage="title_other.ks" target="*window"]
;------------------------------------------------------------
;结局收集
*endlist
[clmap_sys]
[call storage="endlist.ks"]
[jump storage="title_other.ks" target="*window"]
;------------------------------------------------------------
;音乐鉴赏
*bgmlist
[clmap_sys]
[call storage="bgm.ks"]
[jump storage="title_other.ks" target="*window"]
;------------------------------------------------------------
*返回
[clmap_sys]
[backlay]
[tempload backlay="true" place="1"]
[trans method="crossfade" time=200]
[wt]
[return]
