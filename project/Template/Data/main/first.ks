;------------------------------------------------------------
;游戏从这里开始启动，这是做各种系统设置的地方，请不要随意编辑
;------------------------------------------------------------
[stoptrans]
[clearvar]
[iscript]
//清理按键HOOK
kag.keyDownHook.clear();
kag.leftClickHook.clear();
kag.rightClickHook.clear();
[endscript]
;------------------------------------------------------------
;初始化
;------------------------------------------------------------
[iscript]
if (sf.nvlmaker_init==false)
{
	//option初始化
	kag.allskip=false;//SKIP时只允许略过已读部分
	kag.bgmvolume=50;//背景音乐音量

	kag.textspeed=5;//文字速度
	kag.autospeed=5;//自动前进速度
	
	//系统变数初始化
	sf.cglist=%[];
	sf.savelastlog=[];
	sf.RecentSavePage=1;

	sf.nvlmaker_init=true;
}
[endscript]

[iscript]
//如果要把音效音量根据BUF分开，可以使用下面的设置

if (sf.nvlmaker_sound_init==false)
{
	//初始化语音全局变数

	kag.sevolume=100; //设置总音效音量到最大

	//系统设置里使用到的中间值
	sf.sevolume=50;
	sf.voicevolume=50;
	sf.nvlmaker_sound_init=true;
}

//启动游戏时，使音量值与记录的值相同
kag.se[0].volume=sf.sevolume;
kag.se[1].volume=sf.voicevolume;

[endscript]
;------------------------------------------------------------
;载入宏
;------------------------------------------------------------
[call storage="macro.ks"]
;------------------------------------------------------------
;右键菜单及系统按钮层的处理
;------------------------------------------------------------
[rclick enabled="false" call="true" storage="rclick.ks" target=*hidemes]
;要右键菜单就是改成下面这行：
;[rclick enabled="false" call="true" storage="main_menu.ks"]
[history enabled="false" output="false"]
;预先定义系统按钮
[defsysbutton]
;------------------------------------------------------------
;字体设定
;如果显示的不是想要的字体，可以尝试在这里设定预渲染文字
;------------------------------------------------------------
;message清空
[frame layer="message4" visible=false]
[current layer=message0 page=fore]
[resetfont]
;------------------------------------------------------------
;补充系统设定
;------------------------------------------------------------
;[p]过后自动消去文字
[erafterpage mode="true"]
;------------------------------------------------------------
;跳跃到测试处理画面
;------------------------------------------------------------
[bg storage="black" time="0"]
[startanchor]
[jump storage="start.ks"]
