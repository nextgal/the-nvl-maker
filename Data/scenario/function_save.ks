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
	//var language="tchinese";
	var language="schinese";

	var str=line;

	if (line=="") return "";
	if (language=="schinese") return line;

	if (language!=void && trans_data[line]!=void) str=trans_data[line][language];
	else if (findrepeat(line)==false) trans_arr.add(line);

	if (str!=void) return str;

	return line;
}

function saveTransArr()
{
	saveScript(Storages.getLocalName(sf.path+"translate_str.txt"),trans_arr);
}

[endscript]
[return]
