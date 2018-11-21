*start
[iscript]
//-----------------------------------------------------------------------
//保存字典
//-----------------------------------------------------------------------
function SaveDic(dic,file,folder="macro")
{
	//保存
	(Dictionary.saveStruct incontextof dic)(sf.path+folder+"/"+file);
}
//-----------------------------------------------------------------------
//读取字典
//-----------------------------------------------------------------------
function LoadDic(file,folder="macro")
{
	var fullfile=sf.path+folder+"/"+file;
	if (Storages.isExistentStorage(fullfile))
	{
		var dic=Scripts.evalStorage(fullfile);
		return dic;
	}
	else
	{
		return %[];
	}
}
//-----------------------------------------------------------------------
//返回文件完整路径
//-----------------------------------------------------------------------
function GetPath(file,folder="macro")
{
	//System.inform(sf.path+folder+"/"+file);
	return sf.path+folder+"/"+file;
}
//-----------------------------------------------------------------------
//打开文件
//-----------------------------------------------------------------------
function OpenPath(file,folder)
{
	var path=GetPath(file,folder);
	//System.inform(path);
	System.shellExecute(Storages.getLocalName(path));
}
[endscript]
[return]
