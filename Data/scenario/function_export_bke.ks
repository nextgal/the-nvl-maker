;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;---------------------------------------------------------------
;界面数据导出
;---------------------------------------------------------------
*start

[iscript]
//-------------------------------------------------------------------------------------------
//导出JSON
//-------------------------------------------------------------------------------------------

function outAsJson(file,flagname)
{

	var path=Storages.getLocalName(sf.outputpath+"json/");
	Scripts.saveJSON(path+file, flagname, 1, 0);
}

//-------------------------------------------------------------------------------------------
//查找替换内容
//-------------------------------------------------------------------------------------------
function textReplace(text,key,out="")
{
	var re = new RegExp(key,"g");
	text=text.replace(re,out);
	return text;
}
//-------------------------------------------------------------------------------------------
//BKE格式转换
//-------------------------------------------------------------------------------------------
function checkLabelNum(label)
{
	//标签处理
	var text=label.substring(1);

	//去掉空格
	//text=text.trim();

	//修正数字开头的标签
	var num=text[0];

	if (num>0 && num<9)
	{
		return "*"+"label_"+text;
	}
	else
	{
		return "*"+text;
	}

}
function convertLineBKE(dic)
{
		var text;
		dm(dic.tagname);

		switch (dic.tagname)
		{
			case "_remark":
				text="//"+dictoTag(dic);
				break;

			case "_label":
				text=checkLabelNum(dic.label);
				if (dic.cansave!=void && dic.cansave!=false) 
				{
					var pagename=textReplace(dic.pagename,"&");
					text+="\n"+"@setlabel name=\""+pagename+"\"";
				}
				break;

			case "_msg":
				text=dic.text;
				break;

			case "iscript":
				text="##\n";
				text+=dic.tjs;
				text+="\n##";
				break;

			//重名&特殊TAG强转
			case "elsif":
				text=dictoTag(dic);
				text=textReplace(text,"@elsif","@elseif");
				break;

			case "ignore":
				text=dictoTag(dic);
				text=textReplace(text,"@ignore","@if");
				text+="\n@else";
				break;

			case "endignore":
				text=dictoTag(dic);
				text=textReplace(text,"@endignore","@endif");
				break;

			case "jump":
				if (dic.target!=void) dic.target=checkLabelNum(dic.target);
				text=dictoTag(dic);
				text=textReplace(text,"@jump","@njump");
				text=textReplace(text,".ks","");
				break;

			case "call":
				if (dic.target!=void) dic.target=checkLabelNum(dic.target);
				text=dictoTag(dic);
				text=textReplace(text,"@call","@ncall");
				text=textReplace(text,".ks","");
				break;

			case "locate":
				text=dictoTag(dic);
				text=textReplace(text,"@locate","@nlocate");
				break;

			case "action":
				text=dictoTag(dic);
				text=textReplace(text,"@action","@kag_action");
				break;

			case "video":
				text=dictoTag(dic);
				text=textReplace(text,"@video","@kag_video");
				break;

			case "stopaction":
				text=dictoTag(dic);
				text=textReplace(text,"@stopaction","@kag_stopaction");
				break;

			case "trans":
				text=dictoTag(dic);
				text=textReplace(text,"method=","mode=");
				break;

			case "bgm":
				text=dictoTag(dic);
				text=textReplace(text,"@bgm","@nbgm");
				text=textReplace(text,".ogg","");
				text=textReplace(text,".wav","");
				text=textReplace(text,".mp3","");
				break;

			case "se":
				text=dictoTag(dic);
				text=textReplace(text,"@se","@nse");
				text=textReplace(text,".ogg","");
				text=textReplace(text,".wav","");
				text=textReplace(text,".mp3","");
				break;

			case "vo":
				text=dictoTag(dic);
				text=textReplace(text,".ogg","");
				text=textReplace(text,".wav","");
				text=textReplace(text,".mp3","");
				break;

			case "s":
				text="@waitbutton";
				break;

			case "selbutton":
				dic.target=checkLabelNum(dic.target);
				text=dictoTag(dic);
				text=textReplace(text,".ogg","");
				text=textReplace(text,".wav","");
				text=textReplace(text,".mp3","");
				break;

			default:
				text=dictoTag(dic);
				break;
		}

		return text;

}

function convertBKE(filename)
{
	var path=Storages.getLocalName(sf.path+"scenario/"+filename+".ks");
	dm("剧本解析中："+path);

	//生成数组
	var script=[];
	script=extractTagsFromKS_DCustom(path);
	var arr=[];

	//将解析的剧本转换成BKE的格式
	for (var i=0;i<script.count;i++)
	{
		var dic=script[i];
		var text;

		text=convertLineBKE(dic);

		if (typeof text == "String")
		{		
			//添加这行转换完成的代码
			arr.add(text);
		}
		else
		{
			for (var j=0;j<text.count;j++)
			{
				arr.add(text[j]);
			}
		}
	
	}

	//修正错误的文件名
	if (filename=="prelogue") filename="prologue";

	//保存转换后的脚本
	var bpath=Storages.getLocalName(sf.outputpath+"BKE/scenario/"+filename+".bkscr");
	arr.save(bpath);

}

