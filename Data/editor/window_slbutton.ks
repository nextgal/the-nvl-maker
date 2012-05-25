;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;--------------------------------------------------
;存儲按鈕信息設定
;編號
;章節名
;日期
;使用/不使用新檔標記
;--------------------------------------------------
*window
[window_middle width=1000 height=650 title="存儲按鈕信息設定"]

[iscript]
drawFrame("檔案信息",7,30,50,kag.fore.layers[5],300);
drawFrame("新檔標記",4,30,310,kag.fore.layers[5],300);
drawFrame("遊戲截圖",4,30,480,kag.fore.layers[5],300);

drawFrame("章節名稱",5,350,50,kag.fore.layers[5],300);
drawFrame("存檔日期",5,350,250,kag.fore.layers[5],300);
drawFrame("對話記錄",7,670,50,kag.fore.layers[5],300);

[endscript]
[check title="使用" name="f.config_slpos.num.use" x=50 y=70]
[line title="相對位置" x=50 y=100]
[line title="x" name="f.config_slpos.num.x" x=50 y=130]
[line title="y" name="f.config_slpos.num.y" x=50 y=160]
[line title="字號" name="f.config_slpos.num.height" x=50 y=190]
[line title="前綴" name="f.config_slpos.num.pre" x=50 y=220]
[line title="後綴" name="f.config_slpos.num.after" x=50 y=250]
;-------------------------------------------------------------------------------
[check title="使用" name="f.config_slpos.lastsavemark.use" x=50 y=330]
[line title="相對位置（可為負）" x=50 y=360]
[line title="x" name="f.config_slpos.lastsavemark.x" x=50 y=390]
[line title="y" name="f.config_slpos.lastsavemark.y" x=50 y=420]
;-------------------------------------------------------------------------------
[check title="使用" name="f.config_slpos.bookmark.use" x=370 y=70]
[line title="相對位置" x=370 y=100]
[line title="x" name="f.config_slpos.bookmark.x" x=370 y=130]
[line title="y" name="f.config_slpos.bookmark.y" x=370 y=160]
[line title="字號" name="f.config_slpos.bookmark.height" x=370 y=190]
;-------------------------------------------------------------------------------
[check title="使用" name="f.config_slpos.date.use" x=370 y=270]
[line title="相對位置" x=370 y=300]
[line title="x" name="f.config_slpos.date.x" x=370 y=330]
[line title="y" name="f.config_slpos.date.y" x=370 y=360]
[line title="字號" name="f.config_slpos.date.height" x=370 y=390]
;-------------------------------------------------------------------------------
;使用
[check title="使用" name="f.config_slpos.smallsnap.use" x=50 y=500]
;相對位置
[line title="相對位置（為負時不會顯示在編輯器中）" x=50 y=530]
[line title="x" name="f.config_slpos.smallsnap.x" x=50 y=560]
[line title="y" name="f.config_slpos.smallsnap.y" x=50 y=590]
;-------------------------------------------------------------------------------
;使用
[check title="使用" name="f.config_slpos.history.use" x=690 y=70]
;相對位置
[line title="相對位置" x=690 y=100]
[line title="x" name="f.config_slpos.history.x" x=690 y=130]
[line title="y" name="f.config_slpos.history.y" x=690 y=160]

[line title="文字設定（目前僅支持單行）" x=690 y=190]
;;行數
;[line title="行數" name="f.config_slpos.history.line" x=350 y=560]
;;行間距
;[line title="行間距" name="f.config_slpos.history.linespace" x=350 y=590]
;字號
[line title="字號" name="f.config_slpos.history.height" x=690 y=220]
;每行字數
[line title="字數" name="f.config_slpos.history.num" x=690 y=250]
;-------------------------------------------------------------------------------
[s]

*確認
[commit]


*關閉選單
[freeimage layer="5"]
[current layer="message5"]
[er]
[layopt layer="message5" visible="false"]
[return]
