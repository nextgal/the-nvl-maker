*start
[iscript]
//----------------------------------------------------------
//收集翻译文本用函数
//----------------------------------------------------------

var trans_arr=[];
var trans_data=Scripts.evalStorage("translate.tjs");

function findrepeat(line)
{
	for (var i=0;i<trans_arr.count;i++)
	{
		if (trans_arr[i]==line) return true;
	}

	return false;
}


function getTransStr(line)
{
	if (line=="") return "";

	var language="";

	if (language!=void && trans_data[line][language]!=void) line=trans_data[line][language];
	else if (findrepeat(line)==false) trans_arr.add(line);

	return line;
}

function saveTransArr()
{
	saveScript(Storages.getLocalName(sf.path+"translate_str.txt"),trans_arr);
}

[endscript]
[return]
