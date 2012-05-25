*start
;layer 14 背景
;message4 按鈕
;15 狀態
;16 懸停顯示
;17 截圖

;------------------------------------------------------------
;返回檔案名/確認檔案是否存在
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
;描繪用函數
;------------------------------------------------------------
[iscript]
function slbuttontitle(button,num)
{
button.font.face=sf.font;
button.font.bold=f.config_slpos.pagefont.bold;
button.font.italic=f.config_slpos.pagefont.italic;
var sha=f.config_slpos.pagefont.shadow;
var shac=f.config_slpos.pagefont.shadowcolor;
var edg=f.config_slpos.pagefont.edge;
var edgc=f.config_slpos.pagefont.edgecolor;

if (f.config_slpos.num.use)
{
//檔案編號
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
////描繪章節名
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
//描繪日期
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
//描繪對話
if (f.config_slpos.history.use)
{
   button.font.height=f.config_slpos.history.height;
   var x=(int)f.config_slpos.history.x;
   var y=(int)f.config_slpos.history.y;
   
   var normal=f.config_sl.history.normal;
   var on=f.config_sl.history.on;
   var over=f.config_sl.history.over;
   //取得歷史記錄
   var his;
   if (sf.歷史[num]!=void)
   {
    his=sf.歷史[num];
   }
   else
   {
    his="……";
   }
   //切掉不必要的字數
   var str=his.substring(0,f.config_slpos.history.num);
   str+="……";
   //描繪
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
;懸停
;------------------------------------------------------------
[iscript]
function slshow(num)
{
if (kag.getBookMarkDate(num)!=void)
{
    //清空描繪層
    kag.fore.layers[16].loadImages(%['storage'=>'empty','visible'=>true,'left'=>0,'top'=>0]);
   //描繪章節名
   if (f.config_slpos.drawmark.use)
   {
      var setting=new Dictionary();
      //複製字體設定
      (Dictionary.assign incontextof setting)(f.config_slpos.pagefont);
      //增加其他參數
      setting.text=kag.getBookMarkPageName(num);
      setting.layer="16";
      setting.face=sf.font;
      setting.x=f.config_slpos.drawmark.x;
      setting.y=f.config_slpos.drawmark.y;
      setting.size=f.config_slpos.drawmark.size;
      setting.color=f.config_sl.draw.bookmark;   
      kag.tagHandlers.ptext(setting);
   }
   
   //描繪日期時間
   if (f.config_slpos.drawdate.use)
   {
      var setting=new Dictionary();
      //複製字體設定
      (Dictionary.assign incontextof setting)(f.config_slpos.pagefont);
      //增加其他參數
      setting.text=kag.getBookMarkDate(num);
      setting.layer="16";
      setting.face=sf.font;
      setting.x=f.config_slpos.drawdate.x;
      setting.y=f.config_slpos.drawdate.y;
      setting.size=f.config_slpos.drawdate.size;
      setting.color=f.config_sl.draw.date;   
      kag.tagHandlers.ptext(setting);
   }
   
   //描繪對話
   if (f.config_slpos.drawtalk.use)
   {
        if (sf.歷史[num]!=void)
      {
           var talk=sf.歷史[num];
           talk+="……";
           var t_linecount=talk.length\f.config_slpos.drawtalk.count;
           if  (talk.length%f.config_slpos.drawtalk.count>0) {t_linecount++;}

           //開始描繪
            for (var i=0; i<t_linecount; i++)
               {
                   //複製字體設定
                   var setting=new Dictionary();
                   (Dictionary.assign incontextof setting)(f.config_slpos.pagefont);
                   setting.layer="16";
                   setting.face=sf.font;
                   setting.x=(int)f.config_slpos.drawtalk.x;
                   setting.y=(int)i*f.config_slpos.drawtalk.space+(int)f.config_slpos.drawtalk.y;
                   setting.size=f.config_slpos.drawtalk.size;
                   setting.color=f.config_sl.draw.talk;
                   setting.text=talk.substring(i*f.config_slpos.drawtalk.count,f.config_slpos.drawtalk.count);
                   kag.tagHandlers.ptext(setting);
               }
        }
    }

   //描繪截圖
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
;描繪單個按鈕
;------------------------------------------------------------
[iscript]
function slbutton(num)
{
      //創建數據
      var savebutton = new Dictionary();

      savebutton.normal=f.config_sl.button.normal;

      if (f.config_sl.button.over!=void) savebutton.over=f.config_sl.button.over;
      if (f.config_sl.button.on!=void) savebutton.on=f.config_sl.button.on;

      if (f.config_sl.button.enterse!=void) savebutton.enterse=f.config_sl.button.enterse;
      if (f.config_sl.button.clickse!=void) savebutton.clickse=f.config_sl.button.clickse;

      savebutton.onenter='slshow('+num+')';
      savebutton.onleave="slhide()";
      savebutton.exp='tf.最近檔案='+num;
      savebutton.target="*存取遊戲";
      kag.tagHandlers.button(savebutton);
      slbuttontitle(kag.current.links[kag.current.links.count-1].object,num);
}
[endscript]
;------------------------------------------------------------
;批量描繪
;------------------------------------------------------------
[iscript]
function drawslbutton(page="fore")
{
var layer;
//載入空白圖片,用於顯示狀態
  if (page=="fore") layer=kag.fore.layers[15];
  else layer=kag.back.layers[15];
  layer.loadImages(%['storage'=>'empty', 'visible'=>true,'left'=>0,'top' =>0]);

//描繪其他按鈕
//返回
if (f.config_slpos.back[2])
{
      kag.tagHandlers.locate(
      %[
        "x" => f.config_slpos.back[0],
        "y" => f.config_slpos.back[1]
      ]);

      //取得參數
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

      //取得參數
      var mybutton=new Dictionary();

      mybutton.normal=f.config_sl.up.normal;
      if (f.config_sl.up.over!=void) mybutton.over=f.config_sl.up.over;
      if (f.config_sl.up.on!=void) mybutton.on=f.config_sl.up.on;

      if (f.config_sl.up.enterse!=void) mybutton.enterse=f.config_sl.up.enterse;
      if (f.config_sl.up.clickse!=void) mybutton.clickse=f.config_sl.up.clickse;
      mybutton.target="*刷新畫面";
      mybutton.exp="sf.最近存儲頁-- if (sf.最近存儲頁>1)";

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

      //取得參數
      var mybutton=new Dictionary();

      mybutton.normal=f.config_sl.down.normal;
      if (f.config_sl.down.over!=void) mybutton.over=f.config_sl.down.over;
      if (f.config_sl.down.on!=void) mybutton.on=f.config_sl.down.on;

      if (f.config_sl.down.enterse!=void) mybutton.enterse=f.config_sl.down.enterse;
      if (f.config_sl.down.clickse!=void) mybutton.clickse=f.config_sl.down.clickse;
      mybutton.target="*刷新畫面";
      mybutton.exp="sf.最近存儲頁++ if (sf.最近存儲頁<(f.setting.savedata.num/f.config_slpos.locate.count))";

      kag.tagHandlers.button(mybutton);

}
//循環描繪存取按鈕
for (var i=0;i<f.config_slpos.locate.count;i++)
  {
      var number=i*1+(sf.最近存儲頁-1)*(f.config_slpos.locate.count);
      kag.tagHandlers.locate(
      %[
        "x" => f.config_slpos.locate[i][0],
        "y" => f.config_slpos.locate[i][1]
      ]);
      slbutton(number); 
      //當前編號==sf.最近檔案，且的確存在檔案時，描繪狀態標記
      if (number==sf.最近檔案 && f.config_slpos.lastsavemark.use==1 && checkdata(sf.最近檔案)==true)
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
      //有用到，進行遊戲截圖描繪
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
