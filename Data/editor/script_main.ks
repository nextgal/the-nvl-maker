;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;---------------------------------------------------------------
;腳本編輯
;---------------------------------------------------------------
*start
[eval exp="drawPageBoard(143)"]
;---------------------------------------------------------------
[unlocklink]
[current layer="message1"]
[er]
;---------------------------------------------------------------
;有工程時，顯示按鈕(新建腳本、打開腳本)
[if exp="sf.project!=void"]
[frame title="腳本編輯" line=1 x=15 y=15]
[locate x=50 y=40]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*新建腳本]
[eval exp="drawButtonCaption('新建腳本',14)"]

[locate x=190 y=40]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*打開腳本]
[eval exp="drawButtonCaption('打開腳本',14)"]
[endif]

[s]

*新建腳本
;清空腳本名
[eval exp="tf.filename=void"]
[input name="tf.filename" title="新建腳本" prompt="請輸入腳本文件名（不用擴展名）："]
;假如有輸入腳本名，開始創建腳本
[iscript]
if (tf.filename!=void)
{
if (Storages.isExistentStorage(sf.path+"scenario/"+tf.filename+".ks"))
{
   System.inform("哎呀呀~已經有同名腳本存在了~");
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
System.inform("腳本創建成功，可以打開編輯了","新建腳本");
}
}
[endscript]
[jump storage="script_main.ks"]

*打開腳本
[iscript]
f.scenario=void;
f.list=getsozai("ks","scenario");
tf.當前編輯值="f.scenario";
[endscript]
[call storage="window_file.ks"]

;假如選擇了文件，打開
[if exp="f.scenario!=void"]
[iscript]
//讀入並解釋
extractScript();
[endscript]
[jump storage="gui_script.ks"]
[endif]

[jump storage="script_main.ks"]
