;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
*window
[window_middle width=400 height=300 title="畫面震動"]
[line title="時間" name="f.參數.time" x=30 y=50]
[line title="橫向幅度" name="f.參數.hmax" x=30 y=80]
[line title="縱向幅度" name="f.參數.vmax" x=30 y=110]
[s]

*確認
[commit]
[eval exp="commitLine(f.參數)"]
[jump storage="tag_direct.ks" target=*擦除窗口]

*關閉選單
[jump storage="tag_direct.ks" target=*關閉選單]
