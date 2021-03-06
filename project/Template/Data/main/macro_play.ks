;-------------------------------------------------------------------------------------------
;封装的宏,对应于指令编辑器，可以根据自己的需求修改
;-------------------------------------------------------------------------------------------
*start
;------------------------------------------------------------------
;★显示背景
;------------------------------------------------------------------
[macro name=bg]
[backlay]
;一般效果
[image * layer=stage storage=%storage|black page=back visible="true" left=0 top=0 grayscale=%grayscale|false mcolor=%mcolor mopacity=%mopacity]
;反色效果
[if exp="mp.convert==true"]
[image * layer=stage storage=%storage|black page=back visible="true" left=0 top=0 grayscale=%grayscale|false mcolor=%mcolor mopacity=%mopacity rceil=0 gceil=0 bceil=0 rfloor=255 bfloor=255 gfloor=255]
[endif]

;消除立绘
[if exp="mp.clfg==true"]
[freeimage layer=0 page="back"]
[freeimage layer=1 page="back"]
[freeimage layer=2 page="back"]
[freeimage layer=3 page="back"]
[freeimage layer=4 page="back"]
[freeimage layer=5 page="back"]
[freeimage layer=6 page="back"]
[freeimage layer=7 page="back"]
;[freeimage layer=event page="back"]
;隐藏头像
[clface page="back"]
[endif]

;消除对话框
[if exp="mp.hidemes==true"]
[current layer="message0" page="back"]
[er]
[current layer="message1" page="back"]
[er]
[current layer="message2" page="back"]
[er]
[layopt layer="message0" visible="false" page="back"]
[layopt layer="message1" visible="false" page="back"]
;隐藏名字栏
[clname page="back"]
[hidesysbutton]
[endif]

;显示人物
[if exp="mp.l!=void"]
[image layer="1" page="back" pos="left" storage=%l visible="true"]
[endif]
[if exp="mp.c!=void"]
[image layer="0" page="back" pos="center" storage=%c visible="true"]
[endif]
[if exp="mp.r!=void"]
[image layer="2" page="back" pos="right" storage=%r visible="true"]
[endif]

[trans method=%method|crossfade time=%time|700 rule=%rule stay=%stay from=%from]
[wt canskip=%canskip|true]
[endmacro]
;------------------------------------------------------------------
;★消除背景
;------------------------------------------------------------------
[macro name=clbg]
[backlay]
[freeimage layer=stage page="back"]
;连同全部前景
[if exp="mp.clfg==true"]
[freeimage layer=0 page="back"]
[freeimage layer=1 page="back"]
[freeimage layer=2 page="back"]
[freeimage layer=3 page="back"]
[freeimage layer=4 page="back"]
[freeimage layer=5 page="back"]
[freeimage layer=6 page="back"]
[freeimage layer=7 page="back"]
;[freeimage layer=event page="back"]
;隐藏头像
[clface page="back"]
[endif]

;连同对话框
[if exp="mp.hidemes==true"]
[current layer="message0" page="back"]
[er]
[current layer="message1" page="back"]
[er]
[current layer="message2" page="back"]
[er]
[layopt layer="message0" visible="false" page="back"]
[layopt layer="message1" visible="false" page="back"]
;隐藏名字栏
[clname page="back"]
[hidesysbutton]
[endif]

