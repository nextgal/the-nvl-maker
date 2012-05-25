;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
*window
[window_middle width=400 height=280 title="消除對話"]
[group title="清空當前文字層" name="f.參數.tagname" x=30 y=50 comp="er"]
[group title="清空全部文字層" name="f.參數.tagname" x=30 y=80 comp="cm"]
[group title="清空全部文字層並復位" name="f.參數.tagname" x=30 y=110 comp="ct"]
[s]

*確認
[commit]
[eval exp="commitLine(f.參數)"]
[jump storage="tag_direct.ks" target=*擦除窗口]

*關閉選單
[jump storage="tag_direct.ks" target=*關閉選單]
