;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
*window
[window_middle width=400 height=400 title="标记"]
[group title="等待" name="f.参数.tagname" x=30 y=50 comp="l"]
[group title="换行等待" name="f.参数.tagname" x=30 y=80 comp="lr"]
[group title="单纯换行" name="f.参数.tagname" x=30 y=110 comp="r"]
[group title="分页等待" name="f.参数.tagname" x=30 y=140 comp="w"]

[group title="文字样式还原" name="f.参数.tagname" x=30 y=210 comp="resetfont"]
[group title="确认输入" name="f.参数.tagname" x=30 y=240 comp="commit"]
[s]

*确认
[commit]
[eval exp="commitLine(f.参数)"]
[jump storage="tag_direct.ks" target=*擦除窗口]

*关闭选单
[jump storage="tag_direct.ks" target=*关闭选单]