[trans method=%method|crossfade time=%time|700 rule=%rule stay=%stay from=%from]
[wt canskip=%canskip|true]
[endmacro]
;------------------------------------------------------------------
;★显示人物
;------------------------------------------------------------------
[macro name=fg]
[backlay]
;第一次显示,指定角色位置
[if exp="mp.pos!=''"]
[image * storage=%storage|empty layer=%layer|0 page="back" pos=%pos visible="true"]
[else]
;不指定时,自动调整,使立绘显示在原位置/指定位置
[eval exp="mp.layer='0'" cond="mp.layer==''"]
[eval exp="mp.left=kag.fore.layers[mp.layer].left" cond="mp.left==void"]
[eval exp="mp.top=kag.fore.layers[mp.layer].top" cond="mp.top==void"]
[image * storage=%storage layer=%layer page="back" left=%left top=%top visible="true"]
[endif]
[trans method=%method|crossfade time=%time|500 rule=%rule stay=%stay from=%from]
[wt canskip=%canskip|true]
[endmacro]
;------------------------------------------------------------------
;★消除人物
;------------------------------------------------------------------
[macro name=clfg]
[backlay]
;消除全部
[if exp="mp.layer=='all'"]
[freeimage layer=0 page="back"]
[freeimage layer=1 page="back"]
[freeimage layer=2 page="back"]
[freeimage layer=3 page="back"]
[freeimage layer=4 page="back"]
[freeimage layer=5 page="back"]
[freeimage layer=6 page="back"]
[freeimage layer=7 page="back"]
;[freeimage layer=event page="back"]
;隐藏头像
[clface page="back"]
[endif]
;消除单层
[if exp="mp.layer!='all'"]
[freeimage layer=%layer|0 page="back"]
[endif]
;消除头像
[if exp="mp.clface==true"]
;隐藏头像
[clface page="back"]
[endif]
;连同对话框
[if exp="mp.hidemes==true"]
[current layer="message0" page="back"]
[er]
[current layer="message1" page="back"]
[er]
[current layer="message2" page="back"]
[er]
[layopt layer="message0" visible="false" page="back"]
[layopt layer="message1" visible="false" page="back"]
;隐藏名字栏
[clname page="back"]
[hidesysbutton]
[endif]
[trans method=%method|crossfade time=%time|500 rule=%rule stay=%stay from=%from]
[wt canskip=%canskip|true]
[endmacro]
;------------------------------------------------------------------
;★显示头像
;------------------------------------------------------------------
[macro name=face]
[backlay]
[image * layer=8 visible="true" page="back" storage=%storage|empty]
[layopt layer=8 page="back" left=&"(int)f.config_dia.face.left-kag.back.layers[8].width\2" top=&"(int)f.config_dia.face.top-kag.back.layers[8].height"]
;附加显示立绘
[if exp="mp.fg!=void"]
;在原位置显示图片
[eval exp="mp.layer='0'" cond="mp.layer==''"]
[eval exp="mp.left=kag.fore.layers[mp.layer].left"]
[eval exp="mp.top=kag.fore.layers[mp.layer].top"]
[image layer=%layer page="back" storage=%fg left=%left top=%top visible="true"]
[endif]
[trans method=%method|crossfade time=%time|100 rule=%rule]
[wt]
[endmacro]
;------------------------------------------------------------
;★播放音乐
;------------------------------------------------------------
[macro name=bgm]
[xchgbgm * storage=%storage overlap=%overlap|500 time=%time|1000]
[endmacro]
;------------------------------------------------------------
;★播放音效
;------------------------------------------------------------
[macro name=se]
[if exp="mp.time==void"]
[playse storage=%storage loop=%loop|false buf=%buf|0]
[else]
[fadeinse storage=%storage loop=%loop|false buf=%buf|0 time=%time|0]
[endif]
[endmacro]
;------------------------------------------------------------
;★播放语音
;------------------------------------------------------------
;播放语音（并进行历史记录回放处理）
[macro name=vo]
	[eval exp="f.voing=true"]
	[playse storage=%storage buf="1" loop="false"]
	[hact exp=&("playse("+"\""+mp.storage+"\""+")")]
[endmacro]
;语音结束（等待播放完毕，历史记录处理结束）
[macro name=endvo]
	;假如有语音正在播放才执行以下指令
	[if exp="f.voing==true"]
		[eval exp="f.voing=false"]
		[endhact]
		;仅在auto模式下进行语音等待
		[ws buf="1" canskip="true" cond="kag.autoMode==true"]
	[endif]
[endmacro]
;-------------------------------------------------------------------------------------------
;★播放视频
;-------------------------------------------------------------------------------------------
[macro name=mv]
[video visible="true" mode="mixer" width=&"kag.scWidth" height=&"kag.scHeight"]
[playvideo storage=%storage]
[wv canskip=%canskip|true]
[endmacro]
;-------------------------------------------------------------------------------------------
;★移动
;-------------------------------------------------------------------------------------------
[macro name=movepos]
[eval exp="tf.layer=0"]
[eval exp="tf.layer=mp.layer" cond="mp.layer!=''"]
[eval exp="tf.left=kag.fore.layers[tf.layer].left"]
[eval exp="tf.top=kag.fore.layers[tf.layer].top"]
[eval exp="tf.oop=kag.fore.layers[tf.layer].opacity"]
[eval exp="tf.x=0"]
[eval exp="tf.y=0"]
[eval exp="tf.opacity=kag.fore.layers[tf.layer].opacity"]
[eval exp="tf.x=mp.x" cond="mp.x!=''"]
[eval exp="tf.y=mp.y" cond="mp.y!=''"]
[eval exp="tf.opacity=mp.opacity" cond="mp.opacity!=''"]
[eval exp="tf.x2=tf.left*1+mp.x*1"]
[eval exp="tf.y2=tf.top*1+mp.y*1"]
[eval exp="tf.path='('+&tf.x2+','+&tf.y2+','+&tf.opacity+')'"]
[move layer=%layer|0 path="&tf.path" time=%time|100 accel=%accel]
[wm canskip=%canskip]
[endmacro]
;-------------------------------------------------------------------------------------------
;★背景摇晃
;-------------------------------------------------------------------------------------------
[macro name=shake]
[action layer=stage module=LayerWaveActionModule vibration=10 cycle=100 time=400 cond="mp.dir=='wave'"]
[action layer=stage module=LayerJumpActionModule vibration=10 cycle=100 time=400 cond="mp.dir=='jump'"]
[wact canskip=%canskip]
[endmacro]
;-------------------------------------------------------------------------------------------
;★小CG
;-------------------------------------------------------------------------------------------
[macro name=mcg]
[backlay]
[image layer=%layer|6 page="back" storage=%storage visible="true" left=&(1280-128)/2 top=&(720-128)/2]
[trans method="crossfade" time=100]
[wt]
[endmacro]

[macro name=clmcg]
[backlay]
[freeimage layer=%layer|6 page="back"]
[trans method="crossfade" time=100]
[wt]
[endmacro]
;-------------------------------------------------------------------------------------------

[return]
