*start
;-------------------------------------------------------------------------------------------
;扫描素材文件夹中的素材文件
;-------------------------------------------------------------------------------------------
[iscript]
function getAllMaterialList()
{
	var arr=["bgimage","fgimage"];
	var list=[];

	for (var i=0;i<arr.count;i++)
	{
		var list_temp=getpic(arr[i]);

		list.add("["+arr[i]+"]");

		for (var j=0;j<list_temp.count;j++)
		{
			list.add(list_temp[j]);
		}
	}

		var path=GetPath("materials"+".txt");
		list.save(path);
}
[endscript]
;-------------------------------------------------------------------------------------------
;对素材文件进行使用统计
;-------------------------------------------------------------------------------------------
[iscript]
function getMaterialUseage()
{
	//读取素材文件列表
	var filelist=Storages.getLocalName(GetPath("materials"+".txt"));
	var matlist=[].load(filelist);

	//读取脚本列表
	filelist=Storages.getLocalName(GetPath("scenario"+".txt"));
	var sclist=[].load(filelist);

	var uselist=createEmptyUseList(matlist);
	
	//取得所有的剧本内容
	for (var i=0;i<sclist.count;i++)
	{
		//取得文件名
		var filename=sclist[i];
		if (filename==void) continue;
		dm(filename);
		//取得路径
		var path=Storages.getLocalName(sf.path+"scenario"+"/"+filename+".ks");
		dm("导出文本："+path);

		//分析文本
		var script=[].load(path);
		for (var j=0;j<script.count;j++)
		{
			var text=script[j];

			for (var k=0;k<matlist.count;k++)
			{
				var file=matlist[k];
				if (file.indexOf("[")==0) continue;

				//检查
				if (text.indexOf(file)!=-1) uselist[file]+=1;
			}
		}

	}
		var savepath=GetPath("uselist"+".txt");
		(Dictionary.saveStruct incontextof uselist)(savepath);

}
[endscript]

[iscript]
function createEmptyUseList(matlist)
{
	var uselist=%[];

	for (var i=0;i<matlist.count;i++)
	{
		var file=matlist[i];
		if (file.indexOf("[")==0) continue;
		uselist[file]=0;
	}

	return uselist;
}

[endscript]

[return]
