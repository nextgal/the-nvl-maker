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
return cd;
}
[endscript]
;------------------------------------------------------------
;描绘用函数
;------------------------------------------------------------
[iscript]
function slbuttontitle(button,num)
{
button.font.face=kag.fore.messages[0].userFace;
button.font.bold=f.config_slpos.pagefont.bold;
button.font.italic=f.config_slpos.pagefont.italic;
var sha=f.config_slpos.pagefont.shadow;
var shac=f.config_slpos.pagefont.shadowcolor;
var edg=f.config_slpos.pagefont.edge;
var edgc=f.config_slpos.pagefont.edgecolor;

if (f.config_slpos.num.use)
{
//档案编号
   button.font.height=f.config_slpos.num.height;
   var x=(int)f.config_slpos.num.x;
   var y=(int)f.config_slpos.num.y;
   var normal=f.config_sl.num.normal;
   var on=f.config_sl.num.on;
   var over=f.config_sl.num.over;
   var str=f.config_slpos.num.pre+(num*1+1)+f.config_slpos.num.after;
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
if (f.config_slpos.bookmark.use)
{
////描绘章节名
   button.font.height=f.config_slpos.bookmark.height;
   var x=(int)f.config_slpos.bookmark.x;
   var y=(int)f.config_slpos.bookmark.y;
   var normal=f.config_sl.bookmark.normal;
   var on=f.config_sl.bookmark.on;
   var over=f.config_sl.bookmark.over;
   var str=kag.getBookMarkPageName(num);
   if (sha)
   {
   button.drawText(x,                           y, str, normal,255,true,255,shac,0,2,2);
   button.drawText(x+button.width,              y, str, on,255,true,255,shac,0,2,2);
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
if (f.config_slpos.date.use)
{
//描绘日期
   button.font.height=f.config_slpos.date.height;
   var x=(int)f.config_slpos.date.x;
   var y=(int)f.config_slpos.date.y;
   
   var normal=f.config_sl.date.normal;
   var on=f.config_sl.date.on;
   var over=f.config_sl.date.over;
   var str=kag.getBookMarkDate(num);
   if (sha)
   {
   button.drawText(x,                           y, str, normal,255,true,255,shac,0,2,2);
   button.drawText(x+button.width,              y, str, on,255,true,255,shac,0,2,2);
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
//描绘对话
if (f.config_slpos.history.use)
{
   button.font.height=f.config_slpos.history.height;
   var x=(int)f.config_slpos.history.x;
   var y=(int)f.config_slpos.history.y;
   
   var normal=f.config_sl.history.normal;
   var on=f.config_sl.history.on;
   var over=f.config_sl.history.over;
   //取得历史记录
   var his;
   if (sf.历史[num]!=void)
   {
    his=sf.历史[num];
   }
   else
   {
    his="……";
   }
   //切掉不必要的字数
   var str=his.substring(0,f.config_slpos.history.num);
   str+="……";
   //描绘
   if (sha)
   {
   button.drawText(x,                           y, str, normal,255,true,255,shac,0,2,2);
   button.drawText(x+button.width,              y, str, on,255,true,255,shac,0,2,2);
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

}
[endscript]
;------------------------------------------------------------
;悬停
;------------------------------------------------------------
[iscript]
function slshow(num)
{
if (kag.getBookMarkDate(num)!=void)
{
    //清空描绘层
    kag.fore.layers[16].loadImages(%['storage'=>'empty','visible'=>true,'left'=>0,'top'=>0]);
   //描绘章节名
   if (f.config_slpos.drawmark.use)
   {
      var setting=new Dictionary();
      //复制字体设定
      (Dictionary.assign incontextof setting)(f.config_slpos.pagefont);
      //增加其他参数
      setting.text=kag.getBookMarkPageName(num);
      setting.layer="16";
      setting.face=kag.fore.messages[0].userFace;
      setting.x=f.config_slpos.drawmark.x;
      setting.y=f.config_slpos.drawmark.y;
      setting.size=f.config_slpos.drawmark.size;
      setting.color=f.config_sl.draw.bookmark;   
      kag.tagHandlers.ptext(setting);
   }
   
   //描绘日期时间
   if (f.config_slpos.drawdate.use)
   {
      var setting=new Dictionary();
      //复制字体设定
      (Dictionary.assign incontextof setting)(f.config_slpos.pagefont);
      //增加其他参数
      setting.text=kag.getBookMarkDate(num);
      setting.layer="16";
      setting.face=kag.fore.messages[0].userFace;
      setting.x=f.config_slpos.drawdate.x;
      setting.y=f.config_slpos.drawdate.y;
      setting.size=f.config_slpos.drawdate.size;
      setting.color=f.config_sl.draw.date;   
      kag.tagHandlers.ptext(setting);
   }
   
   //描绘对话
   if (f.config_slpos.drawtalk.use)
   {
        if (sf.历史[num]!=void)
      {
           var talk=sf.历史[num];
           talk+="……";
           var t_linecount=talk.length\f.config_slpos.drawtalk.count;
           if  (talk.length%f.config_slpos.drawtalk.count>0) {t_linecount++;}

           //开始描绘
            for (var i=0; i<t_linecount; i++)
               {
                   //复制字体设定
                   var setting=new Dictionary();
                   (Dictionary.assign incontextof setting)(f.config_slpos.pagefont);
                   setting.layer="16";
                   setting.face=kag.fore.messages[0].userFace;
                   setting.x=(int)f.config_slpos.drawtalk.x;
                   setting.y=(int)i*f.config_slpos.drawtalk.space+(int)f.config_slpos.drawtalk.y;
                   setting.size=f.config_slpos.drawtalk.size;
                   setting.color=f.config_sl.draw.talk;
                   setting.text=talk.substring(i*f.config_slpos.drawtalk.count,f.config_slpos.drawtalk.count);
                   kag.tagHandlers.ptext(setting);
               }
        }
    }

   //描绘截图
   if (checkdata(num)) kag.fore.layers[17].loadImages(%[
      'storage'=>storagedata(num),
      'visible'=>f.config_slpos.snapshot.visible,
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

      savebutton.normal=f.config_sl.button.normal;

      if (f.config_sl.button.over!=void) savebutton.over=f.config_sl.button.over;
      if (f.config_sl.button.on!=void) savebutton.on=f.config_sl.button.on;

      if (f.config_sl.button.enterse!=void) savebutton.enterse=f.config_sl.button.enterse;
      if (f.config_sl.button.clickse!=void) savebutton.clickse=f.config_sl.button.clickse;

      savebutton.onenter='slshow('+num+')';
      savebutton.onleave="slhide()";
      savebutton.exp='tf.最近档案='+num;
      savebutton.target="*存取游戏";
      kag.tagHandlers.button(savebutton);
      slbuttontitle(kag.current.links[kag.current.links.count-1].object,num);
}
[endscript]
;------------------------------------------------------------
;批量描绘
;------------------------------------------------------------
[iscript]
function drawslbutton(page="fore")
{
var layer;
//载入空白图片,用于显示状态
  if (page=="fore") layer=kag.fore.layers[15];
  else layer=kag.back.layers[15];
  layer.loadImages(%['storage'=>'empty', 'visible'=>true,'left'=>0,'top' =>0]);

//描绘其他按钮
//返回
if (f.config_slpos.back[2])
{
      kag.tagHandlers.locate(
      %[
        "x" => f.config_slpos.back[0],
        "y" => f.config_slpos.back[1]
      ]);

      //取得参数
      var mybutton=new Dictionary();

      mybutton.normal=f.config_sl.back.normal;
      if (f.config_sl.back.over!=void) mybutton.over=f.config_sl.back.over;
      if (f.config_sl.back.on!=void) mybutton.on=f.config_sl.back.on;

      if (f.config_sl.back.enterse!=void) mybutton.enterse=f.config_sl.back.enterse;
      if (f.config_sl.back.clickse!=void) mybutton.clickse=f.config_sl.back.clickse;
      mybutton.target="*返回";

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

      //取得参数
      var mybutton=new Dictionary();

      mybutton.normal=f.config_sl.up.normal;
      if (f.config_sl.up.over!=void) mybutton.over=f.config_sl.up.over;
      if (f.config_sl.up.on!=void) mybutton.on=f.config_sl.up.on;

      if (f.config_sl.up.enterse!=void) mybutton.enterse=f.config_sl.up.enterse;
      if (f.config_sl.up.clickse!=void) mybutton.clickse=f.config_sl.up.clickse;
      mybutton.target="*刷新画面";
      mybutton.exp="sf.最近存储页-- if (sf.最近存储页>1)";

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

      //取得参数
      var mybutton=new Dictionary();

      mybutton.normal=f.config_sl.down.normal;
      if (f.config_sl.down.over!=void) mybutton.over=f.config_sl.down.over;
      if (f.config_sl.down.on!=void) mybutton.on=f.config_sl.down.on;

      if (f.config_sl.down.enterse!=void) mybutton.enterse=f.config_sl.down.enterse;
      if (f.config_sl.down.clickse!=void) mybutton.clickse=f.config_sl.down.clickse;
      mybutton.target="*刷新画面";
      mybutton.exp="sf.最近存储页++ if (sf.最近存储页<(kag.numBookMarks/f.config_slpos.locate.count))";

      kag.tagHandlers.button(mybutton);

}
//循环描绘存取按钮
for (var i=0;i<f.config_slpos.locate.count;i++)
  {
      var number=i*1+(sf.最近存储页-1)*(f.config_slpos.locate.count);
      kag.tagHandlers.locate(
      %[
        "x" => f.config_slpos.locate[i][0],
        "y" => f.config_slpos.locate[i][1]
      ]);
      slbutton(number); 
      //当前编号==sf.最近档案，且的确存在档案时，描绘状态标记
      if (number==sf.最近档案 && f.config_slpos.lastsavemark.use==1 && checkdata(sf.最近档案)==true)
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

}
[endscript]
;------------------------------------------------------------
[return]
