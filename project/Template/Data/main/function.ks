;-------------------------------------------------------------------------------------------
;系统相关函数：键盘操作、选择按钮、自定界面宏、历史记录等
;-------------------------------------------------------------------------------------------
*start
;------------------------------------------------------------
;使用ALT+ENTER切换全屏/窗口
;------------------------------------------------------------
[iscript]
function changeScreenMode(key, shift)
{
  if (key != VK_RETURN || !(shift & ssAlt))
    return false;
  if (global.kag.fullScreen)
    global.kag.onWindowedMenuItemClick(global.kag);
  else
    global.kag.onFullScreenMenuItemClick(global.kag);
  return true;
}
// キー押下時のハンドラを登録
kag.keyDownHook.add(changeScreenMode);
[endscript]
;------------------------------------------------------------
;截图功能
;------------------------------------------------------------
[iscript]
//保存截图
function savenote(name)
{
	//设定保存路径
	var fn = System.exePath + "/ScreenShot/" + name+".bmp";

	//锁定当前截图
	kag.tagHandlers.locksnapshot();
	//保存截图
	kag.snapshotLayer.saveLayerImage(fn,"bmp32");
	//解锁截图
	kag.tagHandlers.unlocksnapshot();
	dm("保存截图为"+name);
}

//获得日期时间字符串
function getDateString()
{
	var time=new Date();
	
	var str=System.title;
	var year=time.getYear();
	var month=time.getMonth()+1;
	var day=time.getDate();
	
	if (month<10) month="0"+(string)month;
	if (day<10) day="0"+(string)day;
	
	var hour=time.getHours();
	var minute=time.getMinutes();
	var second=time.getSeconds();
	
	if (hour<10) hour="0"+(string)hour;
	if (minute<10) minute="0"+(string)minute;
	if (second<10) second="0"+(string)second;
	
	//最后结果
	str+=(string)year+(string)month+(string)day+"_";
	str+=(string)hour+(string)minute+(string)second;
	return str;
}

function ScreenShot(key, shift)
{	
  dm("按键编号"+key);
  
  //106为小键盘星号截图键|116为F5
  if (!(key == 106 || key==116))
    return false;

	//保存图片
	var str=getDateString();
	savenote("nvlmaker_"+str);
}
// キー押下時のハンドラを登録
kag.keyDownHook.add(ScreenShot);
[endscript]
;------------------------------------------------------------
;左键点击显示对话框
;------------------------------------------------------------
[iscript]
function onLeftClick()
{
  kag.process("rclick.ks", "*showmes");
  return true;
}
[endscript]
;------------------------------------------------------------
;封装的人物姓名宏，字体设置
;------------------------------------------------------------
[iscript]
//按照配置表的内容设定字体，默认只是改变字体颜色
function setfont()
{
  kag.tagHandlers.font(%["color"=>f.config_name[1].color]);
}
[endscript]
;------------------------------------------------------------
;历史记录用的文字记录效果
;------------------------------------------------------------
[iscript]
kag.tagHandlers.htext = function(elm)
{
	if(historyWriteEnabled) historyLayer.store(elm.text);
	return false;
} incontextof kag;

[endscript]
;------------------------------------------------------------
;字典相关数据处理
;------------------------------------------------------------
[iscript]
//删除字典中的空值
function checkdict(name,value,dict)
{
	if (value=='') 
	{
		dict[name]=void;
	}
}

//将字典dict中不为空的值复制到字典param内
function setdictvalue(name,value,dict,param)
{
	if (value!=void)
	{
		param[name]=dict[name];
		//查看有几个参数被传入
		//dm("mp."+name+"="+value);
	}
}
[endscript]
;------------------------------------------------------------------
;自定按钮宏（对应NVL参数字典,标签，表达式，TICK间隔时间，点击时每TICK执行函数）
;------------------------------------------------------------------
[iscript]

