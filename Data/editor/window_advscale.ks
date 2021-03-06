*start
*window
[window_up width=&"sf.gs.width+200" height=&"sf.gs.height+100" title="范围设定"]
[iscript]
//背景设定
with(kag.fore.layers[8])
{
   .left=kag.fore.layers[7].left+20;
   .top=kag.fore.layers[7].top+50;
   .width=sf.gs.width;
   .height=sf.gs.height;

   .loadImages(%["storage"=>f.uibacklayer.LayerElm().frame]);

   .visible=true;
   //.fillRect(0,0,sf.gs.width,sf.gs.height,0xFFC8C8C8);
}

drawFrame("位置大小",3,sf.gs.width+40,50,kag.fore.layers[7],140);
kag.fore.layers[7].drawText(20,sf.gs.height+65,getTransStr("提示：请以左上角->右下角的方向用鼠标拖动出红色框线，红框代表可点击区域的大小和位置"),0x000000);

f.advlayer=new getAdvLayer(kag.fore.layers[8].width,kag.fore.layers[8].height,f.参数);

[endscript]

[s]

*确认
[iscript]
f.advlayer.MarginElm();
[endscript]

*关闭选单
[iscript]
delete f.advlayer;
[endscript]
[rclick enabled="false"]
[freeimage layer="7"]
[freeimage layer="8"]
[current layer="message7"]
[er]
[layopt layer="message7" visible="false"]
[return]
