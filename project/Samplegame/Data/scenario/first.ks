;------------------------------------------------------------
;请不要随意编辑
;------------------------------------------------------------
[startanchor]
[stoptrans]
[clearvar]
;------------------------------------------------------------
;初始化
;------------------------------------------------------------
[if exp="sf.初始化==false"]
[eval exp="kag.allskip=false"]
[eval exp="kag.bgmvolume=70"]
[eval exp="kag.sevolume=100"]
[eval exp="kag.textspeed=5"]
[eval exp="kag.autospeed=5"]
[eval exp="sf.历史=[]"]
[eval exp="sf.最近存储页=1"]
[eval exp="sf.初始化=true"]
[endif]
;------------------------------------------------------------
;载入宏
;------------------------------------------------------------
[call storage="macro.ks"]
;------------------------------------------------------------
;右键菜单及系统按钮层的处理
;------------------------------------------------------------
[rclick enabled="false" call="true" storage="rclick.ks" target=*隐藏对话框]
[history enabled="false" output="false"]
[system_menu]
;------------------------------------------------------------
;字体设定
;------------------------------------------------------------
;载入配置文件
[eval exp="f.setting=Scripts.evalStorage('setting.tjs')"]

;简繁字体选择（繁型字体没有的情况，强制简型）
[eval exp="sf.font=f.setting.font.gb" cond="f.setting.font.big5==void"]
;简繁字体选择（存在2种字体，要求玩家选择）
[call storage="selectfont.ks" cond="sf.font==void"]

;强制字体设定
[current layer=message0 page=fore]
[deffont face=&"sf.font"]
[deffont size=&"f.setting.font.size"]
[deffont bold=&"f.setting.font.bold"]
[deffont color=&"f.setting.font.color"]
[deffont edge=&"f.setting.font.edge"]
[deffont edgecolor=&"f.setting.font.edgecolor"]
[deffont shadow=&"f.setting.font.shadow"]
[deffont shadowcolor=&"f.setting.font.shadowcolor"]
[resetfont]
;------------------------------------------------------------
;跳跃到测试处理画面
;------------------------------------------------------------

[jump storage="start.ks"]
