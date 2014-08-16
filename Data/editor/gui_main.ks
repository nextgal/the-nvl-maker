;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;---------------------------------------------------------------
;界面设定
;---------------------------------------------------------------
*start
[eval exp="drawPageBoard(72)"]
;---------------------------------------------------------------
[unlocklink]
[current layer="message1"]
[er]
;---------------------------------------------------------------
;有工程时，显示按钮
[if exp="sf.project!=void"]
;---------------------------------------------------------------
[frame title="主界面样式" line=1 x=15 y=15]

[locate x=50 y=40]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*KAGConfig]
[eval exp="drawButtonCaption('Config.tjs')"]

[locate x=190 y=40]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*对话画面]
[eval exp="drawButtonCaption('对话画面')"]

;---------------------------------------------------------------
[frame title="系统样式" line=2 x=15 y=95]

;title
[locate x=50 y=120]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*标题画面]
[eval exp="drawButtonCaption('默认标题')"]

;menu
[locate x=190 y=120]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*主菜单]
[eval exp="drawButtonCaption('主选单')"]

;option
[locate x=50 y=150]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*系统设定]
[eval exp="drawButtonCaption('系统设定')"]

;history
[locate x=190 y=150]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*对话履历]
[eval exp="drawButtonCaption('历史记录')"]

;---------------------------------------------------------------
[frame title="存取系统样式" line=2 x=15 y=205]

;版面
[locate x=50 y=230]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*存取版面设定]
[eval exp="drawButtonCaption('版面设定')"]

;save
[locate x=50 y=260]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*存储系统图形]
[eval exp="drawButtonCaption('存储画面')"]
;load
[locate x=190 y=260]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*读取系统图形]
[eval exp="drawButtonCaption('读取画面')"]
;---------------------------------------------------------------
[frame title="特别模式" line=2 x=15 y=315]
[locate x=50 y=340]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*CG界面]
[eval exp="drawButtonCaption('CG界面编辑')"]
[iscript]
tf.cgpath=Storages.getLocalName(sf.path+"macro/"+"cglist.txt");
[endscript]
[locate x=190 y=340]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" exp="System.shellExecute(tf.cgpath)" hint="将所有需要显示的CG图片名写进本TXT中，在脚本中登陆CG后即可显示"]
[eval exp="drawButtonCaption('CG列表编辑')"]
[iscript]
tf.bgmpath=Storages.getLocalName(sf.path+"macro/"+"bgmlist.txt");
[endscript]
[locate x=50 y=370]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" exp="System.shellExecute(tf.bgmpath)" hint="将曲目名称和对应文件按照每行一个写入本TXT即可在BGM模式中显示"]
[eval exp="drawButtonCaption('BGM列表编辑')"]

[frame title="数据导出" line=2 x=345 y=15]
[locate x=380 y=40]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" exp="System.shellExecute(sf.sclist)"]
[eval exp="drawButtonCaption('脚本列表')"]

[locate x=520 y=40]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*导出JSON]
[eval exp="drawButtonCaption('导出JSON')"]
[endif]

[locate x=380 y=70]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*导出BKE]
[eval exp="drawButtonCaption('导出BKE')"]
[endif]

[locate x=520 y=70]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*导出TAG]
[eval exp="drawButtonCaption('导出TAG')"]
[endif]

[licence]

[s]

*标题画面
[iscript]
//重载
f.setting=getConfig();
[endscript]
[jump storage="gui_title.ks"]

*主菜单
[iscript]
//重载
f.setting=getConfig();
[endscript]
[jump storage="gui_menu.ks"]

*对话画面
[iscript]
//重载
f.setting=getConfig();
[endscript]
[jump storage="gui_dia.ks"]

*KAGConfig
[iscript]
var config_path1=System.exePath + 'project/'+sf.project+'/Data/'+'Config.tjs';
var config_path2=Storages.getLocalName(config_path1);
System.shellExecute(Storages.getLocalName(System.exePath+'tool/') + 'KAGConfigEx2.exe',"\""+config_path2+"\"");
[endscript]
[jump target=*start]

*系统设定
[iscript]
//重载
f.setting=getConfig();
[endscript]
[jump storage="gui_option.ks"]

*对话履历
[iscript]
//重载
f.setting=getConfig();
[endscript]
[jump storage="gui_history.ks"]

*存取版面设定
[iscript]
//重载
f.setting=getConfig();
[endscript]
[jump storage="gui_sl.ks"]

*存储系统图形
[jump storage="gui_savestyle.ks"]

*读取系统图形
[jump storage="gui_loadstyle.ks"]

