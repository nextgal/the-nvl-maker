;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;--------------------------------------------------
;养成按钮设定
;--------------------------------------------------
*window
[window_middle width=700 height=470 title="养成按钮设定"]
[iscript]
drawFrame("显示设定",2,15,40,kag.fore.layers[5],314);
drawFrame("按钮图形",5,15,145,kag.fore.layers[5],314);

drawFrame("按钮音效",2,345,40,kag.fore.layers[5],314);
drawFrame("鼠标动作",2,345,145,kag.fore.layers[5],314);
drawFrame("执行操作",3,345,250,kag.fore.layers[5],314);
[endscript]

[line title="名称" name="f.参数.name" x=30 y=60]
[line title="条件" name="f.参数.cond" type="cond" x=30 y=90]

[line title="x" name="f.参数.x" x=30 y=165]
[line title="y" name="f.参数.y" x=30 y=195]
[line title="一般" name="f.参数.normal" x=30 y=225 type="pic" path="map"]
[line title="选中" name="f.参数.over" x=30 y=255 type="pic" path="map" copyfrom="f.参数.normal"]
[line title="按下" name="f.参数.on" x=30 y=285 type="pic" path="map" copyfrom="f.参数.over"]

[line title="选中SE" name="f.参数.enterse" x=360 y=60 type="sound"]
[line title="按下SE" name="f.参数.clickse" x=360 y=90 type="sound"]

[line title="鼠标移入" name="f.参数.onenter" x=360 y=165]
[line title="鼠标移出" name="f.参数.onleave" x=360 y=195]

[line title="剧本" name="f.参数.storage" x=360 y=270 type="script"]
[line title="标签" name="f.参数.target" x=360 y=300]
[line title="表达式" name="f.参数.exp" x=360 y=330]
[s]

*生成条件
[call storage="window_cond.ks"]
[jump target=*window]

*选择图片
[call storage="window_picture.ks"]
[jump target=*window]

*选择音声
[call storage="window_bgm.ks"]
[jump target=*window]

*选择文件
[call storage="window_file.ks"]
[jump target=*window]

*确认
[commit]
[iscript]
//防止出错用——假如参数开头不是星号，强制加入星号
f.参数.target=check_target(f.参数.target);
[endscript]
[eval exp=&"tf.当前操作层+'.Reset(f.参数)'"]

*关闭选单
[freeimage layer="5"]
[current layer="message5"]
[er]
[layopt layer="message5" visible="false"]
[return]
