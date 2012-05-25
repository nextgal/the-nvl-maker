;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;--------------------------------------------------
;默認選項按鈕設定,包括x,y,normal,over,on幾個選項
;--------------------------------------------------
*window
[window_down width=400 height=520 title="默認選項按鈕設定"]

[line title="按鈕圖形" x=30 y=40]
[line title="一般" name="f.setting.selbutton.normal" type="pic" path="others" x=30 y=70]
[line title="選中" name="f.setting.selbutton.over" type="pic" path="others" x=30 y=100 copyfrom="f.setting.selbutton.normal"]
[line title="按下" name="f.setting.selbutton.on" type="pic" path="others" x=30 y=130 copyfrom="f.setting.selbutton.over"]
[line title="選項文字" x=30 y=160]
[line title="字號" name="f.setting.selfont.height" x=30 y=190]
[line title="一般" name="f.setting.selfont.normal" type="color" x=30 y=220]
[line title="選中" name="f.setting.selfont.over" type="color" x=30 y=250 copyfrom="f.setting.selfont.normal"]
[line title="按下" name="f.setting.selfont.on" type="color" x=30 y=280 copyfrom="f.setting.selfont.over"]
[line title="既讀" name="f.setting.selfont.read" type="color" x=30 y=310 copyfrom="f.setting.selfont.on"]
[line title="音效設定" x=30 y=340]
[line title="選中" name="f.setting.selbutton.enterse" x=30 y=370 type="sound"]
[line title="按下" name="f.setting.selbutton.clickse" x=30 y=400 type="sound"]
[s]

*選擇圖片
[call storage="window_picture.ks"]
[jump target=*window]

*選擇顏色
[call storage="window_color.ks"]
[jump target=*window]

*選擇音聲
[call storage="window_bgm.ks"]
[jump target=*window]

*確認
;保存當前f.setting內容
[commit]
[iscript]
(Dictionary.saveStruct incontextof f.setting)(sf.path+"macro/"+'setting.tjs');
[endscript]

*關閉選單
;重載f.setting內容
[iscript]
f.setting=Scripts.evalStorage(sf.path+"macro/"+'setting.tjs');
[endscript]

[rclick enabled="false"]
[freeimage layer="3"]
[freeimage layer="4"]
[current layer="message3"]
[er]
[layopt layer="message3" visible="false"]
[jump storage="gui_main.ks"]
