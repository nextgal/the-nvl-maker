;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;--------------------------------------------------
;养成面板文字设定
;--------------------------------------------------
*window
[window_middle width=400 height=580 title="文字设定"]

[iscript]
drawFrame("显示设定",3,15,40,kag.fore.layers[5],314);
drawFrame("文字样式",9,15,175,kag.fore.layers[5],314);
[endscript]

[line title="名称" name="f.参数.name" x=30 y=60]
[line title="条件" name="f.参数.cond" type="cond" x=30 y=90]
[line title="变数" name="f.参数.flagname" x=30 y=120]
;
[line title="x" name="f.参数.x" x=30 y=195]
[line title="y" name="f.参数.y" x=30 y=225]
[line title="行高" name="f.参数.lineheight" x=30 y=255]

;
[line title="字体" name="f.参数.fontname" type="font" x=30 y=285]
[line title="字号" name="f.参数.size" x=30 y=315]
[line title="颜色" name="f.参数.color" type="color" x=30 y=345]
[check title="加粗" name="f.参数.bold" x=30 y=375]

[option title="阴影" name="f.参数.shadow" x=30 y=405 false="f.参数.edge"]
[line title="" name="f.参数.shadowcolor" type="color" x=80 y=405 true="f.参数.shadow" length=174]
[option title="边缘" name="f.参数.edge" x=30 y=435 false="f.参数.shadow"]
[line title="" name="f.参数.edgecolor" type="color" x=80 y=435 true="f.参数.edge" length=174]


[s]

*确认
[commit]
[eval exp=&"tf.当前操作层+'.Reset(f.参数)'"]

*关闭选单
[freeimage layer="5"]
[current layer="message5"]
[er]
[layopt layer="message5" visible="false"]
[return]

*生成条件
[call storage="window_cond.ks"]
[jump target=*window]

*选择颜色
[call storage="window_color.ks"]
[jump target=*window]

*选择字体
[call storage="window_font.ks"]
[jump target=*window]

