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

function getLanguage()
{
	//return Steam.language;
	return "schinese";
}


function getTransStr(line)
{
	var language=getLanguage();

	var str=line;

	if (line=="") return "";

	if (language!="schinese")
	{
		if (trans_data[line]!=void) str=trans_data[line][language];
		else if (findrepeat(line)==false) trans_arr.add(line);
	}

	if (str!=void) return str;

	return line;
}

function saveTransArr()
{
	saveScript(Storages.getLocalName("translate_str.txt"),trans_arr);
}

function getTagDesc()
{
	var taglist;
	var language=getLanguage();

	if (language=="tchinese")
	{
		taglist=Scripts.evalStorage("tagname_tchinese.tjs");
	}
	else
	{
		taglist=Scripts.evalStorage("tagname.tjs");
	}

	return taglist;
}

[endscript]
[return]
