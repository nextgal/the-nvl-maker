;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
*window
[window_middle width=400 height=200 title="插入注释"]
[line title="内容" name="f.参数.text" x=30 y=50]

[s]

*确认
[commit]
[iscript]
if (f.参数.text!=void)
{
   if (f.参数.text[0]!=";") f.参数.text=";"+f.参数.text;
}
[endscript]
[eval exp="commitLine(f.参数)"]
[jump storage="tag_direct.ks" target=*擦除窗口]

*关闭选单
[jump storage="tag_direct.ks" target=*关闭选单]
