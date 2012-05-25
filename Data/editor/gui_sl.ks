;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;---------------------------------------------------------------
;存取版面設定窗口
;---------------------------------------------------------------
*start
[window_down width=&"sf.gs.width+200" height=&"sf.gs.height+100" title="存取版面設定"]
[iscript]

//以存儲版面為例
f.config_sl=f.config_save;
f.存儲=true;
f.讀取=false;

//創建固定的層
f.uilayer=[];
//簡單按鈕
f.uilayer[0]=new uiSLLayer(f.config_sl.up,f.config_slpos.up);
f.uilayer[1]=new uiSLLayer(f.config_sl.down,f.config_slpos.down);
f.uilayer[2]=new uiSLLayer(f.config_sl.back,f.config_slpos.back);
//懸停效果
//截圖
f.uilayer[3]=new uiSnapLayer(f.config_slpos.snapshot);
//章節
f.uilayer[4]=new uiTextLayer("第一章 章節名稱",f.config_slpos.drawmark,f.config_sl.draw.bookmark);
//日期
f.uilayer[5]=new uiTextLayer("0000/00/00 00:00",f.config_slpos.drawdate,f.config_sl.draw.date);
//對話
f.uilayer[6]=new uiTextLayer("對話記錄……",f.config_slpos.drawtalk,f.config_sl.draw.talk);
[endscript]

*update
[iscript]
//--------------------------------------------------------
//清空檔案按鈕層
for (var i=7;i<f.uilayer.count;i++)
{
  f.uilayer[i]=void;
}
//強制設定f.uilayer.count的值
f.uilayer.count=f.config_slpos.locate.count+7;
//--------------------------------------------------------
//重建
for (var i=0;i<f.config_slpos.locate.count;i++)
{
  f.uilayer[i+7]=new uiSLButton(i);
}
[endscript]
;---------------------------------------------------------------
*window
[window_down width=&"sf.gs.width+200" height=&"sf.gs.height+100" title="存取版面設定"]
[iscript]
//刷新畫面----------------------------------------------------------------------------------------
with(kag.fore.layers[3])
{
   .fillRect(20,50,sf.gs.width,sf.gs.height,0xFFC8C8C8);
}

//所有層全部不選中
      for (var i=0;i<f.config_slpos.locate.count+7;i++)
      {
         if (f.uilayer[i].select)
         {
           f.uilayer[i].select=false;
           f.uilayer[i].drawSelect();
         }
      }
//切換版面
if (f.存儲==true)
{
f.config_sl=f.config_save;
}
else
{
f.config_sl=f.config_load;
}
//--------------------------------------------
//背景重載
with(kag.fore.layers[4])
{
   .left=kag.fore.layers[3].left+20;
   .top=kag.fore.layers[3].top+50;
   .visible=true;
   .loadImages(%["storage"=>f.config_sl.bgd]);
   .width=sf.gs.width;
   .height=sf.gs.height;
}

[endscript]

;新檔標記
[freeimage page=fore layer=11]
[if exp="f.config_slpos.lastsavemark.use==true"]
[image layer=11 page=fore visible=true storage=&"f.config_sl.lastsavemark"]
[layopt layer=11 page=fore left=&"(int)kag.fore.layers[4].left+(int)f.config_slpos.locate[0][0]+(int)f.config_slpos.lastsavemark.x" top=&"(int)kag.fore.layers[4].top+(int)f.config_slpos.locate[0][1]+(int)f.config_slpos.lastsavemark.y"]
[endif]
[iscript]
//--------------------------------------------
//其他樣式重載
//簡單按鈕(改變造型)
f.uilayer[0].Reset(f.config_sl.up);
f.uilayer[1].Reset(f.config_sl.down);
f.uilayer[2].Reset(f.config_sl.back);
//截圖省略(改變顏色,字體樣式)
f.uilayer[4].Reset(f.config_sl.draw.bookmark);
f.uilayer[5].Reset(f.config_sl.draw.date);
f.uilayer[6].Reset(f.config_sl.draw.talk);
//--------------------------------------------
//重載存取按鈕內容
//改變造型,位置,內容文字...
for (var i=0;i<f.config_slpos.locate.count;i++)
{
  f.uilayer[i+7].Reset(i);
}
//-----------------------------------------------------------------------------------------
//設定界面
drawFrame("基本設定",5,sf.gs.width+40,50,kag.fore.layers[3],140);
//----基本設定----
//背景
[endscript]
[option title="存" name="f.存儲" x=&(sf.gs.width+65) y=65 false="f.讀取"]
[option title="取" name="f.讀取" x=&(sf.gs.width+115) y=65 false="f.存儲"]
[iscript]
//字體樣式
drawEdit("文字樣式",,sf.gs.width+55,95);
[endscript]
 [link hint="點此打開文字樣式設定窗口" target=*文字樣式]□[endlink]
