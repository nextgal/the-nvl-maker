;---------------------------------------------------------------------------------------
;AnimPlayer.ks
;逐帧动画播放插件 by VariableD & karryngai
;---------------------------------------------------------------------------------------
;加工·修改自由
;转载请注明作者和出处
;---------------------------------------------------------------------------------------
;宏指令
;@animinit
;参数：
;file（必须） 文件名
;所有文件格式命名为"文件名 (数字).png"的图片可以被识别，文件名和(数字)间有一个半角空格。
;（WINDOWS的批量重命名默认格式）
;数值必须从0开始，当找不到下一个数字时，视为一轮播放完毕
;loop 是否循环，默认为是
;target 循环时的起始帧，默认为0
;interval 每帧的间隔时间，默认为100毫秒，建议不要低于60（否则可能会卡）
;index 图层的显示顺位，默认为50000-1

;left,top 左上点坐标
;width,height 宽度,高度

;@addpath storage="文件夹名" 可以加入文件夹
;---------------------------------------------------------------------------------------
@if exp="typeof(global.animplayer_object) == 'undefined'"
@iscript

//动画层
class MyanimLayer
{
    var fore;
    var back;
    
    function MyanimLayer(window,owner)
    {
	this.owner = owner;
	this.window = window;
	
	fore = new Layer(window, window.fore.base);
	back = new Layer(window, window.back.base);
	
	fore.hitType = htMask;
	fore.hitThreshold = 256; 
	back.hitType = htMask;
	back.hitThreshold = 256;
	
	//可以在这里随便玩效果
//	fore.type=ltLighten;
//	back.type=ltLighten;
	
	fore.fillRect(0,0,1024,768,0x00000000); //清空图层
	back.assignImages(fore);
	fore.setSizeToImageSize(); 
	back.setSizeToImageSize();      
    }
    
        function finalize()
    {
            invalidate fore;
            invalidate back;
    }

	function changeImage(image)
	{
		fore.loadImages(image); //图片
		back.assignImages(fore);
	}

    //可见效果（由plugin控制）
        function resetVisibleState()
        {

            fore.visible = owner.foreVisible;
            back.visible = owner.backVisible;
        }
        
      //表里交换
              function exchangeForeBack()
        {
                // trans时的表里页内容交换
                var tmp = fore;
                fore = back;
                back = tmp;
        }
        
        property index
        {
        	setter(x)
        	{
	        	fore.absolute=x;
	        	back.absolute=x;
        	}
        	
        	getter
        	{
        		return fore.absolute;
        	}
        }
        
        property left
        {
        	setter(x)
        	{
	        	fore.left=x;
	        	back.left=x;
        	}
        }
        
        property top
        {
        	setter(x)
        	{
	        	fore.top=x;
	        	back.top=x;
        	}
        }
        
        property width
        {
        	setter(x)
        	{
	        	fore.width=x;
	        	back.width=x;
        	}
        }
        
        property height
        {
        	setter(x)
        	{
	        	fore.height=x;
	        	back.height=x;
        	}
        }
}
//---------------------------------------------------------------------------------------
class AnimPlayerPlugin extends KAGPlugin
{
        
        var timer; // 计时器
        var interval=100;
        
        var window; 
        var foreVisible = true; 
        var backVisible = true; 
        var animLayer;
        var file;
        var index=50000-1;
        
        var count=0;//当前帧编号
        var loop=1;//是否循环
        var target=0;//循环标记，0为从第一帧开始循环
        
        var left=0;
        var top=0;
        var width=1024;
        var height=768;
        
       function AnimPlayerPlugin(window)
        {
                super.KAGPlugin();
                this.window = window;
        }
        
        function finalize()
        {
                invalidate timer if timer !== void;
                super.finalize(...);
        }
        
