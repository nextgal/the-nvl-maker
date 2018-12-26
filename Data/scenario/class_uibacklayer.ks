*start
[iscript]
class uiBackLayer extends Layer
{
	var frame;
	var stitle;
	var stitle_x;
	var stitle_y;

  //父层
  var parent=kag.fore.layers[4];

	function uiBackLayer(elm)
	{
     	super.Layer(kag, parent); 

		left=0;
		top=0;

		absolute=1;

		visible=true;
		
		hitType = htMask;
		hitThreshold =0;

		focusable=false;

		if (typeof elm == "String") 
		{
			var bgdstr=elm;
			elm=%["frame"=>bgdstr];
		}
		else
		{
			
		}

		Reset(elm);
	}

	function Reset(elm)
	{
		frame=elm.frame;
		stitle=elm.stitle;
		stitle_x=elm.stitle_x;
		stitle_y=elm.stitle_y;

		//载入图片
		this.loadImages(frame);
		this.setSizeToImageSize();

		//附加小图片
		if (stitle!=void)
		{
			var slayer = new global.Layer(kag,this);
				slayer.loadImages(stitle);
				slayer.setSizeToImageSize();
	
			//复制小图片
			this.pileRect(stitle_x,stitle_y,slayer,0,0,slayer.width,slayer.height);
			delete slayer;
		}
	}

	function LayerElm()
	{
		var dic=%[];
		dic.frame=this.frame;
		dic.stitle=this.stitle;
		dic.stitle_x=this.stitle_x;
		dic.stitle_y=this.stitle_y;
		return dic;
	}
}
[endscript]
[return]
