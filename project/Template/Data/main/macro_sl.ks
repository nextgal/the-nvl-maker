;-------------------------------------------------------------------------------------------
;SAVE、LOAD系统通用的宏
;layer 14 背景
;message4 按钮
;15 状态
;16 悬停显示
;17 截图
;-------------------------------------------------------------------------------------------
*start
;------------------------------------------------------------
;删除档按钮
;------------------------------------------------------------
[iscript]
function delslbutton(x,y,num)
{
	//这里的坐标是存档按钮本体的x/y，自行为x/y增加值即可调整坐标
      kag.tagHandlers.locate(
      %[
        "x" => x+600,
        "y" => y+4
      ]);

		//創建數據
		var mybutton = new Dictionary();
		mybutton.normal="log_play_normal";
		mybutton.over="log_play_over";

		mybutton.target="*update";
		mybutton.exp="askYesNo('删除档案吗？', '确认', delsldata,void,"+num+",void)";

		kag.tagHandlers.button(mybutton);
}

function delsldata(num)
{
		//删除存档
		kag.eraseBookMark(num);
		sf.savelastlog[num]="";
		kag.process(,"*update");
}
[endscript]
;------------------------------------------------------------
;页数按钮
;------------------------------------------------------------
[iscript]
function drawpagelist()
{
	var i;
	for (var i=1;i<11;i++)
	{
		drawpagebtn(130+(i-1)*40,660,i);
	}
}

