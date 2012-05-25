;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
*window
[window_middle width=400 height=300 title="分歧結束"]

[group title="默認分歧" name="f.參數.tagname" x=30 y=50 comp="else"]
[group title="分歧結束" name="f.參數.tagname" x=30 y=80 comp="endif"]

[s]

*生成條件
[call storage="window_cond.ks"]
[jump target=*window]

*確認
[commit]
[eval exp="commitLine(f.參數)"]
[jump storage="tag_direct.ks" target=*擦除窗口]

*關閉選單
[jump storage="tag_direct.ks" target=*關閉選單]
