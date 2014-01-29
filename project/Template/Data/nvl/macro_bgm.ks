;-------------------------------------------------------------------------------------------
;音乐鉴赏界面相关函数
;-------------------------------------------------------------------------------------------
[iscript]
function BgmButton(name)
{
	//取得显示名和播放文件名
	var text=name.split(',');
	
	//按钮设定
	var dic=%[];
	
	dic.normal="extra_bgmbutton_normal"; //这里是设定BGM按钮底图的地方
	dic.over="extra_bgmbutton_over";
	dic.on="extra_bgmbutton_over";
	
	dic.exp="tf.当前BGM=\""+text[1]+"\"";
	dic.target="*播放音乐";
	kag.current.addButton(dic);
	
	//在按钮上描绘文字
	var x=20;//设定按钮上文字位置的地方
	var y=10;
	
	var str=text[0];
	var button=kag.current.links[kag.current.links.count-1].object;
	
	button.font.height=20;//设定字体大小
	
	button.drawText(x,y,str,0xFFFFFF);//设定文字颜色
	button.drawText(x+button.width,y,str,0xFFFFFF);//设定文字颜色
	button.drawText(x+button.width*2,y,str,0xFFFFFF);//设定文字颜色
	
}
function draw_bgmlist()
{

	//每页显示的BGM数和bgm.ks里设定的一样
	var nump=f.bgmnump;
	
	for (var i=0;i<nump;i++)
	{
		if ((tf.当前BGM页-1)*nump+i>=f.bgmlist.count) break;
		
		if (i<nump/2) kag.tagHandlers.locate(%["x"=>45,"y"=>170+50*i]); //设定BGM按钮第一列坐标的地方，起始位置为45,170,按钮间距为50
		else kag.tagHandlers.locate(%["x"=>419,"y"=>170+50*(i-nump/2)]);//设定BGM按钮第二列坐标的地方，起始位置为419,170,按钮间距为50
		
		//总之愿意的话可以随便自己调整坐标变成一列或者三列或者更多……

		BgmButton(f.bgmlist[(tf.当前BGM页-1)*nump+i]);
	}
}
[endscript]
;-------------------------------------------------------------------------------------------
;描绘bgm按钮
;-------------------------------------------------------------------------------------------
[macro name=draw_bgmlist]
;BGM按钮
[eval exp="draw_bgmlist()"]

;返回按钮
[locate x=620 y=56]
[button normal="menu_button_07" over="menu_button_on_07" target=*返回]
;上翻按钮
[locate x=310 y=56]
[button normal="option_button_01" over="option_button_on_01" target=*刷新画面 exp="tf.当前BGM页-- if (tf.当前BGM页>1)" cond="tf.BGM页数>1"]
;下翻按钮
[locate x=485 y=56]
[button normal="option_button_01" over="option_button_on_02" target=*刷新画面 exp="tf.当前BGM页++ if (tf.当前BGM页<tf.BGM页数)" cond="tf.BGM页数>1"]

[endmacro]

;-------------------------------------------------------------------------------------------
[return]
