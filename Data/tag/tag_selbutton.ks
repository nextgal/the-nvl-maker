;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
*window
[window_middle width=500 height=440 title="选项按钮"]
[iscript]
drawFrame("按钮图形",6,15,40,kag.fore.layers[5],314);

drawFrame("执行操作",3,15,270,kag.fore.layers[5],314);

[endscript]
[line title="选项文字" name="f.参数.text" x=30 y=60]
[line title="一般" name="f.参数.normal" x=30 y=90 type="pic" path="others"]
[line title="选中" name="f.参数.over" x=30 y=120 type="pic" path="others" copyfrom="f.参数.normal"]
[line title="按下" name="f.参数.on" x=30 y=150 type="pic" path="others" copyfrom="f.参数.over"]
[line title="选中SE" name="f.参数.enterse" x=30 y=180 type="sound"]
[line title="按下SE" name="f.参数.clickse" x=30 y=210 type="sound"]

[line title="标签" name="f.参数.target" x=30 y=290]
[line title="文件" name="f.参数.storage" x=30 y=320 type="script"]
[line title="表达式" name="f.参数.exp" x=30 y=350]

[s]

*确认
[commit]
[iscript]
//防止出错用——假如参数开头不是星号，强制加入星号
f.参数.target=check_target(f.参数.target);
[endscript]
[eval exp="commitLine(f.参数)"]
[jump storage="tag_direct.ks" target=*擦除窗口]

*关闭选单
[jump storage="tag_direct.ks" target=*关闭选单]

*选择音声
[call storage="window_bgm.ks"]
[jump target=*window]

*选择文件
[call storage="window_file.ks"]
[jump target=*window]

*选择图片
[call storage="window_picture.ks"]
[jump target=*window]