function drawpagebtn(x,y,num)
{
      kag.tagHandlers.locate(
      %[
        "x" => x,
        "y" => y
      ]);

		//創建數據
		var mybutton = new Dictionary();
		mybutton.normal="log_play_normal";
		mybutton.over="log_play_over";

		if (sf.RecentSavePage==num)
		{
		mybutton.normal="log_play_over";
		mybutton.over="log_play_over";
		}

		mybutton.target="*update";
		mybutton.exp="sf.RecentSavePage="+num;
		kag.tagHandlers.button(mybutton);

}
[endscript]
;------------------------------------------------------------
;返回档案名/确认档案是否存在
;------------------------------------------------------------
[iscript]
function storagedata(num)
{
	var sd=kag.saveDataLocation+'/data'+num+'.bmp';
	return sd;
}
function checkdata(num)
{
	var cd=Storages.isExistentStorage(kag.saveDataLocation+'/data'+num+'.bmp');
	if (cd==true) 
	{
		if (kag.getBookMarkPageName(num)!=void) return cd;
		else return false;
	}
	return cd;
}
[endscript]
;------------------------------------------------------------
;在存取按钮上描绘文字的函数
;------------------------------------------------------------
[iscript]
function drawbuttontext(button,style,mytext)
{
	//取得传入的字体样式参数和文字内容参数
	button.font.height=style.height;

	var sha=style.sha;
	var shac=style.shac;
	var edg=style.edg;
	var edgc=style.edgc;
	var normal=style.normal;
	var over=style.over;
	var on=style.on;

	var x=mytext.x;
	var y=mytext.y;
	var str=mytext.str;

	if (sha)
	{
		button.drawText(x,                    y, str, normal,255,true,255,shac,0,2,2);
		button.drawText(x+button.width,y, str, on,255,true,255,shac,0,2,2);
		button.drawText(x+button.width+button.width, y, str, over,255,true,255,shac,0,2,2);
	}
	else if (edg)
	{
		button.drawText(x,                           y, str, normal,255,true,255,edgc,1,0,0);
		button.drawText(x+button.width,              y, str, on,255,true,255,edgc,1,0,0);
		button.drawText(x+button.width+button.width, y, str, over,255,true,255,edgc,1,0,0);
	}
	else
	{
		button.drawText(x,                           y, str, normal);
		button.drawText(x+button.width,              y, str, on);
		button.drawText(x+button.width+button.width, y, str, over);
	}
}
[endscript]
;------------------------------------------------------------
;根据设置，在按钮上描绘相应文字
;------------------------------------------------------------
[iscript]
function slbuttontitle(button,num)
{
	//字体
	button.font.face=kag.fore.messages[0].userFace;

	//通用样式
	button.font.bold=f.config_slpos.pagefont.bold;
	button.font.italic=f.config_slpos.pagefont.italic;

	var style=new Dictionary();

	//公用样式2
	style.sha=f.config_slpos.pagefont.shadow;
	style.shac=f.config_slpos.pagefont.shadowcolor;
	style.edg=f.config_slpos.pagefont.edge;
	style.edgc=f.config_slpos.pagefont.edgecolor;
	
	var mytext=new Dictionary();

	//档案编号
	if (f.config_slpos.num.use)
	{
		style.height=f.config_slpos.num.height;
		style.normal=f.config_sl.num.normal;
		style.over=f.config_sl.num.over;
		style.on=f.config_sl.num.on;

		mytext.x=(int)f.config_slpos.num.x;
		mytext.y=(int)f.config_slpos.num.y;
		mytext.str=f.config_slpos.num.pre+(num*1+1)+f.config_slpos.num.after;
		
		drawbuttontext(button,style,mytext);
	}

	//章节名
	if (f.config_slpos.bookmark.use)
	{
		style.height=f.config_slpos.bookmark.height;
		style.normal=f.config_sl.bookmark.normal;
		style.over=f.config_sl.bookmark.over;
		style.on=f.config_sl.bookmark.on;

		mytext.x=(int)f.config_slpos.bookmark.x;
		mytext.y=(int)f.config_slpos.bookmark.y;
		mytext.str=kag.getBookMarkPageName(num);
		
		drawbuttontext(button,style,mytext);
	}

	//日期
	if (f.config_slpos.date.use)
	{
		style.height=f.config_slpos.date.height;
		style.normal=f.config_sl.date.normal;
		style.over=f.config_sl.date.over;
		style.on=f.config_sl.date.on;

		mytext.x=(int)f.config_slpos.date.x;
		mytext.y=(int)f.config_slpos.date.y;
		mytext.str=kag.getBookMarkDate(num);
		
		drawbuttontext(button,style,mytext);
	}
	
	//最近对话
	if (f.config_slpos.history.use)
	{
		style.height=f.config_slpos.history.height;
		style.normal=f.config_sl.history.normal;
		style.over=f.config_sl.history.over;
		style.on=f.config_sl.history.on;

		mytext.x=(int)f.config_slpos.history.x;
		mytext.y=(int)f.config_slpos.history.y;
		
		//取得历史记录
		var his;
		if (sf.savelastlog[num]!=void) {his=sf.savelastlog[num];}
		else { his="……"; }
		//切掉不必要的字数
		var str=his.substring(0,f.config_slpos.history.num);
		str+="……";

		mytext.str=str;
		
		drawbuttontext(button,style,mytext);
	}
}
[endscript]
;------------------------------------------------------------
;悬停
;------------------------------------------------------------
[iscript]
function drawlayertext(layer,style,text)
{
	//取得传入的字体样式参数和文字内容参数
	layer.font.height=style.size;

	//设定预渲染字体
	if (style.mappfont!=void) 
	{
		layer.font.unmapPrerenderedFont();
		layer.font.mapPrerenderedFont(style.mappfont);
	}

	var sha=style.sha;
	var shac=style.shac;
	var edg=style.edg;
	var edgc=style.edgc;
	var color=style.color;

	var x=style.x;
	var y=style.y;

	if (sha) {layer.drawText(x,y,text,color, 255, true, 255, shac, 0, 2, 2);}
	else if (edg) {layer.drawText(x,y,text,color, 255, true, 255, edgc, 1, 0, 0);}
	else {layer.drawText(x,y,text,color, 255, true);}

}
[endscript]
;------------------------------------------------------------
;取得一段文字的宽度
;------------------------------------------------------------
[iscript]
//取得一段文字的宽度
function getMyTextWidth(text,size)
{
	var temp=new Layer(kag,kag.fore.base);

	temp.font.height=size;
	temp.font.face=kag.fore.messages[0].userFace;

	var width=temp.font.getTextWidth(text);
	return width;
}
[endscript]
;------------------------------------------------------------
;悬停全部
;------------------------------------------------------------
[iscript]
function slshow(num)
{
	var layer = kag.fore.layers[16];

	if (kag.getBookMarkDate(num)!=void)
	{
	    //清空描绘层
	   layer.loadImages(%['storage'=>'empty','visible'=>true,'left'=>0,'top'=>0]);

		var setting=new Dictionary();
		//复制字体设定
		(Dictionary.assign incontextof setting)(f.config_slpos.pagefont);
		//其他参数设定
		setting.layer="16";
		setting.face=kag.fore.messages[0].userFace;

	   //描绘章节名
	   if (f.config_slpos.drawmark.use)
	   {
			setting.x=f.config_slpos.drawmark.x;
			setting.y=f.config_slpos.drawmark.y;
			setting.size=f.config_slpos.drawmark.size;
			setting.color=f.config_sl.draw.bookmark;
			
			drawlayertext(layer,setting,kag.getBookMarkPageName(num));
	   }
	   
	   //描绘日期时间
	   if (f.config_slpos.drawdate.use)
	   {
			setting.x=f.config_slpos.drawdate.x;
			setting.y=f.config_slpos.drawdate.y;
			setting.size=f.config_slpos.drawdate.size;
			setting.color=f.config_sl.draw.date;
			
			drawlayertext(layer,setting,kag.getBookMarkDate(num));
	   }
	   
	   //描绘对话
	   if (f.config_slpos.drawtalk.use)
	   {
	        if (sf.savelastlog[num]!=void)
	      {
	           var talk=sf.savelastlog[num];
	           if (talk==void) talk+="……";
	           var t_linecount=talk.length\f.config_slpos.drawtalk.count;
	           if  (talk.length%f.config_slpos.drawtalk.count>0) {t_linecount++;}

	      		//设定其他参数
				setting.size=f.config_slpos.drawtalk.size;
				setting.color=f.config_sl.draw.talk;
	            setting.x=(int)f.config_slpos.drawtalk.x;

	           //开始描绘
	            for (var i=0; i<t_linecount; i++)
	               {
	      			   //改变坐标和描绘内容
	                   setting.y=(int)i*f.config_slpos.drawtalk.space+(int)f.config_slpos.drawtalk.y;
	                   drawlayertext(layer,setting,talk.substring(i*f.config_slpos.drawtalk.count,f.config_slpos.drawtalk.count));
	               }
	        }
	    }
	
	   //描绘截图
	   if (checkdata(num)) kag.fore.layers[17].loadImages(%[
	      'storage'=>storagedata(num),
	      'visible'=>f.config_slpos.snapshot.visible, //假如设定visible=0，这个功能照样在但是不显示
	      'left'=>f.config_slpos.snapshot.x,
	      'top'=>f.config_slpos.snapshot.y
	     ]);
	 
	 }
}

