;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------------------
;导出台词
;------------------------------------------------------------------------------------------------
[iscript]
function getTalk()
{
	//取得ks文件列表
	var sclist=[].load(sf.sclist);

	//逐个解读
	for (var i=0;i<sclist.count;i++)
	{
		var filename=sclist[i];
		if (filename==void) break;
		var path=Storages.getLocalName(sf.path+"scenario/"+filename+".ks");
		dm("导出台词："+path);
	
		var script=extractTagsFromKS_DCustom(path);
	
		var arr=[];
		var dia=false;
	
		for (var j=0;j<script.count;j++)
		{
			//人名
			if (findName(script[j].tagname))
			{
				arr.add("【"+script[j].tagname+"】");
				dia=true;
			}
			//路人名
			if (script[j].tagname=="npc")
			{
				arr.add("【"+script[j].id+"】");
				dia=true;
			}
			//对话
			if ((script[j].tagname=="_msg") && (dia==true))
			{
				var text=script[j].text;
				//段落末尾换行标记
				var br=false;
				//假如有[w]换行标记
				if (text.indexOf("[w]")!=-1) br=true;
				//删除所有[]中间的东西
				var reg=new RegExp("\\[[^\]]*\\]","g");
				var text2=text.replace(reg,"");
				//dm(text2);
				arr.add(text2);
				//假如有换行
				if (br) 
				{
					arr.add("");
					dia=false;//对话中的标记重置
				}
			}
		}
		//将台词保存成TXT
		var path2=Storages.getLocalName(sf.outputpath+"line/"+filename+".txt");
		if (arr.count>0) arr.save(path2);
		//saveScript(path2,arr);
	}

	System.inform("导出至"+Storages.getLocalName(sf.outputpath+"line/"));
	System.shellExecute(Storages.getLocalName(sf.outputpath));

}
[endscript]
;------------------------------------------------------------------------------------------------
;导出剧本
;------------------------------------------------------------------------------------------------
[iscript]
function getScenario()
{
	var filelist=Storages.getLocalName(sf.path+"macro/"+"scenario.txt");
	var sclist=[].load(filelist);
	var arr=[];

	//取得所有的剧本内文字
	for (var i=0;i<sclist.count;i++)
	{
		//取得文件名
		var filename=sclist[i];
		if (filename==void) continue;
		//取得路径
		var path=Storages.getLocalName(sf.path+"scenario/"+filename+".ks");
		dm("导出文本："+filename);

		//分析TAG
		var script=extractTagsFromKS_DCustom(path);

		var num=0;
		arr.add(num+"■["+filename+"]");
		num++;

		//按行读取
		for (var j=0;j<script.count;j++)
		{
			//对话
			if (script[j].tagname=="_msg")
			{
				var text=script[j].text;
				arr.add(num+"■"+text);
				script[j].text="■"+num+"■";
				num++;
			}
			//选择
			else if (script[j].tagname=="selbutton")
			{
				var text=script[j].text;
				arr.add(num+"■"+text);
				script[j].text="■"+num+"■";
				num++;
			}
			//标签
			else if (script[j].tagname=="_label" && script[j].pagename!=void)
			{
				var text=script[j].pagename;
				arr.add(num+"■"+text);
				script[j].pagename="■"+num+"■";
				num++;
			}
		}
		//保存修改过的脚本
		//转换为tag
		var tag=createAllScript(script);
		//保存
		var bpath=Storages.getLocalName(sf.outputpath+"/translate/orin/"+filename+".ks");
		dm("备份文本："+bpath);
		tag.save(bpath);
	}

	//保存翻译文件
	var path2=Storages.getLocalName(sf.outputpath+"/translate/dialogue.txt");
	saveScript(path2,arr);

	System.inform("导出至"+Storages.getLocalName(sf.outputpath+"/translate/"));
	System.shellExecute(Storages.getLocalName(sf.outputpath+"/translate/"));
}

