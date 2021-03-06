;-------------------------------------------------------------------------------------------
;CG设定相关宏
;-------------------------------------------------------------------------------------------
;-------------------------------------------------------------------------------------------
;取得CG缩略图列表
;-------------------------------------------------------------------------------------------
[iscript]
function getThumList()
{

	var list=[].load(f.cginfo);

	var thumlist=[];

	for (var i=0;i<list.count;i++)
	{
		var obj=list[i];
		var arr=obj.split(",");
		thumlist.add(arr[0]);
	}

	return thumlist;
}

[endscript]
;-------------------------------------------------------------------------------------------
;取得已登录的CG差分
;-------------------------------------------------------------------------------------------
[iscript]
function getCgDif(num)
{

	var list=[].load(f.cginfo);
	var obj=list[num];
	var arr=obj.split(",");

	var cglist=[];

	dm(" 列表文件"+f.cginfo+"，第"+num+"行，共"+arr.count+"个差分");

	for (var i=0;i<arr.count;i++)
	{
		var name=arr[i];

		//只有已经登录的CG才会被显示
		if (sf.cglist[name]==true)
		{
			cglist.add(name);
			dm(" 差分"+name+"已登陆");
		}
		else
		{
			dm(" 差分"+name+"未登陆");
		}
	}

	return cglist;
}

[endscript]

;-------------------------------------------------------------------------------------------
;登录CG
;-------------------------------------------------------------------------------------------
[iscript]
function AddToCgList(name)
{
	//假如是第一次登录CG
	if (sf.cglist==void) sf.cglist=%[];
	sf.cglist[name]=true;
	dm("登录CG："+name);
}
[endscript]

[macro name=addcg]
[eval exp="AddToCgList(mp.storage)"]
[endmacro]
;-------------------------------------------------------------------------------------------
;CG按钮【取得缩略图的文件名，以及在对应列表文件里的行号】
;-------------------------------------------------------------------------------------------
[iscript]
function CgButton(name,num)
{

		var dic=f.config_cgmode.thum;

		dic.target="*showcg";

		//点下按钮之后执行的表达式，将通过行号取得同一缩略图的差分列表并准备显示
		dic.exp="(tf.CGDiff=getCgDif("+num+")),(tf.CGNum=0)";

		//删除空值
		foreach(dic,checkdict);

		//添加一个CG按钮
		kag.current.addButton(dic);

		//设定按钮为最近添加的按钮
		var button=kag.current.links[kag.current.links.count-1].object;

        //临时图层，读取CG或CG缩略图
        var temp=new Layer(kag, kag.fore.base);

		//查找PNG格式的缩略图，找不到则直接缩放原图
		if (Storages.isExistentStorage(name+"_thum"+".png"))
		{
			temp.loadImages(name+"_thum");
		}
        else
		{
			temp.loadImages(name);
		}

        temp.setSizeToImageSize();

        //临时图层，读取thumbnail大小图片
        var temp2=new Layer(kag, kag.fore.base);
        temp2.loadImages(dic.thum);
        temp2.setSizeToImageSize();

		//将CG缩略图描绘到按钮上
        button.stretchCopy(dic.x, dic.y, temp2.width, temp2.height, temp, 0, 0, temp.width, temp.height, stLinear);
        button.stretchCopy(button.width+(int)dic.x, dic.y, temp2.width, temp2.height, temp, 0, 0, temp.width, temp.height, stLinear);
        button.stretchCopy(button.width*2+(int)dic.x, dic.y, temp2.width, temp2.height, temp, 0, 0, temp.width, temp.height, stLinear);
        
        
}
[endscript]

;-------------------------------------------------------------------------------------------
;CG列表
;-------------------------------------------------------------------------------------------
[iscript]
function draw_cglist()
{

	dm("=========描绘CG按钮，当前第"+tf.CurrentCGPage+"页=========");

	for (var i=0;i<f.config_cgmode.locate.count;i++)
	{	     
	     kag.tagHandlers.locate(%["x"=>f.config_cgmode.locate[i][0],"y"=>f.config_cgmode.locate[i][1]]);
	     
	     //取得CG在列表中的编号（行号）
	     var j=i+f.config_cgmode.locate.count*(tf.CurrentCGPage-1);
	     
	     if (f.cglist[j]!=void)
	     {
		    var name=f.cglist[j];
		    
		    if (sf.cglist[name]==true)
		    {
			    dm("【CG按钮："+name+"成功显示】");
				//假如已经登陆了这张CG文件，则显示按钮
			    CgButton(name,j);
		    }
		    else
		    {
			    dm("【CG按钮："+name+"尚未登录】");
				//新建空白按钮
				var dic=%[];
				dic.normal=f.config_cgmode.thum.normal;
				kag.current.addButton(dic);
		    }
	     }
	}
}
[endscript]

[macro name=draw_cglist]

	;描绘CG
	[eval exp="draw_cglist()"]
	
	;前一页
	[mybutton dicname="f.config_cgmode.up" exp="tf.CurrentCGPage-- if (tf.CurrentCGPage>1)" target=*update]
	;后一页
	[mybutton dicname="f.config_cgmode.down" exp="tf.CurrentCGPage++ if (tf.CurrentCGPage<tf.CGPage)" target=*update]
	;返回按钮
	[mybutton dicname="f.config_cgmode.back" target=*return]

	;自己增加页数按钮的方式（也可以用页数来实现CG分类）
	;[locate x=100 y=100]
	;[button normal="abc" over="def" target="*update" exp="tf.CurrentCGPage=1"]

[endmacro]
;-------------------------------------------------------------------------------------------
[return]

