;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;---------------------------------------------------------------
;地圖編輯
;---------------------------------------------------------------
[eval exp="drawPageBoard(285)"]
;---------------------------------------------------------------
[unlocklink]
[current layer="message1"]
[er]
;---------------------------------------------------------------
;有工程時，顯示按鈕
[if exp="sf.project!=void"]
[frame title="地圖界面" line=1 x=15 y=15]
[locate x=50 y=40]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*新建地圖]
[eval exp="drawButtonCaption('新建地圖',14)"]

[locate x=190 y=40]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*打開地圖]
[eval exp="drawButtonCaption('打開地圖',14)"]
[endif]

[frame title="養成面板" line=1 x=15 y=90]
[locate x=50 y=115]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*新建面板]
[eval exp="drawButtonCaption('新建面板',14)"]

[locate x=190 y=115]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*打開面板]
[eval exp="drawButtonCaption('打開面板',14)"]
[endif]

;[frame title="數據編輯" line=2 x=15 y=165]
;[locate x=50 y=190]
;[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on"]
;[eval exp="drawButtonCaption('事件組',14)"]
;[locate x=190 y=190]
;[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on"]
;[eval exp="drawButtonCaption('小辭典',14)"]
;[locate x=50 y=220]
;[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on"]
;[eval exp="drawButtonCaption('事件組',14)"]
;[locate x=190 y=220]
;[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on"]
;[eval exp="drawButtonCaption('小辭典',14)"]

[s]

*新建地圖
;清空地圖名
[eval exp="tf.mapname=void"]
[input name="tf.mapname" title="新建地圖" prompt="請輸入地圖配置文件名（不用擴展名）："]
;假如有輸入地圖名，開始創建新地圖
[iscript]
if (tf.mapname!=void)
{

if (Storages.isExistentStorage(sf.path+"map/"+tf.mapname+".map"))
{
   System.inform("哎呀呀~已經有同名地圖存在了~");
}
else
{
   var array=Scripts.evalStorage("temp_Map.tjs");

   for (var i=1;i<16;i++)
   {
      var dic=new Dictionary();
      dic.normal=array[0].normal;
      dic.over=array[0].over;
      dic.on=array[0].on;
      dic.use=0;
      dic.x=i*50;
      dic.y=100;
      dic.place="據點"+(int)(i);
      array.add(dic);
   }
   //保存
   var path=sf.path+"map/"+tf.mapname+".map";
   array.saveStruct(path);
   System.inform("地圖創建成功，可以打開編輯了","新建地圖");
}
}
[endscript]
[jump storage="map_main.ks"]

*打開地圖
[iscript]
f.mapname=void;
f.list=getsozai("map","map");
tf.當前編輯值="f.mapname";
[endscript]
[call storage="window_file.ks"]
;假如選擇了地圖，打開
[if exp="f.mapname!=void"]
[eval exp="f.config_map=Scripts.evalStorage(sf.path+'map/'+f.mapname)"]
[jump storage="gui_map.ks"]
[endif]

[jump storage="map_main.ks"]


*新建面板
;清空面板名
[eval exp="tf.eduname=void"]
[input name="tf.eduname" title="新建面板" prompt="請輸入養成面板配置文件名（不用擴展名）："]
;假如有輸入面板名，開始創建新面板
[iscript]
if (tf.eduname!=void)
{

if (Storages.isExistentStorage(sf.path+"map/"+tf.eduname+".edu"))
{
   System.inform("哎呀呀~已經有同名面板存在了~");
}
else
{
   var array=Scripts.evalStorage("temp_Edu.tjs");

   for (var i=1;i<11;i++)
   {
   
      var dic=new Dictionary();
      
      dic.normal=array[0].normal;
      dic.over=array[0].over;
      dic.on=array[0].on;
      
      dic.use=0;
      dic.x=(i)*50;
      dic.y=100;
      dic.name="按鈕"+(int)(i);
      array.add(dic);
   }
   
    for (var i=11;i<21;i++)
   {
   
      var dic=new Dictionary();

      dic.use=0;
      dic.x=(i-11)*50;
      dic.y=200;
      dic.name="文字"+(int)(i-10);
      dic.size=f.setting.selfont.height;
      dic.color=f.setting.selfont.normal;
      
      array.add(dic);
   }
 
     for (var i=21;i<31;i++)
   {
   
      var dic=new Dictionary();
      
      dic.num=array[0].num;
      dic.space=array[0].space;
      
      dic.use=0;
      dic.x=(i-21)*50;
      dic.y=300;
      dic.name="圖形"+(int)(i-20);
      array.add(dic);
   }
   
   //保存
   var path=sf.path+"map/"+tf.eduname+".edu";
   array.saveStruct(path);
   System.inform("面板創建成功，可以打開編輯了","新建面板");
   
}
}
[endscript]
[jump storage="map_main.ks"]

*打開面板
[iscript]
f.eduname=void;
f.list=getsozai("edu","map");
tf.當前編輯值="f.eduname";
[endscript]
[call storage="window_file.ks"]
;假如選擇了面板，打開
[if exp="f.eduname!=void"]
[eval exp="f.config_edu=Scripts.evalStorage(sf.path+'map/'+f.eduname)"]
[jump storage="gui_edu.ks"]
[endif]

[jump storage="map_main.ks"]
