;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
*window
[window_middle width=690 height=370 title="顯示頭像"]

[eval exp="drawFrame('基本信息',2,15,40,kag.fore.layers[5],314)"]
[line title="文件" name="f.參數.storage" x=30 y=60 type="pic" path="face"]
[line title="透明度" name="f.參數.opacity" x=30 y=90]
[eval exp="drawFrame('顯示效果',5,15,150,kag.fore.layers[5],314)"]
[frame_trans x=30 y=170]

[eval exp="drawFrame('同時顯示人物',2,345,40,kag.fore.layers[5],314)"]
[line title="文件" name="f.參數.fg" x=360 y=60 type="pic" path="fgimage"]
[line title="編號" name="f.參數.layer" x=360 y=90 type=list target="*選擇前景層"]
[s]

*確認
[commit]
[eval exp="commitLine(f.參數)"]
[jump storage="tag_direct.ks" target=*擦除窗口]

*關閉選單
[jump storage="tag_direct.ks" target=*關閉選單]

;-----------------------------------------------------------------
*切換方式
[list_method x=34 y=200]
[s]

*捲動方向
[list_from x=34 y=230]
[s]

*背景停留
[list_stay x=34 y=260]
[s]

*選擇前景層
[list_fglayer x=364 y=90]
[s]

*關閉下拉菜單
[rclick enabled="false"]
[current layer="message6"]
[er]
[layopt layer="message6" visible="false"]
[jump target=*window]
;-----------------------------------------------------------------
*選擇圖片
[call storage="window_picture.ks"]
[jump target=*window]

