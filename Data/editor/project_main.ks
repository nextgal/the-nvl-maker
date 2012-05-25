;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;---------------------------------------------------------------
;遊戲工程設定
;---------------------------------------------------------------
*start
[iscript]
//每次切換到此畫面時，重載
f.setting=getConfig();
[endscript]

*window
[eval exp="drawPageBoard()"]
;---------------------------------------------------------------
[unlocklink]
[current layer="message1"]
[er]
[nowait]
;---------------------------------------------------------------
;自定義
;---------------------------------------------------------------
[frame title="系統設定" line=2 x=15 y=15]
[line title="標題" name="f.setting.title" x=30 y=35]
[line title="啟動畫面" name="f.setting.startfrom" type="script" x=30 y=65]

[frame title="畫面大小" line=2 x=15 y=125]
[line title="寬度" name="f.setting.width" x=30 y=145]
[line title="高度" name="f.setting.height" x=30 y=175]

[frame title="選項音效" x=15 y=235 line=2]
[line title="選中" name="f.setting.selbutton.enterse" x=30 y=260 type="sound"]
[line title="按下" name="f.setting.selbutton.clickse" x=30 y=290 type="sound"]

[frame title="選項按鈕" x=345 y=15 line=3]
[line title="一般" name="f.setting.selbutton.normal" type="pic" path="others" x=360 y=35]
[line title="選中" name="f.setting.selbutton.over" type="pic" path="others" x=360 y=65 copyfrom="f.setting.selbutton.normal"]
[line title="按下" name="f.setting.selbutton.on" type="pic" path="others" x=360 y=95 copyfrom="f.setting.selbutton.over"]

[frame title="選項文字" x=345 y=155 line=5]
[line title="字號" name="f.setting.selfont.height" x=360 y=175]
[line title="一般" name="f.setting.selfont.normal" type="color" x=360 y=205]
[line title="選中" name="f.setting.selfont.over" type="color" x=360 y=235 copyfrom="f.setting.selfont.normal"]
[line title="按下" name="f.setting.selfont.on" type="color" x=360 y=265 copyfrom="f.setting.selfont.over"]
[line title="既讀" name="f.setting.selfont.read" type="color" x=360 y=295 copyfrom="f.setting.selfont.on"]

;---------------------------------------------------------------
;保存與重載按鈕
;---------------------------------------------------------------
[frame title="記錄" line=1 x=15 y=345]
[locate x=50 y=370]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*保存設定]
[eval exp="drawButtonCaption('保存設定',16)"]
[locate x=190 y=370]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*放棄修改]
[eval exp="drawButtonCaption('放棄修改',16)"]
[s]

*選擇音聲
[call storage="window_bgm.ks"]
[jump target=*window]

*選擇文件
[call storage="window_file.ks"]
[jump target=*window]

*選擇圖片
[call storage="window_picture.ks"]
[jump target=*window]

*選擇顏色
[call storage="window_color.ks"]
[jump target=*window]

*選擇字體
[call storage="window_font.ks"]
[jump target=*window]

*關閉下拉菜單
[rclick enabled="false"]
[current layer="message4"]
[er]
[layopt layer="message4" visible="false"]
[jump target=*window]

*保存設定
[commit]
[iscript]
//將「文字」->數值
f.setting.width=(int)f.setting.width;
f.setting.height=(int)f.setting.height;

//確保分辨率最小值
if (f.setting.width<800) f.setting.width=800;
if (f.setting.height<600) f.setting.height=600;

 //根據設定改變分辨率
sf.gs.width=f.setting.width;
sf.gs.height=f.setting.height;

 //保存自定義內容
 (Dictionary.saveStruct incontextof f.setting)(sf.path+"macro/"+"setting.tjs");
 //保存config.tjs內容
 saveConfig();
 
 //重寫start.ks.從新標題啟動
 rewriteStart(f.setting.startfrom);

[endscript]
[jump target=*window]

*放棄修改
[iscript]
//重載
f.setting=getConfig();
[endscript]
[jump target=*window]
