;-------------------------------------------------------------------------------------------
;登錄CG
;-------------------------------------------------------------------------------------------
[iscript]
function AddToCgList(name)
{
	//假如是第一次登錄CG
	if (sf.cglist==void) sf.cglist=%[];
	sf.cglist[name]=true;
	dm("登錄CG："+name);
}
[endscript]

[macro name=addcg]
[eval exp="AddToCgList(mp.storage)"]
[endmacro]
;-------------------------------------------------------------------------------------------
;CG按鈕
;-------------------------------------------------------------------------------------------
[iscript]
function CgButton(name)
{
       f.config_cgmode.thum.target="*顯示CG";
       f.config_cgmode.thum.exp="tf.當前CG=\""+name+"\"";
       kag.current.addButton(f.config_cgmode.thum);

	//在按鈕上描繪縮略圖
	var button=kag.current.links[kag.current.links.count-1].object;
	button.fillRect(0,0,button.width*3,button.height,0x00FFFFFF);

        //臨時圖層
        var temp=new Layer(kag, kag.fore.base);
        temp.loadImages(name);
        temp.setSizeToImageSize();
        
        button.stretchCopy(0, 0, button.width, button.height, temp, 0, 0, temp.width, temp.height, stNearest);
        button.stretchCopy(button.width, 0, button.width, button.height, temp, 0, 0, temp.width, temp.height, stNearest);
        button.stretchCopy(button.width*2, 0, button.width, button.height, temp, 0, 0, temp.width, temp.height, stNearest);
        
        //選中效果
        button.colorRect(button.width, 0,button.width, button.height, f.setting.link.color, f.setting.link.opacity);
        button.colorRect(button.width*2, 0,button.width, button.height, f.setting.link.color, f.setting.link.opacity);
        
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
	     
	     var j=i+f.config_cgmode.locate.count*(tf.當前CG頁-1);
	     
	     if (f.cglist[j]!=void)
	     {
		    var name=f.cglist[j];
		    
		    if (sf.cglist[name]==true)
		    {
			    CgButton(name);
			    dm("【CG："+name+"成功顯示】");
		    }
		    else
		    {
			    dm("【CG："+name+"尚未登錄】");
		    }
	     }
	}
}
[endscript]

[macro name=draw_cglist]

;描繪CG
[eval exp="draw_cglist()"]

;前一頁
[if exp="f.config_cgmode.up.use==true"]
[locate x=&"f.config_cgmode.up.x" y=&"f.config_cgmode.up.y"]
[mybutton dicname="f.config_cgmode.up" exp="tf.當前CG頁-- if (tf.當前CG頁>1)" target=*刷新畫面]
[endif]
;後一頁
[if exp="f.config_cgmode.down.use==true"]
[locate x=&"f.config_cgmode.down.x" y=&"f.config_cgmode.down.y"]
[mybutton dicname="f.config_cgmode.down" exp="tf.當前CG頁++ if (tf.當前CG頁<tf.CG頁數)" target=*刷新畫面]
[endif]
;返回按鈕
[if exp="f.config_cgmode.back.use==true"]
[locate x=&"f.config_cgmode.back.x" y=&"f.config_cgmode.back.y"]
[mybutton dicname="f.config_cgmode.back" target=*返回]
[endif]

[endmacro]
;-------------------------------------------------------------------------------------------
[return]

