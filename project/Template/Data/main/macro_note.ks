;-------------------------------------------------------------------------------------------
;笔记系统范例
;-------------------------------------------------------------------------------------------
*start

;-------------------------------------------------------------------------------------------
;初始化
;-------------------------------------------------------------------------------------------
[iscript]
//加载笔记数据库
sf.notedata=Scripts.evalStorage("notebook.tjs");
//初始化笔记
if (f.notelist==void) f.notelist=[];
[endscript]
;-------------------------------------------------------------------------------------------
;数据操作
;-------------------------------------------------------------------------------------------
[iscript]
//获得新笔记
function addNote(id)
{
	//初始化笔记
	if (f.notelist==void) f.notelist=[];

	//检查是否已经存在这个id
	for (var i=0;i<f.notelist.count;i++)
	{
		if (f.notelist[i]==id) return id;
	}

	//都不存在的情况，添加这条笔记记录
	f.notelist.add(id);

}

function getNote(id)
{
	//笔记数据库内容
	var arr=sf.notedata;
	//返回单条记录
	return arr[id];
}

[endscript]

;添加笔记并提示
[macro name=addnote]
[eval exp="addNote(mp.id)"]
@dia
获得了笔记《[emb exp="getNote(mp.id).title"]》。[w]
[endmacro]
;-------------------------------------------------------------------------------------------
;界面显示相关
;-------------------------------------------------------------------------------------------
[iscript]
function drawNote()
{
	//初始化笔记记录
	if (f.notelist==void) f.notelist=[];

	//笔记数据库内容
	var arr=sf.notedata;

	//描绘笔记按钮
	for (var i=0;i<f.notelist.count;i++)
	{
			//定义按钮位置
			kag.tagHandlers.locate(%["x" => 175, "y" => 160+50*i ]);



			//创建按钮用字典
			var btndic = new Dictionary();
			btndic.normal="extra_bgmbutton_normal";
			btndic.over="extra_bgmbutton_normal";

			//数据
			var id=f.notelist[i];
			//点击时将获取对应笔记的ID并保存到变数中
			btndic.exp="f.selected_note="+id;

			btndic.target="*note";

			kag.current.addButton(btndic);
			var button=kag.current.links[kag.current.links.count-1].object;

			//字体设定
			button.font.face=kag.fore.messages[0].userFace;
			button.font.height=24;

			//取得笔记标题
			var dic=getNote(id);
			var str=dic.title;

			//描绘笔记标题文字
			var x=15;
			var y=10;
			var color=0xFFFFFF;

			button.drawText(x,y,str,color);
			button.drawText(x+button.width,y,str,color);
			button.drawText(x+button.width*2,y,str,color);
	}
}
[endscript]

;显示笔记
[macro name=draw_note]
[eval exp="drawNote()"]
[endmacro]
[return]
