;-------------------------------------------------------------------------------------------
;结局设定相关宏
;-------------------------------------------------------------------------------------------
;-------------------------------------------------------------------------------------------
;登录END
;-------------------------------------------------------------------------------------------
[iscript]
function AddToEndList(name)
{
	//假如是第一次登录
	if (sf.endlist==void) sf.endlist=%[];
	sf.endlist[name]=true;
	dm("登录END："+name);
}
[endscript]

[macro name=addend]
[eval exp="AddToEndList(mp.storage)"]
[endmacro]

;-------------------------------------------------------------------------------------------
;END按钮
;-------------------------------------------------------------------------------------------
[iscript]
function EndButton()
{
	
}

//
function draw_endlist()
{
	
}
[endscript]


[macro name=draw_endlist]

	;描绘按钮
	[eval exp="draw_endlist()"]

	;前一页
	[mybutton dicname="f.config_endmode.up" exp="tf.当前END页-- if (tf.当前END页>1)" target=*刷新画面]
	;后一页
	[mybutton dicname="f.config_endmode.down" exp="tf.当前END页++ if (tf.当前END页<tf.END页数)" target=*刷新画面]
	;返回按钮
	[mybutton dicname="f.config_endmode.back" target=*返回]
[endmacro]

[return]
