;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------------------
;脚本编辑器UI/脚本读入/解释/回写等
;------------------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------------------
;检查某个参数格式是否正常
;------------------------------------------------------------------------------------------------
[iscript]
function check_target(text)
{
	//检查*target是否正常
	if (text!=void && text[0]!="*")
	{
		if (text.indexOf("&")==-1) text="*"+text;
	}
	
	return text;

}
[endscript]
;------------------------------------------------------------------------------------------------
;脚本相关的翻页和刷新
;------------------------------------------------------------------------------------------------
[iscript]
//-----------------------------------------------------------------------------------------------
//脚本编辑器所用的单行翻动效果
function line_up()
{
        if (f.索引行>0)
        {
           f.索引行--;
           if (f.当前脚本行>f.索引行+34) f.当前脚本行--;
        }
}
function line_down()
{
        if (f.索引行<f.script.count-1)
        {
           f.索引行++;
           if (f.当前脚本行<f.索引行) f.当前脚本行++;
        }
}
//-----------------------------------------------------------------------------------------------
//脚本编辑器滚动条拖动
function script_scroll()
{
    if (kag.fore.base.cursorY<kag.fore.layers[2].top) page_up(1);
    if (kag.fore.base.cursorY>(int)kag.fore.layers[2].top+(int)kag.fore.layers[2].height) page_down(-1);
}
//-----------------------------------------------------------------------------------------------
//描绘代码
function drawScriptBox()
{
//位置
var x=360;
var y=35;
var height=735+1;

//描绘
with(kag.fore.layers[0])
 {
     .font.height=16;
     //行数
     .fillRect(x,y+1,45,height,0xFFFFFFFF);
     //代码
     .fillRect(x+50,y+1,890,height,0xFFFFFFFF);
     
     var base=f.索引行;
     
     for (var i=base;i<35+base;i++)
     {
        var j=i-base;
       //假如行数超过，中断循环
       if (i==f.script.count) break;
       //被选中，加蓝
       if (i==f.当前脚本行) 
       {
          .fillRect(x,y+j*21+1,45,22,0xFFCAFFFF);
          .fillRect(x+50,y+j*21+1,890,22,0xFFCAFFFF);
       }
       //没超过
       .drawText(x+2,y+5+j*21,i+1, 0x000000);
       .drawText(x+50+2,y+5+j*21,f.脚本显示[i].text, f.脚本显示[i].color);
     }
  }
  
//描绘详细参数文字
x=25;
y=480;

with(kag.fore.layers[0])
  {
  //描绘区域设定
    .fillRect(x,y,295,305,0xFFD4D0C8);
  //描绘详细参数
    if (f.script[f.当前脚本行]!=void)
    {
        var dic=f.script[f.当前脚本行];
       //描绘其他参数
        drawScriptElm(x+5,y+5,dic);
    }
  }
  
}
//-----------------------------------------------------------------------------------------------
//描绘参数
function drawScriptElm(x,y,dic)
{
    //根据tagname判断描绘内容
    var tagname=dic.tagname;
    
  with(kag.fore.layers[0])
 {
    //是对话/注释，描绘全句
    if (tagname=="_msg" || tagname=="_remark")
    {
      
      //每行16字
      var line=dic.text.length\16;
      if  (dic.text.length%16>0) line++;
      for (var i=0; i<line; i++)
      {
        var text=dic.text.substring(i*16,16);
        .drawText(x,y+i*25,text, 0x000000);
      }
    }
    else if (tagname=="_blank")
    {
        .drawText(x,y,"(新增空白行)", 0x000000);
    }
    else if (tagname=="_end")
    {
        .drawText(x,y,"(到达文件末端)", 0x000000);
    }
    //是标签
    else if (tagname=="_label")
    {
        var text=dic.label;
        .drawText(x,y,text, 0x000000);
        if (dic.pagename!=void)
        {
          text="|"+dic.pagename;
          .drawText(x,y+25,text, 0x000000);
        }
        else if (dic.cansave==true)
        {
          text="|";
          .drawText(x,y+25,text, 0x000000);
        }
    }
    //是TJS代码
    else if (tagname=="iscript")
    {
        .drawText(x,y,"TJS代码段，请打开直接查看", 0x000000);
    }
	else if (tagname=="macro")
    {
        .drawText(x,y,"宏指令代码段，请打开直接查看", 0x000000);
    }
    //其他的情况(普通的TAG)
    else
   {
      //挨个描绘参数
      var arr=dictoArr(dic);
      
      for (var i=0;i<arr.count;i++)
      {
		 var text=arr[i];
		 if (text.length>30) text=text.substring(0,30)+"…";
         //描绘
         .drawText(x,y+i*25,text, 0x000000);
      }
   }
      
 }
}
//-----------------------------------------------------------------------------------------------
//设定选中行/打开编辑菜单
function selScript(line)
{
  //如果当前脚本行和现在的行不一致
   if (f.当前脚本行!=line+f.索引行)
  {
    //设定选中行
    if ((line+f.索引行)<f.script.count-1) f.当前脚本行=line+f.索引行;
    else f.当前脚本行=f.script.count-1;
    //刷新选中效果
    drawScriptBox();
  }
  //如果一致(已选中),打开编辑窗口
  else
  {
       kag.process("gui_script.ks","*进行编辑");
  }

}
//-----------------------------------------------------------------------------------------------
//刷新代码栏/翻页效果
function updateScript()
{
//设定滚动条位置
   with(kag.fore.layers[2])
   {
      .visible=true;
      .top=36+(int)kag.fore.messages[1].top;
      if (f.索引行>0) .top+=(int)(f.索引行)*722/(f.script.count-1);
   }
//描绘代码
drawScriptBox();
}
[endscript]
;------------------------------------------------------------------------------------------------
;脚本文件的识别/脚本编辑器的UI
;------------------------------------------------------------------------------------------------
@loadplugin module=TagExtractor.dll
;------------------------------------------------------------------------------------------------
;DLL相关特殊处理1
;------------------------------------------------------------------------------------------------
[iscript]
function tagToStr(tag)
{
	var text = "";
	
	if(tag.tagname == "_ch")
		text += tag.text;
	else
	{
		text += "[" + tag.tagname;
		var temparr = [];
		temparr.assign(tag);
		for(var i=0; i<temparr.count; i+=2)
		{
			if(temparr[i] != "tagname" && temparr[i] != "linenum")
				text += " " + temparr[i] + "=" + temparr[i + 1];
		}
		text += "]";
	}
	return text;
}
[endscript]
;------------------------------------------------------------------------------------------------
;DLL相关特殊处理2-拆分为字典
;------------------------------------------------------------------------------------------------
[iscript]
function extractTagsFromKS_DCustom(filename)
{
	var tagarr = extractTagsFromKS(filename);
	var temparr = [];
	
	var p = 0;
	var texttemp = "";
	var tagcount = tagarr.count;
	var is_ch = false;
	
	while(p < tagcount)
	{
		if(tagarr[p].tagname == "_ch")
		{
			if(!is_ch)
			{
				is_ch = true;
				texttemp = "";
			}
		}
		else if(tagarr[p].tagname == "_cr")
		{
			if(is_ch) // 装入按文本处理的数据
			{
				temparr.add(%["tagname" => "_msg", "text" => texttemp]);
			}
			is_ch = false;
		}
		//不是对话中的一部分，不是换行符
		if(!is_ch && tagarr[p].tagname!="_cr")
			temparr.add(tagarr[p]);
	      //是对话的一部分
		else
			texttemp += tagToStr(tagarr[p]);
		p++;
	}
	
	return temparr;
}
[endscript]
;------------------------------------------------------------------------------------------------
;处理3-将脚本编辑器中某一行解读为中文的一行提示
;------------------------------------------------------------------------------------------------
[iscript]
//解释某一行
function expLine(line)
{
  //载入字典
  var taglist=f.taglist;
  //取得转换参照表
  var tag=taglist[line.tagname];
  //创建用于显示的字典
  var dic=%[];
  
    //可以解读
    if (tag!=void)
    {
       //颜色和指令解释
        dic.color=tag.tagcolor;
        dic.text=tag.tagname;
       //将对照表里提到的其他参数进行解释
        var elm=[];
       //将对照表复制成数组
        elm.assign(tag);
        for (var i=0;i<elm.count;i+=2)
        {
            //添加tagname和tagcolor以外的参数
            if (elm[i]!="tagname" && elm[i]!="tagcolor")
            {
               //假如找得到这个参数，则进行显示
                if (line[elm[i]]!=void)
                {
                   //解释参数名
                   if (elm[i+1]!=void) dic.text+=" "+elm[i+1]+":";
                   //加上参数值
                   dic.text+=line[elm[i]];
                }
            }
        }
        
    }
    //是人名
    else if (findName(line.tagname))
    {
       dic.color=0xeeaa00;
       dic.text="【"+line.tagname+"】";
       //增加立绘和头像显示参数
       if (line.fg!=void) dic.text+="立绘:"+line.fg;
       if (line.face!=void) dic.text+=" "+"头像:"+line.face;
    }
    //无法解读
    else
    {
       dic.color=0xa6a6a6;
       dic.text="@"+line.tagname;
    }
  
  //控制显示长度
  kag.fore.layers[0].font.height=16;
  while(kag.fore.layers[0].font.getTextWidth(dic.text)>(int)(740))
  {
      dic.text=dic.text.substring(0,dic.text.length-2)+"…";
  }
  

  //返回字典（颜色和显示内容）
  return dic;
}
[endscript]
;------------------------------------------------------------------------------------------------
;处理4-人名判定
;------------------------------------------------------------------------------------------------
[iscript]
function findName(name)
{
   for (var i=0;i<f.config_name.count;i++)
   {
       if (f.config_name[i].tag==name) return true;
   }
   return false;
}
[endscript]
;------------------------------------------------------------------------------------------------
;处理5-全部解读为中文
;------------------------------------------------------------------------------------------------
[iscript]
function expAllScript()
{
  //载入字典
  var taglist=f.taglist;
  //分析
  var str=[];
  //循环
  for (var i=0;i<f.script.count;i++)
  {
      str[i]=expLine(f.script[i]);
  }
  return str;
}
[endscript]
;样例用法
;@iscript
;var arr = extractTagsFromKS("testfirst.ks");
;arr.saveStruct("out.txt");
;arr = extractTagsFromKS_DCustom("testfirst.ks");
;arr.saveStruct("outDCustom.txt");
;@endscript
;------------------------------------------------------------------------------------------------
;处理6-载入+拆分
;------------------------------------------------------------------------------------------------
[iscript]
function extractScript()
{
//分析脚本
f.script=extractTagsFromKS_DCustom(Storages.getLocalName(sf.path+"scenario/"+f.scenario));
f.脚本显示=expAllScript();

//备份分析内容
//f.script.saveStruct(sf.path+"scenario/"+f.scenario+".txt");

//为最后一行添加空白行
var dic=%[];
dic.tagname="_end";
f.script.add(dic);
f.脚本显示.add(expLine(dic));
}
[endscript]
;------------------------------------------------------------------------------------------------
;脚本文件的还原
;------------------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------------------
;处理1-dic返回参数Arr(不包括：代码、宏、空行、末尾、注释、对话、标签)
;------------------------------------------------------------------------------------------------
[iscript]
//对字典内的每个name和value进行处理
function dictoText(name,value,dict,param)
{
	if (name!="tagname" && value!=void)
	{
		//假如不是string，不帮加双引号
		if (typeof value != "String") param.add(name+"="+value);
		//其中存在取值符号&，且不为TJS表达式或条件式
		else if (value.indexOf("&")!=-1 && name!="exp" && name!="cond") param.add(name+"="+value);
		//否则自动加入双引号
		else param.add(name+"=\""+value+"\"");
	}
}
//将TAG字典转成一个由字符串组成的数组（显示在“详细参数”一栏或在回写时使用）
function dictoArr(dic)
{
   //将对照表里提到的其他参数进行解释
   var arr=[];
	//读入TAGNAME
	arr[0]="@"+dic.tagname;
	//读入其他参数和值
	foreach(dic,dictoText,arr);

   return arr;
}
[endscript]
;------------------------------------------------------------------------------------------------
;处理2-dic返回tag(不包括：代码、宏、空行、末尾)，回写用
;------------------------------------------------------------------------------------------------
[iscript]
function dictoTag(dic)
{
   //注释
   if (dic.tagname=="_remark") return dic.text;
   //对话
   else if (dic.tagname=="_msg") return dic.text;
   //标签
   else if (dic.tagname=="_label")
   {
       var text=dic.label;
       //可保存
       if (dic.cansave!=void && dic.cansave!=false)
       {
          text+="|";
          if (dic.pagename!=void) text+=dic.pagename;
       }
       return text;
   }
   else
   {
		var arr=dictoArr(dic);
		//将TAGNAME+所有参数写成一行TEXT
		var text=arr[0];
		for (var i=1;i<arr.count;i++)
		{
			text+=" "+arr[i];
		}
		return text;
   }
}
[endscript]
;------------------------------------------------------------------------------------------------
;处理3-回写
;------------------------------------------------------------------------------------------------
[iscript]
function createAllScript(script)
{
   var arr=[];

   for (var i=0;i<script.count;i++)
   {
     //是代码
     	 if (script[i].tagname=="iscript")
     	 {
	         arr.add("[iscript]");
	         arr.add(script[i].tjs);
	         arr.add("[endscript]");
      	}
	//是宏
		else if (script[i].tagname=="macro" && script[i].macroscenario!=void)
		{
	         arr.add("[macro name="+script[i].name+"]");
	         arr.add(script[i].macroscenario);
	         arr.add("[endmacro]");
		}
     //其他TAG，不是空行也不是末尾
		else if (script[i].tagname!="_blank" && script[i].tagname!="_end")
		{
			arr.add(dictoTag(script[i]));
		}
   }

   return arr;
}
[endscript]
;----------------------------------------------------------------------------
[return]
