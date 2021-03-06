;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------------------
;脚本编辑器的行操作
;------------------------------------------------------------------------------------------------
;------------------------------------------------------------
;快捷键操作
;------------------------------------------------------------
;ALL FOR SCRIPT
[iscript]
function ScriptKey(key, shift)
{
   if (f.window!="script") return false;
   //删除
   if (key==VK_DELETE)
   {
         deleteLine();
   }
   //选中上一行
   else if (key==VK_UP)
   {
           if (f.当前脚本行>0)
        {
           f.当前脚本行--;
           if (f.索引行>f.当前脚本行) f.索引行--;
           updateScript();
         }
   }
   //选中下一行
   else if (key==VK_DOWN)
   {
           if (f.当前脚本行<f.script.count-1)
        {
           f.当前脚本行++;
           if (f.索引行+24<f.当前脚本行) f.索引行++;
           updateScript();
         }
   }
   //剪切
   else if (key==VK_X && shift==ssCtrl)
   {
          cutLine();
          kag.process("gui_script.ks","*window");
   }   
   //复制
   else if (key==VK_C && shift==ssCtrl)
   {
          tf.复制行=copyLine();
          kag.process("gui_script.ks","*window");
   }
   //粘贴
   else if (key==VK_V && shift==ssCtrl)
   {
         pasteLine(tf.复制行);
   }
   //新增
   else if (key==VK_N && shift==ssCtrl)
   {
         insertLine();
   }
   //return false;
}
// キー押下時のハンドラを登録
//如果没有添加过键盘钩子，添加
if (tf.hookloaded==false) kag.keyDownHook.add(ScriptKey);
tf.hookloaded=true;
[endscript]
;------------------------------------------------------------
;函数
;------------------------------------------------------------
[iscript]

//---------------------------------------------------------------------
//将字典转为编辑用格式
//---------------------------------------------------------------------
function dictoForm(dic)
{
   var arr=[];
   arr[0]=dic.tagname;
   var elm=[];
   //将对照表复制成数组
   elm.assign(dic);
           for (var i=0;i<elm.count;i+=2)
        {
           if (elm[i]!="tagname") arr.add(%["elm"=>elm[i],"value"=>elm[i+1]]);
        }
    return arr;
}
//---------------------------------------------------------------------
//将编辑完的参数格式转为字典
//---------------------------------------------------------------------
function formtoDic(form)
{
    var dic=%[];
    dic.tagname=form[0];
for (var i=1;i<form.count;i++)
{
   if (form[i].elm!=void && form[i].value!=void)
   {
       dic[form[i].elm]=form[i].value;
   }
}
    return dic;
}
//---------------------------------------------------------------------
//将字典写入当前行
//---------------------------------------------------------------------
function commitLine(dic)
{
    //复制
    f.script[f.当前脚本行]=dic;
    f.脚本显示[f.当前脚本行]=expLine(dic);
}
//---------------------------------------------------------------------
//处理4-编辑器用多行文本写入
//---------------------------------------------------------------------
function spiltLine()
{
    var text=f.文本框.text.split('\r\n',,true);
    if (text.count>0)
   {
     //循环添加自动符号
      for (var i=0;i<text.count;i++)
       {
         var line=text[i];
         if (f.参数.autor==true && text[i].charAt(0)!="[" &&  text[i].charAt(0)!="@") line+="[lr]";
         else if (f.参数.autow==true && text[i].charAt(0)!="[" && text[i].charAt(0)!="@") line+="[w]";
         text[i]=line;
       }
       return text;
   }
   else return [""];
}

function multiLine(text)
{
   //参数写入第一行
   f.参数=%[];
   f.参数.tagname="_msg";
   f.参数.text=text[0];
   commitLine(f.参数);
   
   //附加多行
      if (text.count>1)
   {
      //循环写入
      for (var i=1;i<text.count;i++)
      {
         var line=text[i];
         f.参数=%[];
         f.参数.tagname="_msg";
         f.参数.text=text[i];
         //下方加入一行
         addLine(f.参数);
      }
   }

}
//---------------------------------------------------------------------
//增加一行(下方)
//---------------------------------------------------------------------
function addLine(dic=%["tagname"=>"_blank"])
{
//假如不是最后一行，加在下方
  if (f.当前脚本行<f.script.count-1)
 {
   f.script.insert(f.当前脚本行+1,dic);
   f.脚本显示.insert(f.当前脚本行+1,expLine(dic));
   //重新选中增加的那行
   f.当前脚本行++;
   if (f.当前脚本行>f.索引行+24) f.索引行++;
   updateScript();
 }
//假如是最后一行，加在上方
 else
 {
    insertLine(dic);
 }
}
//---------------------------------------------------------------------
//增加一行（上方）
//---------------------------------------------------------------------
function insertLine(dic=%["tagname"=>"_blank"])
{
   f.script.insert(f.当前脚本行,dic);
   f.脚本显示.insert(f.当前脚本行,expLine(dic));
    updateScript();
}
//---------------------------------------------------------------------
//删除一行
function deleteLine()
{
//删除的不是最后一行
    if (f.当前脚本行!=f.script.count-1)
  {
     f.script.erase(f.当前脚本行);
     f.脚本显示.erase(f.当前脚本行);
     updateScript();
   }
}
//---------------------------------------------------------------------
//复制一行
function copyLine()
{
   var tagname=f.script[f.当前脚本行].tagname;
   
   //不是末尾行，返回行内容
   if (tagname!="_end")
   {
     return f.script[f.当前脚本行];
   }
   //是末尾行，返回空
   else
   {
      return void;
   }
}

//---------------------------------------------------------------------
//粘贴一行(在选中行位置)
function pasteLine(line)
{
//假如存在粘贴对象
   if (line!=void)
   {
        insertLine(line);
   }
}
//---------------------------------------------------------------------
//剪切一行
function cutLine()
{
      //复制
      tf.复制行=copyLine();
      //删除
      deleteLine();
}
[endscript]
;------------------------------------------------------------------------------------------------
[return]
