;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
*window
[window_middle width=400 height=280 title="段落样式"]
[line title="对齐" x=30 y=50]
[group title="左" name="f.参数.align" x=80 y=50 comp="left"]
[group title="中" name="f.参数.align" x=140 y=50 comp="center"]
[group title="右" name="f.参数.align" x=200 y=50 comp="right"]
[line title="行间距" name="f.参数.linespacing" x=30 y=80]
[line title="字间距" name="f.参数.pitch" x=30 y=110]

[s]

*确认
[commit]
[eval exp="commitLine(f.参数)"]
[jump storage="tag_direct.ks" target=*擦除窗口]

*关闭选单
[jump storage="tag_direct.ks" target=*关闭选单]
