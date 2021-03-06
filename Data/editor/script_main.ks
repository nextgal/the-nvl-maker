;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;---------------------------------------------------------------
;脚本编辑
;---------------------------------------------------------------
*start
[eval exp="drawPageBoard(143)"]
;---------------------------------------------------------------
[unlocklink]
[current layer="message1"]
[er]
;---------------------------------------------------------------
;有工程时，显示按钮(新建脚本、打开脚本)
[if exp="sf.project!=void"]
[frame title="脚本编辑" line=1 x=15 y=15]
[locate x=50 y=40]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*新建脚本]
[eval exp="drawButtonCaption('新建脚本')"]

[locate x=190 y=40]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*打开脚本]
[eval exp="drawButtonCaption('打开脚本')"]

[frame title="多语言功能" line=3 x=15 y=95]

[locate x=50 y=120]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" exp="OpenPath('scenario.txt')"]
[eval exp="drawButtonCaption('打开列表')"]

[locate x=190 y=120]
[hbutton normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*生成列表 hint="自动生成scenario下非系统的脚本列表"]
[eval exp="drawButtonCaption('生成列表')"]
[endif]

[locate x=50 y=180]
[hbutton normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*导出文本 hint="导出带有编号、人名标记提示的文本至output文件夹下，可放入excel下进行追加语音、翻译等处理"]
[eval exp="drawButtonCaption('导出文本')"]

[locate x=190 y=180]
[hbutton normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*回写翻译 hint="将translate.txt的内容翻译回写到备用脚本内"]
[eval exp="drawButtonCaption('回写文本')"]


[locate x=50 y=150]
[hbutton normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*格式整理 hint="将所有指令单独成行，以方便多语言等处理"]
[eval exp="drawButtonCaption('格式整理')"]

[locate x=190 y=150]
[hbutton normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*添加引号 hint="为人物对白添加前后标志"]
[eval exp="drawButtonCaption('添加引号')"]

[frame title="素材管理" line=1 x=15 y=230]
[locate x=50 y=255]
[hbutton normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*素材列表 hint="生成素材列表"]
[eval exp="drawButtonCaption('素材列表')"]
[locate x=190 y=255]
[hbutton normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*使用统计 hint="根据素材列表扫描脚本，并统计素材用到的次数"]
[eval exp="drawButtonCaption('使用统计')"]
[endif]

[s]


*LOG转换
[iscript]
getTrpgLogBat();
[endscript]
[jump storage="script_main.ks"]


*新建脚本
;清空脚本名
[eval exp="tf.filename=void"]
[input name="tf.filename" title="新建脚本" prompt="请输入脚本文件名（不用扩展名）：        "]
;假如有输入脚本名，开始创建脚本
[iscript]
if (tf.filename!=void)
{
if (Storages.isExistentStorage(sf.path+"scenario/"+tf.filename+".ks"))
{
   System.inform("哎呀呀~已经有同名脚本存在了~");
}
else
{
var content=[];
var path=Storages.getLocalName(sf.path+"scenario/"+tf.filename+".ks");
content[0]=";--------------------------------------------------";
content[1]=";"+tf.filename+".ks";
content[2]=";--------------------------------------------------";
content[3]="*start";
saveScript(path,content);
System.inform("脚本创建成功，可以打开编辑了","新建脚本");
}
}
[endscript]
[jump storage="script_main.ks"]

*打开脚本
[iscript]
f.scenario=void;
f.list=getsozai("ks","scenario");
tf.当前编辑值="f.scenario";
[endscript]
[call storage="window_file.ks"]

;假如选择了文件，打开
[if exp="f.scenario!=void"]
[iscript]
//读入并解释
extractScript();
[endscript]
[jump storage="gui_script.ks"]
[endif]

[jump storage="script_main.ks"]

*格式整理
[iscript]
FormatScenario();
[endscript]
[jump storage="script_main.ks"]


*添加引号
[eval exp="tf.mark='『』'"]
[input name="tf.mark" title="输入符号" prompt="请输入要插入的符号：        "]
[iscript]
FormatTalk(,tf.mark[0],tf.mark[1]);
[endscript]
[jump storage="script_main.ks"]


*回写翻译
[iscript]
reWriteTranslate();
[endscript]
[jump storage="script_main.ks"]

*导出文本
[iscript]
getTalk();
[endscript]
[jump storage="script_main.ks"]

*添加标记
[iscript]
addTagAll();
[endscript]
[jump storage="script_main.ks"]

*生成列表
[iscript]
saveScenarioList();
[endscript]
[jump storage="script_main.ks"]

*素材列表
[iscript]
getAllMaterialList();
[endscript]
[jump storage="script_main.ks"]

*使用统计
[iscript]
getMaterialUseage();
[endscript]
[jump storage="script_main.ks"]
