*start
;------------------------------------------------------------
;配方系统范例（宏）-配方系统
;------------------------------------------------------------
[iscript]
//初始化：读入配方数据
f.recipe=Scripts.evalStorage("recipe_data.tjs");

[endscript]

;根据配方ID，获得配方
[macro name="addrecipe"]
[eval exp="f.recipe[mp.id].edu=true"]
[endmacro]

[iscript]
function getRecipeList()
{
	var arr=[];

	for (var i=0;i<f.recipe.count-1;i++)
	{
		var dic=f.recipe[i];

		if (dic.edu==true)
		{
			arr.add(dic);
		}
	}

	return arr;
}
[endscript]

;---------------------------------------显示一页的配方按钮---------------------------------------
[iscript]
//描绘配方
function draw_recipe()
{
	//------【修改排版的位置】------
	
	//设定每页显示的配方数量
	var per_num=5;
	//设定按钮位置
	var x=160;
	var y=125;
	//设定按钮间距
	var line_space=35;

	//---------------------------------
	var arr = getRecipeList();

	//计算配方页数
	f.配方总页数=arr.count\per_num;
	if (arr.count%per_num>0) f.配方总页数++;
	
	//假如配方总页数<1，说明不存在配方，那么就不继续了
	if (f.配方总页数<1) 
	{
		f.当前配方页=0;
		return;
	}
	
	//保证当前配方页不为0，且不超过配方总页数
	if (f.当前配方页<1) f.当前配方页=1;
	if (f.当前配方页>f.配方总页数) f.当前配方页=f.配方总页数;
	
	for (var i=0;i<per_num;i++)
        {
        	 //准备显示的配方编号
            var item_index=(int)(f.当前配方页-1)*per_num+(int)i;

            	//假如超过了配方列表总数（最后一页配方已经显示完毕），跳出循环
             if (item_index>=arr.count) break;
             
             //假如没有超过，继续显示

			//用TJS的方式设定按钮坐标
	             kag.tagHandlers.locate(%["x" => x, "y" => y+i*line_space ]);
	             
	             //【描绘小函数1】创建配方按钮
				draw_recipe_button(item_index);
	             //【描绘小函数2】在配方按钮上描绘配方名称
	             draw_recipe_name(arr[item_index].name);

        }
}
[endscript]

;---------------------------------------描绘小函数1：创建单个配方按钮---------------------------------------

[iscript]

function draw_recipe_button(item_index)
{
         //设定配方按钮的具体属性
         var mybutton=new Dictionary();

         //【修改按钮图形】
         mybutton.normal="sl_button_normal";
         mybutton.over="sl_button_over";

         //【悬停效果函数】设定鼠标移动到配方按钮上和离开时的效果
         mybutton.onenter="draw_recipe_icon("+item_index+")";
         mybutton.onleave="hide_item_icon()";

         //设定按钮按下后的效果，跳转到标签 *合成
         mybutton.target="*合成";
         //按下后会将配方编号赋值给 f.选择配方编号 这个变数
         mybutton.exp="f.选择配方编号="+item_index;
         
         //用tjs的方式创建按钮
         kag.tagHandlers.button(mybutton);

}

[endscript]

;---------------------------------------描绘小函数2：描绘配方按钮上的文字---------------------------------------
[iscript]

function draw_recipe_name(name)
{

	var mybutton=kag.current.links[kag.current.links.count-1].object;
	
	//字体大小
	mybutton.font.height=24;
	//根据传入的编号取得配方名称
	var str=name;
	
	//文字在按钮上的坐标
	var x=5;
	var y=7;
	//描绘配方名称
	mybutton.drawText(x,                           y, str, 0xD1BEA0);
	mybutton.drawText(x+mybutton.width,              y, str, 0xD1BEA0);
	mybutton.drawText(x+mybutton.width+mybutton.width, y, str, 0xD1BEA0);
}
[endscript]

;---------------------------------------悬停效果（显示）---------------------------------------
[iscript]

function draw_recipe_icon(item_index)
{
	    //取得配方的详细资料
	    var item=f.recipe[item_index];
	    
	    //在层16上显示配方图标
	    kag.fore.layers[16].loadImages(%[
	    'storage'=>item.icon,
	    'visible'=>true,
	    'left'=>524,
	    'top'=>128,
	    ]);
	    
	    //用空白图片清空描绘解释文字的图层17
	    kag.fore.layers[17].loadImages(%['storage'=>'empty','visible'=>true,'left'=>0,'top'=>0]);
	    	    
	    //【悬停小函数2】描绘配方的说明文字
	    draw_item_exp(item.intro);

}
[endscript]

[macro name=recipe_page]
;描绘返回按钮
[locate x=186 y=21]
[button normal=sysmenu_return_normal over=sysmenu_return_over storage="other.ks" target=*返回]
;描绘翻页按钮
[locate x=234 y=314]
[button normal=page_button_normal_01 over=page_button_over_01 target=*刷新画面 exp="f.当前配方页-- if (f.当前配方页>1)"]
[locate x=351 y=314]
[button normal=page_button_normal_02 over=page_button_over_02 target=*刷新画面 exp="f.当前配方页++ if (f.当前配方页<f.配方总页数)"]
;用ptext描绘页数文字
[image layer=15 page=%page storage="empty" visible="true" left=0 top=0]
[ptext layer=15 page=%page  x=540 y=330 text=&"'Page '+.f.当前配方页+' of '+f.配方总页数" color=0xD1BEA0 size=24 shadow="false"]
[endmacro]

[return]
