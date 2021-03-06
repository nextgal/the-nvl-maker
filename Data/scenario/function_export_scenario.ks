;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------------------
;生成ks脚本列表
;------------------------------------------------------------------------------------------------
[iscript]
function saveScenarioList(folder="scenario")
{
	var list=getfile(folder);
	var path=GetPath(folder+".txt");

	var arr=[];
	for (var i=0;i<list.count;i++)
	{
		var filename=list[i];
		dm(filename);
		if (Storages.extractStorageExt(filename)==".ks")
		{
			var skiparr=["start","about","title","title_other","first","other","other_sample"];
			var canskip=false;
			for (var j=0;j<skiparr.count;j++)
			{
				var compare=skiparr[j]+".ks";
				if (filename==compare) canskip=true;
			}

			if (canskip==false) arr.add(Storages.chopStorageExt(Storages.extractStorageName(filename)));
		}
	}

	arr.save(path);
}
[endscript]
;------------------------------------------------------------------------------------------------
;导出台词
;------------------------------------------------------------------------------------------------
[iscript]
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
;剧本格式整理
;------------------------------------------------------------------------------------------------
[iscript]
function FormatScenario(folder="scenario")
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
		var script=extractTagsFromKS_DCustom2(path);

		//保存修改过的脚本
		//转换为tag
		var tag=createAllScript(script);
		//保存
		var bpath=Storages.getLocalName(sf.outputpath+"/format/"+filename+".ks");
		tag.save(bpath);
	}


	System.inform("导出至"+Storages.getLocalName(sf.outputpath+"/format/"));
	System.shellExecute(Storages.getLocalName(sf.outputpath+"/format/"));

}

function extractTagsFromKS_DCustom2(filename)
{
	var tagarr = extractTagsFromKS(filename);
	var temparr = [];
	
	var p = 0;
	var texttemp = "";
	var tagcount = tagarr.count;
	var is_ch = false;
	
	while(p < tagcount)
	{
		if (tagarr[p].tagname=="_cr")
		{
			//换行，啥都不做
		}
		else if (tagarr[p].tagname == "_ch")
		{
			temparr.add(%["tagname" => "_msg", "text" => tagarr[p].text]);
		}
		else
		{
			temparr.add(tagarr[p]);
		}

		p++;
	}
	
	return temparr;
}
[endscript]
;------------------------------------------------------------------------------------------------
;添加自动标点
;------------------------------------------------------------------------------------------------
[iscript]
function FormatTalk(folder="scenario",mark_begin="『",mark_end="』")
{
	var filelist=Storages.getLocalName(GetPath(folder+".txt"));
	var sclist=[].load(filelist);

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
		var arr=[];

		var num=0;
		var istalk=false;
		var needmark=false;

		//按行读取
		for (var j=0;j<script.count;j++)
		{
			//人名
			if (findName(script[j].tagname) || script[j].tagname=="npc")
			{
				istalk=true;
			}
			//重置对话框则重置人名提示
			else if (script[j].tagname=="dia" || script[j].tagname=="scr")
			{
				istalk=false;
				needmark=false;
			}
			//对话
			else if (script[j].tagname=="_msg")
			{
				var text=script[j].text;

				if (istalk && needmark==false)
				{
					text=mark_begin+text;
					needmark=true;
				}

				//查找到[w]
				if (istalk && needmark && text.indexOf("[w]") != -1)
				{
					var index_w=text.indexOf("[w]");
					//在[w]前面插入结束符号
					text=text.substr(0,index_w)+mark_end+text.substr(index_w);

					istalk=false;
					needmark=false;
				}
				
				//处理后赋值
				script[j].text=text;

			}
			else if (script[j].tagname=="w")
			{
				//单独追加
				if (needmark)
				{
					arr.add(mark_end);
					istalk=false;
					needmark=false;
				}
			}

				arr.add(script[j]);

		}
		//保存修改过的脚本
		//转换为tag
		var tag=createAllScript(arr);
		//保存
		var bpath=Storages.getLocalName(sf.outputpath+"/format/"+filename+".ks");
		dm("备份文本："+bpath);
		tag.save(bpath);
	}

	System.inform("导出至"+Storages.getLocalName(sf.outputpath+"/format/"));
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
