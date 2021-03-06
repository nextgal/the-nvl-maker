;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
[iscript]
f.参数.autor=false;
f.参数.autow=true;

f.文本框=new MultiEditLayer(kag , kag.fore.base);
f.文本框.text=f.参数.text;
f.文本框.left=(kag.scWidth-700)/2+25;
f.文本框.top=10+205;
[endscript]

*window
[window_middle width=700 height=600 title="显示对话"]
[line title="姓名" name="f.参数.name" x=30 y=50 type="list" target=*选择姓名]
[line title="颜色" name="f.参数.color" x=30 y=80 type="color"]
[line title="头像" name="f.参数.face" x=30 y=110 type="pic" path="face"]

[line title="角色" name="f.参数.fg" x=330 y=50 type="pic" path="fgimage"]
[line title="编号" name="f.参数.layer" x=330 y=80 type=list target="*选择前景层"]
[line title="不指定姓名时，头像、角色相关参数无效" x=330 y=110]
[locate x=30 y=140]
[emb exp="getTransStr('指令')"]
[locate x=100 y=140]
[link exp="f.文本框.insertCharacter('[lr]')"][emb exp="getTransStr('换行等待')"]
[endlink]
[locate x=200 y=140]
[link exp="f.文本框.insertCharacter('[w]')"][emb exp="getTransStr('分页等待')"]
[endlink]
[locate x=300 y=140]
[link exp="f.文本框.insertCharacter('[r]')"][emb exp="getTransStr('单纯换行')"][endlink]
[locate x=400 y=140]
[link exp="f.文本框.insertCharacter('[indent]')"][emb exp="getTransStr('文字缩进')"][endlink]
[locate x=500 y=140]
[link exp="f.文本框.insertCharacter('[endindent]')"][emb exp="getTransStr('解除缩进')"][endlink]

[locate x=30 y=170]
[emb exp="getTransStr('符号')"]
[locate x=100 y=170]
[link exp="f.文本框.insertCharacter('【】')"]【】[endlink]  
[link exp="f.文本框.insertCharacter('『』')"]『』[endlink]  
[link exp="f.文本框.insertCharacter('〖〗')"]〖〗[endlink]  
[link exp="f.文本框.insertCharacter('「」')"]「」[endlink]

[line title="文字色" name="f.参数.fontcolor" x=300 y=170 type="color"]
[locate x=590 y=170]
[link exp="f.文本框.insertCharacter('[font color='+f.参数.fontcolor+']') if (f.参数.fontcolor!=void)"][emb exp="getTransStr('插入')"][endlink]

[line title="段落末尾" x=30 y=515]
[locate x=130 y=515]
[checkbox name="f.参数.autor" opacity=0] [emb exp="getTransStr('自动换行')"]  
[checkbox name="f.参数.autow" opacity=0] [emb exp="getTransStr('自动分页')"]

[iscript]
f.文本框.visible=true;
[endscript]
[s]

*确认
[commit]
;----------------------------------------
[iscript]
//假如有人物姓名
if (f.参数.name!=void)
{
     //人物姓名输入
     var dic=%[];
     if (findName(f.参数.name)) dic.tagname=f.参数.name;
     else
     {
       dic.tagname="npc";
       dic.id=f.参数.name;
     }
     //其他的处理
     dic.color=f.参数.color;
     dic.face=f.参数.face;
     dic.fg=f.参数.fg;
     dic.layer=f.参数.layer;
     //写入
     commitLine(dic);
     //新增一行空白
     addLine();
     //写入文本处理
     multiLine(spiltLine());
}
//假如没有人物姓名
else
{
   //文本处理
   multiLine(spiltLine());
}
[endscript]
;----------------------------------------
[iscript]
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

;-----------------------------------------------------------------
*选择图片
[call storage="window_picture.ks"]
[jump target=*window]

*选择颜色
[call storage="window_color.ks"]
[jump target=*window]

*选择前景层
[list_fglayer x=334 y=80]
[s]

*选择姓名
[list x=34 y=50 line=&"f.config_name.count-1" layer="message6"]
[link target=*关闭下拉菜单 exp="f.参数.name='主角'"]主角[endlink]
[iscript]
for (var i=2;i<f.config_name.count;i++)
{
      kag.tagHandlers.r(%[]);
      //描绘列表
      var setting=new Dictionary();
      setting.target="*关闭下拉菜单";
      setting.exp="f.参数.name=\'"+f.config_name[i].tag+"\'";
      kag.tagHandlers.link(setting);
      kag.tagHandlers.ch(%["text"=>f.config_name[i].tag]);
      kag.tagHandlers.endlink(%[]);

}
[endscript]
[s]

*关闭下拉菜单
[rclick enabled="false"]
[current layer="message6"]
[er]
[layopt layer="message6" visible="false"]
[jump target=*window]

*输入姓名
[rclick enabled="false"]
[current layer="message6"]
[er]
[layopt layer="message6" visible="false"]
[input name="f.参数.name" title=输入姓名 prompt="请输入要显示的人名：          "]
[jump target=*window]
