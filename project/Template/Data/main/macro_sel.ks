*start
;------------------------------------------------------------
;描绘选择按钮
;------------------------------------------------------------
[iscript]
//用函数创建按钮并描绘文字
function createSelbutton(mp)
{
	var selbutton=%[];
	//复制默认设定
	(Dictionary.assign incontextof selbutton)(f.config_sel.selbutton);
	//将mp中传入的值覆盖默认设定
	foreach(mp,setdictvalue,selbutton);
	//删除空值
	foreach(selbutton,checkdict);
	//根据字典建立按钮
	kag.tagHandlers.button(selbutton);

	//为描绘文字做出处理

	//假如没有填写剧本，则读取当前执行中的剧本名
	if (mp.storage==void) mp.storage=Storages.extractStorageName(kag.conductor.curStorage);
	//假如连标签也没有，就自动填个标签
	if (mp.target==void) mp.target="*start";

	//在按钮上描绘文字
	drawSelButton(mp.text,mp.storage,mp.target);
}

//描绘按钮文字用函数
function drawSelButton(caption, storage, target)
{
	var button;
	button=kag.current.links[kag.current.links.count-1].object;

	//默认文字样式设定
	button.font.face = kag.fore.messages[0].userFace;
	button.font.bold = kag.fore.messages[0].defaultBold;

	//读取设定
	var font=f.config_sel.selfont;
	button.font.height = font.height;
	
	//sel颜色设定
	var normal=font.normal;
	var read=font.read;
	var over=font.over;
	var on=font.on;
	
	var edgecolor=kag.fore.messages[0].defaultEdgeColor;
	var shadowcolor=kag.fore.messages[0].defaultShadowColor;

	var w = button.font.getTextWidth(caption); // 取得要描绘文字的宽度
	var x = (button.width - w) \ 2;    // 在按钮中央显示文字
	var y = (button.height - button.font.getTextHeight(caption)) \ 2;   //   文字在按钮上的y位置（左上角起算）

	//取得既读设定
	var target_name=target.substring(1,target.length-1); //去掉星号
	var labelname="trail_"+Storages.chopStorageExt(storage)+"_"+target_name;
	var checklabel="sf[\""+labelname+"\"]";
	var sel_color;

	// 既读文字颜色设定
	if ((checklabel!)>0 && read!=void) {sel_color=read;}
	else {sel_color=normal;}

	//设定每行最大字数
	var num=20;
	//计算行数
	var t_linecount=caption.length\num;
	if  (caption.length%num>0) {t_linecount++;}
	//假如多于1行，修改x的坐标
	if (t_linecount>1) x=(button.width - button.font.getTextWidth("一")*num) \ 2;

	//描绘文字
	for (var i=0; i<t_linecount; i++)
	{
		//y的坐标随行数变化
		var y=(button.height - button.font.getTextHeight(caption)*t_linecount) \ 2+i*button.font.getTextHeight(caption);
		//以20个字为单位取得要描绘的文字
		var text=caption.substring(i*num,num);

		if (kag.fore.messages[0].defaultEdge) //默认设置带有描边
		{
			// 按钮「通常状態」部分文字显示
			button.drawText(x,y, text, sel_color, 255, true, 255, edgecolor, 1, 0, 0);
			// 按钮「按下状態」部分文字显示
			button.drawText(x+button.width, y, text, on ,255, true, 255, edgecolor, 1, 0, 0);
			// 按钮「选中状態」部分文字显示
			button.drawText(x+button.width+button.width, y, text, over ,255, true, 255, edgecolor, 1, 0, 0);
		}
		else if (kag.fore.messages[0].defaultShadow)//默认设置带有阴影
		{
			// 按钮「通常状態」部分文字显示
			button.drawText(x,y, text, sel_color, 255, true, 255, shadowcolor, 0, 2, 2);
			// 按钮「按下状態」部分文字显示
			button.drawText(x+button.width, y, text, on ,255, true, 255, shadowcolor, 0, 2, 2);
			// 按钮「选中状態」部分文字显示
			button.drawText(x+button.width+button.width, y, text, over ,255, true, 255, shadowcolor, 0, 2, 2);
		}
		else //无任何效果
		{
			// 按钮「通常状態」部分文字显示
			button.drawText(x,y, text, sel_color, 255, true);
			// 按钮「按下状態」部分文字显示
			button.drawText(x+button.width, y, text, on ,255, true);
			// 按钮「选中状態」部分文字显示
			button.drawText(x+button.width+button.width, y, text, over ,255, true);
		}

	}

}
[endscript]
;------------------------------------------------------------
;选择按钮居中对齐
;------------------------------------------------------------
[iscript]
//让所有按钮自动居中对齐的效果
function Arrange_SelButton(num)
{
	var x=f.config_sel.scale.x;
	var y=f.config_sel.scale.y;

	var width=f.config_sel.scale.width;
	var height=f.config_sel.scale.height;
	
//设置自动范围
if (f.config_sel.scale.width==0 || f.config_sel.scale.height==0)
{
	//假如没有这两个值，使用上2/3画面
	width=kag.scWidth;
	height=kag.scHeight*2/3;
}

	var per_height=height/(num+1);

	for (var i=0;i<num;i++)
	{
		var button=kag.current.links[i].object;
		button.left=(int)x+(int)(width-button.width)/2;
		button.top=(int)y+(int)per_height*(i+1);
		
		dm("选项按钮"+(i+1));
		dm("x="+button.left);
		dm("y="+button.top);
	}

}
[endscript]


