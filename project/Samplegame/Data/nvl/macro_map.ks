;-------------------------------------------------------------------------------------------
;地图显示专用宏
;和养成相同
;背景板显示在event层上
;按钮显示在message1层上
;可刷新的数值显示面板显示在layer 9上
;-------------------------------------------------------------------------------------------
*start
[iscript]
//------------------------------------------------------------
//读入地图配置表
//------------------------------------------------------------
//显示地图按钮
function loadmap(name)
{
//创建类并读入关键字
var dic =[];
dic=Scripts.evalStorage(name);

 if (dic!='')
 {
   //载入背景
   kag.back.event.loadImages(%["storage"=>dic[0].bgd,"visible"=>true,"left"=>0,"top"=>0]);
   //循环描绘按钮
   for (var i=1;i<dic.count;i++)
   {
   //定义按钮位置
   kag.tagHandlers.locate(%["x" => dic[i]["x"], "y" => dic[i]["y"] ]);
   //创建按钮用字典
   var mapbutton = new Dictionary();
   //取得数据
   mapbutton["normal"]=dic[i]["normal"];
   mapbutton["over"]=dic[i]["over"];
   mapbutton["on"]=dic[i]["on"];
   mapbutton["storage"]=dic[i]["storage"];
   mapbutton["target"]=dic[i]["target"];

   if (dic[i]["exp"]!=void) mapbutton["exp"]=dic[i]["exp"];

   if (dic[i]["enterse"]!=void) mapbutton["enterse"]=dic[i]["enterse"];
   if (dic[i]["clickse"]!=void) mapbutton["clickse"]=dic[i]["clickse"];

   //假如有条件，取得条件表达式
   if (dic[i]["cond"]!=void) mapbutton["cond"]=dic[i]["cond"];
   
       //该据点在本地图上使用到
       if (dic[i]["use"]==1)
      {
           //满足条件
           if (Scripts.eval(mapbutton["cond"])==true) kag.tagHandlers.button(mapbutton);
           //或者无需条件
           if (mapbutton["cond"]==void) kag.tagHandlers.button(mapbutton);
      }
   }
 }
}
[endscript]
;------------------------------------------------------------
;显示地图
;------------------------------------------------------------
[macro name=map]
[rclick enabled="false"]
[history enabled="false"]
[backlay]
;隐藏一般对话层
[layopt layer="message0" page="back" visible="false"]
;隐藏系统按钮层
[hidesysbutton]
[position page="back" layer="message1" frame="empty" color="0xFFFFFF" opacity=0 left=0 top=0]
[layopt layer="message1" page="back" visible="true"]
[current layer="message1" page="back"]
[er]
;显示按钮
[eval exp=&"'loadmap(\''+mp.storage+'\')'"]
[trans * method=%method|crossfade time=%time|500]
[wt]
[s]
[endmacro]
;------------------------------------------------------------
;清除地图
;------------------------------------------------------------
[macro name=clmap]
[backlay]
;[freeimage layer=stage page="back"]
[freeimage layer=event page="back"]
[current layer="message1" page="back"]
[er]
[layopt layer="message1" page="back" visible="false"]
[layopt layer="message0" page="back" visible="true"]
[hidesysbutton]
[trans * method=%method|crossfade time=%time|500]
[wt]
[current layer="message0"]
[rclick enabled="true"]
[history enabled="true"]
[endmacro]
;------------------------------------------------------------
[return]
