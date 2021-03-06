*start
;-------------------------------------------------------------------------------------------
;★独立姓名框
;-------------------------------------------------------------------------------------------
[iscript]
function drawNameFrame(id,page,color)
{
	var dic=f.config_dia.nameframe;

	var layer;

	if (page!="back") layer=kag.fore.layers[9];
	else layer=kag.back.layers[9];

	//使用文字层默认字体
	if (dic.face!=void) layer.font.face=dic.face;
	else layer.font.face=kag.fore.messages[0].userFace;

	layer.font.height=dic.textsize;//设定字体大小
	layer.font.italic=dic.italic;//是否斜体
	layer.font.bold=dic.bold;//是否粗体

	var x;
	var y;

	//设置姓名
	var str=id;
	if (id=='主角') str=f.姓+f.名;

	//计算文字长宽
	var width=layer.font.getTextWidth(str);
	var height=layer.font.getTextHeight(str);

	//描绘文字
	if (dic.anchorc==true)
	{
		x=(layer.width-width)/2;
		y=(layer.height-height)/2;
	}
	else
	{
		x=(int)dic.textx;//设定按钮上文字位置的地方
		y=(int)dic.texty;
	}
	
		var psetting=%[];
		psetting.layer="9";
		if (page!=void) psetting.page=page;
		
		//设定其他参数
		psetting.text=str;
		psetting.x=x;
		psetting.y=y;
		psetting.size=dic.textsize;

		//颜色为空，传入历史记录颜色
		if (color==void) color=history_color("【"+str+"】");
		//
		psetting.color=color;

		//字体样式
		psetting.italic=dic.italic;//是否斜体
		psetting.bold=dic.bold;//是否粗体

		psetting.edge=dic.edge;
		psetting.edgecolor=dic.edgecolor;
		psetting.shadow=dic.shadow;
		psetting.shadowcolor=dic.shadowcolor;

		//字体
		if (dic.face!=void) psetting.face=dic.face;
		else psetting.face=kag.fore.messages[0].userFace;

		//ptext进行描绘
		kag.tagHandlers.ptext(psetting);

}

function getNameFrameFile(file)
{
	if (file!=void) return file;
	else return f.config_dia.nameframe.frame;
}

[endscript]

;显示姓名栏
[macro name=nameframe]
;描绘图片框
[image layer=9 storage=&"getNameFrameFile(mp.frame)" left=&f.config_dia.nameframe.left top=&f.config_dia.nameframe.top visible="true" page=%page]
;描绘文字
[eval exp="drawNameFrame(mp.id,mp.page,mp.color)"]
[if exp="mp.id=='主角'"]
[htext text=&("【"+f.姓+f.名+"】")]
[else]
[htext text=&("【"+mp.id+"】")]
[endif]
[hr]
[endmacro]

;消除姓名栏
[macro name=clname]
[freeimage layer=9 page=%page|fore]
[endmacro]

[macro name=clface]
[freeimage layer=8 page=%page|fore]
[endmacro]
;-------------------------------------------------------------------------------------------
;★普通文字姓名
;-------------------------------------------------------------------------------------------
[macro name=nametext]

[nowait]

;修改姓名显示相对位置的地方
;去掉下面这行的;，就可以用了，坐标可以为负值
;【记得后面还有要把对话文字位置改回来的地方】
;[locate x=-50 y=0]

;使用人名默认颜色
[eval exp="setfont()"]

;假如特别设定了颜色，使用传入的颜色值
[font color=%color]

;非主角
[if exp="mp.id!='主角'"]
【[emb exp="mp.id"]】
[endif]

;为主角，没姓名时不显示
[if exp="mp.id=='主角'"]
[ch text="【" cond="f.姓!=void || f.名!=void"]
[emb exp="f.姓"][emb exp="f.名"]
[ch text="】" cond="f.姓!=void || f.名!=void"]
[endif]

[resetfont]

[r]
[endnowait]

;可以这里再把显示位置改回来
;[locate x=0 y=0]

[endmacro]
;-------------------------------------------------------------------------------------------
;★人名显示基础
;-------------------------------------------------------------------------------------------
[macro name=npc]

[layopt layer="message0" visible="true"]
[current layer="message0"]
[er]

;根据情况使用不同的姓名样式
[if exp="f.config_dia.nameframe==void || f.config_dia.nameframe.use==false"]
[nametext color=%color id=%id]
[endif]

;附加显示
[backlay]

;姓名栏的情况
[if exp="f.config_dia.nameframe!=void"]
[nameframe frame=%frame color=%color id=%id page="back" cond="f.config_dia.nameframe.use==true"]
[endif]

