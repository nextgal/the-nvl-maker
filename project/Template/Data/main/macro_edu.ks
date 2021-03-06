;-------------------------------------------------------------------------------------------
;养成面板专用宏
;默认：
;背景板显示在layer11层上
;按钮显示在message3层上
;可刷新的数值显示面板显示在layer12上
;悬停图片显示在layer13上

;系统：
;背景板显示在layer14层上
;按钮显示在message4层上
;可刷新的数值显示面板显示在layer15上
;悬停图片显示在layer16上
;追加悬停图片函数,配合新增的参数，鼠标移到按钮上时可在指定位置额外显示一张图片
;使用方式为在如下参数里填入内容:
;鼠标移入：mapshow('图片名',x,y)
;鼠标移出：maphide()
;-------------------------------------------------------------------------------------------
*start
[iscript]
//------------------------------------------------------------
//载入多个.edu文件
//------------------------------------------------------------
function loadedus(arr,layer=11)
{
	//创建数组类并读入关键字
	var dic =[];
	dm(arr);
	dm(arr[0]);

	dic=Scripts.evalStorage((string)arr[0]+".edu");
	dm(dic);

   //载入背景
	loadCustomUIBack(dic[0].bgd,layer);

	var p_layer=(string)(1+(int)layer);
   //读取空白底图
   kag.back.layers[p_layer].loadImages(%['storage'=>'empty','visible'=>true,'left'=>0,'top'=>0]);

	for (var i=0;i<arr.count;i++)
	{
		dic=Scripts.evalStorage((string)arr[i]+".edu");
		createControls(dic,p_layer);
	}

}
[endscript]

[iscript]
//------------------------------------------------------------
//生成按钮
//------------------------------------------------------------
function createEduBtn(dic)
{
	//定义按钮位置
	kag.tagHandlers.locate(%["x" => dic["x"], "y" => dic["y"] ]);
	
	//创建按钮用字典
	var edubutton = new Dictionary();
	//取得数据
	edubutton["normal"]=dic["normal"];
	edubutton["over"]=dic["over"];
	edubutton["on"]=dic["on"];
	edubutton["storage"]=dic["storage"];
	edubutton["target"]=dic["target"];
	
	if (dic["exp"]!=void) edubutton["exp"]=dic["exp"];
	
	if (dic["enterse"]!=void) edubutton["enterse"]=dic["enterse"];
	if (dic["clickse"]!=void) edubutton["clickse"]=dic["clickse"];
	if (dic["onenter"]!=void) edubutton["onenter"]=dic["onenter"];
	if (dic["onleave"]!=void) edubutton["onleave"]=dic["onleave"];
	
	//假如有条件，取得条件表达式
	if (dic["cond"]!=void) edubutton["cond"]=dic["cond"];
	
	//该据点在本地图上使用到
	if (dic["use"]==1)
	{
	   //满足条件
	   if (Scripts.eval(edubutton["cond"])==true) kag.tagHandlers.button(edubutton);
	   //或者无需条件
	   if (edubutton["cond"]==void) kag.tagHandlers.button(edubutton);
	}
      
}
//------------------------------------------------------------
//生成文字
//------------------------------------------------------------
function createEduText(dic,layer)
{

	//创建文字用字典
	var edutext = new Dictionary();
	
	edutext["layer"]=layer;
	edutext["page"]="back";
	
	edutext["x"]=dic.x;
	edutext["y"]=dic.y;
	//加入行高度属性
	if (dic.lineheight!=void) edutext["lineheight"]=dic.lineheight;

	//字体
	if (dic.fontname!=void) edutext["face"]=dic.fontname;
	else edutext["face"]=kag.fore.messages[0].userFace;

	edutext["size"]=dic.size;
	edutext["color"]=dic.color;
	edutext["bold"]=dic.bold;
	edutext["shadow"]=dic.shadow;
	edutext["shadowcolor"]=dic.shadowcolor;
	edutext["edge"]=dic.edge;
	edutext["edgecolor"]=dic.edgecolor;
	
	//假如有条件，取得条件表达式
	if (dic["cond"]!=void) edutext["cond"]=dic["cond"];
	
	//该据点在本地图上使用到
	if (dic["use"]==1)
	{
	   //满足条件
	   if (Scripts.eval(edutext["cond"])==true || edutext["cond"]==void) 
		{
			//显示的文字内容
			if (dic.flagname!=void) edutext["text"]=(string)Scripts.eval(dic.flagname);
			else edutext["text"]=dic.name;
			kag.tagHandlers.ptext(edutext);
		}

	}
	
}
//------------------------------------------------------------
//生成图像
//------------------------------------------------------------
function createEduPic(dic,layer)
{
     if (dic.pic!=void && dic["use"]==1)
     {
       //图形的情况，创建图形用字典
        var edupic = new Dictionary();
        
		edupic["layer"]=layer;
		edupic["page"]="back";
		
		edupic["dx"]=dic.x;
		edupic["dy"]=dic.y;
		
		edupic["storage"]=dic.pic;
		
		//假如变数值不为空，则将变数值视为图片名
		if (dic.flagname!=void) edupic["storage"]=Scripts.eval(dic.flagname);
		
		if (Scripts.eval(dic["cond"])==true) kag.tagHandlers.pimage(edupic);
		if (dic["cond"]==void)  kag.tagHandlers.pimage(edupic);
     
     }
     else if (dic.pic==void && dic["use"]==1)
     {
         //假如是数字的情况
          if (Scripts.eval(dic["cond"])==true) drawnum(Scripts.eval(dic.flagname),dic.num,dic.space,layer,"back",dic.x,dic.y);
          if (dic["cond"]==void) drawnum(Scripts.eval(dic.flagname),dic.num,dic.space,layer,"back",dic.x,dic.y); 
     }
     
}
//------------------------------------------------------------
//生成控件
//------------------------------------------------------------
function createControls(arr,layer)
{
	for (var i=1;i<arr.count;i++)
	{
		if (arr[i].ctype!=void)
		{
			dm(arr[i].ctype);

			switch (arr[i].ctype)
			{
				case "btn":
					createEduBtn(arr[i]);
					break;
				case "text":
					createEduText(arr[i],layer);
					break;
				case "pic":
					createEduPic(arr[i],layer);
					break;
			}
		}
		else
		{
				if (i<11)
				{
					dm("btn");
					createEduBtn(arr[i]);
				}
				else if (i<21)
				{
					dm("text");
					createEduText(arr[i],layer);
				}

				else
				{
					dm("pic");
					createEduPic(arr[i],layer);
				}
		}
	}

}
[endscript]

