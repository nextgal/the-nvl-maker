;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;--------------------------------------------------
;默认选项按钮设定,包括x,y,normal,over,on几个选项
;--------------------------------------------------
*window
[window_down width=400 height=520 title="默认选项按钮设定"]

[line title="按钮图形" x=30 y=40]
[line title="一般" name="f.setting.selbutton.normal" type="pic" path="others" x=30 y=70]
[line title="选中" name="f.setting.selbutton.over" type="pic" path="others" x=30 y=100 copyfrom="f.setting.selbutton.normal"]
[line title="按下" name="f.setting.selbutton.on" type="pic" path="others" x=30 y=130 copyfrom="f.setting.selbutton.over"]
[line title="选项文字" x=30 y=160]
[line title="字号" name="f.setting.selfont.height" x=30 y=190]
[line title="一般" name="f.setting.selfont.normal" type="color" x=30 y=220]
[line title="选中" name="f.setting.selfont.over" type="color" x=30 y=250 copyfrom="f.setting.selfont.normal"]
[line title="按下" name="f.setting.selfont.on" type="color" x=30 y=280 copyfrom="f.setting.selfont.over"]
[line title="既读" name="f.setting.selfont.read" type="color" x=30 y=310 copyfrom="f.setting.selfont.on"]
[line title="音效设定" x=30 y=340]
[line title="选中" name="f.setting.selbutton.enterse" x=30 y=370 type="sound"]
[line title="按下" name="f.setting.selbutton.clickse" x=30 y=400 type="sound"]
[s]

*选择图片
[call storage="window_picture.ks"]
[jump target=*window]

*选择颜色
[call storage="window_color.ks"]
[jump target=*window]

*选择音声
[call storage="window_bgm.ks"]
[jump target=*window]

*确认
;保存当前f.setting内容
[commit]
[iscript]
(Dictionary.saveStruct incontextof f.setting)(sf.path+"macro/"+'setting.tjs');
[endscript]

*关闭选单
;重载f.setting内容
[iscript]
f.setting=Scripts.evalStorage(sf.path+"macro/"+'setting.tjs');
[endscript]

[rclick enabled="false"]
[freeimage layer="3"]
[freeimage layer="4"]
[current layer="message3"]
[er]
[layopt layer="message3" visible="false"]
[jump storage="gui_main.ks"]
