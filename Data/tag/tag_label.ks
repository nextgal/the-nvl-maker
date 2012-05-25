;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
*window
[window_middle width=400 height=300 title="插入標籤"]
[line title="標籤名" name="f.參數.label" x=30 y=50]
[check title="作為可存檔標籤" name="f.參數.cansave" x=30 y=80]
[line true="f.參數.cansave" title="章節名" name="f.參數.pagename" x=30 y=110]
[s]

*確認
[commit]
[iscript]
//防止出錯用
if (f.參數.cansave=="true") f.參數.cansave=true;
//假如去掉了可存檔標記,則不記錄章節名
if (f.參數.cansave==false) f.參數.pagename=void;
//假如缺乏必須值,自動加入
if (f.參數.label==void) f.參數.label="*label";
//假如參數開頭不是星號，強制加入星號
if (f.參數.label[0]!="*") f.參數.label="*"+f.參數.label;
[endscript]

[eval exp="commitLine(f.參數)"]
[jump storage="tag_direct.ks" target=*擦除窗口]

*關閉選單
[jump storage="tag_direct.ks" target=*關閉選單]
