;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;     This program is free software: you can redistribute it and/or modify
;     it under the terms of the GNU General Public License as published by
;     the Free Software Foundation, either version 3 of the License, or
;     (at your option) any later version.

;     This program is distributed in the hope that it will be useful,
;     but WITHOUT ANY WARRANTY; without even the implied warranty of
;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;     GNU General Public License for more details.
;-------------------------------------------------------------------------------------------
*start
[iscript]
//設定數值(game_setting)
//默認值
sf.gs=%[];
sf.gs.width=800;
sf.gs.height=600;
//about裡的版本信息
sf.version_num="3.50 alpha";
sf.version_date="2012/06/01";
[endscript]
;---------------------------------------------------------------
;DLL插件
;---------------------------------------------------------------
[loadplugin module="dirlist.dll"]
[loadplugin module="addFont.dll"]
;---------------------------------------------------------------
;層設定
;---------------------------------------------------------------
[laycount messages=9 layers=12]
;底板(框架)
[layopt layer=stage index=1000]
;遊戲主菜單
[layopt layer=message0 index=2000]
;-------------------------------------
;底板2(單頁背景,描繪文字)
[layopt layer=0 index=3000]
;底板3(事件編輯器描繪)
[layopt layer=1 index=4000]
;編輯器按鈕
[layopt layer=message1 index=5000]
;滑動條位置按鈕
[layopt layer=2 index=6000]
;右鍵菜單
[layopt layer=message2 index=7000]
;-------------------------------------
;上層界面底板(界面編輯-window_down)
[layopt layer=3 index=8000]
;上層界面窗口
[layopt layer=message3 index=9000]
;預留
[layopt layer=4 index=10000]
;下拉菜單
[layopt layer=message4 index=11000]
;-------------------------------------
;補充底板(參數輸入-window_middle)
[layopt layer=5 index=12000]
;預留
[layopt layer=message5 index=13000]
;預留
[layopt layer=6 index=14000]
;下拉菜單
[layopt layer=message6 index=15000]
;-------------------------------------
;最上層界面底板(文件選擇，位置設定window_up)
[layopt layer=7 index=16000]
;預留(特殊描繪)
[layopt layer=8 index=17000]
;菜單
[layopt layer=message7 index=18000]
;滾動條標誌位置按鈕
[layopt layer=9 index=19000]
;預覽圖片/取色板
[layopt layer=10 index=20000]
;最上層下拉菜單
[layopt layer=message8 index=21000]
;-------------------------------------
;最上層提示
[layopt layer=event index=30000]
;其他
[layopt layer=11 index=10999]
;---------------------------------------------------------------
;宏
;---------------------------------------------------------------
;文件載入與操作
[call storage="function_load.ks"]
[call storage="function_rws.ks"]

;界面編輯器相關
[call storage="function_ui.ks"]
[call storage="function_layer.ks"]
[call storage="function_layerplus.ks"]
[call storage="function_edulayer.ks"]
[call storage="function_preview.ks"]

;腳本編輯器相關
[call storage="function_script.ks"]
[call storage="function_line.ks"]

[call storage="macro_ui.ks"]

;初始化

[startanchor]
;------------------------------------------------------------------------------------------------------------------------
;預載
;------------------------------------------------------------------------------------------------------------------------
*載入工程
[if exp="sf.project!=void"]

;清理變數
[clearvar]

[iscript]

//圖片預覽窗口創建
if (tf.preview==void) tf.preview=new PicPreviewWindow();

//載入taglist
f.taglist=Scripts.evalStorage("tagname.tjs");
//載入targetlist
f.target=Scripts.evalStorage("target.tjs");

//設定Data目錄位置
sf.path=System.exePath + "project/"+sf.project+"/Data/";
//添加自動搜索路徑
AddPath();
//載入工程相關設定
getSetting();
[endscript]

