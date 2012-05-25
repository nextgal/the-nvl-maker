;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
*start
[window_down width=&"sf.gs.width+200" height=&"sf.gs.height+100" title="CG界面編輯"]

[iscript]
//載入CG界面配置表
f.config_cgmode=Scripts.evalStorage(sf.path+"macro/"+'uicgmode.tjs');

//新建顯示用層
f.uilayer=[];

//按鈕
f.uilayer[0]=new uiButtonLayer(f.config_cgmode.up);
f.uilayer[1]=new uiButtonLayer(f.config_cgmode.down);
f.uilayer[2]=new uiButtonLayer(f.config_cgmode.back);

[endscript]

*update
[iscript]
//--------------------------------------------------------
//清空檔案按鈕層
for (var i=3;i<f.uilayer.count;i++)
{
  f.uilayer[i]=void;
}
//強制設定f.uilayer.count的值
f.uilayer.count=f.config_cgmode.locate.count+3;
//--------------------------------------------------------
//重建
for (var i=0;i<f.config_cgmode.locate.count;i++)
{
  f.uilayer[i+3]=new uiCgThumLayer(f.config_cgmode.locate[i]);
}

[endscript]

*window
[window_down width=&"sf.gs.width+200" height=&"sf.gs.height+100" title="CG界面編輯"]


[iscript]
with(kag.fore.layers[3])
{
   .fillRect(20,50,sf.gs.width,sf.gs.height,0xFFC8C8C8);
}
//背景重載
with(kag.fore.layers[4])
{
   .left=kag.fore.layers[3].left+20;
   .top=kag.fore.layers[3].top+50;
   .visible=true;
   .loadImages(%["storage"=>f.config_cgmode.bgd]);
   .width=sf.gs.width;
   .height=sf.gs.height;
}

//--------------------------------------------------------
//刷新圖層
      //所有層全部不選中
      for (var i=0;i<f.config_cgmode.locate.count+3;i++)
      {
         if (f.uilayer[i].select==true)
         {
           f.uilayer[i].select=false;
           f.uilayer[i].drawSelect();
         }
      }
//--------------------------------------------------------
drawFrame("基本設定",3,sf.gs.width+40,50,kag.fore.layers[3],140);

drawEdit("背景圖形",,sf.gs.width+70,70);drawLink_Picwin("f.config_cgmode.bgd","others",,);
drawEdit("略圖大小",,sf.gs.width+70,100);drawLink_Picwin("f.config_cgmode.thum.normal","others",,);
drawEdit("每頁圖數",,sf.gs.width+70,130);
[endscript]
 [link hint="點此打開CG縮略圖數量設定窗口" target=*縮略圖數量]□[endlink]
[iscript]

drawFrame("控件設定",3,sf.gs.width+40,190,kag.fore.layers[3],140);
drawButtonSetting("上翻按鈕","f.uilayer[0]",sf.gs.width+50,210);
drawButtonSetting("下翻按鈕","f.uilayer[1]",sf.gs.width+50,240);
drawButtonSetting("返回按鈕","f.uilayer[2]",sf.gs.width+50,270);
//--------------------------------------------------------
drawFrame("當前坐標",1,sf.gs.width+40,540,kag.fore.layers[3],140);
[endscript]
[s]

*縮略圖數量
[call storage="window_cgthum.ks"]
[jump target=*update]

*選擇圖片
[call storage="window_picture.ks"]
[jump target=*update]

*按鈕設定
[call storage="window_sysbutton.ks"]
[jump target=*window]

*確認

[iscript]
//按鈕信息
f.config_cgmode.up=f.uilayer[0].ButtonElm();
f.config_cgmode.down=f.uilayer[1].ButtonElm();
f.config_cgmode.back=f.uilayer[2].ButtonElm();

//各縮略圖的位置記錄
for (var i=0;i<f.config_cgmode.locate.count;i++)
{
  f.config_cgmode.locate[i][0]=f.uilayer[i+3].left;
  f.config_cgmode.locate[i][1]=f.uilayer[i+3].top;
}
//保存
(Dictionary.saveStruct incontextof f.config_cgmode)(sf.path+"macro/"+'uicgmode.tjs');
[endscript]

*關閉選單
;重載字典
[iscript]
f.config_cgmode=Scripts.evalStorage(sf.path+"macro/"+'uicgmode.tjs');
delete f.uilayer;
[endscript]

[rclick enabled="false"]
[freeimage layer="3"]
[freeimage layer="4"]
[current layer="message3"]
[er]
[layopt layer="message3" visible="false"]
[jump storage="gui_main.ks"]
