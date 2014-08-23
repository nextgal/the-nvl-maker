;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

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

	var path=Storages.getLocalName(sf.path+"json/");
	Scripts.saveJSON(path+file, flagname, 1, 0);
}

//-------------------------------------------------------------------------------------------
//BKE格式转换
//-------------------------------------------------------------------------------------------
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

		dm(dic.tagname);

		switch (dic.tagname)
		{
			case "_remark":
				text="//"+dictoTag(dic);
				break;

			case "_label":
				text=dic.label;
				if (dic.cansave!=void && dic.cansave!=false) text+="\n"+"@setlabel name=\""+dic.pagename+"\"";
				break;

			case "_msg":
				text=dic.text;
				break;


			//重名&特殊TAG强转
			case "elsif":
				text="@elseif";
				text+=" exp=\""+exp+"\"";
				break;

			case "jump":
				text="@jump";
				if (dic.storage!=void) text+=" file=\""+Storages.chopStorageExt(dic.storage)+"\"";
				if (dic.target!=void) text+=" label=\""+dic.target+"\"";
				else text+=" label=\"*start\"";
				if (dic.cond!=void) text+=" cond=\""+dic.cond+"\"";
				break;

			case "call":
				text="@call";
				if (dic.storage!=void) text+=" file=\""+Storages.chopStorageExt(dic.storage)+"\"";
				if (dic.target!=void) text+=" label=\""+dic.target+"\"";
				else text+=" label=\"*start\"";
				if (dic.cond!=void) text+=" cond=\""+dic.cond+"\"";
				break;

			case "bgm":
				text="@bgm file=\""+dic.storage+"\"";
				if (dic.time!=void) text+=" fadein="+dic.time;
				break;

			case "se":
				text="@se file=\""+dic.storage+"\"";
				if (dic.buf!=void) text+=" channel="+dic.buf;
				if (dic.time!=void) text+=" fadein="+dic.time;
				if (dic.loop!=void) text+=" loop="+dic.loop;
				break;

			case "s":
				text="@waitbutton";
				break;

			default:
				text=dictoTag(dic);
				break;
		}

		//添加这行转换完成的代码
		arr.add(text);
	}

	//保存转换后的脚本
	var bpath=Storages.getLocalName(sf.path+"BKE/scenario/"+filename+".bkscr");
	arr.save(bpath);

}

//-------------------------------------------------------------------------------------------
//批量转换
//-------------------------------------------------------------------------------------------
function convertAllToBKE()
{
	//转换剧本
	var sclist=[].load(sf.sclist);

	for (var i=0;i<sclist.count;i++)
	{
		var filename=sclist[i];
		if (filename!=void) 
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

	arr.add("@macro name=\"主角\""+" face fg layer");

	for (var i=2;i<f.config_name.count;i++)
	{
		var tag=f.config_name[i].tag;
		arr.add("@macro name=\""+tag+"\""+" face fg layer");
	}
	arr.add("[return]");
	arr.add("//-------------------------------------------");
	//输出人名宏
	arr.add("");
	arr.add("*主角");
	arr.add("@npc id=\"主角\""+" face=face fg=fg layer=layer");
	arr.add("[return]");
	arr.add("//-------------------------------------------");
	for (var i=2;i<f.config_name.count;i++)
	{
		arr.add("");
		var tag=f.config_name[i].tag;
		var name=f.config_name[i].name;
		var color=f.config_name[i].color;
		arr.add("*"+tag);
		arr.add("@npc id=\""+name+"\""+" color="+color+" face=face fg=fg layer=layer");
		arr.add("[return]");
		arr.add("//-------------------------------------------");
	}
	//保存至文件
	var bpath=Storages.getLocalName(sf.path+"BKE/macro/macro_name.bkscr");
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
	
	//输出姓名
	var npath=Storages.getLocalName(sf.path+"BKE/macro/namelist.tjs");
	f.config_name.saveStruct(npath);

	//输出TXT列表
	saveTxtList("bgmlist");
	saveTxtList("cglist");


}

//保存界面配置文件
function saveUIlist(filename)
{
	var dic=Scripts.evalStorage(sf.path+"macro/"+filename+'.tjs');
	(Dictionary.saveStruct incontextof dic)(sf.path+"BKE/macro/"+filename+".tjs");
}

//保存TXT文件
function saveTxtList(filename)
{
	var opath=Storages.getLocalName(sf.path+"macro/"+filename+".txt");
	var tpath=Storages.getLocalName(sf.path+"BKE/macro/"+filename+".txt");

	var txt=[].load(opath);
	txt.save(tpath);
}

//导出剧本中用到的TAG列表
function recordTagList()
{
	//载入剧情列表：
	//取得ks文件列表
	var sclist=[].load(sf.sclist);

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
		"map","clmap","edu","cledu"
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
	var bpath=Storages.getLocalName(sf.path+"BKE/"+"taglist.txt");
	arr.save(bpath);

	System.inform("导出至"+Storages.getLocalName(sf.path+"BKE/"));
	//打开文件夹
	System.shellExecute(Storages.getLocalName(sf.path+"BKE/"));

}

[endscript]

[return]
