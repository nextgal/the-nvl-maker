*start
;-----------------------------------------------------------------------------------
;悬停显示的图片位置
;-----------------------------------------------------------------------------------
[iscript]
class uiCgThumLayer extends uiLayer
{

	var pic;
	var thum;
	var thumx;
	var thumy;

  //---------------------------------------------------创建---------------------------------------------------
  function uiCgThumLayer(elm,dic)
  {
        super.Layer(kag, parent);

        //loadImages(pic);
        //setSizeToImageSize();
        
        //fillRect(0,0,width,height,0xFFFFFFFF);
        
		left=elm[0];
		top=elm[1];
		visible=true;
		this.pic=dic.normal;
		this.thum=dic.thum;
		this.thumx=dic.x;
		this.thumy=dic.y;

		hitType = htMask;
		hitThreshold =0;
		focusable=true;

		drawSelect();
  }
    //---------------------------------------------------描绘---------------------------------------------------
  function drawSelect()
  {
  
    //width=this.width;
    //height=this.height;
    
    //fillRect(0,0,width,height,0xFFFFFFFF);
	if (Storages.isExistentStorage(pic+".png") || Storages.isExistentStorage(pic+".jpg"))
	{
    	loadImages(pic);
	}
	else
	{
		loadImages("edit_button_close");
	}
    setSizeToImageSize();
	
	//添加thum小图标
	var temp = window.temporaryLayer;
	if (Storages.isExistentStorage(thum+".png") || Storages.isExistentStorage(thum+".jpg"))
	{
		temp.loadImages(thum);
	}
	else
	{
		loadImages("edit_button_close");
	}
	var w = temp.imageWidth;
	var h = temp.imageHeight;

    fillRect(thumx,thumy,w,h,0x66FFFFFF);

	//描绘边框
	DrawSelectFrame();
  }

}
[endscript]
[return]
