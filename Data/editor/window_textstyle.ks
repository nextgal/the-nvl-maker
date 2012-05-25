;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;--------------------------------------------------
;文字樣式設定,包括除了字體以外的其他項目
;字號，加粗，陰影，邊緣，（顏色視條件而定）
;--------------------------------------------------
*window
[window_middle width=400 height=300 title="文字樣式設定"]

[if exp="tf.允許設定字號!=false"]
[line title="字號" name="f.參數.size" x=30 y=140]
[endif]

[if exp="tf.允許設定顏色!=false"]
[line title="顏色" name="f.參數.color" type="color" x=30 y=170]
[endif]

[check title="加粗" name="f.參數.bold" x=30 y=50]
[check title="斜體" name="f.參數.italic" x=130 y=50]

[option title="陰影" name="f.參數.shadow" x=30 y=80 false="f.參數.edge"]

[line title="" name="f.參數.shadowcolor" type="color" x=80 y=80 true="f.參數.shadow" length=174]
[option title="邊緣" name="f.參數.edge" x=30 y=110 false="f.參數.shadow"]
[line title="" name="f.參數.edgecolor" type="color" x=80 y=110 true="f.參數.edge" length=174]
[s]

*選擇顏色
[call storage="window_color.ks"]
[jump target=*window]

*確認
[commit]

*關閉選單
[freeimage layer="5"]
[current layer="message5"]
[er]
[layopt layer="message5" visible="false"]
[eval exp="delete tf.允許設定字號"]
[eval exp="delete tf.允許設定顏色"]
[return]
