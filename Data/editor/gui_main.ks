;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;---------------------------------------------------------------
;界面设定
;---------------------------------------------------------------
*start
[eval exp="drawPageBoard(72)"]
;---------------------------------------------------------------
[unlocklink]
[current layer="message1"]
[er]
;---------------------------------------------------------------
;有工程时，显示按钮
[if exp="sf.project!=void"]
;---------------------------------------------------------------
[frame title="主界面样式" line=1 x=15 y=15]

[locate x=50 y=40]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*KAGConfig]
[eval exp="drawButtonCaption('Config.tjs')"]

[locate x=190 y=40]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*对话画面]
[eval exp="drawButtonCaption('对话画面')"]

;---------------------------------------------------------------
[frame title="系统样式" line=2 x=15 y=95]

;title
[locate x=50 y=120]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*标题画面]
[eval exp="drawButtonCaption('标题画面')"]

;menu
[locate x=190 y=120]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*主菜单]
[eval exp="drawButtonCaption('主选单')"]

;option
[locate x=50 y=150]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*系统设定]
[eval exp="drawButtonCaption('系统设定')"]

;history
[locate x=190 y=150]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*对话履历]
[eval exp="drawButtonCaption('历史记录')"]

;---------------------------------------------------------------
[frame title="存取系统样式" line=2 x=15 y=205]

;版面
[locate x=50 y=230]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*存取版面设定]
[eval exp="drawButtonCaption('版面设定')"]

;save
[locate x=50 y=260]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*存储系统图形]
[eval exp="drawButtonCaption('存储画面')"]
;load
[locate x=190 y=260]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*读取系统图形]
[eval exp="drawButtonCaption('读取画面')"]
[if exp="Storages.isExistentStorage(sf.path+'macro/'+'uiyesno.tjs')"]
[locate x=190 y=230]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*确认窗口设定]
[eval exp="drawButtonCaption('确认窗口')"]
[endif]
;---------------------------------------------------------------
[frame title="特别模式" line=4 x=15 y=315]
[locate x=50 y=340]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*CG界面]
[eval exp="drawButtonCaption('CG界面编辑')"]
[iscript]
tf.cgpath=Storages.getLocalName(sf.path+"macro/"+"cglist.txt");
[endscript]
[locate x=190 y=340]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" exp="System.shellExecute(tf.cgpath)" hint="将所有需要显示的CG图片名写进本TXT中，在脚本中登陆CG后即可显示"]
[eval exp="drawButtonCaption('CG列表编辑')"]
;---------------------------------------------------------------
[if exp="Storages.isExistentStorage(sf.path+'macro/'+'uiendmode.tjs')"]
	[locate x=50 y=370]
	[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*END界面]
	[eval exp="drawButtonCaption('END界面编辑')"]
	[iscript]
	tf.endpath=Storages.getLocalName(sf.path+"macro/"+"endlist.txt");
	[endscript]
	[locate x=190 y=370]
	[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" exp="System.shellExecute(tf.endpath)" hint="将结局文件、结局图按照每行一个写入本TXT，脚本中登陆结局后即可在结局模式中显示"]
	[eval exp="drawButtonCaption('END列表编辑')"]
[endif]
;---------------------------------------------------------------
[if exp="Storages.isExistentStorage(sf.path+'macro/'+'uibgmmode.tjs')"]
[locate x=50 y=400]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*BGM界面]
[eval exp="drawButtonCaption('BGM界面编辑')"]
[iscript]
tf.bgmpath=Storages.getLocalName(sf.path+"macro/"+"bgmlist.txt");
[endscript]
[locate x=190 y=400]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" exp="System.shellExecute(tf.bgmpath)" hint="将曲目名称和对应文件按照每行一个写入本TXT即可在BGM模式中显示"]
[eval exp="drawButtonCaption('BGM列表编辑')"]
[endif]

[if exp="Storages.isExistentStorage(sf.path+'map/'+'omake.map')"]
[locate x=50 y=430]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*特别模式]
[eval exp="drawButtonCaption('特别模式')"]
[endif]

[if exp="Storages.isExistentStorage(sf.path+'macro/'+'uititle_omake.tjs')"]
[locate x=190 y=430]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*通关标题]
[eval exp="drawButtonCaption('通关标题')"]
[endif]
;---------------------------------------------------------------
[frame title="数据导出" line=2 x=345 y=15]
[iscript]
sf.sclist=Storages.getLocalName(sf.path+"macro/"+"scenario.txt");
[endscript]
[locate x=380 y=40]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" exp="System.shellExecute(sf.sclist)" hint="设定需要导出的剧情脚本"]
[eval exp="drawButtonCaption('脚本列表')"]