        //创建
        function init(elm)
        {

		this.file=elm.file;
		
		if (elm.index!==void) this.index=(int)elm.index;
        	if (elm.loop!==void) this.loop=(int)elm.loop;//是否循环
        	if (elm.target!==void) this.target=(int)elm.target;//循环的起始点
        	
		if (elm.interval!==void) this.interval=(int)elm.interval;
		
		if (elm.left!==void) this.left=(int)elm.left;
		if (elm.top!==void) this.top=(int)elm.top;
		if (elm.width!==void) this.width=(int)elm.width;
		if (elm.height!==void) this.height=(int)elm.height;
		
		animLayer=new MyanimLayer(window,this);
		
		animLayer.left=this.left;
		animLayer.top=this.top;
		animLayer.width=this.width;
		animLayer.height=this.height;
		animLayer.index=this.index;
		
        	   //计时器的具体设定
                timer = new Timer(onTimer, '');
                timer.interval = this.interval;

                
                foreVisible = true;
                backVisible = true;
                resetVisibleState();
                
                dm("开始播放动画："+file+"，循环："+loop);
                
                timer.enabled = true;
                
        }
        
        function uninit()
        {
		count=0;
		timer=void;
		animLayer=void; 
        }
        
        function pause()
        {
        	timer.enabled=false;
        }
        
        function restart()
        {
        	timer.enabled=true;
        }
        
	function loadpic(filename)
	{
		if (Storages.isExistentStorage(filename))  //假如找得到此图片
		{
			animLayer.changeImage(filename);
			count++;
		}
		else if (loop) //找不到图片且要求循环，返回重设filename的值
		{
			dm("动画循环");
			return false;
		}
		else //找不到图片，不要求循环，正常结束
		{
			dm("动画结束");
			uninit();
		}
		
		return true;
		
	}
		
        function onTimer()
        {
             if (timer===void) return;
		var filename=file+" ("+count+").png";
		
		var show=loadpic(filename);
		
		//假如没有图片，又要求循环，重设file的值开始新的循环
		if (show==false)
		{
			//从指定帧开始循环
			count=target;
			filename=file+" ("+target+").png";
			loadpic(filename);
		}

        }
        
                function resetVisibleState()
        {
                if (timer===void) return;
                animLayer.resetVisibleState(); 
        }
        
         function onStore(f, elm)
        {
        	var dic = f.animplayers = %[];
        	
        	   dic.init = timer !== void;
        	   
                dic.foreVisible = foreVisible;
                dic.backVisible = backVisible;

                dic.file=file;
                
                dic.count=count;
                dic.loop=loop;
                dic.target=target;

                dic.index=index;
                dic.interval=interval;
                
                dic.left=left;
                dic.top=top;
                dic.width=width;
                dic.height=height;

        }
        
           function onRestore(f, clear, elm)
        {
         // 当读取时……
                var dic = f.animplayers;
                if(dic === void || !+dic.init)
                {
                        uninit();
                }
                else if(dic !== void && +dic.init)
                {
                        init(%[
                        file : dic.file,
                        count :dic.count,
                        loop : dic.loop,
                        target : dic.target,
                        index : dic.index,
                        interval : dic.interval,
                        left : dic.left,
                        top : dic.top,
                        width : dic.width,
                        height : dic.height,
                        forevisible : dic.foreVisible,
                        backvisible : dic.backVisible ] );
                }
        }
        
        function onCopyLayer(toback)
        {
                // 表里复制的处理
                if(toback)
                {
                        // 表→里
                        backVisible = foreVisible;
                }
                else
                {
                        // 里→表
                        foreVisible = backVisible;
                }
                
                resetVisibleState();
                
        }
        
                function onExchangeForeBack()
        {
           if (animLayer==void) return;
           animLayer.exchangeForeBack(); //表里交换
        }
        
}

kag.addPlugin(global.animplayer_object = new AnimPlayerPlugin(kag));

@endscript
@endif
;---------------------------------------------------------------------------------------

@macro name=addpath
@eval exp="Storages.addAutoPath(mp.storage+'/')"
@if exp="Storages.isExistentStorage(mp.storage+'.xp3')"
@eval exp="Storages.addAutoPath(mp.storage+'.xp3>')"
@endif
@if exp="Storages.isExistentStorage(System.exePath+mp.storage+'.xp3')"
@eval exp="Storages.addAutoPath(System.exePath+mp.storage+'.xp3>')"
@endif
@endmacro

[macro name=animinit]
[eval exp="animplayer_object.init(mp)"]
[endmacro]

[macro name=animuninit]
[eval exp="animplayer_object.uninit()"]
[endmacro]

[macro name=animpause]
[eval exp="animplayer_object.pause()"]
[endmacro]

@return
