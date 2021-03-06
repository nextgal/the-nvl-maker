;------------------------------------------------------------
;物品系统范例（宏）-界面显示相关
;------------------------------------------------------------
;（1）draw_item()显示一页的物品按钮
;（2）draw_item_button(物品编号)显示单个物品按钮
;（3）draw_item_name(物品编号)在物品按钮上描绘物品名称和数量

;（4）draw_item_icon(物品编号)鼠标移入时显示的效果
;（5）draw_item_elm(是否可食用)显示物品的可用属性
;（6）draw_item_exp(物品说明文字)显示物品说明（多行、10个字自动换行）
;（7）hide_item_icon()鼠标离开时的函数，隐藏悬停效果

;（8）[item_page]翻页按钮和页数显示宏

;---------------------------------------显示一页的物品按钮---------------------------------------
[iscript]
function get_item_list_by_type(type=0)
{
	var arr=[];
	for (var i=0;i<f.item.count;i++)
	{
		if (type==0) arr.add(f.item[i]);
		else if (type==f.item[i].type) arr.add(f.item[i]);
	}

	return arr;
}

function draw_item(type=0)
{
	//------【修改排版的位置】------
	
	//设定每页显示的物品数量
	var per_num=5;
	//设定按钮位置
	var x=160;
	var y=125;
	//设定按钮间距
	var line_space=35;
	
	//---------------------------------
	
	//取得数量和count
	var itemlist=get_item_list_by_type(type);
	var item_count=itemlist.count;

	//计算物品页数
	f.物品总页数=item_count\per_num;
	if (item_count%per_num>0) f.物品总页数++;
	
	//假如物品总页数<1，说明不存在物品，那么就不继续了
	if (f.物品总页数<1) 
	{
		f.当前物品页=0;
		return;
	}
	
	//保证当前物品页不为0，且不超过物品总页数
	if (f.当前物品页<1) f.当前物品页=1;
	if (f.当前物品页>f.物品总页数) f.当前物品页=f.物品总页数;
	
	for (var i=0;i<per_num;i++)
        {

			 //准备显示的物品编号
			var item_index=(int)(f.当前物品页-1)*per_num+(int)i;
			
				//假如超过了物品列表总数（最后一页物品已经显示完毕），跳出循环
			 if (item_index>=item_count) break;

			dm("编号"+item_index);
			dm("名字"+itemlist[item_index].name);
			 
			 //假如没有超过，继续显示
			var item_id=isItemExist(itemlist[item_index].name);
			
			//用TJS的方式设定按钮坐标
			     kag.tagHandlers.locate(%["x" => x, "y" => y+i*line_space ]);
			     
			 //【描绘小函数1】创建物品按钮
			draw_item_button(item_id);
			 //【描绘小函数2】在物品按钮上描绘物品名称和数量
			 draw_item_name(item_id);

        }
}
[endscript]

;---------------------------------------描绘小函数1：创建单个物品按钮---------------------------------------
[iscript]

function draw_item_button(item_index)
{
         //设定物品按钮的具体属性
         var mybutton=new Dictionary();
         
         //【修改按钮图形】
         mybutton.normal="sl_button_normal";
         mybutton.over="sl_button_over";
         
         //【悬停效果函数】设定鼠标移动到物品按钮上和离开时的效果
         mybutton.onenter="draw_item_icon("+item_index+")";
         mybutton.onleave="hide_item_icon()";
         
         //设定按钮按下后的效果，跳转到标签 *使用物品
         mybutton.target="*使用物品";
         //按下后会将物品编号赋值给 f.选择物品编号 这个变数
         mybutton.exp="f.选择物品编号="+item_index;
         

         //用tjs的方式创建按钮
         kag.tagHandlers.button(mybutton);
         
}
[endscript]
;---------------------------------------描绘小函数2：描绘物品按钮上的文字---------------------------------------
[iscript]

function draw_item_name(item_index)
{

	var mybutton=kag.current.links[kag.current.links.count-1].object;
	
	//字体大小
	mybutton.font.height=24;
	//根据传入的编号取得物品名称
	var str=f.item[item_index].name;
	
	//文字在按钮上的坐标
	var x=5;
	var y=7;
	//描绘物品名称
	mybutton.drawText(x,                           y, str, 0xD1BEA0);
	mybutton.drawText(x+mybutton.width,              y, str, 0xD1BEA0);
	mybutton.drawText(x+mybutton.width+mybutton.width, y, str, 0xD1BEA0);
	
	//取得物品数量
	var str="x "+f.item[item_index].num;
	//文字在按钮上的坐标
	var x=245;
	var y=7;
	//描绘物品数量
	mybutton.drawText(x,                           y, str, 0xD1BEA0);
	mybutton.drawText(x+mybutton.width,              y, str, 0xD1BEA0);
	mybutton.drawText(x+mybutton.width+mybutton.width, y, str, 0xD1BEA0);
}
[endscript]

