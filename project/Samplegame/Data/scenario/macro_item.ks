;------------------------------------------------------------
;物品系統範例（宏）-獲得與失去物品相關
;------------------------------------------------------------
;（1）讀入物品數據庫item_data.tjs & 創建當前擁有的物品列表（在遊戲開始時執行也可，不過為了方便就寫到這裡了）

;（2）getItemIndex(物品名稱)根據物品名稱，搜索物品數據庫，返回物品在數據庫裡的編號，假如找不到，會返回-1
;（3）isItemExist(物品名稱)根據物品名稱，搜索當前擁有的物品列表，返回物品在列表裡的編號，假如找不到，會返回-1
;（4）getItemCount(物品名稱)根據物品名稱，返回當前擁有的物品數量，假如找不到，會返回0（現在不持有這個物品）

;（5）addItem(物品名稱，增加的數量)
;（6）subItem(物品名稱，減少的數量)

;（7）增加物品、減少物品、顯示物品數量的宏

[iscript]

//初始化：讀入物品數據
f.item_data=Scripts.evalStorage("item_data.tjs");
//初始化：創建主角當前擁有的物品列表
f.item=[];

[endscript]

;------------------------------------------------------------定義函數------------------------------------------------------------
[iscript]
//根據物品名稱，搜索物品資料庫，取得物品編號
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

//根據物品名稱，判斷是否擁有物品，假如有，返回物品在物品列表裡的位置
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

//根據物品名稱，取得現在擁有這個物品的數量
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

//----------------------------------------------------------獲得物品---------------------------------------------------------------------------------------
function addItem(name,num=1)
{
	//首先尋找當前物品是否已經存在
	var find=isItemExist(name);

	if (find!=-1) //找到的情況，直接加
	{
		f.item[find].num+=(int)num;
		//在除錯窗口輸出信息
		dm("原有物品："+name+"，增加："+num+"，總數："+getItemCount(name));
	}
	else //找不到的情況，新增一個物品
	{
		//在物品資料裡查找物品的數據
		var index=getItemIndex(name);
		
		if (index!=-1) //物品資料裡存在這個物品的數據
		{
			f.item.add(f.item_data[index]);
			f.item[f.item.count-1].num+=(int)num;
			//在除錯窗口輸出信息
			dm("新增物品："+name+"，數量："+getItemCount(name));
		}
		else  //找不到
		{
			dm("在物品數據庫裡找不到對應的名字，請檢查是否輸入了錯誤的名字");
		}
	}
}

//----------------------------------------------------------失去物品---------------------------------------------------------------------------------------

function subItem(name,num=1)
{
	//首先尋找當前物品是否已經存在
	var find=isItemExist(name);
	
	if (find!=-1) //找到的情況，直接減
	{
		f.item[find].num-=(int)num;
		
		dm("減少物品："+name+"，減少了"+num+"個，現在是"+getItemCount(name)+"個");
		
		if (getItemCount(name)<=0)
		{
			f.item.erase(find);
			dm("物品數量減少到0，完全失去了這個物品");
		}
	}
	else //找不到的情況，不做任何處理
	{
		dm("本來就沒有這個物品，所以沒有減少");
	}
	
}
[endscript]

;增加物品
[macro name=additem]
[eval exp="addItem(mp.name,mp.num)"]
[endmacro]

;減少物品
[macro name=subitem]
[eval exp="subItem(mp.name,mp.num)"]
[endmacro]

;計算擁有幾個物品，並顯示在對話裡
[macro name=itemcount]
[emb exp="getItemCount(mp.name)"]
[endmacro]

;繼續載入界面相關的宏定義
[call storage="macro_item_ui.ks"]
;------------------------------------------------------------
[return]
