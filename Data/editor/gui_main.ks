;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;---------------------------------------------------------------
;界面設定
;---------------------------------------------------------------
*start
[eval exp="drawPageBoard(72)"]
;---------------------------------------------------------------
[unlocklink]
[current layer="message1"]
[er]
;---------------------------------------------------------------
;有工程時，顯示按鈕
[if exp="sf.project!=void"]
;---------------------------------------------------------------
[frame title="主界面樣式" line=1 x=15 y=15]
[locate x=50 y=40]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*KAGConfig]
[eval exp="drawButtonCaption('Config.tjs',14)"]

[locate x=190 y=40]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*對話畫面]
[eval exp="drawButtonCaption('對話畫面',14)"]
;---------------------------------------------------------------
[frame title="系統樣式" line=2 x=15 y=95]

;title
[locate x=50 y=120]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*標題畫面]
[eval exp="drawButtonCaption('默認標題畫面',14)"]

;menu
[locate x=190 y=120]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*主菜單]
[eval exp="drawButtonCaption('主選單',14)"]

;option
[locate x=50 y=150]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*系統設定]
[eval exp="drawButtonCaption('系統設定',14)"]

;history
[locate x=190 y=150]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*對話履歷]
[eval exp="drawButtonCaption('歷史記錄',14)"]

;---------------------------------------------------------------
[frame title="存取樣式" line=2 x=15 y=205]

;版面
[locate x=50 y=230]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*存取版面設定]
[eval exp="drawButtonCaption('版面設定',14)"]

;save
[locate x=50 y=260]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*存儲系統圖形]
[eval exp="drawButtonCaption('存儲系統樣式',14)"]
;load
[locate x=190 y=260]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*讀取系統圖形]
[eval exp="drawButtonCaption('讀取系統樣式',14)"]
;---------------------------------------------------------------
[frame title="CG模式" line=1 x=15 y=315]
[locate x=50 y=340]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*CG界面]
[eval exp="drawButtonCaption('CG界面編輯',14)"]
[locate x=190 y=340]
[iscript]
tf.cgpath=Storages.getLocalName(sf.path+"macro/"+"cglist.txt");
[endscript]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" exp="System.shellExecute(tf.cgpath)" hint="將所有需要顯示的CG圖片名，每行一個寫進本TXT中即可按順序顯示"]
[eval exp="drawButtonCaption('CG列表編輯',14)"]
[endif]
[s]

*標題畫面
[iscript]
//重載
f.setting=getConfig();
[endscript]
[jump storage="gui_title.ks"]

*主菜單
[iscript]
//重載
f.setting=getConfig();
[endscript]
[jump storage="gui_menu.ks"]

*對話畫面
[iscript]
//重載
f.setting=getConfig();
[endscript]
[jump storage="gui_dia.ks"]

*KAGConfig
[eval exp="System.shellExecute(Storages.getLocalName(System.exePath+'tool/') + 'KAGConfigEx2.exe',Storages.getLocalName(System.exePath + 'project/'+sf.project+'/Data/'+'Config.tjs'))"]
[jump target=*start]

*系統設定
[iscript]
//重載
f.setting=getConfig();
[endscript]
[jump storage="gui_option.ks"]

*對話履歷
[iscript]
//重載
f.setting=getConfig();
[endscript]
[jump storage="gui_history.ks"]

*存取版面設定
[iscript]
//重載
f.setting=getConfig();
[endscript]
[jump storage="gui_sl.ks"]

*存儲系統圖形
[jump storage="gui_savestyle.ks"]

*讀取系統圖形
[jump storage="gui_loadstyle.ks"]

*CG界面
[iscript]
//重載
f.setting=getConfig();
[endscript]
[jump storage="gui_cgmode.ks"]