;[locate x=520 y=40]
;[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*导出JSON hint="将界面配置文件导出成JSON格式"]
;[eval exp="drawButtonCaption('导出JSON')"]
;[endif]

[locate x=380 y=70]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*导出TAG hint="导出游戏剧情脚本中所用到的演出TAG，可在其他引擎中按此列表重新实现"]
[eval exp="drawButtonCaption('导出TAG')"]
[endif]

[locate x=520 y=70]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*导出BKE hint="将游戏剧情脚本.ks转换导出成.bkscr格式"]
[eval exp="drawButtonCaption('导出BKSCR')"]

[endif]

[licence]

[s]

*标题画面
[iscript]
//重载
f.setting=getConfig();
tf.title_filename="uititle.tjs";
f.config_title=Scripts.evalStorage(sf.path+"macro/"+tf.title_filename);
[endscript]
[jump storage="gui_title.ks"]

*通关标题
[iscript]
//重载
f.setting=getConfig();
tf.title_filename="uititle_omake.tjs";
f.config_title=Scripts.evalStorage(sf.path+"macro/"+tf.title_filename);
[endscript]
[jump storage="gui_title.ks"]

*主菜单
[iscript]
//重载
f.setting=getConfig();
[endscript]
[jump storage="gui_menu.ks"]

*对话画面
[iscript]
//重载
f.setting=getConfig();
[endscript]
[jump storage="gui_dia.ks"]

*KAGConfig
[iscript]
var config_path1=System.exePath + 'project/'+sf.project+'/Data/'+'Config.tjs';
var config_path2=Storages.getLocalName(config_path1);
System.shellExecute(Storages.getLocalName(System.exePath+'tool/') + 'KAGConfigEx2.exe',"\""+config_path2+"\"");
[endscript]
[jump target=*start]

*系统设定
[iscript]
//重载
f.setting=getConfig();
[endscript]
[jump storage="gui_option.ks"]

*对话履历
[iscript]
//重载
f.setting=getConfig();
[endscript]
[jump storage="gui_history.ks"]

*存取版面设定
[iscript]
//重载
f.setting=getConfig();
[endscript]
[jump storage="gui_sl.ks"]

*存储系统图形
[jump storage="gui_savestyle.ks"]

*读取系统图形
[jump storage="gui_loadstyle.ks"]

*确认窗口设定
[jump storage="gui_yesno.ks"]

*CG界面
[iscript]
//重载
f.setting=getConfig();
[endscript]
[jump storage="gui_cgmode.ks"]

*END界面
[iscript]
//重载
f.setting=getConfig();
[endscript]
[jump storage="gui_endmode.ks"]

*BGM界面
[iscript]
//重载
f.setting=getConfig();
[endscript]
[jump storage="gui_bgmmode.ks"]

*特别模式
[iscript]
f.mapname="omake.map";
[endscript]
[eval exp="f.config_map=Scripts.evalStorage(sf.path+'map/'+f.mapname)"]
[call storage="gui_map.ks"]
[jump storage="gui_main.ks"]


*导出JSON
[iscript]

outAsJson("setting.json",f.setting);
outAsJson("uititle.json",f.config_title);
outAsJson("uidia.json",f.config_dia);

outAsJson("uisave.json",f.config_save);
outAsJson("uiload.json",f.config_load);
outAsJson("uislpos.json",f.config_slpos);

outAsJson("uimenu.json",f.config_menu);
outAsJson("uioption.json",f.config_option);
outAsJson("uihistory.json",f.config_history);

if (f.config_cgmode!=void) outAsJson("uicgmode.json",f.config_cgmode);
if (f.config_endmode!=void) outAsJson("uiendmode.json",f.config_endmode);
if (f.config_bgmmode!=void) outAsJson("uibgmmode.json",f.config_bgmmode);

outAsJson("namelist.json",f.config_name);

System.inform("导出至"+Storages.getLocalName(sf.outputpath+"json/"));
//打开文件夹
System.shellExecute(Storages.getLocalName(sf.outputpath));

[endscript]
[jump target=*start]

*导出BKE
[iscript]
convertAllToBKE();
System.inform("导出至"+Storages.getLocalName(sf.outputpath+"BKE/"));
//打开文件夹
System.shellExecute(Storages.getLocalName(sf.outputpath));
[endscript]
[jump target=*start]

*导出TAG
[iscript]
recordTagList();
[endscript]
[jump target=*start]
