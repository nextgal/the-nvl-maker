;-------------------------------------------------------------------------------------------
;地图显示专用宏
;默认：
;背景板显示在layer11层上
;按钮显示在message3层上
;悬停图片显示在layer13上

;系统：
;背景板显示在layer14层上
;按钮显示在message4层上
;悬停图片显示在layer16上

;追加悬停图片函数,配合新增的参数，鼠标移到按钮上时可在指定位置额外显示一张图片
;使用方式为在如下参数里填入内容:
;鼠标移入：mapshow('图片名',x,y)
;鼠标移出：maphide()
;-------------------------------------------------------------------------------------------
*start
[iscript]
//地图/养成用背景载入
function loadCustomUIBack(back,layer)
{
	var frame;
	if (typeof back == "String") frame=back;
	else frame=back.frame;

	//取得图层
	var num=getCustomLayer(layer);
	//载入背景
	kag.back.layers[num].loadImages(%["storage"=>frame,"visible"=>true,"left"=>0,"top"=>0]);
	//载入小图
	
}

//取得自定义图层/消息层名
function getCustomLayer(layer="11")
{
	return (int)layer;
}

function getCustomMsgLayer(layer="11")
{
	switch ((int)layer)
	{
		case 11: return "message3";
		case 14: return "message4";
		//默认
		default: return "message3";
	}
}

[endscript]
;-------------------------------------------------------------------------------------------
[iscript]
//------------------------------------------------------------
//读入地图配置表
//------------------------------------------------------------
//显示地图按钮
function loadmap(name,layer)
{
	//创建字典并读入地图文件信息
	var dic =[];
	dic=Scripts.evalStorage(name);

 if (dic!='')
 {
   //载入背景
	loadCustomUIBack(dic[0].bgd,layer);

	//循环描绘按钮
	for (var i=1;i<dic.count;i++)
	{
		if (dic[i].normal!=void)
		{
	  	 	CreateMapButton(dic[i]);
		}
		else
		{
			CreateAdvButton(dic[i]);
		}
	}
 }
}

//区域按钮
function CreateAdvButton(dic)
{
	//定义按钮位置
	kag.tagHandlers.locate(%["x" => dic["x"], "y" => dic["y"] ]);
	//创建按钮用字典
	var mapbutton = new Dictionary();

	mapbutton["normal"]="advbutton_base";

	mapbutton["storage"]=dic["storage"];
	mapbutton["target"]=dic["target"];
	
	if (dic["exp"]!=void) mapbutton["exp"]=dic["exp"];
	
	if (dic["enterse"]!=void) mapbutton["enterse"]=dic["enterse"];
	if (dic["clickse"]!=void) mapbutton["clickse"]=dic["clickse"];
	if (dic["onenter"]!=void) mapbutton["onenter"]=dic["onenter"];
	if (dic["onleave"]!=void) mapbutton["onleave"]=dic["onleave"];
	
	//假如有条件，取得条件表达式
	if (dic["cond"]!=void) mapbutton["cond"]=dic["cond"];
	
	   //该据点在本地图上使用到
	   if (dic["use"]==1)
	  {
	       //满足条件
	       if ((Scripts.eval(mapbutton["cond"])==true) || (mapbutton["cond"]==void))
			{
				kag.current.addButton(mapbutton);
				var button=kag.current.links[kag.current.links.count-1].object;
				//调整按钮大小、透明度
				button.setSize(dic["width"],dic["height"]);
				button.opacity=1;
			}
	  }

}

//地图按钮
function CreateMapButton(dic)
{
	   //定义按钮位置
	   kag.tagHandlers.locate(%["x" => dic["x"], "y" => dic["y"] ]);
	   //创建按钮用字典
	   var mapbutton = new Dictionary();
	   //取得数据
	   mapbutton["normal"]=dic["normal"];
	   mapbutton["over"]=dic["over"];
	   mapbutton["on"]=dic["on"];
	   mapbutton["storage"]=dic["storage"];
	   mapbutton["target"]=dic["target"];
	
	   if (dic["exp"]!=void) mapbutton["exp"]=dic["exp"];
	   
		if (dic["enterse"]!=void) mapbutton["enterse"]=dic["enterse"];
		if (dic["clickse"]!=void) mapbutton["clickse"]=dic["clickse"];
		if (dic["onenter"]!=void) mapbutton["onenter"]=dic["onenter"];
		if (dic["onleave"]!=void) mapbutton["onleave"]=dic["onleave"];
	
	   //假如有条件，取得条件表达式
	   if (dic["cond"]!=void) mapbutton["cond"]=dic["cond"];
	   
	       //该据点在本地图上使用到
	       if (dic["use"]==1)
	      {
	       //满足条件
	       if ((Scripts.eval(mapbutton["cond"])==true) || (mapbutton["cond"]==void))
			{
				kag.current.addButton(mapbutton);
			}
	      }

}
[endscript]
;------------------------------------------------------------
;地图悬停显示图片用函数（默认为layer13，不过也可以自行传入参数）
;------------------------------------------------------------
[iscript]
function mapshow(storage,x=0,y=0,num=13)
{
    //读入图片
    kag.fore.layers[num].loadImages(%['storage'=>storage,'visible'=>true,'left'=>x,'top'=>y]);
}

