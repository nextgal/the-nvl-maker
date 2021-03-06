;-------------------------------------------------------------------------------------------
;CG设定相关宏
;-------------------------------------------------------------------------------------------
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
;CG按钮
;-------------------------------------------------------------------------------------------
[iscript]
function CgButton(name)
{
       f.config_cgmode.thum.target="*显示CG";
       f.config_cgmode.thum.exp="tf.当前CG=\""+name+"\"";
       kag.current.addButton(f.config_cgmode.thum);

		//在按钮上描绘缩略图
		var button=kag.current.links[kag.current.links.count-1].object;
		button.fillRect(0,0,button.width*3,button.height,0x00FFFFFF);

        //临时图层
        var temp=new Layer(kag, kag.fore.base);
        temp.loadImages(name);
        temp.setSizeToImageSize();

        //临时图层，读取thumbnail图片
        var temp2=new Layer(kag, kag.fore.base);
        temp2.loadImages(f.config_cgmode.thum.normal);
        temp2.setSizeToImageSize();

        button.stretchCopy(0, 0, button.width, button.height, temp, 0, 0, temp.width, temp.height, stNearest);
        button.stretchCopy(button.width, 0, button.width, button.height, temp, 0, 0, temp.width, temp.height, stNearest);
        button.stretchCopy(button.width*2, 0, button.width, button.height, temp, 0, 0, temp.width, temp.height, stNearest);
        
        //选中效果（thumbnail图片同时作为高亮效果使用）
         button.stretchPile(button.width, 0, button.width, button.height, temp2, 0, 0, temp2.width, temp2.height,255,stNearest);
         button.stretchPile(button.width*2, 0, button.width, button.height, temp2, 0, 0, temp2.width, temp2.height, 255,stNearest);
        
}
[endscript]

[macro name=cg_button]
[eval exp="CgButton(mp.storage)"]
[endmacro]

;-------------------------------------------------------------------------------------------
;CG列表
;-------------------------------------------------------------------------------------------
[iscript]
function draw_cglist()
{
	for (var i=0;i<f.config_cgmode.locate.count;i++)
	{	     
	     kag.tagHandlers.locate(%["x"=>f.config_cgmode.locate[i][0],"y"=>f.config_cgmode.locate[i][1]]);
	     
	     var j=i+f.config_cgmode.locate.count*(tf.当前CG页-1);
	     
	     if (f.cglist[j]!=void)
	     {
		    var name=f.cglist[j];
		    
		    if (sf.cglist[name]==true)
		    {
			    CgButton(name);
			    dm("【CG："+name+"成功显示】");
		    }
		    else
		    {
			    dm("【CG："+name+"尚未登录】");
		    }
	     }
	}
}
[endscript]

[macro name=draw_cglist]

;描绘CG
[eval exp="draw_cglist()"]

;前一页
[if exp="f.config_cgmode.up.use==true"]
[locate x=&"f.config_cgmode.up.x" y=&"f.config_cgmode.up.y"]
[mybutton dicname="f.config_cgmode.up" exp="tf.当前CG页-- if (tf.当前CG页>1)" target=*刷新画面]
[endif]
;后一页
[if exp="f.config_cgmode.down.use==true"]
[locate x=&"f.config_cgmode.down.x" y=&"f.config_cgmode.down.y"]
[mybutton dicname="f.config_cgmode.down" exp="tf.当前CG页++ if (tf.当前CG页<tf.CG页数)" target=*刷新画面]
[endif]
;返回按钮
[if exp="f.config_cgmode.back.use==true"]
[locate x=&"f.config_cgmode.back.x" y=&"f.config_cgmode.back.y"]
[mybutton dicname="f.config_cgmode.back" target=*返回]
[endif]

[endmacro]
;-------------------------------------------------------------------------------------------
[return]

