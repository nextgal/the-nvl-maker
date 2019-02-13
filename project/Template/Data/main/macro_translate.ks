;-------------------------------------------------------------------------------------------
;翻译、系统字段处理相关函数
;-------------------------------------------------------------------------------------------
*start
[iscript]
function getLanguage()
{
	//取得所用语言
	return "schinese";
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
//取得系统字段
//-------------------------------------------------------------------------------------------
function getSysString(text)
{
	var data=Scripts.evalStorage("systemstring.tjs");
	return data[text][getLanguage()];
}
//-------------------------------------------------------------------------------------------
//替换系统字段内的变数
//-------------------------------------------------------------------------------------------
function textVarFormat(text,var1="",var2="",var3="")
{
	if (var1 != "") text=textReplace(text,"@1",var1);
	if (var1 != "") text=textReplace(text,"@2",var2);
	//text=textReplace(text,"[var3]",var3);

	return text;
}
[endscript]

[return]
