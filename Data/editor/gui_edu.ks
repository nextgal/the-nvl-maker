;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;---------------------------------------------------------------
;面板编辑窗口
;---------------------------------------------------------------
*start
[window_down width=&"sf.gs.width+370" height=&"sf.gs.height+100" title="养成面板"]
[iscript]
//新版背景图
f.uibacklayer=new uiBackLayer(f.config_edu[0].bgd);
//创建层
f.uilayer=[];

for (var i=0;i<f.config_edu.count-1;i++)
{
	var dic=f.config_edu[i+1];

	if (dic.ctype!=void)
	{
		switch (dic.ctype)
		{
			dm("layer"+i+","+dic.ctype);
			case "btn":
				f.uilayer[i]=new uiEduButtonLayer(f.config_edu[i+1]);
				break;
			case "text":
				f.uilayer[i]=new uiEduTextLayer(f.config_edu[i+1].name,f.config_edu[i+1]);
				break;
			case "pic":
				f.uilayer[i]=new uiEduPicLayer(f.config_edu[i+1].name,f.config_edu[i+1]);
				break;
		}
	}
	else
	{
		if (i<10)
		{
			dm("layer"+i+","+"btn");
			f.uilayer[i]=new uiEduButtonLayer(f.config_edu[i+1]);
		}
		else if (i<20)
		{
			dm("layer"+i+","+"text");
			f.uilayer[i]=new uiEduTextLayer(f.config_edu[i+1].name,f.config_edu[i+1]);
		}
		else
		{
			dm("layer"+i+","+"pic");
			f.uilayer[i]=new uiEduPicLayer(f.config_edu[i+1].name,f.config_edu[i+1]);
		}
	}
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

var start_y=125;

drawFrame("基本设定",1,sf.gs.width+200,start_y,kag.fore.layers[3],140);
drawBackLayerSetting("背景图形","f.uibacklayer",sf.gs.width+230,start_y+20);
DrawPosFrame(200,50);
//--------------------------------------------------------
var start_y=200;

drawFrame("按钮设定",10,sf.gs.width+200,start_y,kag.fore.layers[3],140);

//按钮编辑
for (var i=0;i<10;i++)
{
	drawEduButtonSetting(f.uilayer[i].name.substr(0,5),"f.uilayer["+i+"]",sf.gs.width+220,start_y+20+i*30);
}

//--------------------------------------------------------
var start_y=50;

drawFrame("文字控件",10,20,start_y,kag.fore.layers[3],140);
//文字编辑
for (var i=10;i<20;i++)
{
	drawEduTextSetting(f.uilayer[i].name.substr(0,5),"f.uilayer["+i+"]",40,start_y+20+(i-10)*30);
}

//--------------------------------------------------------
var start_y=50+50+30*10;

drawFrame("图形控件",10,20,start_y,kag.fore.layers[3],140);
//数值编辑
for (var i=20;i<30;i++)
{
	drawEduPicSetting(f.uilayer[i].name.substr(0,5),"f.uilayer["+i+"]",40,start_y+20+(i-20)*30);
}

[endscript]
[s]

*确认
[iscript]
//背景信息
f.config_edu[0].bgd=f.uibacklayer.LayerElm();
//控件信息
for (var i=0;i<f.uilayer.count;i++)
{
	f.config_edu[i+1]=f.uilayer[i].LayerElm();
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

*背景设定
[call storage="window_bgd.ks"]
[jump target=*window]

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
