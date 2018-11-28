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
			elm=%["bgd"=>bgdstr];
		}

		Reset(elm);
	}

	function Reset(elm)
	{
		frame=elm.bgd;
		stitle=elm.stitle;
		stitle_x=elm.stitle_x;
		stitle_y=elm.stitle_y;

		//载入图片
		this.loadImages(frame);
		this.setSizeToImageSize();
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
