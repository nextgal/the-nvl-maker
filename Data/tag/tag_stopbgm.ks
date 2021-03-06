;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
[iscript]
//初始值设定
if (f.参数.time==void) f.参数.time=500;
[endscript]

*window
[window_middle width=400 height=300 title="停止音乐"]

[group title="停止音乐" name="f.参数.tagname" x=30 y=50 comp="stopbgm"]
[group title="音乐渐变" name="f.参数.tagname" x=30 y=80 comp="fadebgm"]
[group title="音乐渐出" name="f.参数.tagname" x=30 y=110 comp="fadeoutbgm"]

[if exp="f.参数.tagname=='fadeoutbgm'"]
[line title="时间" name="f.参数.time" x=30 y=150]
[elsif exp="f.参数.tagname=='fadebgm'"]
[line title="时间" name="f.参数.time" x=30 y=150]
[line title="音量" name="f.参数.volume" x=30 y=180]
[endif]

[s]

*确认
[commit]
[iscript]
//清理非必要参数
if (f.参数.tagname=="stopbgm") 
{
f.参数.time=void;
f.参数.volume=void;
}
else if (f.参数.tagname=="fadeoutbgm")
{
f.参数.volume=void;
}
[endscript]
[eval exp="commitLine(f.参数)"]
[jump storage="tag_direct.ks" target=*擦除窗口]

*关闭选单
[jump storage="tag_direct.ks" target=*关闭选单]
