;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
*window
[window_middle width=690 height=450 title="显示背景"]

[eval exp="drawFrame('基本信息',2,15,40,kag.fore.layers[5],314)"]
[line title="文件" name="f.参数.storage" x=30 y=60 type="pic" path="bgimage"]
[check title="消除话框" name="f.参数.hidemes" x=30 y=90]
[check title="消除前景" name="f.参数.clfg" x=170 y=90]

[eval exp="drawFrame('显示效果',5,15,150,kag.fore.layers[5],314)"]
[frame_trans x=30 y=170]

[eval exp="drawFrame('特殊效果',3,345,40,kag.fore.layers[5],314)"]
[check title="黑白" name="f.参数.grayscale" x=360 y=60]
[check title="反色" name="f.参数.convert" x=500 y=60]
[line title="蒙板色" name="f.参数.mcolor" x=360 y=90 type="color"]
[line title="蒙板透明度" name="f.参数.mopacity" x=360 y=120]

[eval exp="drawFrame('显示人物',3,345,180,kag.fore.layers[5],314)"]
[line title="左" name="f.参数.l" x=360 y=200 type="pic" path="fgimage"]
[line title="中" name="f.参数.c" x=360 y=230 type="pic" path="fgimage"]
[line title="右" name="f.参数.r" x=360 y=260 type="pic" path="fgimage"]

[s]

*确认
[commit]
[eval exp="commitLine(f.参数)"]
[jump storage="tag_direct.ks" target=*擦除窗口]

*关闭选单
[jump storage="tag_direct.ks" target=*关闭选单]

;-----------------------------------------------------------------
*切换方式
[list_method x=34 y=200]
[s]

*卷动方向
[list_from x=34 y=230]
[s]

*背景停留
[list_stay x=34 y=260]
[s]

*关闭下拉菜单
[rclick enabled="false"]
[current layer="message6"]
[er]
[layopt layer="message6" visible="false"]
[jump target=*window]
;-----------------------------------------------------------------
*选择图片
[call storage="window_picture.ks"]
[jump target=*window]

*选择颜色
[call storage="window_color.ks"]
[jump target=*window]
