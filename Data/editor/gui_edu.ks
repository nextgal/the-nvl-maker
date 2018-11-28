;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;---------------------------------------------------------------
;面板编辑窗口
;---------------------------------------------------------------
*start
[window_down width=&"sf.gs.width+370" height=&"sf.gs.height+100" title="养成面板"]
[iscript]
//创建层
f.uilayer=[];
//按钮层
for (var i=0;i<10;i++)
{
f.uilayer[i]=new uiMapButtonLayer(f.config_edu[i+1]);
}
//文字层
for (var i=10;i<20;i++)
{
f.uilayer[i]=new uiEduTextLayer(f.config_edu[i+1].name,f.config_edu[i+1]);
}
//数值层
for (var i=20;i<30;i++)
{
f.uilayer[i]=new uiEduPicLayer(f.config_edu[i+1].name,f.config_edu[i+1]);
}

[endscript]
;---------------------------------------------------------------
*window
[window_down width=&"sf.gs.width+370" height=&"sf.gs.height+100" title="养成面板"]
[iscript]
//描绘底板
drawUIEditorBack(180,50);
//--------------------------------------------------------
//刷新图层
      //所有层全部不选中
      for (var i=0;i<f.uilayer.count;i++)
      {
         if (f.uilayer[i].select)
         {
           f.uilayer[i].select=false;
           f.uilayer[i].drawSelect();
         }
      }
//--------------------------------------------------------

drawFrame("显示设定",20,20,50,kag.fore.layers[3],140);
drawFrame("基本设定",1,sf.gs.width+200,50,kag.fore.layers[3],140);
drawEdit("背景图形",,sf.gs.width+220,70);
drawLink_Picwin("f.config_edu[0].bgd","map",,);

drawFrame("按钮设定",10,sf.gs.width+200,130,kag.fore.layers[3],140);
drawFrame("当前坐标",1,sf.gs.width+200,700,kag.fore.layers[3],140);

//按钮编辑
for (var i=0;i<10;i++)
{
	var str=f.uilayer[i].name;
	if (str!=void) str=str.substr(0,6);
	else str="Btn"+"%02d".sprintf(i+1);
	drawEduButtonSetting(str,"f.uilayer["+i+"]",sf.gs.width+220,150+i*30);
}
//文字编辑
for (var i=10;i<20;i++)
{
drawEduTextSetting(f.uilayer[i].name.substr(0,5),"f.uilayer["+i+"]",40,70+(i-10)*30);
}
//数值编辑
for (var i=20;i<30;i++)
{
drawEduPicSetting(f.uilayer[i].name.substr(0,5),"f.uilayer["+i+"]",40,70+(i-10)*30);
}
[endscript]
[s]

*确认
[iscript]
//按钮
for (var i=0;i<10;i++)
{
f.config_edu[i+1]=f.uilayer[i].ButtonElm();
}
//文字
for (var i=10;i<20;i++)
{
f.config_edu[i+1]=f.uilayer[i].TextElm();
}
//图形
for (var i=20;i<30;i++)
{
f.config_edu[i+1]=f.uilayer[i].PicElm();
}

//保存
f.config_edu.saveStruct(sf.path+"map/"+f.eduname);
[endscript]

*关闭选单
[iscript]
delete f.uilayer;
[endscript]

[rclick enabled="false"]
[freeimage layer="3"]
[freeimage layer="4"]
[current layer="message3"]
[er]
[layopt layer="message3" visible="false"]
[jump storage="map_main.ks"]

*选择图片
[call storage="window_picture.ks"]
[jump target=*window]

*按钮设定
[call storage="window_mapbutton.ks"]
[jump target=*window]

*文字设定
[call storage="window_edutext.ks"]
[jump target=*window]

*图形设定
[call storage="window_edupic.ks"]
[jump target=*window]