function maphide(num=13)
{
	kag.fore.layers[num].visible=false;
}
[endscript]

;------------------------------------------------------------
;面板准备设定
;------------------------------------------------------------
[macro name=set_ui_layer]
;隐藏一般对话层
[layopt layer="message0" page="back" visible="false"]
;隐藏系统按钮层
[hidesysbutton]
;设定当前所用层
[eval exp="tf.msg_layer=getCustomMsgLayer(mp.layer)"]
[eval exp="tf.ui_base_layer=getCustomLayer(mp.layer)"]
;执行层处理
[image layer=&tf.ui_base_layer page="back" storage="empty" visible="true"]
[image layer=&tf.ui_base_layer+1 page="back" storage="empty" visible="true"]

[frame layer=&tf.msg_layer page="back"]
[current layer=&tf.msg_layer page="back"]
[er]
[endmacro]
;------------------------------------------------------------
;面板消除设定
;------------------------------------------------------------
[macro name=cl_ui_layer]
;设定当前所用层
[eval exp="tf.msg_layer=getCustomMsgLayer(mp.layer)"]
[eval exp="tf.ui_base_layer=getCustomLayer(mp.layer)"]
;执行层处理
[freeimage layer=&tf.ui_base_layer page="back"]
[freeimage layer=&tf.ui_base_layer+1 page="back"]
[freeimage layer=&tf.ui_base_layer+2 page="back"]
[layopt layer=&tf.ui_base_layer page="back" visible="false"]
[layopt layer=&tf.ui_base_layer+1 page="back" visible="false"]
[layopt layer=&tf.ui_base_layer+2 page="back" visible="false"]
[current layer=&tf.msg_layer page="back"]
[er]
[layopt layer=&tf.msg_layer page="back" visible="false"]
[layopt layer="message0" page="back" visible="true"]
[hidesysbutton]
[endmacro]
;------------------------------------------------------------
;显示地图
;------------------------------------------------------------
[macro name=map]
[rclick enabled="false"]
[history enabled="false"]
[backlay]
[set_ui_layer layer=%layer]
;显示地图背景和按钮
[eval exp=&"'loadmap(\''+mp.storage+'\','+mp.layer+')'"]
[trans * layer="base" method=%method|crossfade time=%time|300]
[wt]
[s]
[endmacro]
;------------------------------------------------------------
;清除地图
;------------------------------------------------------------
[macro name=clmap]
[backlay]
[cl_ui_layer layer=%layer]
[trans * layer="base" method=%method|crossfade time=%time|200]
[wt]
[current layer="message0"]
[rclick enabled="true"]
[history enabled="true"]
[endmacro]
;------------------------------------------------------------
;自制系统用地图宏（没有等待指令，可自行插入右键设置等）
;------------------------------------------------------------
[macro name=sysmap]
[rclick enabled="false"]
[history enabled="false"]
[backlay]
[set_ui_layer layer=%layer]
;显示地图背景和按钮
[eval exp=&"'loadmap(\''+mp.storage+'\','+mp.layer+')'"]
[trans * layer="base" method=%method|crossfade time=%time|300]
[wt]
[endmacro]
;------------------------------------------------------------
;清除自制系统用地图宏（禁止右键菜单，是否消除地图背景要添加额外参数clbg）
;------------------------------------------------------------
[macro name=clsysmap]
[rclick enabled="false"]
[history enabled="false"]
[backlay]
[cl_ui_layer layer=%layer]
[trans * layer="base" method=%method|crossfade time=%time|200]
[wt]
[current layer="message0"]
[endmacro]
;------------------------------------------------------------
[return]