;头像
[if exp="mp.face!=void"]
[image layer=8 page="back" storage=%face visible="true"]
;left/top位置可以自己调整，可以用数字，这里是根据编辑器设定的值，按底边中点对齐
[layopt layer=8 page="back" left=&"(int)f.config_dia.face.left-kag.back.layers[8].width\2" top=&"(int)f.config_dia.face.top-kag.back.layers[8].height"]
[endif]
;立绘
[if exp="mp.fg!=void"]
;在原位置显示图片
[eval exp="mp.layer='0'" cond="mp.layer==''"]
[eval exp="mp.left=kag.fore.layers[mp.layer].left"]
[eval exp="mp.top=kag.fore.layers[mp.layer].top"]
[image layer=%layer page="back" storage=%fg left=%left top=%top visible="true"]
[endif]
[trans method="crossfade" time=100]
[wt]

[endmacro]
;------------------------------------------------------------------
;★文字连接
;------------------------------------------------------------------
[macro name=links]
[link *][ch text=%text][endlink]
[endmacro]

;------------------------------------------------------------------
;★等待
;------------------------------------------------------------------
[macro name=lr]
[l][r]
[endmacro]

[macro name=w]
;可在这里加入等待语音播放完毕的指令
[endvo]
[p]
[stopse buf="1"]
;[clname]
[hr]
[endmacro]
;------------------------------------------------------------------
;★普通对话框(含头像)
;------------------------------------------------------------------
[macro name=dia]
[rclick enabled="true"]
[history enabled="true"]
[backlay]
;隐藏头像
[clface page="back"]
;隐藏名字栏
[clname page="back"]
[current layer="message0" page="back"]
[position page="back" layer="message0" visible="true" frame=&"f.config_dia.dia.frame" left=&"f.config_dia.dia.left" top=&"f.config_dia.dia.top" marginl=&"f.config_dia.dia.marginl" marginr=&"f.config_dia.dia.marginr" margint=&"f.config_dia.dia.margint" marginb=&"f.config_dia.dia.marginb"]
;显示系统按钮层
[showsysbutton]
[trans method="crossfade" time=200]
[wt]
[current layer="message0" page="fore"]
[endmacro]
;------------------------------------------------------------------
;★全屏对话框(不含头像)
;------------------------------------------------------------------
[macro name=scr]
[rclick enabled="true"]
[history enabled="true"]
[backlay]
;隐藏头像
[clface page="back"]
;隐藏名字栏
[clname page="back"]
[current layer="message0" page="back"]
[position page="back" layer="message0" visible="true" frame=&"f.config_dia.scr.frame" left=&"f.config_dia.scr.left" top=&"f.config_dia.scr.top" marginl=&"f.config_dia.scr.marginl" marginr=&"f.config_dia.scr.marginr" margint=&"f.config_dia.scr.margint" marginb=&"f.config_dia.scr.marginb"]
;显示系统按钮层
[showsysbutton]
[trans method="crossfade" time=200]
[wt]
[current layer="message0" page="fore"]
[endmacro]
;------------------------------------------------------------------
;★透明全屏对话框
;------------------------------------------------------------------
[macro name=menu]
[rclick enabled="false"]
[history enabled="false"]
[backlay]
;隐藏头像
[clface page="back"]
;隐藏名字栏
[clname page="back"]
[current layer="message0" page="back"]
[position frame="" page="back" layer="message0" visible="true" width=&"kag.scWidth" height=&"kag.scHeight" color="0xFFFFFF" opacity="0" left=0 top=0 marginl=&"f.config_dia.blank.marginl" marginr=&"f.config_dia.blank.marginr" margint=&"f.config_dia.blank.margint" marginb=&"f.config_dia.blank.marginb"]
;隐藏系统按钮层
[hidesysbutton]
[trans method="crossfade" time=200]
[wt]
[current layer="message0" page="fore"]
[endmacro]
;------------------------------------------------------------
;★隐藏对话框
;------------------------------------------------------------
[macro name=hidemes]
[backlay]
;隐藏对话框
[layopt layer="message0" page="back" visible="false"]
;隐藏系统按钮
[layopt layer="message2" page="back" visible="false"]
;隐藏头像
[layopt layer=8 page="back" visible="false"]
;隐藏名字栏
[layopt layer=9 page="back" visible="false"]
[trans method="crossfade" time=100]
[wt]
[endmacro]
;------------------------------------------------------------
;★显示对话框
;------------------------------------------------------------
[macro name=showmes]
[backlay]
;隐藏对话框
[layopt layer="message0" page="back" visible="true"]
;隐藏系统按钮
[layopt layer="message2" page="back" visible="true"]
;隐藏头像
[layopt layer=8 page="back" visible="true" cond="kag.back.layers[8].width>32"]
;隐藏名字栏
[layopt layer=9 page="back" visible="true" cond="kag.back.layers[9].width>32"]
[trans method="crossfade" time=100]
[wt]
[current layer=message0 page=back]
[er]
[current layer=message0 page=fore]
[endmacro]
;------------------------------------------------------------
[return]
