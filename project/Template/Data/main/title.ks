;------------------------------------------------------------
;对应默认标题画面的脚本，界面编辑的修改都会在这里体现出来
;总之不知道是做什么用的话请不要编辑这里，编辑默认标题界面就够了
;------------------------------------------------------------
*start
[iscript]
if (f.setting.newgameplus==true && sf.nvlmaker_clearance==true)	//二周目的情况
{
	f.config_title=Scripts.evalStorage(f.setting.title_omake);
}
else	//一周目的情况
{
	f.config_title=loadUIFile("uititle");
}

[endscript]

@bg time="500" storage="nvl_logo"
@wait time="500" canskip="true"

;------------------------------------------------------------
;游戏组LOGO、背景音乐等处理
;------------------------------------------------------------
*logo

;可在标题画面“小组标志”一栏处修改这里的游戏组LOGO图
@bg time="500" storage=&"f.config_title.logo"
;背景音乐
@fadeinbgm time="1000" storage=&"f.config_title.bgm" cond="f.config_title.bgm!=void"
;粒子效果
@raininit cond="f.config_title.rain==true"
@snowinit cond="f.config_title.snow==true"
@sakurainit cond="f.config_title.sakura==true"
@momijiinit cond="f.config_title.momiji==true"
@oldmovieinit cond="f.config_title.movie==true"
@fireflyinit cond="f.config_title.firefly==true"
;等待
@wait canskip="1" time="500"
;切黑屏
@bg time="1000" storage="black"
;------------------------------------------------------------
;显示标题画面和按钮（带有渐变切换效果）
;------------------------------------------------------------
*title
;停止其他一切切换效果
@stoptrans

@backlay
;显示背景
[uiback dicname="f.config_title.bgd" layer=0]
;前景图片
@image left="0" visible="true" page="back" layer=8 top="0" storage=&"f.config_title.front" cond="f.config_title.front!=void"
;消息层归位
@frame page="back"
@current layer="message0" page="back"
;显示标题按钮
@button_title
;可在这里修改切换效果
@trans time="500" method="crossfade"
@wt
@s
;------------------------------------------------------------
;标题画面（从其他界面返回时，不带有渐变切换效果）
;------------------------------------------------------------
*update
@current layer="message0" page="fore"
@er
@button_title
@s
;------------------------------------------------------------
*newgame
@fadeoutbgm time="1000"
;清除粒子效果
@rainuninit
@snowuninit
@sakurauninit
@momijiuninit
@oldmovieuninit
@fireflyuninit
;清除标题画面
@backlay
@freeimage layer=0 page="back"
@freeimage layer=8 page="back"
@current layer="message0" page="back"
@er
@trans time="200" method="crossfade"
@wt
@current layer="message0" page="fore"
;鉴于很多人自己不知道打开历史记录，所以加上默认这条，不爽的自己关掉吧
@history output="true"
@hr
@jump storage="prologue.ks"
;------------------------------------------------------------
*load
@call storage="load.ks"
@jump target="*update" storage="title.ks"
;------------------------------------------------------------
*cgmode
@call storage="cgmode.ks"
@jump target="*update" storage="title.ks"
;------------------------------------------------------------
*extra
;可以在这里呼叫自制选单，例如音乐鉴赏、剧情回放等
@call storage="title_other.ks"
;改成下面这行，直接调用音乐鉴赏
;@call storage="bgmmode.ks"
;改成下面这行，直接调用结局鉴赏
;@call storage="endmode.ks"
@jump target="*update" storage="title.ks"
;------------------------------------------------------------
*option
@call storage="option.ks"
@jump target="*update" storage="title.ks"
;------------------------------------------------------------
*exit
@fadeoutbgm time="1500"
@backlay
@freeimage layer="stage" page="back"
@freeimage layer=8 page="back"
@current layer="message0" page="back"
@er
;可在这里修改切换效果
@trans time="1500" rule="00" method="universal"
@wt
@close ask="false"
;------------------------------------------------------------

