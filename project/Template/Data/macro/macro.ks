*start
;------------------------------------------------------------
;DLL插件载入
;------------------------------------------------------------
;OGG、MP3播放插件
[loadplugin module="wuvorbis.dll"] 
[loadplugin module="wump3.dll"]
;切换特效增强插件
[loadplugin module="extrans.dll"]
[loadplugin module="extNagano.dll"]
;------------------------------------------------------------
;层数量
;------------------------------------------------------------
[laycount layers=20]
[laycount messages=8]
;------------------------------------------------------------
;层顺位
;------------------------------------------------------------
;背景层
[layopt layer=stage index=100 withback=true]
;立绘
[layopt layer="0" index=200 withback=true]
[layopt layer="1" index=300 withback=true]
[layopt layer="2" index=400 withback=true]
[layopt layer="3" index=500 withback=true]
[layopt layer="4" index=600 withback=true]
[layopt layer="5" index=700 withback=true]
;动态
[layopt layer="6" index=800 withback=true]
[layopt layer="7" index=900 withback=true]
;----------------------------------------------
;地图、养成背景
[layopt layer="event" index=1000 withback=true]
;对话框
[layopt layer="message0" index=1100 withback=true]
;头像层
[layopt layer="8" index=1200 withback=true]
;选择支/地图
[layopt layer="message1" index=1300 withback=true]
;数值显示面板
[layopt layer="9" index=1400 withback=true]
;系统按钮（伪）
[layopt layer="10" index=1500 withback=true]
;----------------------------------------------
;系统按钮(sysbutton)
[layopt layer="message2" index=2000 withback=true]
;----------------------------------------------
;游戏二级菜单背景
[layopt layer="11" index=3000 withback=true]
;菜单层1
[layopt layer="message3" index=3100 withback=true]
;预留
[layopt layer="12" index=3200 withback=true]
;预留
[layopt layer="13" index=3300 withback=true]
;----------------------------------------------
;系统背景
;----------------------------------------------
[layopt layer="14" index=3400 withback=true]
;菜单层2
[layopt layer="message4" index=3500 withback=true]
;预留
[layopt layer="15" index=3600 withback=true]
;预留
[layopt layer="16" index=3700 withback=true]
;预留
[layopt layer="17" index=3800 withback=true]
;----------------------------------------------
;预留
;----------------------------------------------
;菜单层3
[layopt layer="message5" index=3900 withback=true]
;预留
[layopt layer="18" index=4000 withback=true]
;菜单层4
[layopt layer="message6" index=4100 withback=true]
;滚动条
[layopt layer="19" index=4200 withback=true]
;菜单层5
[layopt layer="message7" index=4300 withback=true]

;------------------------------------------------------------
;载入游戏需要的宏
;------------------------------------------------------------
[iscript]
//载入自定义SL函数，覆盖mainwindow.tjs里的默认函数
KAGLoadScript("MySaveLoadFunction.tjs");

//载入配置文件
f.config_title=Scripts.evalStorage("uititle.tjs");
f.config_dia=Scripts.evalStorage('uidia.tjs');
f.config_menu=Scripts.evalStorage("uimenu.tjs");
f.config_slpos=Scripts.evalStorage("uislpos.tjs");
f.config_option=Scripts.evalStorage("uioption.tjs");
f.config_history=Scripts.evalStorage("uihistory.tjs");
f.config_name=Scripts.evalStorage("namelist.tjs");
[endscript]
;------------------------------------------------------------
[call storage="function.ks"]

[call storage="macro_ui.ks"]
[call storage="macro_sl.ks"]

[call storage="macro_play.ks"]
[call storage="macro_name.ks"]
[call storage="macro_map.ks"]
[call storage="macro_edu.ks"]

[call storage=picmove.ks]
[call storage=oldMovie.ks]
[call storage=timebar.ks]
[call storage=AnimPlayer.ks]

[call storage=snow.ks]
[call storage=rain.ks]
[call storage=fog.ks]
[call storage=sakura.ks]
[call storage=momiji.ks]
[call storage=firefly.ks]

[call storage="macro_cg.ks"]
;------------------------------------------------------------
[return]
