;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
*window
[window_middle width=400 height=300 title="條件分歧"]

[group title="條件分歧" name="f.參數.tagname" x=30 y=50 comp="if"]
[group title="繼續分歧" name="f.參數.tagname" x=30 y=80 comp="elsif"]
;[group title="繼續分歧" name="f.參數.tagname" x=30 y=110 comp="else"]

[line title="條件" name="f.參數.exp" type="cond" x=30 y=140]

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