[endscript]
;------------------------------------------------------------------------------------------------
;回写翻译
;------------------------------------------------------------------------------------------------
[iscript]
//取得对应翻译的文字内容
function getTransLine(text)
{
	var stp=text.indexOf("■");
	var num=text.substring(0,stp);
	var line=text.substring(stp+1,text.length-stp);
	return line;
}
//根据文字取得编号
function getOrinNum(text)
{
	var stp=text.indexOf("■");
	var num;
	//是对话的情况
	if (stp==0)
	{
		var reg=new RegExp("■","g");
		num=text.replace(reg,"");
	}
	else
	{
		var line=text.split("■");
		num=line[1];
	}

	return (int)num;
}
//进行台词替换
function getReplaceLine(line,translate)
{
	if (line.indexOf("■")==0)
	{
		//台词的情况
		return translate;
	}
	else
	{
		//其他的情况
		var arr=line.split("■");
		return arr[0]+translate+arr[2];
	}
}

function reWriteTranslate(inputfile="dialogue")
{
	//读入文件列表
	var filelist=Storages.getLocalName(sf.path+"macro/"+"scenario.txt");
	var sclist=[].load(filelist);

	//读入翻译数组
	var arr=[].load(Storages.getLocalName(sf.outputpath+"/translate/"+inputfile+".txt"));
	//取得所有的剧本内文字
	for (var i=0;i<sclist.count;i++)
	{
		//取得文件名
		var filename=sclist[i];
		if (filename==void) break;

		var path=Storages.getLocalName(sf.outputpath+"/translate/orin/"+filename+".ks");
		var script=[].load(path);
		var startline=0;

		//根据文件名取得对应的行号
		for (var j=0;j<arr.count;j++)
		{
			if (getTransLine(arr[j])=="["+filename+"]")
			{
				startline=j;
				dm("找到文件"+filename+"开始行数"+startline);
			}
		}

		//从当前行号开始检查台词
		for (var k=0;k<script.count;k++)
		{
			if (script[k]==void) continue;

			if (script[k].indexOf("■")!=-1)
			{
				//取得编号
				var linenum=startline+getOrinNum(script[k]);
				var text=getTransLine(arr[linenum]);
				//根据编号替换内容
				script[k]=getReplaceLine(script[k],text);
			}
		}
		var path2=Storages.getLocalName(sf.outputpath+"/translate/tran/"+filename+".ks");
		//保存修改过的脚本
		script.save(path2);
	}
	System.inform("回写至"+Storages.getLocalName(sf.outputpath+"/translate/tran/"));
	System.shellExecute(Storages.getLocalName(sf.outputpath+"/translate/"));
}


/*
function reWriteTranslate()
{
	//读入文件列表
	var filelist=Storages.getLocalName(sf.path+"macro/"+"scenario.txt");
	var sclist=[].load(filelist);

	//读入翻译数组
	var arr=[].load(Storages.getLocalName(sf.outputpath+"/translate/dialogue.txt"));
	var dic=[];
	//翻译文本处理
	for (var i=0;i<arr.count;i++)
	{
		var text=arr[i];
		//开始的位置
		var stp=text.indexOf("■");
		var num=text.substring(0,stp);
		var line=text.substring(stp+1,text.length-stp);
		dic[num]=line;
	}

	//取得所有的剧本内文字
	for (var i=0;i<sclist.count;i++)
	{
		//取得文件名
		var filename=sclist[i];
		if (filename==void) break;

		var path=Storages.getLocalName(sf.outputpath+"/translate/orin/"+filename+".ks");
		var script=[].load(path);
		var startline=0;
		
		//根据文件名取得对应的行号
		for (var i=0;j<script.count;j++)
		{
				if (getTransLine(arr[i])=="["+filename+"]")
			{
				startline=i;
				dm("找到文件"+filename+"开始行数"+startline);
			}

			if (script[j]==void) continue;

			if (script[j].indexOf("■")!=-1)
			{
				var text=script[j];
				var stp=text.indexOf("■");
				//是对话的情况
				if (stp==0)
				{
					var reg=new RegExp("■","g");
					var num=text.replace(reg,"");
					script[j]=dic[num];
				}
				//是选项、标签的情况
				else
				{
					var line=text.split("■");
					script[j]=line[0]+dic[line[1]]+line[2];
					dm(script[j]);
				}
			}

		}
		var path2=Storages.getLocalName(sf.outputpath+"/translate/tran/"+filename+".ks");
		//保存修改过的脚本
		script.save(path2);

	}

	System.inform("回写至"+Storages.getLocalName(sf.outputpath+"/translate/tran/"));
	System.shellExecute(Storages.getLocalName(sf.outputpath+"/translate/"));
}
*/
[endscript]
;----------------------------------------------------------------------------
[return]
