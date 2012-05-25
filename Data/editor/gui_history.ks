;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;---------------------------------------------------------------
;歷史記錄設定窗口
;背景,文字樣式,文字區域
;上下按鈕,返回按鈕,滾動條
;---------------------------------------------------------------
*start
[window_down width=&"sf.gs.width+200" height=&"sf.gs.height+100" title="對話履歷界面設定"]
[iscript]
//防止出錯用
if (f.config_history.slider.width==void) f.config_history.slider.width=20;
if (f.config_history.slider.height==void) f.config_history.slider.height=100;
if (f.config_history.slider.over==void) f.config_history.slider.over=f.config_history.slider.normal;

//新建顯示用層
f.uilayer=[];
f.uilayer[0]=new uiButtonLayer(f.config_history.up);
f.uilayer[1]=new uiButtonLayer(f.config_history.down);
f.uilayer[2]=new uiButtonLayer(f.config_history.back);
f.uilayer[3]=new uiScrollLayer(f.config_history.slider);
[endscript]

*window
[window_down width=&"sf.gs.width+200" height=&"sf.gs.height+100" title="系統界面版面設定"]

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
   .loadImages(%["storage"=>f.config_history.bgd]);
   .width=sf.gs.width;
   .height=sf.gs.height;
}
//描繪文字
demoHistory();
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
drawFrame("基本設定",2,sf.gs.width+40,50,kag.fore.layers[3],140);
drawEdit("背景圖形",,sf.gs.width+70,70);drawLink_Picwin("f.config_history.bgd","others",,);
drawEdit("文字範圍",,sf.gs.width+70,100);
[endscript]
 [link hint="點此打開文字範圍設定窗口" target=*文字範圍]□[endlink]
 
[iscript]
drawFrame("控件設定",4,sf.gs.width+40,160,kag.fore.layers[3],140);
drawButtonSetting("上翻按鈕","f.uilayer[0]",sf.gs.width+50,180);
drawButtonSetting("下翻按鈕","f.uilayer[1]",sf.gs.width+50,210);
drawButtonSetting("返回按鈕","f.uilayer[2]",sf.gs.width+50,240);
//滾動條
       drawCheck("滾動條","f.uilayer[3].visible",sf.gs.width+50,270);
[endscript]
 [link hint="點此打開滾動條樣式設定窗口" target=*滾動條]□[endlink]
[iscript]
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

*文字範圍
[iscript]
f.參數=new Dictionary();
f.參數.frame=f.config_history.bgd;
f.參數.marginl=f.config_history.marginl;
f.參數.marginr=f.config_history.marginr;
f.參數.margint=f.config_history.margint;
f.參數.marginb=f.config_history.marginb;
[endscript]
;[call storage="window_textscale.ks"]
;[iscript]
;f.config_history.left=(int)f.參數.left;
;f.config_history.top=(int)f.參數.top;
;f.config_history.line=(int)f.參數.line;
;f.config_history.linespace=(int)f.參數.linespace;
;[endscript]
[call storage="window_margin.ks"]
[iscript]
f.config_history.marginl=f.參數.marginl;
f.config_history.marginr=f.參數.marginr;
f.config_history.margint=f.參數.margint;
f.config_history.marginb=f.參數.marginb;
[endscript]
[jump target=*window]

*文字樣式
[iscript]
//複製歷史記錄文字樣式
f.參數=new Dictionary();
(Dictionary.assign incontextof f.參數)(f.config_history.font);
[endscript]
[eval exp="tf.允許設定顏色=false"]
[eval exp="tf.允許設定字號=true"]
[call storage="window_textstyle.ks"]
[iscript]
//回寫
(Dictionary.assign incontextof f.config_history.font)(f.參數);
[endscript]
[jump target=*window]

*滾動條
[iscript]
tf.當前操作層="f.uilayer[3]";
f.參數=f.uilayer[3].ScrollElm();
[endscript]
[call storage="window_scroll.ks"]
[jump target=*window]

*確認
[iscript]
//按鈕,滾動條信息
f.config_history.up=f.uilayer[0].ButtonElm();
f.config_history.down=f.uilayer[1].ButtonElm();
f.config_history.back=f.uilayer[2].ButtonElm();
f.config_history.slider=f.uilayer[3].ScrollElm();
//保存
(Dictionary.saveStruct incontextof f.config_history)(sf.path+"macro/"+'uihistory.tjs');
[endscript]

*關閉選單
;重載字典
[iscript]
f.config_history=Scripts.evalStorage(sf.path+"macro/"+'uihistory.tjs');
delete f.uilayer;
[endscript]

[rclick enabled="false"]
[freeimage layer="3"]
[freeimage layer="4"]
[current layer="message3"]
[er]
[layopt layer="message3" visible="false"]
[jump storage="gui_main.ks"]