;---------------------------------------悬停效果（显示）---------------------------------------
[iscript]

function draw_item_icon(item_index)
{
	    //取得物品的详细资料
	    var item=f.item[item_index];
	    
	    //在层16上显示物品图标
	    kag.fore.layers[16].loadImages(%[
	    'storage'=>item.icon,
	    'visible'=>true,
	    'left'=>524,
	    'top'=>128,
	    ]);
	    
	    //用空白图片清空描绘解释文字的图层17
	    kag.fore.layers[17].loadImages(%['storage'=>'empty','visible'=>true,'left'=>0,'top'=>0]);
	    
	    //【悬停小函数1】描绘可食用属性
	    draw_item_elm(item.eat);
	    
	    //【悬停小函数2】描绘物品的说明文字
	    draw_item_exp(item.intro);

}
[endscript]
;---------------------------------------悬停小函数1：描绘物品的可食用属性--------------------------------------
[iscript]
function draw_item_elm(caneat)
{
	    
	var text=new Dictionary();
	text.layer="17";
	text.y=160;
	text.color=0xD1BEA0;
	text.shadow=false;
	text.size=24;
	
	if (caneat) //假如设定成可以吃的
	{
		text.x=662;
		text.text="可食用";
		kag.tagHandlers.ptext(text);
	}
	else
	{
		text.x=650;
		text.text="不可食用";
		kag.tagHandlers.ptext(text);
	}
	    
}
[endscript]

;---------------------------------------悬停小函数2：描绘物品说明---------------------------------------
[iscript]
function draw_item_exp(exp)
{
	
	//每行字数
	var per_num=10;
	//坐标与行间距
	var x=525;
	var y=230;
	var line_space=27;
	
	//计算行数
	var line_count=exp.length\per_num;
	if  (exp.length%per_num>0) {line_count++;}
	
	var text=new Dictionary();
	
	text.layer="17";
	text.color=0xD1BEA0;
	text.shadow=false;
	text.size=24;
	
           //开始描绘
	for (var i=0; i<line_count; i++)
	{
		text.x=x;
		text.y=y+i*line_space;
		text.text=exp.substring(i*per_num,per_num);
		kag.tagHandlers.ptext(text);
	}
	
	
}
[endscript]

;---------------------------------------悬停效果（隐藏）---------------------------------------
[iscript]
function hide_item_icon()
{
	kag.fore.layers[16].visible=false;
	kag.fore.layers[17].visible=false;
}
[endscript]

[macro name=item_page]
;描绘返回按钮
[locate x=186 y=21]
[button normal=sysmenu_return_normal over=sysmenu_return_over storage="other.ks" target=*返回]
;描绘翻页按钮
[locate x=234 y=314]
[button normal=page_button_normal_01 over=page_button_over_01 target=*刷新画面 exp="f.当前物品页-- if (f.当前物品页>1)"]
[locate x=351 y=314]
[button normal=page_button_normal_02 over=page_button_over_02 target=*刷新画面 exp="f.当前物品页++ if (f.当前物品页<f.物品总页数)"]
;用ptext描绘页数文字
[image layer=15 page=%page storage="empty" visible="true" left=0 top=0]
[ptext layer=15 page=%page  x=540 y=330 text=&"'Page '+.f.当前物品页+' of '+f.物品总页数" color=0xD1BEA0 size=24 shadow="false"]

;描绘分类
[locate x=0 y=354]
[button normal="date_frame" exp="f.物品类型=0" target=*刷新画面]

[locate x=0 y=414]
[button normal="date_frame" exp="f.物品类型=1" target=*刷新画面]
[locate x=0 y=474]
[button normal="date_frame" exp="f.物品类型=2" target=*刷新画面]
[locate x=0 y=534]
[button normal="date_frame" exp="f.物品类型=3" target=*刷新画面]
[endmacro]

;------------------------------------------------------------
[return]