*CG界面
[iscript]
//重载
f.setting=getConfig();
[endscript]
[jump storage="gui_cgmode.ks"]

*导出JSON
[iscript]
function outAsJson(file,flagname)
{

	var path=Storages.getLocalName(sf.path+"json/");
	Scripts.saveJSON(path+file, flagname, 1, 0);
}

outAsJson("setting.json",f.setting);
outAsJson("uititle.json",f.config_title);
outAsJson("uidia.json",f.config_dia);

outAsJson("uisave.json",f.config_save);
outAsJson("uiload.json",f.config_load);
outAsJson("uislpos.json",f.config_slpos);

outAsJson("uimenu.json",f.config_menu);
outAsJson("uioption.json",f.config_option);
outAsJson("uihistory.json",f.config_history);
outAsJson("uicgmode.json",f.config_cgmode);

outAsJson("namelist.json",f.config_name);

System.inform("导出至"+Storages.getLocalName(sf.path+"json/"));
//打开文件夹
System.shellExecute(Storages.getLocalName(sf.path+"json/"));

[endscript]
[jump target=*start]

*导出BKE
[iscript]
function convertBKE(filename)
{
	var path=Storages.getLocalName(sf.path+"scenario/"+filename+".ks");
	dm("剧本解析中："+path);
	var script=extractTagsFromKS_DCustom(path);
	var arr=[];

	//将解析的剧本转换成BKE的格式
	for (var i=0;i<script.count;i++)
	{
		var dic=script[i];
		var text;

		switch (dic.tagname)
		{
			case "_remark":
				text="//"+dictoTag(dic);
				break;

			case "_label":
				text=dic.label;
				if (dic.cansave!=void && dic.cansave!=false) text+="\n"+"@setlabel name="+dic.pagename;
				break;

			case "_msg":
				text=dic.text;
				break;

			//重名TAG强转
			case "jump":
				text="@jump";
				if (dic.storage!=void) text+=" file=\""+Storages.chopStorageExt(dic.storage)+"\"";
				if (dic.target!=void) text+=" label=\""+dic.target+"\"";
				else text+=" label=\"*start\"";
				break;

			case "call":
				text="@call";
				if (dic.storage!=void) text+=" file=\""+Storages.chopStorageExt(dic.storage)+"\"";
				if (dic.target!=void) text+=" label=\""+dic.target+"\"";
				else text+=" label=\"*start\"";
				break;
			case "bgm":
				text="@bgm file="+dic.storage;
				break;
			case "se":
				text="@se file="+dic.storage;
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

function convertAllToBKE()
{
	//转换剧本
	var sclist=[].load(sf.sclist);
	for (var i=0;i<sclist.count;i++)
	{
		var filename=sclist[i];
		if (filename==void) break;
		convertBKE(filename);
	}

	//输出人名宏
	var arr=[];
	arr.add("//-------------------------------------------");
	arr.add("//自动生成的人物姓名宏");
	arr.add("//-------------------------------------------");
	arr.add("*register");

	for (var i=2;i<f.config_name.count;i++)
	{
		var tag=f.config_name[i].tag;
		arr.add("@macro name=\""+tag+"\"");
	}
	arr.add("[return]");
	arr.add("//-------------------------------------------");
	//输出人名宏
	for (var i=2;i<f.config_name.count;i++)
	{
		var tag=f.config_name[i].tag;
		var name=f.config_name[i].name;
		var color=f.config_name[i].color;
		arr.add("*"+tag);
		arr.add("@npc id=\""+name+"\""+" color="+color);
		arr.add("[return]");
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

function saveUIlist(filename)
{
	var dic=Scripts.evalStorage(sf.path+"macro/"+filename+'.tjs');
	(Dictionary.saveStruct incontextof dic)(sf.path+"BKE/macro/"+filename+".tjs");
}

function saveTxtList(filename)
{
	var opath=Storages.getLocalName(sf.path+"macro/"+filename+".txt");
	var tpath=Storages.getLocalName(sf.path+"BKE/macro/"+filename+".txt");

	var txt=[].load(opath);
	txt.save(tpath);
}

convertAllToBKE();
System.inform("导出至"+Storages.getLocalName(sf.path+"BKE/"));
//打开文件夹
System.shellExecute(Storages.getLocalName(sf.path+"BKE/"));
[endscript]
[jump target=*start]

*导出TAG
[iscript]
function recordTagList()
{
	//载入剧情列表：
	//取得ks文件列表
	var sclist=[].load(sf.sclist);

	var arr=[];
	var dic=%[];

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
recordTagList();
[endscript]
[jump target=*start]
