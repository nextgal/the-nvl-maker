;------------------------------------------------------------
;   KAGeXpress ver 3.0 封裝宏集
;   Author: Miliardo/2006.11.5
;   Author: 長山真夜/Ver 2.0
;
;   http://kcddp.keyfc.net/
;   (C) 2002-2006，Key Fans Club
;
;------------------------------------------------------------

@jump target=*init
;------------------------------------------------------------
;    初始設定
;------------------------------------------------------------

*init

@loadplugin module=wuvorbis.dll
@loadplugin module=wump3.dll
@loadplugin module=wutcwf.dll
@loadplugin module=extrans.dll
@loadplugin module=extNagano.dll

@if exp="global.useconfigMappfont==true"
@mappfont storage=&global.configMappfont
@endif

@macro name=vend
@if exp="tf.KAGeXpress_voice=1"
@eval exp="tf.KAGeXpress_voice=0"
@endhact
@endif
@endmacro

@macro name=p
@vend
@oporig
@endmacro

@call storage=staffroll.ks
@call storage=ExHistoryLayer.ks
@call storage=HistoryLayerCustom.ks

;------------------------------------------------------------
;    內容調整
;------------------------------------------------------------
@autolabelmode mode=true
@erafterpage mode=true
@history type=scroll
;------------------------------------------------------------
;    Macro區域（可根據情況自行調整）
;------------------------------------------------------------
;文字點擊換行
@macro name=lr
@l
@r
@endmacro
;------------------------------------------------------------
;    Macro區域
;------------------------------------------------------------
@jump storage=first.ks

