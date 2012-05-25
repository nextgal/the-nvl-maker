*start
[iscript]
//------------------------------------------------------------
//讀入地圖配置表
//------------------------------------------------------------
//顯示地圖按鈕
function loadmap(name)
{
//創建類並讀入關鍵字
var dic =[];
dic=Scripts.evalStorage(name);

 if (dic!='')
 {
   //載入背景
   kag.back.event.loadImages(%["storage"=>dic[0].bgd,"visible"=>true,"left"=>0,"top"=>0]);
   //循環描繪按鈕
   for (var i=1;i<dic.count-1;i++)
   {
   //定義按鈕位置
   kag.tagHandlers.locate(%["x" => dic[i]["x"], "y" => dic[i]["y"] ]);
   //創建按鈕用字典
   var mapbutton = new Dictionary();
   //取得數據
   mapbutton["normal"]=dic[i]["normal"];
   mapbutton["over"]=dic[i]["over"];
   mapbutton["on"]=dic[i]["on"];
   mapbutton["storage"]=dic[i]["storage"];
   mapbutton["target"]=dic[i]["target"];
   mapbutton["exp"]=dic[i]["exp"];

   //假如有條件，取得條件表達式
   if (dic[i]["cond"]!=void) mapbutton["cond"]=dic[i]["cond"];
   
       //該據點在本地圖上使用到
       if (dic[i]["use"]==1)
      {
           //滿足條件
           if (Scripts.eval(mapbutton["cond"])==true) kag.tagHandlers.button(mapbutton);
           //或者無需條件
           if (mapbutton["cond"]==void) kag.tagHandlers.button(mapbutton);
      }
   }
 }
}
[endscript]
;------------------------------------------------------------
;顯示地圖
;------------------------------------------------------------
[macro name=map]
[rclick enabled="false"]
[history enabled="false"]
[backlay]
;隱藏一般對話層
[layopt layer="message0" page="back" visible="false"]
;隱藏系統按鈕層
[layopt layer="message2" page="back" visible="false"]
[position page="back" layer="message1" frame="empty" color="0xFFFFFF" opacity=0 left=0 top=0]
[layopt layer="message1" page="back" visible="true"]
[current layer="message1" page="back"]
[er]
;顯示按鈕
[eval exp=&"'loadmap(\''+mp.storage+'\')'"]
[trans * method=%method|crossfade time=%time|500]
[wt]
[s]
[endmacro]
;------------------------------------------------------------
;清除地圖
;------------------------------------------------------------
[macro name=clmap]
[backlay]
[freeimage layer=stage page="back"]
[freeimage layer=event page="back"]
[current layer="message1" page="back"]
[er]
[layopt layer="message1" page="back" visible="false"]
[trans * method=%method|crossfade time=%time|500]
[wt]
[endmacro]
;------------------------------------------------------------
[return]
