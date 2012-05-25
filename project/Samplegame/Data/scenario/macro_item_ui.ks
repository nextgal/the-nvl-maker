;------------------------------------------------------------
;物品系統範例（宏）-界面顯示相關
;------------------------------------------------------------
;（1）draw_item()顯示一頁的物品按鈕
;（2）draw_item_button(物品編號)顯示單個物品按鈕
;（3）draw_item_name(物品編號)在物品按鈕上描繪物品名稱和數量

;（4）draw_item_icon(物品編號)鼠標移入時顯示的效果
;（5）draw_item_elm(是否可食用)顯示物品的可用屬性
;（6）draw_item_exp(物品說明文字)顯示物品說明（多行、10個字自動換行）
;（7）hide_item_icon()鼠標離開時的函數，隱藏懸停效果

;（8）[item_page]翻頁按鈕和頁數顯示宏

;---------------------------------------顯示一頁的物品按鈕---------------------------------------
[iscript]

function draw_item()
{
	//------【修改排版的位置】------
	
	//設定每頁顯示的物品數量
	var per_num=5;
	//設定按鈕位置
	var x=160;
	var y=125;
	//設定按鈕間距
	var line_space=35;
	
	//---------------------------------
	
	//計算物品頁數
	f.物品總頁數=f.item.count\per_num;
	if (f.item.count%per_num>0) f.物品總頁數++;
	
	//假如物品總頁數<1，說明不存在物品，那麼就不繼續了
	if (f.物品總頁數<1) 
	{
		f.當前物品頁=0;
		return;
	}
	
	//保證當前物品頁不為0，且不超過物品總頁數
	if (f.當前物品頁<1) f.當前物品頁=1;
	if (f.當前物品頁>f.物品總頁數) f.當前物品頁=f.物品總頁數;
	
	for (var i=0;i<per_num;i++)
        {
        	 //準備顯示的物品編號
            var item_index=(int)(f.當前物品頁-1)*per_num+(int)i;

            	//假如超過了物品列表總數（最後一頁物品已經顯示完畢），跳出循環
             if (item_index>=f.item.count) break;
             
             //假如沒有超過，繼續顯示

			//用TJS的方式設定按鈕坐標
	             kag.tagHandlers.locate(%["x" => x, "y" => y+i*line_space ]);
	             
	             //【描繪小函數1】創建物品按鈕
			draw_item_button(item_index);
	             //【描繪小函數2】在物品按鈕上描繪物品名稱和數量
	             draw_item_name(item_index);

        }
}
[endscript]

;---------------------------------------描繪小函數1：創建單個物品按鈕---------------------------------------
[iscript]

function draw_item_button(item_index)
{
         //設定物品按鈕的具體屬性
         var mybutton=new Dictionary();
         
         //【修改按鈕圖形】
         mybutton.normal="sl_button_normal";
         mybutton.over="sl_button_over";
         
         //【懸停效果函數】設定鼠標移動到物品按鈕上和離開時的效果
         mybutton.onenter="draw_item_icon("+item_index+")";
         mybutton.onleave="hide_item_icon()";
         
         //設定按鈕按下後的效果，跳轉到標籤 *使用物品
         mybutton.target="*使用物品";
         //按下後會將物品編號賦值給 f.選擇物品編號 這個變數
         mybutton.exp="f.選擇物品編號="+item_index;
         

         //用tjs的方式創建按鈕
         kag.tagHandlers.button(mybutton);
         
}
[endscript]
;---------------------------------------描繪小函數2：描繪物品按鈕上的文字---------------------------------------
[iscript]