;------------------------------------------------------------------
;★准备选项
;------------------------------------------------------------------
[macro name=selstart]
[hr]
[backlay]
;隐藏对话层、消除头像
[if exp="mp.hidemes"]
[rclick enabled="false"]
[layopt layer="message0" visible="false" page=back]
;隐藏头像
[clface page="back"]
;隐藏姓名栏
[clname page="back"]
[endif]
;隐藏按钮层
[if exp="mp.hidesysbutton"]
[rclick enabled="false"]
[hidesysbutton]
[endif]
;显示选项层
[frame layer="message1" page="back"]
[current layer="message1" page="back"]
[nowait]
[endmacro]
;------------------------------------------------------------------
;★按钮选项
;------------------------------------------------------------------
[macro name=selbutton]
;显示选项按钮
[eval exp="createSelbutton(mp)"]
[endmacro]
;------------------------------------------------------------------
;★等待选择-选项
;------------------------------------------------------------------
[macro name=selend]
[endnowait]
;假如是限时选项，强制将系统菜单无效化
[if exp="mp.timeout"]
[history enabled="false"]
[rclick enabled="false"]
[hidesysbutton]
[endif]
;按钮排列处理
[eval exp="Arrange_SelButton(kag.current.links.count)"]
[trans method=%method|crossfade time=%time|300 rule=%rule from=%from stay=%stay]
[wt canskip=%canskip]
;限时选项处理
[if exp="mp.timeout"]
[timeout time=%outtime storage=%storage target=%target]
[endif]
[if exp="mp.timebar"]
[timebar bar=%bar x=%x y=%y time=%outtime width=%width bgimage=%bgimage bgx=%bgx bgy=%bgy]
[endif]
;自动对齐选项

[s]
[endmacro]
;------------------------------------------------------------------
;★清理选项
;------------------------------------------------------------------
[macro name=clsel]
[rclick enabled="true"]
[history enabled="true"]
[backlay]
[layopt layer="message1" visible="false" page="back"]

;恢复对话框与系统按钮
[layopt layer="message0" visible="true" page=back]
;显示系统按钮层
[showsysbutton]
[trans method=%method|crossfade time=%time|100 rule=%rule from=%from stay=%stay]
[wt canskip=%canskip]
;返回对话
[current layer="message0"]
[endmacro]
;------------------------------------------------------------------
[return]
