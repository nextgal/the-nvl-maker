;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;--------------------------------------------------
;文字范围设定
;x,y,行数,行间距
;--------------------------------------------------
*window
[window_middle width=400 height=300 title="文字描绘范围设定"]
[line title="x" name="f.参数.left" x=30 y=50]
[line title="y" name="f.参数.top" x=30 y=80]
[line title="行数" name="f.参数.line" x=30 y=110]
[line title="行间距" name="f.参数.linespace" x=30 y=140]
[s]

*确认
[commit]

*关闭选单
[freeimage layer="5"]
[current layer="message5"]
[er]
[layopt layer="message5" visible="false"]
[return]