function slhide()
{
	kag.fore.layers[16].visible=false;
	kag.fore.layers[17].visible=false;
}
[endscript]
;------------------------------------------------------------
;描绘单个按钮
;------------------------------------------------------------
[iscript]
function slbutton(num)
{
	//创建数据
	var savebutton = new Dictionary();

	//复制按钮设定
	(Dictionary.assign incontextof savebutton)(f.config_sl.button);
	
	savebutton.onenter='slshow('+num+')';
	savebutton.onleave="slhide()";
	savebutton.exp='tf.RecentSaveNum='+num;
	savebutton.target="*saveload";

	//检查字典里是否有空字符串，如有的话，强制设定为void
	foreach(savebutton,checkdict);
	//创建按钮
	kag.tagHandlers.button(savebutton);
	//创建按钮后描绘文字
	slbuttontitle(kag.current.links[kag.current.links.count-1].object,num);

}
[endscript]
;------------------------------------------------------------
;批量描绘
;------------------------------------------------------------
[iscript]
function drawslpage()
{
	//返回
	if (f.config_slpos.back[2])
	{
	      kag.tagHandlers.locate(
	      %[
	        "x" => f.config_slpos.back[0],
	        "y" => f.config_slpos.back[1]
	      ]);
	
		//创建数据
		var mybutton = new Dictionary();
		//复制按钮设定
		(Dictionary.assign incontextof mybutton)(f.config_sl.back);
		
		mybutton.target="*return";

		//删除字典内的空值
		foreach(mybutton,checkdict);
		kag.tagHandlers.button(mybutton);
	
	}
	//上翻
	if (f.config_slpos.up[2])
	{
	      kag.tagHandlers.locate(
	      %[
	        "x" => f.config_slpos.up[0],
	        "y" => f.config_slpos.up[1]
	      ]);
	
	
			//创建数据
			var mybutton = new Dictionary();
			//复制按钮设定
			(Dictionary.assign incontextof mybutton)(f.config_sl.up);
			
			mybutton.target="*update";
			mybutton.exp="sf.RecentSavePage-- if (sf.RecentSavePage>1)";

			//删除字典内的空值
			foreach(mybutton,checkdict);
			kag.tagHandlers.button(mybutton);
	}
	//下翻
	if (f.config_slpos.down[2])
	{
	      kag.tagHandlers.locate(
	      %[
	        "x" => f.config_slpos.down[0],
	        "y" => f.config_slpos.down[1]
	      ]);
	
			//创建数据
			var mybutton = new Dictionary();
			//复制按钮设定
			(Dictionary.assign incontextof mybutton)(f.config_sl.down);
			
			mybutton.target="*update";
			mybutton.exp="sf.RecentSavePage++ if (sf.RecentSavePage<(kag.numBookMarks/f.config_slpos.locate.count))";

			//删除字典内的空值
			foreach(mybutton,checkdict);
			kag.tagHandlers.button(mybutton);
	
	}
}
function drawslbutton(page="fore")
{
	var layer;

	//载入空白图片,用于显示状态
	  if (page=="fore") layer=kag.fore.layers[15];
	  else layer=kag.back.layers[15];
	  layer.loadImages(%['storage'=>'empty', 'visible'=>true,'left'=>0,'top' =>0]);
	
	//描绘其他按钮


	//循环描绘存取按钮及按钮上的小截图、最新档标记等
	for (var i=0;i<f.config_slpos.locate.count;i++)
	  {
	      var number=i*1+(sf.RecentSavePage-1)*(f.config_slpos.locate.count);
	      kag.tagHandlers.locate(
	      %[
	        "x" => f.config_slpos.locate[i][0],
	        "y" => f.config_slpos.locate[i][1]
	      ]);
			
			//描绘存档按钮
			slbutton(number); 
			
			//描绘删除按钮
			//delslbutton(f.config_slpos.locate[i][0],f.config_slpos.locate[i][1],number);

	      //当前编号==sf.RecentSaveNum，且的确存在档案时，描绘状态标记
	      if (number==sf.RecentSaveNum && f.config_slpos.lastsavemark.use==1 && checkdata(sf.RecentSaveNum)==true)
	      {
	           kag.tagHandlers.pimage(
	           %[
	              "layer"=>"15",
	              "page"=>page,
	              "storage"=>f.config_sl.lastsavemark,
	              "dx"=> (int)f.config_slpos.lastsavemark.x+(int)f.config_slpos.locate[i][0],
	              "dy"=>(int)f.config_slpos.lastsavemark.y+(int)f.config_slpos.locate[i][1]
	           ]);
	      }

	      //有用到，进行游戏截图描绘
	      if (f.config_slpos.smallsnap.use==1 && checkdata(number))
	      {
	         var snap=new Dictionary();
	         snap.layer="15";
	         snap.page=page;
	         snap.storage=storagedata(number);
	         snap.dx=(int)f.config_slpos.smallsnap.x+(int)f.config_slpos.locate[i][0];
	         snap.dy=(int)f.config_slpos.smallsnap.y+(int)f.config_slpos.locate[i][1];
	         kag.tagHandlers.pimage(snap);
	      }
	  }

		//描绘页数按钮
		//drawpagelist();

}
[endscript]
;------------------------------------------------------------
[return]
