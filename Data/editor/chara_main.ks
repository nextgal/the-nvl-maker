;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;---------------------------------------------------------------
;姓名編輯
;f.config_name的編輯

;單個內容:
;姓名(宏的名字)
;顯示名
;顏色1
;顏色2

;新增姓名
;刪除姓名
;保存
;重載
;---------------------------------------------------------------
*start
*window
[eval exp="drawPageBoard(214)"]
;---------------------------------------------------------------
[unlocklink]
[current layer="message1"]
[er]
[frame title="默認姓名顏色" line=2 x=15 y=15]
[line title=&"f.config_name[0].name" x=30 y=40]
[line title=&"f.config_name[0].name" name="f.config_name[0].color" x=30 y=40 type="color"]
[line title=&"f.config_name[1].name" name="f.config_name[1].color" x=30 y=70 type="color"]

[frame title="新增姓名" line=4 x=15 y=125]
[line title="簡稱" name="f.name_tag" x=30 y=150]
[line title="姓名" name="f.name_name" x=30 y=180]
[line title="顏色" name="f.name_color" x=30 y=210 type="color"]
[locate x=190 y=245]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*新增姓名]
[eval exp="drawButtonCaption('新增姓名',14)"]

[frame title="記錄" line=1 x=15 y=295]
[locate x=50 y=320]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*保存並生成宏]
[eval exp="drawButtonCaption('保存並生成宏',14)"]
[locate x=190 y=320]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*放棄全部修改]
[eval exp="drawButtonCaption('放棄全部修改',14)"]

[frame title="既有姓名編輯" line=22 x=345 y=15]
[frame title="既有姓名編輯" line=22 x=675 y=15]
[frame title="既有姓名編輯" line=22 x=1005 y=15]
;姓名
;編輯
;刪除
[iscript]
for (var i=2;i<f.config_name.count;i++)
{
//姓名
//姓名
if (i<=23)
{
   drawEdit(f.config_name[i].tag,,360,40+(i-2)*30);
}
else if (i<=45)
{
   drawEdit(f.config_name[i].tag,,690,40+(i-24)*30);
}
else
{
   drawEdit(f.config_name[i].tag,,1020,40+(i-46)*30);
}
//drawEdit(f.config_name[i].tag,,360,40+(i-2)*30);
//編輯
drawLink_Win("f.config_name["+i+"]","name");
//刪除
   kag.tagHandlers.ch(%["text"=>"  "]);
   var setting=new Dictionary();
   setting.exp="kag.current.commit(),tf.當前編輯值="+i;
   setting.target="*刪除姓名";
   kag.tagHandlers.link(setting);
   kag.tagHandlers.ch(%["text"=>"刪除"]);
   kag.tagHandlers.endlink(%[]);
}
[endscript]
[s]

*選擇顏色
[call storage="window_color.ks"]
[jump target=*window]

*新增姓名
[commit]
[iscript]
if (f.config_name.count<68)
{
      //假如值不為空，在姓名串裡增加
    if (f.name_tag!=void && f.name_name!=void && f.name_color!=void)
    {
      f.config_name.add(%["tag"=>f.name_tag,"name"=>f.name_name,"color"=>f.name_color]);
      //消除文字
      f.name_tag=void;
      f.name_name=void;
      f.name_color=void;
     }
}
else
{
System.inform("喂喂，真的有這麼多人嗎，顯示不下了啦~","囧");
}
[endscript]
[jump target=*window]

*編輯姓名
[call storage="window_name.ks"]
[jump target=*window]

*刪除姓名
[iscript]
f.config_name.erase(tf.當前編輯值);
[endscript]
[jump target=*window]

*保存並生成宏
[commit]

[iscript]
//進行保存
f.config_name.saveStruct(sf.path+"macro/"+'namelist.tjs');

//自動生成宏
f.文件=[];
f.文件[0]=";--------------------------------------------";
f.文件[1]=";自動生成的人物姓名宏";
f.文件[2]=";--------------------------------------------";
f.文件[3]="*start";

f.文件[4]="[macro name=主角]";
f.文件[5]="[npc * id=主角"+" color="+f.config_name[0].color+"]";
f.文件[6]="[endmacro]";

//生成宏腳本
for (var i=2;i<f.config_name.count;i++)
{
  f.文件.add("");
  f.文件.add(";--------------------------------------------");
  f.文件.add(";"+f.config_name[i].name);
  f.文件.add(";--------------------------------------------");
  f.文件.add("[macro name="+f.config_name[i].tag+"]");
  f.文件.add("[npc * id="+f.config_name[i].name+" color="+f.config_name[i].color+"]");
  f.文件.add("[endmacro]");
}

f.文件.add(";--------------------------------------------");
f.文件.add("[return]");

//進行保存
f.文件.save(sf.path+"macro/macro_name.ks");
[endscript]

[jump target=*window]

*放棄全部修改
[iscript]
//重載
f.config_name=Scripts.evalStorage(sf.path+"macro/"+'namelist.tjs');
[endscript]
[jump target=*window]