function mybutton(dicname,target,exp,interval,ontimer)
{
	//新建字典并复制一份参数
	var mybutton=new Dictionary(); 
	mybutton=dicname!;

	//假如内容为空，则不发生任何事
	if (mybutton==void) return;
	
	//假如按钮存在并且使用到，则增加其他传入参数
	if (mybutton.use==true)
	{
		kag.tagHandlers.locate(
		%[
			"x" => mybutton.x,
			"y" => mybutton.y
		]);

		mybutton.target=target;
		mybutton.exp=exp;
		
		mybutton.interval=interval;
		mybutton.ontimer=ontimer;

		//删除字典内的空值
		foreach(mybutton,checkdict);
		kag.tagHandlers.button(mybutton);

	}
}
[endscript]
;------------------------------------------------------------------
;自定checkbox宏
;------------------------------------------------------------------
[iscript]
function mycheckbox(dicname,target,exp,result)
{
	dm("显示checkbox"+dicname);
	dm(result);
	//新建字典并复制一份参数
	var mybutton=new Dictionary();
	mybutton=dicname!;

	//假如内容为空，则不发生任何事
	if (mybutton==void) return;
	
	//假如按钮存在并且使用到，则增加其他传入参数
	if (mybutton.use==true)
	{
		kag.tagHandlers.locate(
		%[
			"x" => mybutton.x,
			"y" => mybutton.y
		]);

		var mycheckbox=new Dictionary();

		mycheckbox.target=target;
		mycheckbox.exp=exp;

		mycheckbox.enterse=mybutton.enterse;
		mycheckbox.clickse=mybutton.clickse;

		if (result==true)
		{
			mycheckbox.normal=mybutton.on;
			mycheckbox.over=mybutton.on_over;
		}
		else
		{
			mycheckbox.normal=mybutton.normal;
			mycheckbox.over=mybutton.over;
		}

		//删除字典内的空值
		foreach(mycheckbox,checkdict);
		kag.tagHandlers.button(mycheckbox);

	}
}
[endscript]
;------------------------------------------------------------------
;系统按钮有效、无效操作
;------------------------------------------------------------------
[iscript]
//无效化单个系统按钮（foreach循环用）
function oneButtonEnabled(name,value,dict,enabled)
{
	dict[name].enabled=enabled;
}
//将所有系统按钮无效化/有效化的函数
function setSysbuttonEnabled(page,enabled)
{
	var layer;
	
	if (page=="fore") layer=kag.fore.messages[2];
	else layer=kag.back.messages[2];

	//if (layer.buttons[name]!=void) layer.buttons[name].enabled=enabled;//处理单个按钮的范例

	//批量处理当前层上所有按钮
	foreach(layer.buttons,oneButtonEnabled,enabled);
}
[endscript]
;------------------------------------------------------------------
;自定系统按钮宏（系统按钮名字，对应NVL参数字典，表达式，不安定时是否可点）
;------------------------------------------------------------------
[iscript]
function mysysbutton(dicname,name,exp,nostable)
{

	var mysysbutton=new Dictionary();
	mysysbutton=dicname!;
	
	//假如不存在对应的参数，则不发生任何事
	if (mysysbutton==void) return;

	//假如按钮存在并且使用到，则增加其他传入参数
	if (mysysbutton.use==true)
	{
		mysysbutton.name=name;
		mysysbutton.exp=exp;
		mysysbutton.nostable=nostable;

		//删除字典内的空值
		foreach(mysysbutton,checkdict);

		kag.tagHandlers.sysbutton(mysysbutton);

	}
}
[endscript]
;------------------------------------------------------------
;自定滑动槽
;------------------------------------------------------------
[iscript]
//即时调整音效和语音音量的函数
function setSeVolume()
{
    kag.se[0].volume=sf.sevolume;
	dm("Se Volume="+kag.se[0].volume);
}

function setVoiceVolume()
{
	kag.se[1].volume=sf.voicevolume;
	dm("Voice Volume="+kag.se[1].volume);
}
[endscript]

[iscript]
//滑动槽定义
function myslider(dicname,value,max,min,mychangefunc)
{

	var myslider=new Dictionary();	
	myslider=dicname!;

	//假如不存在对应的参数，则不发生任何事
	if (myslider==void) return;

	//假如Slider存在并且使用到，则增加其他传入参数
	if (myslider.use==true)
	{

		kag.tagHandlers.locate(
		%[
			"x" => myslider.x,
			"y" => myslider.y
		]);

		myslider.nofixpos=true;
		myslider.nohilight=true;

		myslider.value=value;
		myslider.max=max;
		myslider.min=min;

		myslider.mychangefunc=mychangefunc;

		//删除字典内的空值
		foreach(myslider,checkdict);
		//创建滑动槽
		kag.tagHandlers.slider(myslider);

	}
}
[endscript]
;------------------------------------------------------------
;历史记录里，播放语音用的函数
;------------------------------------------------------------
[iscript]
//简单的播放语音函数
function playse(file,buf=1,isloop=false)
{
	kag.tagHandlers.playse(%[
	"storage"=>file,
	"buf"=>buf,
	"loop"=>isloop
	]);
}
[endscript]
;------------------------------------------------------------
;历史记录里，识别人名并自动返回对应颜色
;------------------------------------------------------------
[iscript]
function history_color(text)
{
       if (text!=void && text.charAt(0)=="【")
       {
	         var name=text.substring(1,text.length-2);
	         var arr=f.config_name;
         
	         //为主角，使用主角的颜色
	         if (name==f.姓+f.名) return arr[0].color;
	         //否则
	         //是姓名列表里的角色，使用列表里设置的颜色
	           for (var i=2;i<arr.count;i++)
	          {
	             if (arr[i].name==name) return arr[i].color;
	           }
           
	         //无颜色记录,使用路人的颜色
	         return arr[1].color;

       }
		
       //不是人名，返回默认历史记录字体颜色
       return f.config_history.font.color;
}
[endscript]
;------------------------------------------------------------
;为ptext指令增加\n换行效果
;------------------------------------------------------------
[iscript]
kag.tagHandlers.ptext = function(elm)
{
        var layer = getLayerFromElm(elm);

        if(elm.lineheight === void)
        {
                layer.drawReconstructibleText(elm);
        }
        else
        {
                var textS = elm.text;
                var textarr = textS.split(/\\n|\n/);
                var lineheight = +elm.lineheight;
                var iy = +elm.y;
                for(var i=0; i<textarr.count; i++)
                {
                        elm.text = textarr[i];
                        layer.drawReconstructibleText(elm);
                        iy += lineheight;
                        elm.y = iy;
                }
        }
        return 0;
} incontextof kag;
[endscript]
;------------------------------------------------------------
;界面文件载入
;------------------------------------------------------------
[iscript]
function loadUIFile(file)
{
	return Scripts.evalStorage(file+".tjs");
}

function loadUIFiles()
{
	f.setting=loadUIFile("setting");

	f.config_dia=loadUIFile('uidia');
	f.config_sel=loadUIFile('uisel');
	f.config_menu=loadUIFile("uimenu");
	f.config_slpos=loadUIFile("uislpos");
	f.config_option=loadUIFile("uioption");
	f.config_history=loadUIFile("uihistory");
	f.config_name=loadUIFile("namelist");
	f.config_save=loadUIFile("uisave");
	f.config_load=loadUIFile("uiload");
	f.config_cgmode=loadUIFile("uicgmode");
	f.config_bgmmode=loadUIFile("uibgmmode");
	f.config_endmode=loadUIFile("uiendmode");
}
[endscript]
;------------------------------------------------------------
[return]