[iscript]
//------------------------------------------------------------
//载入.edu文件
//------------------------------------------------------------
function loadedu(name,layer=11)
{
	//创建数组类并读入关键字
	var edupanel =[];
	edupanel=Scripts.evalStorage(name);

	if (edupanel!='')
	{
		//载入背景
		loadCustomUIBack(edupanel[0].bgd,(int)layer);
		var p_layer=(string)(1+(int)layer);
		//创建控件
		createControls(edupanel,p_layer);
	}
}
[endscript]
;------------------------------------------------------------
;加载养成面板
;------------------------------------------------------------
[macro name=loadedu]
[set_ui_layer layer=%layer]
;显示养成面板
[eval exp=&"'loadedu(\''+mp.storage+'\','+(int)mp.layer+')'"]
[endmacro]
;------------------------------------------------------------
;显示养成面板
;------------------------------------------------------------
[macro name=edu]
[rclick enabled="false"]
[history enabled="false"]
[backlay]
[loadedu storage=%storage layer=%layer]
[trans * layer="base" method=%method|crossfade time=%time|300]
[wt]
;当“等待玩家选择”选中时，等待玩家点击按钮再继续
[s cond="mp.waitclick"]
[endmacro]
;------------------------------------------------------------
;显示养成面板
;------------------------------------------------------------
[macro name=edus]
[rclick enabled="false"]
[history enabled="false"]
[backlay]
[set_ui_layer layer=%layer]
;显示养成面板
[eval exp=&"'loadedus(\''+mp.storage+'\','+mp.layer+')'"]
[trans * layer="base" method=%method|crossfade time=%time|300]
[wt]
;当“等待玩家选择”选中时，等待玩家点击按钮再继续
[s cond="mp.waitclick"]
[endmacro]
;------------------------------------------------------------
;清除面板
;------------------------------------------------------------
[macro name=cledu]
[backlay]
[cl_ui_layer layer=%layer]
[trans * layer="base" method=%method|crossfade time=%time|200]
[wt]
[current layer="message0"]
[rclick enabled="true"]
[history enabled="true"]
[endmacro]
;------------------------------------------------------------

[iscript]
//------------------------------------------------------------
//显示数字图片
//------------------------------------------------------------
function drawnum(flagname,num,sp=20,layer="12",page="back",x=0,y=0) //数值，图片，字间距，所在层,x,y
{

   //分析处理变数（格式化为三位数，改成%04d就可格式化为4位）
   var str="%03d".sprintf(flagname);

   //循环描绘数值;
   for (var i=0;i<str.length;i++)
   {
           kag.tagHandlers.pimage(
           %[
              "layer"=>layer,
              "page"=>page,
              "storage"=>num+str[i],
              "dx"=> (int)x+(int)i*sp,
              "dy"=> (int)y
           ]);
   
   }

}
[endscript]
;------------------------------------------------------------
;描绘数字显示的宏
;------------------------------------------------------------
;使用范例
;@draw_num num=&"f.test" pic="num-" x=100 y=150
[macro name=draw_num]
[eval exp="drawnum(mp.num,mp.pic,mp.sp,mp.layer,mp.page,mp.x,mp.y)"]
[endmacro]

[return]
