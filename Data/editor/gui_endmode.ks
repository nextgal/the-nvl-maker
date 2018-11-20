;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
*start
[window_down width=&"sf.gs.width+200" height=&"sf.gs.height+100" title="结局界面编辑"]

[iscript]


//新建显示用层
f.uilayer=[];

//按钮
f.uilayer[0]=new uiButtonLayer(f.config_endmode.up);
f.uilayer[1]=new uiButtonLayer(f.config_endmode.down);
f.uilayer[2]=new uiButtonLayer(f.config_endmode.back);

[endscript]

*update
[iscript]
//--------------------------------------------------------
//清空档案按钮层
for (var i=3;i<f.uilayer.count;i++)
{
  f.uilayer[i]=void;
}
//强制设定f.uilayer.count的值
f.uilayer.count=f.config_endmode.locate.count+3;
//--------------------------------------------------------
//重建
for (var i=0;i<f.config_endmode.locate.count;i++)
{
  f.uilayer[i+3]=new uiCgThumLayer(f.config_endmode.locate[i],f.config_endmode.thum.normal);
}

[endscript]

*window
[window_down width=&"sf.gs.width+200" height=&"sf.gs.height+100" title="结局界面编辑"]


[iscript]
with(kag.fore.layers[3])
{
   .fillRect(20,50,sf.gs.width,sf.gs.height,0xFFC8C8C8);
}
//背景重载
with(kag.fore.layers[4])
{
   .left=kag.fore.layers[3].left+20;
   .top=kag.fore.layers[3].top+50;
   .visible=true;
   .loadImages(%["storage"=>f.config_endmode.bgd]);
   .width=sf.gs.width;
   .height=sf.gs.height;
}

//--------------------------------------------------------
//刷新图层
      //所有层全部不选中
      for (var i=0;i<f.config_endmode.locate.count+3;i++)
      {
         if (f.uilayer[i].select==true)
         {
           f.uilayer[i].select=false;
           f.uilayer[i].drawSelect();
         }
      }
//--------------------------------------------------------
drawFrame("基本设定",3,sf.gs.width+40,50,kag.fore.layers[3],140);

drawEdit("背景图形",,sf.gs.width+70,70);drawLink_Picwin("f.config_endmode.bgd","others",,);
drawEdit("END按钮",,sf.gs.width+70,100);//drawLink_Picwin("f.config_endmode.thum.normal","others",,);
[endscript]
 [link hint="点此打开缩略图细节设定窗口" target=*缩略图设置]□[endlink]
[iscript]
drawEdit("每页图数",,sf.gs.width+70,130);
[endscript]
 [link hint="点此打开缩略图数量设定窗口" target=*缩略图数量]□[endlink]
[iscript]

drawFrame("控件设定",3,sf.gs.width+40,190,kag.fore.layers[3],140);
drawButtonSetting("前一页","f.uilayer[0]",sf.gs.width+50,210);
drawButtonSetting("后一页","f.uilayer[1]",sf.gs.width+50,240);
drawButtonSetting("返回按钮","f.uilayer[2]",sf.gs.width+50,270);
//--------------------------------------------------------
drawFrame("当前坐标",1,sf.gs.width+40,540,kag.fore.layers[3],140);
[endscript]
[s]

*缩略图数量
[call storage="window_endthum.ks"]
[jump target=*update]

*选择图片
[call storage="window_picture.ks"]
[jump target=*update]

*按钮设定
[call storage="window_sysbutton.ks"]
[jump target=*window]

*缩略图设置
[iscript]
f.参数=new Dictionary();
f.参数.thum=f.config_endmode.thum.thum;
f.参数.x=f.config_endmode.thum.x;
f.参数.y=f.config_endmode.thum.y;

f.参数.normal=f.config_endmode.thum.normal;
f.参数.over=f.config_endmode.thum.over;
f.参数.on=f.config_endmode.thum.on;
f.参数.enterse=f.config_endmode.thum.enterse;
f.参数.clickse=f.config_endmode.thum.clickse;
[endscript]
[call storage="window_endbutton.ks"]
[iscript]
f.config_endmode.thum.thum=f.参数.thum;
f.config_endmode.thum.x=f.参数.x;
f.config_endmode.thum.y=f.参数.y;
f.config_endmode.thum.normal=f.参数.normal;
f.config_endmode.thum.over=f.参数.over;
f.config_endmode.thum.on=f.参数.on;
f.config_endmode.thum.enterse=f.参数.enterse;
f.config_endmode.thum.clickse=f.参数.clickse;
[endscript]

*确认

[iscript]
//按钮信息
f.config_endmode.up=f.uilayer[0].ButtonElm();
f.config_endmode.down=f.uilayer[1].ButtonElm();
f.config_endmode.back=f.uilayer[2].ButtonElm();

//各缩略图的位置记录
for (var i=0;i<f.config_endmode.locate.count;i++)
{
  f.config_endmode.locate[i][0]=f.uilayer[i+3].left;
  f.config_endmode.locate[i][1]=f.uilayer[i+3].top;
}

//保存字典
SaveDic(f.config_endmode,"uiendmode.tjs");
[endscript]

*关闭选单
;重载字典
[iscript]
f.config_endmode=LoadDic("uiendmode.tjs");
delete f.uilayer;
[endscript]

[rclick enabled="false"]
[freeimage layer="3"]
[freeimage layer="4"]
[current layer="message3"]
[er]
[layopt layer="message3" visible="false"]
[jump storage="gui_main.ks"]