[iscript]
drawSLsetting("上翻按鈕","f.uilayer[0]",sf.gs.width+60,125);
drawSLsetting("下翻按鈕","f.uilayer[1]",sf.gs.width+60,155);
drawSLsetting("返回按鈕","f.uilayer[2]",sf.gs.width+60,185);

drawFrame("懸停效果",4,sf.gs.width+40,250,kag.fore.layers[3],140);
//----懸停效果----
drawSLsetting("遊戲截圖","f.uilayer[3]",sf.gs.width+60,270);
drawSLsetting("章節名稱","f.uilayer[4]",sf.gs.width+60,300,"*懸停章節");
drawSLsetting("日期顯示","f.uilayer[5]",sf.gs.width+60,330,"*懸停日期");
drawSLsetting("對話記錄","f.uilayer[6]",sf.gs.width+60,360,"*懸停對話");

drawFrame("存檔按鈕",2,sf.gs.width+40,425,kag.fore.layers[3],140);
//----存檔按鈕----
//檔案設定-每頁檔案數及位置(頁數用setting去除)
drawEdit("檔案個數",,sf.gs.width+60,445);
[endscript]
 [link hint="點此打開存檔按鈕個數設定窗口" target=*檔案個數]□[endlink]
[iscript]
drawEdit("內容設定",,sf.gs.width+60,475);
[endscript]
 [link hint="點此打開存檔按鈕內容設定窗口" target=*內容設定]□[endlink]
[iscript]
drawFrame("當前坐標",1,sf.gs.width+40,540,kag.fore.layers[3],140);
[endscript]
[s]
;---------------------------------------------------------------
*檔案個數
[call storage="window_savedata.ks"]
[jump target=*update]
;---------------------------------------------------------------
*內容設定
[call storage="window_slbutton.ks"]
[jump target=*window]
;---------------------------------------------------------------
*文字樣式
[iscript]
//複製歷史記錄文字樣式
f.參數=new Dictionary();
(Dictionary.assign incontextof f.參數)(f.config_slpos.pagefont);
[endscript]
[eval exp="tf.允許設定字號=false"]
[eval exp="tf.允許設定顏色=false"]
[call storage="window_textstyle.ks"]
[iscript]
//回寫
(Dictionary.assign incontextof f.config_slpos.pagefont)(f.參數);
[endscript]
[jump target=*window]
;---------------------------------------------------------------
*懸停章節
[iscript]
f.參數=new Dictionary();
f.參數.size=f.uilayer[4].font.height;
[endscript]
[call storage="window_num.ks"]
[iscript]
//回寫
f.uilayer[4].font.height=f.參數.size;
[endscript]
[jump target=*window]

*懸停日期
[iscript]
f.參數=new Dictionary();
f.參數.size=f.uilayer[5].font.height;
[endscript]
[call storage="window_num.ks"]
[iscript]
//回寫
f.uilayer[5].font.height=f.參數.size;
[endscript]
[jump target=*window]

*懸停對話
[iscript]
f.參數=new Dictionary();
(Dictionary.assign incontextof f.參數)(f.config_slpos.drawtalk);
f.參數.size=f.uilayer[6].font.height;
[endscript]
[call storage="window_drawtalk.ks"]
[iscript]
//回寫
f.uilayer[6].font.height=f.參數.size;
f.config_slpos.drawtalk.count=f.參數.count;
f.config_slpos.drawtalk.space=f.參數.space;
[endscript]
[jump target=*window]
;---------------------------------------------------------------
*確認
[iscript]
//導出按鈕信息
f.config_slpos.up=f.uilayer[0].SLlayerElm();
f.config_slpos.down=f.uilayer[1].SLlayerElm();
f.config_slpos.back=f.uilayer[2].SLlayerElm();
f.config_slpos.snapshot=f.uilayer[3].SnapElm();

//懸停效果信息
f.config_slpos.drawmark=f.uilayer[4].TextElm();
f.config_slpos.drawdate=f.uilayer[5].TextElm();

//對話記錄
f.config_slpos.drawtalk.x=f.uilayer[6].left;
f.config_slpos.drawtalk.y=f.uilayer[6].top;
f.config_slpos.drawtalk.use=f.uilayer[6].visible;
f.config_slpos.drawtalk.size=f.uilayer[6].font.height;

//各SL按鈕的位置記錄
for (var i=0;i<f.config_slpos.locate.count;i++)
{
  f.config_slpos.locate[i][0]=f.uilayer[i+7].left;
  f.config_slpos.locate[i][1]=f.uilayer[i+7].top;
}

//保存
(Dictionary.saveStruct incontextof f.config_slpos)(sf.path+"macro/"+'uislpos.tjs');
[endscript]

*關閉選單
;重載字典
[iscript]
f.config_slpos=Scripts.evalStorage(sf.path+"macro/"+'uislpos.tjs');
delete f.uilayer;
[endscript]

[rclick enabled="false"]
[freeimage layer="3"]
[freeimage layer="4"]
[freeimage layer="5"]
[freeimage layer="11"]
[current layer="message3"]
[er]
[layopt layer="message3" visible="false"]
[jump storage="gui_main.ks"]
