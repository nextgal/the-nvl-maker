;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;--------------------------------------------------
;文字範圍設定
;x,y,行數,行間距
;--------------------------------------------------
*window
[window_middle width=400 height=300 title="對話記錄文字樣式"]
[line title="字號" name="f.參數.size" x=30 y=50]
[line title="行間距" name="f.參數.space" x=30 y=80]
[line title="每行字數" name="f.參數.count" x=30 y=110]
[s]

*確認
[commit]

*關閉選單
[freeimage layer="5"]
[current layer="message5"]
[er]
[layopt layer="message5" visible="false"]
[return]
