;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
*window
[window_middle width=400 height=370 title="显示姓名栏(NPC)"]

[line title="姓名" name="f.参数.id" x=30 y=50]
[line title="颜色" name="f.参数.color" x=30 y=80 type="color"]

[eval exp="drawFrame('同时显示',3,15,150,kag.fore.layers[5],314)"]
[line title="头像" name="f.参数.face" x=30 y=170 type="pic" path="face"]
[line title="角色" name="f.参数.fg" x=30 y=200 type="pic" path="fgimage"]
[line title="编号" name="f.参数.layer" x=30 y=230 type=list target="*选择前景层"]

[s]

*确认
[commit]
[eval exp="commitLine(f.参数)"]
[jump storage="tag_direct.ks" target=*擦除窗口]

*关闭选单
[jump storage="tag_direct.ks" target=*关闭选单]

*选择图片
[call storage="window_picture.ks"]
[jump target=*window]

*选择颜色
[call storage="window_color.ks"]
[jump target=*window]

*选择前景层
[list_fglayer x=34 y=230]
[s]

*关闭下拉菜单
[rclick enabled="false"]
[current layer="message6"]
[er]
[layopt layer="message6" visible="false"]
[jump target=*window]
