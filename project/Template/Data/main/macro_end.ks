;-------------------------------------------------------------------------------------------
;结局设定相关宏
;-------------------------------------------------------------------------------------------
;-------------------------------------------------------------------------------------------
;登录END
;-------------------------------------------------------------------------------------------
[iscript]
function AddToEndList(name)
{
	//假如是第一次登录
	if (sf.endlist==void) sf.endlist=%[];
	sf.endlist[name]=true;
	//通关设定为true
	sf.nvlmaker_clearance=true;
	dm("登录END："+name);
}
[endscript]

[macro name=addend]
[eval exp="AddToEndList(mp.storage)"]

[endmacro]

;-------------------------------------------------------------------------------------------
;END按钮
;-------------------------------------------------------------------------------------------
[iscript]
function EndButton(filename,picname)
{
		var dic=f.config_endmode.thum;
		dic.target="*play";

		//点下按钮之后执行的表达式，将通过行号取得同一缩略图的差分列表并准备显示
		dic.exp="tf.EndFile=\""+filename+"\"";

		//删除空值
		foreach(dic,checkdict);
		//利用thumbnail大小图片添加一个CG按钮
		kag.current.addButton(dic);

		//设定按钮为最近添加的按钮
		var button=kag.current.links[kag.current.links.count-1].object;

        //临时图层，读取CG或CG缩略图
        var temp=new Layer(kag, kag.fore.base);

		//查找PNG格式的缩略图，找不到则直接缩放原图
		if (Storages.isExistentStorage(picname+"_thum"+".png"))
		{
			temp.loadImages(picname+"_thum");
		}
        else
		{
			temp.loadImages(picname);
		}

        temp.setSizeToImageSize();

        //临时图层，读取thumbnail大小图片
        var temp2=new Layer(kag, kag.fore.base);
        temp2.loadImages(f.config_endmode.thum.normal);
        temp2.setSizeToImageSize();

		//将CG缩略图描绘到按钮上
        button.stretchCopy(dic.x, dic.y, temp2.width, temp2.height, temp, 0, 0, temp.width, temp.height, stLinear);
        button.stretchCopy(button.width+(int)dic.x, dic.y, temp2.width, temp2.height, temp, 0, 0, temp.width, temp.height, stLinear);
        button.stretchCopy(button.width*2+(int)dic.x, dic.y, temp2.width, temp2.height, temp, 0, 0, temp.width, temp.height, stLinear);
        
}

//
function draw_endlist()
{

	dm("=========描绘END按钮，当前第"+tf.CurrentENDPage+"页=========");

	for (var i=0;i<f.config_endmode.locate.count;i++)
	{	     
	     kag.tagHandlers.locate(%["x"=>f.config_endmode.locate[i][0],"y"=>f.config_endmode.locate[i][1]]);
	     
	     //取得CG在列表中的编号（行号）
	     var j=i+f.config_endmode.locate.count*(tf.CurrentENDPage-1);
	     
	     if (f.endlist[j]!=void)
	     {
			var arr=f.endlist[j].split(",");
			//脚本名
			var name=arr[0];
			//对应图片
		    var pic=arr[1];
		    
		    if (sf.endlist[name]==true)
		    {
			    dm("【END按钮："+name+"成功显示】");
			    EndButton(name,pic);
		    }
		    else
		    {
			    dm("【END按钮："+name+"尚未登录】");
				//新建空白按钮
				var dic=%[];
				dic.normal=f.config_endmode.thum.normal;
				kag.current.addButton(dic);
		    }
	     }
	}
}
[endscript]


[macro name=draw_endlist]

	;描绘按钮
	[eval exp="draw_endlist()"]

	;前一页
	[mybutton dicname="f.config_endmode.up" exp="tf.CurrentENDPage-- if (tf.CurrentENDPage>1)" target=*update]
	;后一页
	[mybutton dicname="f.config_endmode.down" exp="tf.CurrentENDPage++ if (tf.CurrentENDPage<tf.ENDPage)" target=*update]
	;返回按钮
	[mybutton dicname="f.config_endmode.back" target=*return]
[endmacro]

[return]