[endif]
;------------------------------------------------------------------------------------------------------------------------
;開始描繪菜單
;------------------------------------------------------------------------------------------------------------------------
*window
[iscript]
//描繪背景
with(kag.fore.base)
{
.width=1440;
.height=900;
//底板
.fillRect(0,0,1440,900,0xFFD4D0C8);

//菜單欄分隔線
.fillRect(0,50,1440,1,0xFFaca899);
.fillRect(0,51,1440,1,0xFFFFFFFF);

//菜單欄豎線
.fillRect(165+5,5,1,40,0xFFaca899);
.fillRect(290+5,5,1,40,0xFFaca899);
//狀態欄
//.fillRect(0,890,1440,1,0xFFFFFFFF);
//.fillRect(0,891,1440,1,0xFFaca899);
//.fillRect(0,892,1440,1,0xFFFFFFFF);
}
[endscript]
;---------------------------------------------------------------
;主菜單
;---------------------------------------------------------------
[rclick enabled="false"]
[history enabled="false" output="false"]
;---------------------------------------------------------------
[current layer="message0"]
[er]
;---------------------------------------------------------------
;創建按鈕
[locate x=15 y=10]
[button normal=edit_button_insert hint="新建工程：打開新建工程嚮導" storage="first.ks" target=*新建工程]
[eval exp="drawButtonCaption('新建')"]
[locate x=65 y=10]
[button normal=edit_button_open storage="first.ks" target=*打開工程 hint="打開工程：打開project文件夾下的遊戲工程"]
[eval exp="drawButtonCaption('打開')"]
[locate x=315 y=10]
[button normal=edit_button_help hint="使用說明：查看幫助文件" exp="System.shellExecute(Storages.getLocalName(System.exePath+'/') + '/tutorial')"]
[eval exp="drawButtonCaption('教程')"]
;組標誌
[locate x=1230 y=5]
[button normal="banner_ddf" exp="System.shellExecute( 'http://d.mega-zone.org/' )" hint="Something about kirikiri/KAG & indie games"]
;-------------------------------------------------
;當有工程時才顯示
;-------------------------------------------------
[if exp="sf.project!=void"]
[title name=&"'THE NVL Maker-'+f.setting.title"]
[locate x=115 y=10]
[button normal=edit_button_reload storage="first.ks" target=*載入工程 hint="重載工程：將重載工程相關的設定及素材圖片，所有未保存的設定將丟失" exp="f.window=''"]
[eval exp="drawButtonCaption('重載')"]
[locate x=190 y=10]
[button normal=edit_button_option hint="素材管理：打開遊戲工程的素材文件夾，假如添加了新素材，請記得『重載工程』" exp="System.shellExecute(Storages.getLocalName(System.exePath+'/') + '/project/'+sf.project+'/Data')"]
[eval exp="drawButtonCaption('素材')"]
[locate x=240 y=10]
[button normal=edit_button_test storage="first.ks" target=*全篇測試 hint="全篇測試：將從指定的標題文件開始執行遊戲"]
[eval exp="drawButtonCaption('測試')"]
[locate x=370 y=10]
[button normal=edit_button_package storage="first.ks" target=*遊戲打包 hint="遊戲打包：將打開krkrrel.exe"]
[eval exp="drawButtonCaption('打包')"]
;-------------------------------------------------
;分頁按鈕
[locate x=10 y=60]
[button normal=edit_button_page storage="project_main.ks" exp="f.window='',sf.main='project_main.ks'"]
[eval exp="drawButtonCaption('工程設定')"]

[locate x=81 y=60]
[button normal=edit_button_page storage="gui_main.ks" exp="f.window='',sf.main='gui_main.ks'"]
[eval exp="drawButtonCaption('界面設定')"]

[locate x=152 y=60]
[button normal=edit_button_page storage="script_main.ks" exp="f.window='',sf.main='script_main.ks'"]
[eval exp="drawButtonCaption('腳本編輯')"]

[locate x=223 y=60]
[button normal=edit_button_page storage="chara_main.ks" exp="f.window='',sf.main='chara_main.ks'"]
[eval exp="drawButtonCaption('姓名編輯')"]

[locate x=294 y=60]
[button normal=edit_button_page storage="map_main.ks" exp="f.window='',sf.main='map_main.ks'"]
[eval exp="drawButtonCaption('遊戲系統')"]

;-------------------------------------------------
;默認打開工程設置窗口，但之後會根據之前記錄
[jump storage=&"sf.main" cond="sf.main!=void"]
[jump storage="project_main.ks"]
[endif]
[s]

;------------------------------------------------------------------------------------------------------------------------
*打開工程
;------------------------------------------------------------------------------------------------------------------------
;描繪窗口
[window_up width=450 height=400 title="打開工程"]
[iscript]
//工程文件夾的自動路徑消去
if (sf.project!=void) RemovePath();

//取得文件夾名+計算頁數
getProject();

//默認選中第一項
f.select=0;
//當前窗口
f.window='project';
//描繪按鈕
drawButtonLine(20,74,"edit_button_line",10,20);
//描繪BOX
update();
[endscript]

;翻頁按鈕
[button_page x=345 y=50 length=220]

[s]

*確認
;選擇了新的工程或者重載了工程
[if exp="f.project[f.select]!=void"]
[eval exp="sf.project=f.project[f.select]"]
[eval exp="sf.main=''"]
[gotostart ask="false"]
[endif]

*關閉選單
[eval exp="f.window=''"]
[rclick enabled="false"]
[freeimage layer="7"]
[current layer="message7"]
[er]
[layopt layer="message7" visible="false"]
[iscript]
if (sf.project!=void)
{
AddPath();
}
[endscript]
[jump target=*window]

;------------------------------------------------------------------------------------------------------------------------
*全篇測試
;------------------------------------------------------------------------------------------------------------------------
;覆寫start.ks
[iscript]
rewriteStart(f.setting.startfrom);
[endscript]
;啟動測試
[eval exp="System.shellExecute(Storages.getLocalName(System.exePath+'project/'+sf.project+'/') + 'krkr.exe')"]
[jump target=*window]

*遊戲打包
;覆寫start.ks
[iscript]
rewriteStart(f.setting.startfrom);
[endscript]
;啟動軟件
[eval exp="System.shellExecute(Storages.getLocalName(System.exePath+'tool/') + 'krkrrel.exe')"]
[jump target=*window]

*新建工程
[eval exp="System.shellExecute(Storages.getLocalName(System.exePath)+'Wizard.exe')"]
[jump target=*window]
