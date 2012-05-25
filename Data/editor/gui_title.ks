;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;---------------------------------------------------------------
;標題畫面設定窗口
;---------------------------------------------------------------
*start
[window_down width=&"sf.gs.width+200" height=&"sf.gs.height+100" title="標題畫面設定"]
[iscript]
//新建顯示用層
f.uilayer=[];
f.uilayer[0]=new uiButtonLayer(f.config_title.start);
f.uilayer[1]=new uiButtonLayer(f.config_title.load);
f.uilayer[2]=new uiButtonLayer(f.config_title.extra);
f.uilayer[3]=new uiButtonLayer(f.config_title.exit);

if (f.config_title.option!=void) //新版模板的情況下
{
 f.uilayer[4]=new uiButtonLayer(f.config_title.option);
 f.uilayer[5]=new uiButtonLayer(f.config_title.omake);
}
[endscript]

*window
[window_down width=&"sf.gs.width+200" height=&"sf.gs.height+100" title="標題畫面設定"]

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
   .loadImages(%["storage"=>f.config_title.bgd]);
   .width=sf.gs.width;
   .height=sf.gs.height;
}
//--------------------------------------------------------
//前景圖層
if (f.config_title.front!=void) with(kag.fore.layers[11])
{
   .left=kag.fore.layers[4].left;
   .top=kag.fore.layers[4].top;
   .visible=true;
   .loadImages(%["storage"=>f.config_title.front]);
}
//--------------------------------------------------------
//刷新圖層
      //所有層全部不選中
      for (var i=0;i<f.uilayer.count;i++)
      {
         if (f.uilayer[i].select)
         {
           f.uilayer[i].select=false;
           f.uilayer[i].drawSelect();
         }
      }
//--------------------------------------------------------
drawFrame("基本設定",6,sf.gs.width+40,50,kag.fore.layers[3],140);
drawEdit("小組標誌",,sf.gs.width+70,70);
drawLink_Picwin("f.config_title.logo","others",,);
drawEdit("背景圖形",,sf.gs.width+70,100);
drawLink_Picwin("f.config_title.bgd","others",,);

drawEdit("背景音樂",,sf.gs.width+70,130);
drawLink_Win("f.config_title.bgm","music");

drawEdit("畫面特效",,sf.gs.width+70,160);
[endscript]
 [link hint="點此打開畫面特效設定窗口" target=*選擇特效]□[endlink]
[iscript]

drawEdit("前景圖片",,sf.gs.width+70,190);
drawLink_Picwin("f.config_title.front","others",,);

drawFrame("按鈕",7,sf.gs.width+40,280,kag.fore.layers[3],140);
drawButtonSetting("開始遊戲","f.uilayer[0]",sf.gs.width+50,300);
drawButtonSetting("讀取進度","f.uilayer[1]",sf.gs.width+50,330);
drawButtonSetting("特別模式","f.uilayer[2]",sf.gs.width+50,360);
drawButtonSetting("離開遊戲","f.uilayer[3]",sf.gs.width+50,390);

if (f.config_title.option!=void)
{
  drawButtonSetting("系統設定","f.uilayer[4]",sf.gs.width+50,420);
  drawButtonSetting("CG模式","f.uilayer[5]",sf.gs.width+50,450);
}
//--------------------------------------------------------
drawFrame("當前坐標",1,sf.gs.width+40,540,kag.fore.layers[3],140);
[endscript]
[s]

*選擇圖片
[call storage="window_picture.ks"]
[jump target=*window]

*按鈕設定
[call storage="window_sysbutton.ks"]
[jump target=*window]

*選擇音聲
[call storage="window_bgm.ks"]
[jump target=*window]

*選擇特效
[call storage="window_weather.ks"]
[jump target=*window]

*確認
[iscript]
f.config_title.start=f.uilayer[0].ButtonElm();
f.config_title.load=f.uilayer[1].ButtonElm();
f.config_title.extra=f.uilayer[2].ButtonElm();
f.config_title.exit=f.uilayer[3].ButtonElm();
if (f.config_title.option!=void)
{
 f.config_title.option=f.uilayer[4].ButtonElm();
  f.config_title.omake=f.uilayer[5].ButtonElm();
}
(Dictionary.saveStruct incontextof f.config_title)(sf.path+"macro/"+'uititle.tjs');
[endscript]

*關閉選單
;重載字典
[iscript]
f.config_title=Scripts.evalStorage(sf.path+"macro/"+'uititle.tjs');
delete f.uilayer;
[endscript]

[rclick enabled="false"]
[freeimage layer="3"]
[freeimage layer="4"]
[freeimage layer="11"]
[current layer="message3"]
[er]
[layopt layer="message3" visible="false"]
[jump storage="gui_main.ks"]
