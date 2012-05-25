;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------------------
;腳本編輯器UI/腳本讀入/解釋/回寫等
;------------------------------------------------------------------------------------------------

;------------------------------------------------------------------------------------------------
;腳本相關的翻頁和刷新
;------------------------------------------------------------------------------------------------
[iscript]
//-----------------------------------------------------------------------------------------------
//腳本編輯器所用的單行翻動效果
function line_up()
{
        if (f.索引行>0)
        {
           f.索引行--;
           if (f.當前腳本行>f.索引行+34) f.當前腳本行--;
        }
}
function line_down()
{
        if (f.索引行<f.script.count-1)
        {
           f.索引行++;
           if (f.當前腳本行<f.索引行) f.當前腳本行++;
        }
}
//-----------------------------------------------------------------------------------------------
//腳本編輯器滾動條拖動
function script_scroll()
{
    if (kag.fore.base.cursorY<kag.fore.layers[2].top) page_up(1);
    if (kag.fore.base.cursorY>(int)kag.fore.layers[2].top+(int)kag.fore.layers[2].height) page_down(-1);
}
//-----------------------------------------------------------------------------------------------
//描繪代碼
function drawScriptBox()
{
//位置
var x=360;
var y=35;
var height=735+1;

//描繪
with(kag.fore.layers[0])
 {
     .font.height=18;
     //行數
     .fillRect(x,y+1,45,height,0xFFFFFFFF);
     //代碼
     .fillRect(x+50,y+1,890,height,0xFFFFFFFF);
     
     var base=f.索引行;
     
     for (var i=base;i<35+base;i++)
     {
        var j=i-base;
       //假如行數超過，中斷循環
       if (i==f.script.count) break;
       //被選中，加藍
       if (i==f.當前腳本行) 
       {
          .fillRect(x,y+j*21+1,45,22,0xFFCAFFFF);
          .fillRect(x+50,y+j*21+1,890,22,0xFFCAFFFF);
       }
       //沒超過
       .drawText(x+2,y+5+j*21,i+1, 0x000000);
       .drawText(x+50+2,y+5+j*21,f.腳本顯示[i].text, f.腳本顯示[i].color);
     }
  }
  
//描繪詳細參數文字
x=25;
y=480;

with(kag.fore.layers[0])
  {
  //描繪區域設定
    .fillRect(x,y,295,305,0xFFD4D0C8);
  //描繪詳細參數
    if (f.script[f.當前腳本行]!=void)
    {
        var dic=f.script[f.當前腳本行];
       //描繪其他參數
        drawScriptElm(x+5,y+5,dic);
    }
  }
  
}
//-----------------------------------------------------------------------------------------------
//描繪參數
function drawScriptElm(x,y,dic)
{
    //根據tagname判斷描繪內容
    var tagname=dic.tagname;
    
  with(kag.fore.layers[0])
 {
    //是對話/註釋，描繪全句
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
        .drawText(x,y,"(到達文件末端)", 0x000000);
    }
    //是標籤
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
    //是TJS代碼
    else if (tagname=="iscript")
    {
        .drawText(x,y,"TJS代碼段，請打開直接查看", 0x000000);
    }
    //其他的情況(普通的TAG)
    else
   {
      //挨個描繪參數
      var arr=dictoArr(dic);
      
      for (var i=0;i<arr.count;i++)
      {
         //控制參數長度
         while (kag.fore.layers[0].font.getTextWidth(arr[i])>290)
         {
            arr[i]=arr[i].substring(0,arr[i].length-2)+"…";
         }
         //描繪
         .drawText(x,y+i*25,arr[i], 0x000000);
      }
   }
      
 }
}
//-----------------------------------------------------------------------------------------------
//設定選中行/打開編輯菜單
function selScript(line)
{
  //如果當前腳本行和現在的行不一致
   if (f.當前腳本行!=line+f.索引行)
  {
    //設定選中行
    if ((line+f.索引行)<f.script.count-1) f.當前腳本行=line+f.索引行;
    else f.當前腳本行=f.script.count-1;
    //刷新選中效果
    drawScriptBox();
  }
  //如果一致(已選中),打開編輯窗口
  else
  {
       kag.process("gui_script.ks","*進行編輯");
  }

}
//-----------------------------------------------------------------------------------------------
//刷新代碼欄/翻頁效果
function updateScript()
{
//設定滾動條位置
   with(kag.fore.layers[2])
   {
      .visible=true;
      .top=36+(int)kag.fore.messages[1].top;
      if (f.索引行>0) .top+=(int)(f.索引行)*722/(f.script.count-1);
   }
//描繪代碼
drawScriptBox();
}
[endscript]
;------------------------------------------------------------------------------------------------
;腳本文件的識別/腳本編輯器的UI
;------------------------------------------------------------------------------------------------
@loadplugin module=TagExtractor.dll
;------------------------------------------------------------------------------------------------
;處理1
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
;處理2-拆分為字典
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
			if(is_ch) // 裝入按文本處理的數據
			{
				temparr.add(%["tagname" => "_msg", "text" => texttemp]);
			}
			is_ch = false;
		}
		//不是對話中的一部分，不是換行符
		if(!is_ch && tagarr[p].tagname!="_cr")
			temparr.add(tagarr[p]);
	      //是對話的一部分
		else
			texttemp += tagToStr(tagarr[p]);
		p++;
	}
	
	return temparr;
}
[endscript]
;------------------------------------------------------------------------------------------------
;處理3-解讀為中文
;------------------------------------------------------------------------------------------------
[iscript]
//解釋某一行
function expLine(line)
{
  //載入字典
  var taglist=f.taglist;
  //取得轉換參照表
  var tag=taglist[line.tagname];
  //創建用於顯示的字典
  var dic=%[];
  
    //可以解讀
    if (tag!=void)
    {
       //顏色和指令解釋
        dic.color=tag.tagcolor;
        dic.text=tag.tagname;
       //將對照表裡提到的其他參數進行解釋
        var elm=[];
       //將對照表複製成數組
        elm.assign(tag);
        for (var i=0;i<elm.count;i+=2)
        {
            //添加tagname和tagcolor以外的參數
            if (elm[i]!="tagname" && elm[i]!="tagcolor")
            {
               //假如找得到這個參數，則進行顯示
                if (line[elm[i]]!=void)
                {
                   //解釋參數名
                   if (elm[i+1]!=void) dic.text+=" "+elm[i+1]+":";
                   //加上參數值
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
       //增加立繪和頭像顯示參數
       if (line.fg!=void) dic.text+="立繪:"+line.fg;
       if (line.face!=void) dic.text+=" "+"頭像:"+line.face;
    }
    //無法解讀
    else
    {
       dic.color=0xa6a6a6;
       dic.text="@"+line.tagname;
    }
  
  //控制顯示長度
  kag.fore.layers[0].font.height=15;
  while(kag.fore.layers[0].font.getTextWidth(dic.text)>(int)(740))
  {
      dic.text=dic.text.substring(0,dic.text.length-2)+"…";
  }
  
//    if (kag.fore.layers[0].font.getTextWidth(dic.text)>480) dic.text=dic.text.substring(0,55)+"…";
//    if (kag.fore.layers[0].font.getTextWidth(dic.text)>480) dic.text=dic.text.substring(0,27)+"…";

  //返回字典（顏色和顯示內容）
  return dic;
}
[endscript]
;------------------------------------------------------------------------------------------------
;處理4-人名判定
;------------------------------------------------------------------------------------------------
[iscript]
function findName(name)
{
   for (var i=0;i<f.config_name.count;i++)
   {
       //if (f.config_name[i].name==name) return true;
       if (f.config_name[i].tag==name) return true;
   }
   return false;
}
[endscript]
;------------------------------------------------------------------------------------------------
;處理5-全部解讀為中文
;------------------------------------------------------------------------------------------------
[iscript]
function expAllScript()
{
  //載入字典
  var taglist=f.taglist;
  //分析
  var str=[];
  //循環
  for (var i=0;i<f.script.count;i++)
  {
      str[i]=expLine(f.script[i]);
  }
  return str;
}
[endscript]
;樣例用法
;@iscript
;var arr = extractTagsFromKS("testfirst.ks");
;arr.saveStruct("out.txt");
;arr = extractTagsFromKS_DCustom("testfirst.ks");
;arr.saveStruct("outDCustom.txt");
;@endscript
;------------------------------------------------------------------------------------------------
;處理6-載入+拆分
;------------------------------------------------------------------------------------------------
[iscript]
function extractScript()
{
//分析腳本
f.script=extractTagsFromKS_DCustom(Storages.getLocalName(sf.path+"scenario/"+f.scenario));
f.腳本顯示=expAllScript();

//備份分析內容
//f.script.saveStruct(sf.path+"scenario/"+f.scenario+".txt");

//為最後一行添加空白行
var dic=%[];
dic.tagname="_end";
f.script.add(dic);
f.腳本顯示.add(expLine(dic));
}
[endscript]
;------------------------------------------------------------------------------------------------
;腳本文件的還原
;------------------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------------------
;處理1-dic返回參數Arr(一行)
;------------------------------------------------------------------------------------------------
[iscript]
//顯示用
function dictoArr(dic)
{
   //將對照表裡提到的其他參數進行解釋
   var arr=[];
   arr[0]="@"+dic.tagname;
   var elm=[];
   //將對照表複製成數組
   elm.assign(dic);
   //循環
           for (var i=0;i<elm.count;i+=2)
        {
           if (elm[i]!="" && elm[i+1]!="" && elm[i]!="tagname")
           {
             if (typeof elm[i+1]!="String") arr.add(elm[i]+"="+"\""+elm[i+1]+"\"");
             else if (elm[i+1].charAt(0)=="&") arr.add(elm[i]+"="+elm[i+1]);
             else arr.add(elm[i]+"="+"\""+elm[i+1]+"\"");
           }
        }
   return arr;
}
[endscript]
;------------------------------------------------------------------------------------------------
;處理2-dic返回tag(一行.不包括_blank,_end,iscript),回寫用
;------------------------------------------------------------------------------------------------
[iscript]
function dictoTag(dic)
{
   //註釋
   if (dic.tagname=="_remark") return dic.text;
   //對話
   else if (dic.tagname=="_msg") return dic.text;
   //標籤
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
;處理3-回寫
;------------------------------------------------------------------------------------------------
[iscript]
function createAllScript(script)
{
   var arr=[];
   for (var i=0;i<script.count-1;i++)
   {
     //是代碼
      if (script[i].tagname=="iscript")
      {
         arr.add("[iscript]");
         arr.add(script[i].tjs);
         arr.add("[endscript]");
      }
     //是TAG
      else if (script[i].tagname!="_blank")
     {
        arr.add(dictoTag(script[i]));
     }
   }

   return arr;
}
[endscript]
;----------------------------------------------------------------------------
[return]
