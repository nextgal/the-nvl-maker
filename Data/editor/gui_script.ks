;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;--------------------------------------------------
;脚本编辑器
;--------------------------------------------------
[iscript]
//默认翻到最后一页
if (f.script.count-15>=0) f.索引行=f.script.count-15;
else f.索引行=0;

f.当前脚本行=f.索引行;
[endscript]

*window
[rclick enabled="false"]
;当前编辑中
[eval exp="f.window='script'"]
[eval exp="drawPageBoard(143)"]
;显示工具栏
[current layer="message1"]
[er]
[iscript]
drawFrame("文件操作",2,15,15,kag.fore.layers[0],314);
drawFrame("测试",1,15,120,kag.fore.layers[0],314);
drawFrame("单行操作",2,15,355,kag.fore.layers[0],314);
drawFrame("详细参数",10,15,465,kag.fore.layers[0],314);
drawFrame(f.scenario,25,345,15,kag.fore.layers[0],1000);
[endscript]

;文件操作
[locate x=50 y=40]
[hbutton normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*重载脚本 hint="放弃已经做出的修改"]
[eval exp="drawButtonCaption('重载脚本')"]

[locate x=190 y=40]
[hbutton normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*保存脚本 hint="将修改保存到脚本文件"]
[eval exp="drawButtonCaption('保存脚本')"]

[locate x=50 y=70]
[hbutton normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*关闭脚本 hint="退出脚本编辑器，未作保存的修改会丢失"]
[eval exp="drawButtonCaption('关闭脚本')"]
[locate x=190 y=70]
[hbutton normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*直接编辑 hint="切换到文本编辑模式（自动保存并关闭脚本编辑器）"]
[eval exp="drawButtonCaption('直接编辑')"]

[locate x=50 y=145]
[hbutton normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*全局测试 hint="从标题开始测试游戏（自动保存）"]
[eval exp="drawButtonCaption('全局测试')"]
[locate x=190 y=145]
[hbutton normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*保存测试 hint="从本脚本开始测试游戏（自动保存）"]
[eval exp="drawButtonCaption('事件测试')"]

;单行操作
[locate x=40 y=385]
[hbutton normal="edit_button_insert" exp="insertLine()" hint="插入空白行（到上方）"]
[locate x=90 y=385]
[hbutton normal="edit_button_delete" exp="deleteLine()" hint="删除"]

[locate x=150 y=385]
[hbutton normal="edit_button_cut" exp="cutLine()" target=*window hint="剪切"]
[locate x=200 y=385]
[hbutton normal="edit_button_copy" exp="tf.复制行=copyLine()" target=*window hint="复制"]
[locate x=250 y=385]
[hbutton normal="edit_button_paste" exp="pasteLine(tf.复制行)" cond="tf.复制行!=void" hint="粘贴（到下方）"]
[hbutton normal="edit_button_paste_disable" cond="tf.复制行==void" hint="粘贴（不可用）"]

;滚动条
[button_page x=1320 y=20 length=770]
[locate x=1320 y=36]
[button normal="edit_slider_back" interval=10 ontimer="script_scroll()"]
[image layer=2 storage="edit_slider_button" left=&"1320+(int)kag.fore.messages[1].left"]

;显示代码栏
[iscript]
updateScript();

//显示代码选择按钮
for (var i=0;i<35;i++)
{
     kag.tagHandlers.locate(
     %[
         "x"=>360,
         "y"=>36+21*i,
      ]
      );
      var setting=new Dictionary();
      setting.normal="edit_button_line_normal";
      setting.over="edit_button_line_over";
      setting.exp="selScript("+i+")";
      kag.tagHandlers.button(setting);
}
[endscript]
[s]
;--------------------------------------------------
*保存脚本
[iscript]
//转换为tag
f.tag=createAllScript(f.script);
//保存
f.tag.save(sf.path+"scenario/"+f.scenario);
[endscript]
[jump storage="gui_script.ks" target=*window]

*直接编辑
;保存
[iscript]
//转换为tag
f.tag=createAllScript(f.script);
//保存
f.tag.save(sf.path+"scenario/"+f.scenario);
[endscript]

;关闭
[eval exp="f.window=''"]
;滚动条消除
[freeimage layer=2]
[iscript]
//清除相关内容
f.索引行=void;
f.当前脚本行=void;
f.script=void;
f.脚本显示=void;
//改回从标题启动
rewriteStart(f.setting.startfrom);
[endscript]

;打开脚本
[eval exp="System.shellExecute(Storages.getLocalName(sf.path+'scenario/')+f.scenario)"]
[jump storage="script_main.ks"]
;--------------------------------------------------
*保存测试
[iscript]
//转换为tag
f.tag=createAllScript(f.script);
//保存
f.tag.save(sf.path+"scenario/"+f.scenario);
//重写start.ks
rewriteStart(f.scenario);
//启动测试
runGameTest();
[endscript]
[jump storage="gui_script.ks" target=*window]

*全局测试
[iscript]
//转换为tag
f.tag=createAllScript(f.script);
//保存
f.tag.save(sf.path+"scenario/"+f.scenario);
//重写start.ks
rewriteStart(f.setting.startfrom);
//启动测试
runGameTest();
[endscript]
[jump storage="gui_script.ks" target=*window]

;--------------------------------------------------
*重载脚本
[iscript]
//重载并拆分
extractScript();
[endscript]
[jump storage="gui_script.ks"]
;--------------------------------------------------
*关闭脚本
[eval exp="f.window=''"]
;滚动条消除
[freeimage layer=2]
[iscript]
//清除相关内容
f.索引行=void;
f.当前脚本行=void;
f.script=void;
f.脚本显示=void;
//改回从标题启动
rewriteStart(f.setting.startfrom);
[endscript]
[jump storage="script_main.ks"]

;--------------------------------------------------
;根据已有的行内容进行编辑
;--------------------------------------------------
*进行编辑
[eval exp="f.window=''"]

[iscript]
//取得行信息
f.参数=%[];
(Dictionary.assign incontextof f.参数)(f.script[f.当前脚本行]);
[endscript]
;--------------------------------------------------
;最后一行
[if exp="f.参数.tagname=='_end'"]
[iscript]
//插入空白行
insertLine();
//重设参数
f.参数=%[];
f.参数.tagname="_blank";
[endscript]
[jump storage="window_tag.ks" target=*window]
;--------------------------------------------------
;一般空白行
[elsif exp="f.参数.tagname=='_blank'"]
[jump storage="window_tag.ks" target=*window]
;--------------------------------------------------
;姓名栏
[elsif exp="findName(f.参数.tagname)"]
[call storage="tag_name.ks"]
;--------------------------------------------------
;非空白行(根据tagname配置表直接call对应的窗口)
[elsif exp="f.target[f.参数.tagname]!=void"]
[call storage="&('tag_'+f.target[f.参数.tagname]+'.ks')"]
[else]
[call storage="tag_direct.ks"]
[endif]
;--------------------------------------------------
[jump storage="gui_script.ks" target=*window]
