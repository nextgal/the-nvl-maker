;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;---------------------------------------------------------------
;脚本编辑
;---------------------------------------------------------------
*start
[eval exp="drawPageBoard(143)"]
;---------------------------------------------------------------
[unlocklink]
[current layer="message1"]
[er]
;---------------------------------------------------------------
;有工程时，显示按钮(新建脚本、打开脚本)
[if exp="sf.project!=void"]
[frame title="脚本编辑" line=1 x=15 y=15]
[locate x=50 y=40]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*新建脚本]
[eval exp="drawButtonCaption('新建脚本',16)"]

[locate x=190 y=40]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*打开脚本]
[eval exp="drawButtonCaption('打开脚本',16)"]

[frame title="台词抽取" line=2 x=15 y=95]

[iscript]
//创建有台词的剧本列表
sf.sclist=Storages.getLocalName(sf.path+"macro/"+"scenario.txt");
if (!Storages.isExistentStorage(sf.sclist))
{
	saveScript(sf.sclist,["prelogue"]);
}
[endscript]

[locate x=50 y=120]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" exp="System.shellExecute(sf.sclist)"]
[eval exp="drawButtonCaption('脚本列表',16)"]

[locate x=50 y=150]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*导出剧本 hint="导出带有标签、叙述和人物对白的剧本"]
[eval exp="drawButtonCaption('导出剧本',16)"]
[endif]

[locate x=190 y=150]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*导出台词 hint="仅导出人物对白"]
[eval exp="drawButtonCaption('导出台词',16)"]
[endif]

[licence]

[s]

*新建脚本
;清空脚本名
[eval exp="tf.filename=void"]
[input name="tf.filename" title="新建脚本" prompt="请输入脚本文件名（不用扩展名）：        "]
;假如有输入脚本名，开始创建脚本
[iscript]
if (tf.filename!=void)
{
if (Storages.isExistentStorage(sf.path+"scenario/"+tf.filename+".ks"))
{
   System.inform("哎呀呀~已经有同名脚本存在了~");
}
else
{
var content=[];
var path=Storages.getLocalName(sf.path+"scenario/"+tf.filename+".ks");
content[0]=";--------------------------------------------------";
content[1]=";"+tf.filename+".ks";
content[2]=";--------------------------------------------------";
content[3]="*start";
saveScript(path,content);
System.inform("脚本创建成功，可以打开编辑了","新建脚本");
}
}
[endscript]
[jump storage="script_main.ks"]

*打开脚本
[iscript]
f.scenario=void;
f.list=getsozai("ks","scenario");
tf.当前编辑值="f.scenario";
[endscript]
[call storage="window_file.ks"]

;假如选择了文件，打开
[if exp="f.scenario!=void"]
[iscript]
//读入并解释
extractScript();
[endscript]
[jump storage="gui_script.ks"]
[endif]

[jump storage="script_main.ks"]

*导出剧本
[iscript]
//取得ks文件列表
f.sclist=[].load(sf.sclist);
//逐个解读
for (var i=0;i<f.sclist.count;i++)
{
	var filename=f.sclist[i];
	if (filename==void) break;
	dm(filename);
	var path=Storages.getLocalName(sf.path+"scenario/"+filename+".ks");
	dm(path);

	var script=extractTagsFromKS_DCustom(path);

	var arr=[];

	for (var j=0;j<script.count;j++)
	{
		//人名
		if (findName(script[j].tagname))
		{
			arr.add("【"+script[j].tagname+"】");
		}
		//路人名
		if (script[j].tagname=="npc")
		{
			arr.add("【"+script[j].id+"】");
		}
		//标签
		if (script[j].tagname=="_label" && script[j].label!="*")
		{
			arr.add("---------------------------------------");
			arr.add(script[j].label);
			arr.add("---------------------------------------");
		}
		//换行
		if (script[j].tagname=="w")
		{
			arr.add("");
		}
		//对话
		if (script[j].tagname=="_msg")
		{
			var text=script[j].text;
			//段落末尾换行标记
			var br=false;
			//假如有[w]换行标记
			if (text.indexOf("[w]")!=-1) br=true;
			//删除所有[]中间的东西
			var reg=new RegExp("\\[[^\]]*\\]","g");
			var text2=text.replace(reg,"");
			dm(text2);
			arr.add(text2);
			if (br) arr.add("");
		}
	}

	var path2=Storages.getLocalName(sf.path+"scenario/"+"("+(int)(i+1)+")"+filename+".txt");
	saveScript(path2,arr);
}

System.inform("导出完毕");
System.shellExecute(Storages.getLocalName(sf.path+"scenario/"));

[endscript]
[jump storage="script_main.ks"]

*导出台词
[iscript]
//取得ks文件列表
f.sclist=[].load(sf.sclist);
//逐个解读
for (var i=0;i<f.sclist.count;i++)
{
	var filename=f.sclist[i];
	if (filename==void) break;
	dm(filename);
	var path=Storages.getLocalName(sf.path+"scenario/"+filename+".ks");
	dm(path);

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
			dm(text2);
			arr.add(text2);
			//假如有换行
			if (br) 
			{
				arr.add("");
				dia=false;//对话中的标记重置
			}
		}
	}

	var path2=Storages.getLocalName(sf.path+"scenario/"+"("+(int)(i+1)+")"+filename+".txt");
	saveScript(path2,arr);
}

System.inform("导出完毕");
System.shellExecute(Storages.getLocalName(sf.path+"scenario/"));

[endscript]
[jump storage="script_main.ks"]


