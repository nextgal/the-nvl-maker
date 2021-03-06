;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
[iscript]
f.参数.autor=false;
f.参数.autow=false;

f.文本框=new MultiEditLayer(kag , kag.fore.base);
f.文本框.text=f.参数.text;
f.文本框.left=(kag.scWidth-700)/2+25;
f.文本框.top=10+105;
[endscript]

*window
[window_middle width=700 height=600 title="编辑文本"]
[locate x=30 y=40]
[emb exp="getTransStr('指令')"]
[locate x=100 y=40]
[link exp="f.文本框.insertCharacter('[lr]')"][emb exp="getTransStr('换行等待')"]
[endlink]
[locate x=200 y=40]
[link exp="f.文本框.insertCharacter('[w]')"][emb exp="getTransStr('分页等待')"]
[endlink]
[locate x=300 y=40]
[link exp="f.文本框.insertCharacter('[r]')"][emb exp="getTransStr('单纯换行')"][endlink]
[locate x=400 y=40]
[link exp="f.文本框.insertCharacter('[indent]')"][emb exp="getTransStr('文字缩进')"][endlink]
[locate x=500 y=40]
[link exp="f.文本框.insertCharacter('[endindent]')"][emb exp="getTransStr('解除缩进')"][endlink]

[locate x=30 y=70]
[emb exp="getTransStr('符号')"]
[locate x=100 y=70]
[link exp="f.文本框.insertCharacter('【】')"]【】[endlink]  
[link exp="f.文本框.insertCharacter('『』')"]『』[endlink]  
[link exp="f.文本框.insertCharacter('〖〗')"]〖〗[endlink]  
[link exp="f.文本框.insertCharacter('「」')"]「」[endlink]

[line title="文字色" name="f.参数.fontcolor" x=300 y=70 type="color"]
[locate x=590 y=70]
[link exp="f.文本框.insertCharacter('[font color='+f.参数.fontcolor+']') if (f.参数.fontcolor!=void)"][emb exp="getTransStr('插入')"][endlink]

[line title="段落末尾" x=30 y=415]
[locate x=130 y=415]
[checkbox name="f.参数.autor" opacity=0] [emb exp="getTransStr('自动换行')"]  
[checkbox name="f.参数.autow" opacity=0] [emb exp="getTransStr('自动分页')"]

[iscript]
f.文本框.visible=true;
[endscript]

[s]

*确认
[commit]

[iscript]
//文本处理
multiLine(spiltLine());

f.文本框.visible=false;
f.文本框=void;

[endscript]
[jump storage="tag_direct.ks" target=*擦除窗口]

*关闭选单
[iscript]
f.文本框.visible=false;
f.文本框=void;
[endscript]
[jump storage="tag_direct.ks" target=*关闭选单]

*选择颜色
[call storage="window_color.ks"]
[jump target=*window]
