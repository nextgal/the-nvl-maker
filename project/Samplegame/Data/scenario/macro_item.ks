;------------------------------------------------------------
;物品系统范例（宏）-获得与失去物品相关
;------------------------------------------------------------
;（1）读入物品数据库item_data.tjs & 创建当前拥有的物品列表（在游戏开始时执行也可，不过为了方便就写到这里了）

;（2）getItemIndex(物品名称)根据物品名称，搜索物品数据库，返回物品在数据库里的编号，假如找不到，会返回-1
;（3）isItemExist(物品名称)根据物品名称，搜索当前拥有的物品列表，返回物品在列表里的编号，假如找不到，会返回-1
;（4）getItemCount(物品名称)根据物品名称，返回当前拥有的物品数量，假如找不到，会返回0（现在不持有这个物品）

;（5）addItem(物品名称，增加的数量)
;（6）subItem(物品名称，减少的数量)

;（7）增加物品、减少物品、显示物品数量的宏

[iscript]

//初始化：读入物品数据
f.item_data=Scripts.evalStorage("item_data.tjs");
//初始化：创建主角当前拥有的物品列表
f.item=[];

[endscript]

;------------------------------------------------------------定义函数------------------------------------------------------------
[iscript]
//根据物品名称，搜索物品资料库，取得物品编号
function getItemIndex(name)
{
	for (var i=0;i<f.item_data.count;i++)
	{
		if (f.item_data[i].name==name)
		{
			return i;
		}
	}
	
	return -1;
}

//根据物品名称，判断是否拥有物品，假如有，返回物品在物品列表里的位置
function isItemExist(name)
{
	for (var i=0;i<f.item.count;i++)
	{
		if (f.item[i].name==name)
		{
			return i;
		}
	}
	
	//假如找不到
	return -1;
	
}

//根据物品名称，取得现在拥有这个物品的数量
function getItemCount(name)
{
	var find=isItemExist(name);
	
	if (find!=-1) 
	{
		return f.item[find].num;
	}
	else
	{
		return 0;
	}
}

//----------------------------------------------------------获得物品---------------------------------------------------------------------------------------
function addItem(name,num=1)
{
	//首先寻找当前物品是否已经存在
	var find=isItemExist(name);

	if (find!=-1) //找到的情况，直接加
	{
		f.item[find].num+=(int)num;
		//在除错窗口输出信息
		dm("原有物品："+name+"，增加："+num+"，总数："+getItemCount(name));
	}
	else //找不到的情况，新增一个物品
	{
		//在物品资料里查找物品的数据
		var index=getItemIndex(name);
		
		if (index!=-1) //物品资料f.item_data里存在这个物品的数据，将对应的物品数据复制到f.item中
		{
			f.item.add(f.item_data[index]);
			f.item[f.item.count-1].num+=(int)num;
			//在除错窗口输出信息
			dm("新增物品："+name+"，数量："+getItemCount(name));
		}
		else  //找不到
		{
			dm("在物品数据库里找不到对应的名字，请检查是否输入了错误的名字");
		}
	}
}

//----------------------------------------------------------失去物品---------------------------------------------------------------------------------------

function subItem(name,num=1)
{
	//首先寻找当前物品是否已经存在
	var find=isItemExist(name);
	
	if (find!=-1) //找到的情况，直接减
	{
		f.item[find].num-=(int)num;
		
		dm("减少物品："+name+"，减少了"+num+"个，现在是"+getItemCount(name)+"个");
		
		if (getItemCount(name)<=0)
		{
			f.item.erase(find);
			dm("物品数量减少到0，完全失去了这个物品");
		}
	}
	else //找不到的情况，不做任何处理
	{
		dm("本来就没有这个物品，所以没有减少");
	}
	
}
[endscript]

;增加物品
[macro name=additem]
[eval exp="addItem(mp.name,mp.num)"]
[endmacro]

;减少物品
[macro name=subitem]
[eval exp="subItem(mp.name,mp.num)"]
[endmacro]

;计算拥有几个物品，并显示在对话里
[macro name=itemcount]
[emb exp="getItemCount(mp.name)"]
[endmacro]

;继续载入界面相关的宏定义
[call storage="macro_item_ui.ks"]
[call storage="macro_recipe.ks"]
;------------------------------------------------------------
[return]