function draw_item_name(item_index)
{

	var mybutton=kag.current.links[kag.current.links.count-1].object;
	
	//字體大小
	mybutton.font.height=24;
	//根據傳入的編號取得物品名稱
	var str=f.item[item_index].name;
	
	//文字在按鈕上的坐標
	var x=5;
	var y=7;
	//描繪物品名稱
	mybutton.drawText(x,                           y, str, 0xD1BEA0);
	mybutton.drawText(x+mybutton.width,              y, str, 0xD1BEA0);
	mybutton.drawText(x+mybutton.width+mybutton.width, y, str, 0xD1BEA0);
	
	//取得物品數量
	var str="x "+f.item[item_index].num;
	//文字在按鈕上的坐標
	var x=245;
	var y=7;
	//描繪物品數量
	mybutton.drawText(x,                           y, str, 0xD1BEA0);
	mybutton.drawText(x+mybutton.width,              y, str, 0xD1BEA0);
	mybutton.drawText(x+mybutton.width+mybutton.width, y, str, 0xD1BEA0);
}
[endscript]

;---------------------------------------懸停效果（顯示）---------------------------------------
[iscript]

function draw_item_icon(item_index)
{
	    //取得物品的詳細資料
	    var item=f.item[item_index];
	    
	    //在層16上顯示物品圖標
	    kag.fore.layers[16].loadImages(%[
	    'storage'=>item.icon,
	    'visible'=>true,
	    'left'=>524,
	    'top'=>128,
	    ]);
	    
	    //用空白圖片清空描繪解釋文字的圖層17
	    kag.fore.layers[17].loadImages(%['storage'=>'empty','visible'=>true,'left'=>0,'top'=>0]);
	    
	    //【懸停小函數1】描繪可食用屬性
	    draw_item_elm(item.eat);
	    
	    //【懸停小函數2】描繪物品的說明文字
	    draw_item_exp(item.intro);

}
[endscript]
;---------------------------------------懸停小函數1：描繪物品的可食用屬性--------------------------------------
[iscript]
function draw_item_elm(caneat)
{
	    
	var text=new Dictionary();
	text.layer="17";
	text.y=160;
	text.color=0xD1BEA0;
	text.shadow=false;
	text.size=24;
	
	if (caneat) //假如設定成可以吃的
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

;---------------------------------------懸停小函數2：描繪物品說明---------------------------------------
[iscript]
function draw_item_exp(exp)
{
	
	//每行字數
	var per_num=10;
	//坐標與行間距
	var x=525;
	var y=230;
	var line_space=27;
	
	//計算行數
	var line_count=exp.length\per_num;
	if  (exp.length%per_num>0) {line_count++;}
	
	var text=new Dictionary();
	
	text.layer="17";
	text.color=0xD1BEA0;
	text.shadow=false;
	text.size=24;
	
           //開始描繪
	for (var i=0; i<line_count; i++)
	{
		text.x=x;
		text.y=y+i*line_space;
		text.text=exp.substring(i*per_num,per_num);
		kag.tagHandlers.ptext(text);
	}
	
	
}
[endscript]

;---------------------------------------懸停效果（隱藏）---------------------------------------
[iscript]
function hide_item_icon()
{
	kag.fore.layers[16].visible=false;
	kag.fore.layers[17].visible=false;
}
[endscript]

[macro name=item_page]
;描繪返回按鈕
[locate x=186 y=21]
[button normal=sysmenu_return_normal over=sysmenu_return_over storage="other.ks" target=*返回]
;描繪翻頁按鈕
[locate x=234 y=314]
[button normal=page_button_normal_01 over=page_button_over_01 target=*刷新畫面 exp="f.當前物品頁-- if (f.當前物品頁>1)"]
[locate x=351 y=314]
[button normal=page_button_normal_02 over=page_button_over_02 target=*刷新畫面 exp="f.當前物品頁++ if (f.當前物品頁<f.物品總頁數)"]
;用ptext描繪頁數文字
[image layer=15 page=%page storage="empty" visible="true" left=0 top=0]
[ptext layer=15 page=%page  x=540 y=330 text=&"'Page '+.f.當前物品頁+' of '+f.物品總頁數" color=0xD1BEA0 size=24 shadow="false"]
[endmacro]

;------------------------------------------------------------
[return]
