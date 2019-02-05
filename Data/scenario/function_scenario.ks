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
function getTrpgLogBat()
{
	//取得脚本文件列表
	var sclist=[].load(sf.sclist);
	//逐个解读
	for (var i=0;i<sclist.count;i++)
	{
		var filename=sclist[i];
		if (filename==void) break;
		getTrpgLog(filename);
	}

	System.inform("转换成功！");

}
function getTrpgLog(filename="log")
{
	dm("转换TRPGLOG");
	
	var arr=[].load(System.exePath + "project/"+sf.project+"/"+filename+".txt");
	var path=Storages.getLocalName(sf.path+"scenario/"+filename+".ks");

	//逐个解读
	for (var i=0;i<arr.count;i++)
	{
		//替换吐槽
		//arr[i]=textReplace(arr[i],"[","（");
		//arr[i]=textReplace(arr[i],"]","）");
		//替换人名格式
		arr[i]=textReplace(arr[i],"<","[");
		arr[i]=textReplace(arr[i],">","]");
		//添加标记
		arr[i]+="[w]";
	}

	arr.insert(0,"@dia");
	arr.save(path);

}

function getTalk(folder="scenario")
{
	var filelist=Storages.getLocalName(GetPath(folder+".txt"));
	var sclist=[].load(filelist);
	var arr=[];
	var repeatdic=%[];

	//取得所有的剧本内文字
	for (var i=0;i<sclist.count;i++)
	{
		//取得文件名
		var filename=sclist[i];
		if (filename==void) continue;
		dm(filename);
		//取得路径
		var path=Storages.getLocalName(sf.path+folder+"/"+filename+".ks");
		dm("导出文本："+path);

		//分析TAG
		var script=extractTagsFromKS_DCustom(path);

		//var num=arr.count;
		var num=0;
		arr.add(num+"■■["+filename+"]");
		var npc="";

		//按行读取
		for (var j=0;j<script.count;j++)
		{
			//人名
			if (findName(script[j].tagname))
			{
				npc=script[j].tagname;
			}
			//路人名
			else if (script[j].tagname=="npc")
			{
				npc=script[j].id;
			}
			//重置对话框则重置人名提示
			else if (script[j].tagname=="dia" || script[j].tagname=="scr")
			{
				npc="";
			}
			//对话
			else if (script[j].tagname=="_msg")
			{
				var text=script[j].text;

				var hint;

				if (repeatdic[text]==true) {hint="{re}";}
				else hint="";

				num++;
				//var num=arr.count;
				if (npc==void)
				{
					arr.add(num+"■"+"■"+text+"■"+hint);
				}
				else
				{
					arr.add(num+"■"+npc+"■"+text+"■"+hint);
					npc="";
				}

				script[j].text="■"+num+"■";
				repeatdic[text]=true;
			}
			//选择
			else if (script[j].tagname=="selbutton")
			{
				var text=script[j].text;
				num++;
				//var num=arr.count;
				arr.add(num+"■selection■"+text);
				script[j].text="■"+num+"■";
			}
			//标签
			else if (script[j].tagname=="_label" && script[j].pagename!=void)
			{
				var text=script[j].pagename;
				num++;
				arr.add(num+"■label■"+text);
				script[j].pagename="■"+num+"■";
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
	var path2=Storages.getLocalName(sf.outputpath+"/translate/"+folder+".txt");
	saveScript(path2,arr);

	System.inform("导出至"+Storages.getLocalName(sf.outputpath+"/translate/"));
	System.shellExecute(Storages.getLocalName(sf.outputpath+"/translate/"));
}

[endscript]
;------------------------------------------------------------------------------------------------
;导出剧本
;------------------------------------------------------------------------------------------------
[iscript]
function getScenario(folder="scenario")
{
	var filelist=Storages.getLocalName(GetPath(folder+".txt"));
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
		dm("导出文本："+path);

		//分析TAG
		var script=extractTagsFromKS_DCustom(path);

		var num=0;
		arr.add(num+"■["+filename+"]");

		//按行读取
		for (var j=0;j<script.count;j++)
		{
			//对话
			if (script[j].tagname=="_msg")
			{
				var text=script[j].text;
				num++;
				arr.add(num+"■"+text);
				script[j].text="■"+num+"■";
			}
			//选择
			else if (script[j].tagname=="selbutton")
			{
				var text=script[j].text;
				num++;
				arr.add(num+"■"+text);
				script[j].text="■"+num+"■";
			}
			//标签
			else if (script[j].tagname=="_label" && script[j].pagename!=void)
			{
				var text=script[j].pagename;
				num++;
				arr.add(num+"■"+text);
				script[j].pagename="■"+num+"■";
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
	var path2=Storages.getLocalName(sf.outputpath+"/translate/"+folder+".txt");
	saveScript(path2,arr);

	System.inform("导出至"+Storages.getLocalName(sf.outputpath+"/translate/"));
	System.shellExecute(Storages.getLocalName(sf.outputpath+"/translate/"));
}

[endscript]
;------------------------------------------------------------------------------------------------
;回写翻译
;------------------------------------------------------------------------------------------------
[iscript]

function getTransLine(text)
{
	var stp=text.indexOf("■");
	var num=text.substring(0,stp);
	var line=text.substring(stp+1,text.length-stp);
	return line;
}

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

function reWriteTranslate(folder="scenario",file="translate")
{

	var filelist=Storages.getLocalName(GetPath(folder+".txt"));
	var sclist=[].load(filelist);

	//翻译文本路径
	var transfilepath=sf.outputpath+'translate/'+file+'.txt';
	if (Storages.isExistentStorage(transfilepath)==false) return;

	var arr=[].load(Storages.getLocalName(transfilepath));

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
		for (var i=0;i<arr.count;i++)
		{
			if (getTransLine(arr[i])=="["+filename+"]")
			{
				startline=i;
				dm("找到文件"+filename+"开始行数"+startline);
			}
		}

		//从当前行号开始检查台词
		for (var j=0;j<script.count;j++)
		{
			if (script[j]==void) continue;

			if (script[j].indexOf("■")!=-1)
			{
				//取得编号
				var linenum=startline+getOrinNum(script[j]);
				var text=getTransLine(arr[linenum]);
				//根据编号替换内容
				script[j]=getReplaceLine(script[j],text);
			}

		}

		var path2=Storages.getLocalName(sf.outputpath+"/translate/tran/"+folder+"/"+filename+".ks");
		//保存修改过的脚本
		script.save(path2);

	}

	System.inform("回写至"+Storages.getLocalName(sf.outputpath+"/translate/tran/"));
	System.shellExecute(Storages.getLocalName(sf.outputpath+"/translate/"));
}

[endscript]
;----------------------------------------------------------------------------
[iscript]
function addTag(ori,trans)
{
	var text=trans;

	//句尾标记指令数组（可自行添加）
	var arr=["r","l","lr","er","p","w"];

	for (var i=0;i<arr.count;i++)
	{
		var tag="["+arr[i]+"]";
		if (ori.indexOf(tag) != -1 && trans.indexOf(tag) == -1) text=trans+tag;
	}

	return text;
}

function addTagAll(folder="scenario",file="translate")
{

	//翻译文本路径
	var transfilepath=sf.outputpath+'translate/'+file+'.txt';
	if (Storages.isExistentStorage(transfilepath)==false) return;

	var fileA=Storages.getLocalName(sf.outputpath+"translate/"+folder+".txt");
	var fileB=Storages.getLocalName(transfilepath);

	var arrA=[].load(fileA);
	var arrB=[].load(fileB);

	for (var i=0;i<arrA.count;i++)
	{
		arrB[i]=addTag(arrA[i],arrB[i]);
	}

	arrB.save(fileB);
}
[endscript]
[return]
