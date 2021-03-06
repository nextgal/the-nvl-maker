;-------------------------------------------------------------------------------------------
;养成游戏专用宏
;和地图相同
;背景板显示在event层上
;按钮显示在message1层上
;可刷新的数值显示面板显示在layer 9上
;-------------------------------------------------------------------------------------------
*start
[iscript]
//------------------------------------------------------------
//载入.edu文件
//------------------------------------------------------------
function loadedu(name)
{
//创建数组类并读入关键字
var dic =[];
dic=Scripts.evalStorage(name);

 if (dic!='')
 {
   //载入背景
   kag.back.event.loadImages(%["storage"=>dic[0].bgd,"visible"=>true,"left"=>0,"top"=>0]);
   //读取空白底图
   kag.back.layers[9].loadImages(%['storage'=>'empty','visible'=>true,'left'=>0,'top'=>0]);

////循环描绘按钮-------------------------------------------------------------------------------
   for (var i=1;i<11;i++)
   {
   //定义按钮位置
   kag.tagHandlers.locate(%["x" => dic[i]["x"], "y" => dic[i]["y"] ]);
   
   //创建按钮用字典
   var edubutton = new Dictionary();
   //取得数据
   edubutton["normal"]=dic[i]["normal"];
   edubutton["over"]=dic[i]["over"];
   edubutton["on"]=dic[i]["on"];
   edubutton["storage"]=dic[i]["storage"];
   edubutton["target"]=dic[i]["target"];

   if (dic[i]["exp"]!=void) edubutton["exp"]=dic[i]["exp"];

   if (dic[i]["enterse"]!=void) edubutton["enterse"]=dic[i]["enterse"];
   if (dic[i]["clickse"]!=void) edubutton["clickse"]=dic[i]["clickse"];
 
   //假如有条件，取得条件表达式
   if (dic[i]["cond"]!=void) edubutton["cond"]=dic[i]["cond"];
   
       //该据点在本地图上使用到
       if (dic[i]["use"]==1)
      {
           //满足条件
           if (Scripts.eval(edubutton["cond"])==true) kag.tagHandlers.button(edubutton);
           //或者无需条件
           if (edubutton["cond"]==void) kag.tagHandlers.button(edubutton);
      }
      
      
   }
//
// //-------------------------------------------------------------------------------
 
   //循环描绘文字
   for (var i=11;i<21;i++)
   {
     //创建文字用字典
     var edutext = new Dictionary();
     
      edutext["layer"]="9";
      edutext["page"]="back";
      
      edutext["x"]=dic[i].x;
      edutext["y"]=dic[i].y;
      
      edutext["text"]=Scripts.eval(dic[i].flagname);
      
      edutext["face"]=dic[i].fontname;
      edutext["size"]=dic[i].size;
      edutext["color"]=dic[i].color;
      edutext["bold"]=dic[i].bold;
      edutext["shadow"]=dic[i].shadow;
      edutext["shadowcolor"]=dic[i].shadowcolor;
      edutext["edge"]=dic[i].edge;
      edutext["edgecolor"]=dic[i].edgecolor;

   //假如有条件，取得条件表达式
   if (dic[i]["cond"]!=void) edutext["cond"]=dic[i]["cond"];
   
       //该据点在本地图上使用到
       if (dic[i]["use"]==1)
      {
           //满足条件
           if (Scripts.eval(edutext["cond"])==true)  kag.tagHandlers.ptext(edutext);
           //或者无需条件
           if (edutext["cond"]==void)   kag.tagHandlers.ptext(edutext);
      }
 
   }
   //-------------------------------------------------------------------------------
      //循环描绘图形
   for (var i=21;i<31;i++)
   {

     if (dic[i].pic!=void && dic[i]["use"]==1)
     {
       //图形的情况，创建图形用字典
        var edupic = new Dictionary();
        
		edupic["layer"]="9";
		edupic["page"]="back";
		
		edupic["dx"]=dic[i].x;
		edupic["dy"]=dic[i].y;
		
		edupic["storage"]=dic[i].pic;
		
		//假如变数值不为空，则将变数值视为图片名
		if (dic[i].flagname!=void) edupic["storage"]=Scripts.eval(dic[i].flagname);
		
		if (Scripts.eval(dic[i]["cond"])==true) kag.tagHandlers.pimage(edupic);
		if (dic[i]["cond"]==void)  kag.tagHandlers.pimage(edupic);
     
     }
     else if (dic[i].pic==void && dic[i]["use"]==1)
     {
         //假如是数字的情况
          if (Scripts.eval(dic[i]["cond"])==true) drawnum(Scripts.eval(dic[i].flagname),dic[i].num,dic[i].space,"9","back",dic[i].x,dic[i].y);
          if (dic[i]["cond"]==void) drawnum(Scripts.eval(dic[i].flagname),dic[i].num,dic[i].space,"9","back",dic[i].x,dic[i].y);  
     }
     
   }
   
   //-------------------------------------------------------------------------------
}
}
[endscript]
;------------------------------------------------------------
;显示养成面板
;------------------------------------------------------------
[macro name=edu]
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
[eval exp=&"'loadedu(\''+mp.storage+'\')'"]
[trans * method=%method|crossfade time=%time|500]
[wt]
;当“等待玩家选择”选中时，等待玩家点击按钮再继续
[s cond="mp.waitclick"]
[endmacro]

;------------------------------------------------------------
;清除面板
;------------------------------------------------------------
[macro name=cledu]
[backlay]
;[freeimage layer=stage page="back"]
[freeimage layer=event page="back"]
[freeimage layer=9 page="back"]
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

[iscript]
//------------------------------------------------------------
//显示数字图片
//------------------------------------------------------------
function drawnum(flagname,num,sp=20,layer="9",page="back",x=0,y=0) //数值，图片，字间距，所在层,x,y
{

   //分析处理变数;
   var str=(string)flagname;
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