//-------------------------------------------------------------------------------------------
//批量转换
//-------------------------------------------------------------------------------------------
function convertAllToBKE()
{
	//转换剧本
	var sclist=[].load(GetPath("scenario.txt"));

	for (var i=0;i<sclist.count;i++)
	{
		var filename=sclist[i];
		if (filename!=void && filename!="title")
			{
				convertBKE(filename);
			}
	}

	//输出人名宏
	var arr=[];
	arr.add("//-------------------------------------------");
	arr.add("//自动生成的人物姓名宏");
	arr.add("//-------------------------------------------");
	arr.add("*register");

	arr.add("@macro name=\"主角\""+" face fg layer color tag");

	for (var i=2;i<f.config_name.count;i++)
	{
		var tag=f.config_name[i].tag;
		arr.add("@macro name=\""+tag+"\""+" face fg layer color tag");
	}
	arr.add("[return]");
	arr.add("//-------------------------------------------");
	//输出人名宏
	arr.add("");
	arr.add("*主角");
	arr.add("@npc id=\"主角\""+" face=face fg=fg layer=layer color=color tag='主角'");
	arr.add("[return]");
	arr.add("//-------------------------------------------");
	for (var i=2;i<f.config_name.count;i++)
	{
		arr.add("");
		var tag=f.config_name[i].tag;
		var name=f.config_name[i].name;
		var color=f.config_name[i].color;
		arr.add("*"+tag);
		arr.add("@npc id=\""+name+"\""+" face=face fg=fg layer=layer color=color tag=\""+name+"\"");
		arr.add("[return]");
		arr.add("//-------------------------------------------");
	}
	//保存至文件
	var bpath=Storages.getLocalName(sf.outputpath+"BKE/macro/macro_name.bkscr");
	arr.save(bpath);

	//输出界面配置表
	saveUIlist("setting");

	saveUIlist("uidia");
	saveUIlist("uioption");
	saveUIlist("uihistory");

	saveUIlist("uislpos");
	saveUIlist("uisave");
	saveUIlist("uiload");

	saveUIlist("uititle");
	saveUIlist("uimenu");

	saveUIlist("uicgmode");
	saveUIlist("uibgmmode");
	saveUIlist("uiendmode");
	saveUIlist("uiyesno");

	//输出姓名
	var npath=Storages.getLocalName(sf.outputpath+"BKE/uidata/namelist.tjs");
	f.config_name.saveStruct(npath);

	//输出TXT列表
	saveTxtList("bgmlist");
	saveTxtList("cglist");
	saveTxtList("endlist");
	saveTxtList("scenario");


}

//保存界面配置文件
function saveUIlist(filename)
{
	var path=GetPath(filename+'.tjs');

	if (Storages.isExistentStorage(path))
	{
		var dic=Scripts.evalStorage(path);
		(Dictionary.saveStruct incontextof dic)(sf.outputpath+"BKE/uidata/"+filename+".tjs");
	}
}

//保存TXT文件
function saveTxtList(filename)
{
	var path=GetPath(filename+'.txt');
	if (Storages.isExistentStorage(path))
	{
		var opath=Storages.getLocalName(path);
		var tpath=Storages.getLocalName(sf.outputpath+"BKE/uidata/"+filename+".txt");
	
		var txt=[].load(opath);
		txt.save(tpath);
	}
}

//导出剧本中用到的TAG列表
function recordTagList()
{
	//载入剧情列表：
	//取得ks文件列表
	var sclist=[].load(GetPath("scenario.txt"));

	var arr=[];
	var dic=%[];

	//设定姓名宏
	for (var i=2;i<f.config_name.count;i++)
	{
		var nametag=f.config_name[i].tag;
		dic[nametag]=true;
	}

	//设定已经实装的TAGNAME
	var existtag=
	[
		"_remark","_label","_msg","s","locate","npc",
		"dia","scr","menu","er","waitclick",
		"backlay","trans","wt","image","freeimage",
		"jump","call","rclick",
		"gotostart","return","if","endif","elsif",
		"addcg","addend",
		"bgm","se","history","selstart","selbutton","selend","clsel",
		"bg","clbg","fg","clfg","face","clface",
		"map","clmap","edu","cledu",
		"eval","font","resetfont",
		"fadeoutse","fadeoutbgm","fadese","fadeinse","fadeoutbgm","fadeinbgm","stopbgm","vo",
		"hidemes","showmes","w","l","r","lr",
		"主角"
	];

	for (var i=0;i<existtag.count;i++)
	{
		var tagname=existtag[i];
		if (tagname!=void) dic[tagname]=true;
	}

	//逐个解读
	for (var i=0;i<sclist.count;i++)
	{
		var filename=sclist[i];
		if (filename==void) break;
		var path=Storages.getLocalName(sf.path+"scenario/"+filename+".ks");
		dm("剧本解析中："+path);

		var script=extractTagsFromKS_DCustom(path);

		//搜索所有剧情文件内的TAG列表并保存
		for (var j=0;j<script.count;j++)
		{
			var tagname=script[j].tagname;

			if (dic[tagname]==void)
			{
				dm(tagname);
				arr.add(tagname);
				dic[tagname]=true;
			}
		}

	}

	//将array保存成文件：
	var bpath=Storages.getLocalName(sf.outputpath+"taglist.txt");
	arr.save(bpath);

	System.inform("导出至"+Storages.getLocalName(sf.outputpath));
	//打开文件夹
	System.shellExecute(Storages.getLocalName(sf.outputpath+"taglist.txt"));

}

[endscript]

[return]
