;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;---------------------------------------------------------------
;询问窗口设定窗口
;---------------------------------------------------------------
*start
[window_down width=&"sf.gs.width+200" height=&"sf.gs.height+100" title="询问窗口"]

[iscript]

//新建显示用层
f.uilayer=[];
//按钮
f.uilayer[0]=new uiButtonLayer(f.config_yesno.btnyes);
f.uilayer[1]=new uiButtonLayer(f.config_yesno.btnno);
//消息文字
f.uilayer[2]=new uiYNMsgLayer("红色十字代表对齐锚点",f.config_yesno.msg);
[endscript]

*update
[iscript]
//--------------------------------------------------------
//消息文字
f.uilayer[2].Reset(f.config_yesno.msg);

//所有层全部不选中
for (var i=0;i<f.uilayer.count;i++)
{
   f.uilayer[i].select=false;
   f.uilayer[i].drawSelect();
}
[endscript]

*window
[window_down width=&"sf.gs.width+200" height=&"sf.gs.height+100" title="询问窗口"]

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
   .loadImages(%["storage"=>f.config_yesno.bgd]);
   .width=sf.gs.width;
   .height=sf.gs.height;
}

//--------------------------------------------------------
drawFrame("基本设定",3,sf.gs.width+40,50,kag.fore.layers[3],140);
drawEdit("背景图形",,sf.gs.width+70,70);drawLink_Picwin("f.config_yesno.bgd","others",,);
drawEdit("文字样式",,sf.gs.width+70,100);
[endscript]
 [link hint="点此打开文字样式设置界面" target=*文字样式]□[endlink]
[iscript]
drawFrame("控件设定",3,sf.gs.width+40,190,kag.fore.layers[3],140);
drawButtonSetting("确认","f.uilayer[0]",sf.gs.width+50,210);
drawButtonSetting("取消","f.uilayer[1]",sf.gs.width+50,240);

drawFrame("当前坐标",1,sf.gs.width+40,540,kag.fore.layers[3],140);

[endscript]
[s]

*文字样式
[iscript]
f.参数=new Dictionary();
f.参数=f.uilayer[2].TextElm();
[endscript]
[call storage="window_ynmsg.ks"]
[iscript]
(Dictionary.assign incontextof f.config_yesno.msg)(f.参数);
[endscript]
[jump target=*update]

*选择图片
[call storage="window_picture.ks"]
[jump target=*update]

*按钮设定
[call storage="window_sysbutton.ks"]
[jump target=*window]

*确认

[iscript]
//按钮信息
f.config_yesno.btnyes=f.uilayer[0].ButtonElm();
f.config_yesno.btnno=f.uilayer[1].ButtonElm();
f.config_yesno.msg=f.uilayer[2].TextElm();
//保存
(Dictionary.saveStruct incontextof f.config_yesno)(sf.path+"uidata/"+'uiyesno.tjs');
[endscript]

*关闭选单
;重载字典
[iscript]
f.config_yesno=Scripts.evalStorage(sf.path+"uidata/"+'uiyesno.tjs');
delete f.uilayer;
[endscript]

[rclick enabled="false"]
[freeimage layer="3"]
[freeimage layer="4"]
[current layer="message3"]
[er]
[layopt layer="message3" visible="false"]
[jump storage="gui_main.ks"]

