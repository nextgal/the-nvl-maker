;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;---------------------------------------------------------------
;编辑器设定
;---------------------------------------------------------------
*window
[window_up width=450 height=200 title="默认打开"]
[line title="工程" name="sf.project" x=30 y=50]
[s]

*确认
[commit]

*关闭选单
[eval exp="f.window=''"]
[rclick enabled="false"]
[freeimage layer="7"]
[current layer="message7"]
[er]
[layopt layer="message7" visible="false"]
[jump storage="first.ks" target=*window]
