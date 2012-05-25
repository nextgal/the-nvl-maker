;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------------------
;常用控件組
;------------------------------------------------------------------------------------------------
;---------------------------------------------------------------
;指令按鈕
;---------------------------------------------------------------
[macro name=button_tag]
[locate x=%x y=%y]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target="*打開指令窗口" exp=%exp]
[eval exp="drawButtonCaption(mp.name,14)"]
[endmacro]

;---------------------------------------------------------------
;滾動條/翻頁按鈕
;---------------------------------------------------------------
[macro name=button_page]
[locate x=%x y=%y]
[button normal=edit_slider_up exp="page_up(1)" interval=150 ontimer="page_up(1)"]
[locate x=%x y=&"(int)mp.y+(int)mp.length-16"]
[button normal=edit_slider_down exp="page_down(-1)" interval=150 ontimer="page_down(-1)"]
[endmacro]

[macro name=button_slider]
[locate x=%x y=%y]
[button normal="%normal|edit_slider_back2" interval=10 ontimer="page_scroll()"]
[endmacro]

;---------------------------------------------------------------
;下層窗口背景
;---------------------------------------------------------------
[macro name=window_down]
[locklink]
[rclick enabled=true jump=true call="false" target=*關閉選單]
;描繪窗體底板
[eval exp="drawWin(kag.fore.layers[3],kag.fore.messages[3],mp.title,mp.width,mp.height)"]
;描繪關閉按鈕
[current layer="message3"]
[er]
[nowait]
[locate x=&"mp.width-23" y=6]
[button normal=edit_slider_button target=*關閉選單]
[eval exp="drawButtonCaption('×',14)"]
[if exp="mp.height>=800"]
[eval exp="mp.height=710"]
[endif]
[locate x=&"mp.width-140" y=&"mp.height-80"]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*確認]
[eval exp="drawButtonCaption('確認',14)"]
[locate x=&"mp.width-140" y=&"mp.height-50"]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*關閉選單]
[eval exp="drawButtonCaption('取消',14)"]
[endmacro]
;---------------------------------------------------------------
;中層窗口背景
;---------------------------------------------------------------
[macro name=window_middle]
[locklink]
[rclick enabled=true jump=true call="false" target=*關閉選單]
;描繪窗體底板
[eval exp="drawWin(kag.fore.layers[5],kag.fore.messages[5],mp.title,mp.width,mp.height)"]
;描繪關閉按鈕
[current layer="message5"]
[er]
[nowait]
[locate x=&"mp.width-23" y=6]
[button normal=edit_slider_button target=*關閉選單]
[eval exp="drawButtonCaption('×',14)"]

[locate x=&"mp.width-140" y=&"mp.height-80"]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*確認]
[eval exp="drawButtonCaption('確認',14)"]
[locate x=&"mp.width-140" y=&"mp.height-50"]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*關閉選單]
[eval exp="drawButtonCaption('取消',14)"]
[endmacro]
;---------------------------------------------------------------
;最上層窗口背景
;---------------------------------------------------------------
[macro name=window_up]
[locklink]
[rclick enabled=true jump=true call="false" target=*關閉選單]
;描繪窗體底板
[eval exp="drawWin(kag.fore.layers[7],kag.fore.messages[7],mp.title,mp.width,mp.height)"]
;描繪關閉按鈕
[current layer="message7"]
[er]
[nowait]
[locate x=&"mp.width-23" y=6]
[button normal=edit_slider_button target=*關閉選單]
[eval exp="drawButtonCaption('×',14)"]

[locate x=&"mp.width-140" y=&"mp.height-80"]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*確認]
[eval exp="drawButtonCaption('確認',14)"]
[locate x=&"mp.width-140" y=&"mp.height-50"]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*關閉選單]
[eval exp="drawButtonCaption('取消',14)"]
[endmacro]
;---------------------------------------------------------------
;特別設定（圖片窗口專用）
;---------------------------------------------------------------
[macro name=window_up_sp]
[locklink]
[rclick enabled=true jump=true call="false" target=*關閉選單]
;描繪窗體底板
[eval exp="drawWin(kag.fore.layers[7],kag.fore.messages[7],mp.title,mp.width,mp.height)"]
;描繪關閉按鈕
[current layer="message7"]
[er]
[nowait]
[locate x=&"mp.width-23" y=6]
[button normal=edit_slider_button target=*關閉選單]
[eval exp="drawButtonCaption('×',14)"]
[locate x=93 y=40]
點三角形切換素材文件夾
[locate x=320 y=40]
提示：新加入的素材在預覽圖中找不到的情況，請「重載工程」後再試
[locate x=&"mp.width-260" y=40]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*確認]
[eval exp="drawButtonCaption('確認',14)"]
[locate x=&"mp.width-140" y=40]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*關閉選單]
[eval exp="drawButtonCaption('取消',14)"]
[endmacro]
;---------------------------------------------------------------
;標題框
;---------------------------------------------------------------
[macro name=frame]
[eval exp="drawFrame(mp.title,(int)mp.line,(int)mp.x,(int)mp.y)"]
[endmacro]
;---------------------------------------------------------------
;行[type=color/font/music/sound/script/cursor/cond][type=pic附帶path/dw/dh]
;---------------------------------------------------------------
[macro name=line]
[eval exp="drawEdit(mp.title,mp.name,(int)mp.x,(int)mp.y,mp.length,mp.true)"]
;附加框1
[if exp="mp.type!=void && mp.type!='pic' && mp.type!='list'"]
[eval exp="drawLink_Win(mp.name,mp.type)"]
[endif]
;圖片附加框
[if exp="mp.type=='pic'"]
[eval exp="drawLink_Picwin(mp.name,mp.path,mp.dw,mp.dh)"]
[endif]
;下拉附加框
[if exp="mp.type=='list'"]
[eval exp="drawLink_List(mp.target)"]
[endif]
;附加框2
[if exp="mp.copyfrom!=void"]
 [link target=*window exp=&"mp.name+'=copy(\''+mp.copyfrom+'\')'" hint="點此複製上一欄內容"]

[endlink]
[endif]
[endmacro]
;---------------------------------------------------------------
;單選框
;---------------------------------------------------------------
[macro name=check]
[eval exp="drawCheck(mp.title,mp.name,(int)mp.x,(int)mp.y)"]
[endmacro]
;---------------------------------------------------------------
;互斥選框
;---------------------------------------------------------------
[macro name=option]
[eval exp="drawOption(mp.title,mp.name,(int)mp.x,(int)mp.y,mp.false)"]
[endmacro]
;---------------------------------------------------------------
;互斥選框組
;---------------------------------------------------------------
[macro name=group]
[eval exp="drawGroup(mp.title,mp.name,(int)mp.x,(int)mp.y,mp.comp)"]
[endmacro]
;---------------------------------------------------------------
;位置聯動框(值xy,位置xy,條件,當作範例的圖)
;---------------------------------------------------------------
[macro name=pos]
[eval exp="drawPos(mp.valuex,mp.valuey,(int)mp.x,(int)mp.y,mp.true,mp.sample)"]
[endmacro]

;---------------------------------------------------------------
;method相關參數輸入
;---------------------------------------------------------------
[macro name=frame_trans]

[line title="時間" name="f.參數.time" x=%x y=%y]
[line title="方式" name="f.參數.method" x=%x y=&"(int)mp.y+30" type="list" target="*切換方式"]

;使用rule
[if exp="f.參數.method=='universal'"]
[line title="遮片" name="f.參數.rule" x=%x y=&"(int)mp.y+60" type="pic" path="rule"]
;使用滾動
[elsif exp="f.參數.method=='scroll'"]
[line title="方向" name="f.參數.from" x=%x y=&"(int)mp.y+60" type="list" target="*捲動方向"]
[line title="背景" name="f.參數.stay" x=%x y=&"(int)mp.y+90" type="list" target="*背景停留"]
[endif]

[check title="可略過" name="f.參數.canskip" x=%x y=&"(int)mp.y+125"]

[endmacro]
;---------------------------------------------------------------
;下拉菜單
;---------------------------------------------------------------
[macro name=list]
[locklink]
[rclick enabled=true jump=true target="%target|*關閉下拉菜單"]
[position layer="%layer|message4" left=&"(int)kag.current.left+(int)mp.x+40" top=&"(int)kag.current.top+(int)mp.y+24"]
[position layer="%layer|message4" width=%width|200 height=&"mp.line*22" frame="" color="0xFFFFFF" opacity=255]
[layopt layer="%layer|message4" visible="true"]
[current layer="%layer|message4"]
[er]
[nowait]
[style align="center"]
[endmacro]

;---------------------------------------------------------------
;層選擇下拉菜單
;---------------------------------------------------------------
[macro name=list_fglayer]
[commit]
[list x=%x y=%y line=9 layer="message6"]
[link target=*關閉下拉菜單 exp="f.參數.layer='0'"]前景層No.0[endlink][r]
[link target=*關閉下拉菜單 exp="f.參數.layer='1'"]前景層No.1[endlink][r]
[link target=*關閉下拉菜單 exp="f.參數.layer='2'"]前景層No.2[endlink][r]
[link target=*關閉下拉菜單 exp="f.參數.layer='3'"]前景層No.3[endlink][r]
[link target=*關閉下拉菜單 exp="f.參數.layer='4'"]前景層No.4[endlink][r]
[link target=*關閉下拉菜單 exp="f.參數.layer='5'"]前景層No.5[endlink][r]
[link target=*關閉下拉菜單 exp="f.參數.layer='6'"]前景層No.6[endlink][r]
[link target=*關閉下拉菜單 exp="f.參數.layer='7'"]前景層No.7[endlink][r]
[link target=*關閉下拉菜單 exp="f.參數.layer='8'"]頭像層No.8[endlink]
[endmacro]

[macro name=list_glayer]
[commit]
[list x=%x y=%y line=10 layer="message6"]
[link target=*關閉下拉菜單 exp="f.參數.layer='all'"]全部前景[endlink][r]
[link target=*關閉下拉菜單 exp="f.參數.layer='0'"]前景層No.0[endlink][r]
[link target=*關閉下拉菜單 exp="f.參數.layer='1'"]前景層No.1[endlink][r]
[link target=*關閉下拉菜單 exp="f.參數.layer='2'"]前景層No.2[endlink][r]
[link target=*關閉下拉菜單 exp="f.參數.layer='3'"]前景層No.3[endlink][r]
[link target=*關閉下拉菜單 exp="f.參數.layer='4'"]前景層No.4[endlink][r]
[link target=*關閉下拉菜單 exp="f.參數.layer='5'"]前景層No.5[endlink][r]
[link target=*關閉下拉菜單 exp="f.參數.layer='6'"]前景層No.6[endlink][r]
[link target=*關閉下拉菜單 exp="f.參數.layer='7'"]前景層No.7[endlink][r]
[link target=*關閉下拉菜單 exp="f.參數.layer='8'"]頭像層No.8[endlink]
[endmacro]

[macro name=list_layer]
[commit]
[list x=%x y=%y line=11 layer="message6"]
[link target=*關閉下拉菜單 exp="f.參數.layer='stage'"]背景層[endlink][r]
[link target=*關閉下拉菜單 exp="f.參數.layer='0'"]前景層No.0[endlink][r]
[link target=*關閉下拉菜單 exp="f.參數.layer='1'"]前景層No.1[endlink][r]
[link target=*關閉下拉菜單 exp="f.參數.layer='2'"]前景層No.2[endlink][r]
[link target=*關閉下拉菜單 exp="f.參數.layer='3'"]前景層No.3[endlink][r]
[link target=*關閉下拉菜單 exp="f.參數.layer='4'"]前景層No.4[endlink][r]
[link target=*關閉下拉菜單 exp="f.參數.layer='5'"]前景層No.5[endlink][r]
[link target=*關閉下拉菜單 exp="f.參數.layer='6'"]前景層No.6[endlink][r]
[link target=*關閉下拉菜單 exp="f.參數.layer='7'"]前景層No.7[endlink][r]
[link target=*關閉下拉菜單 exp="f.參數.layer='8'"]頭像層No.8[endlink][r]
[link target=*關閉下拉菜單 exp="f.參數.layer='event'"]特效層[endlink]
[endmacro]

[macro name=list_page]
[commit]
[list x=%x y=%y line=2 layer="message6"]
[link target=*關閉下拉菜單 exp="f.參數.page='fore'"]表頁[endlink][r]
[link target=*關閉下拉菜單 exp="f.參數.page='back'"]裡頁[endlink]
[endmacro]
;---------------------------------------------------------------
;method相關效果下拉菜單
;---------------------------------------------------------------
[macro name=list_method]
[commit]
[list x=%x y=%y line=10 layer="message6"]
[link target=*關閉下拉菜單 exp="f.參數.method='crossfade'"]淡入（crossfade）[endlink][r]
[link target=*關閉下拉菜單 exp="f.參數.method='universal'"]遮片（universal）[endlink][r]
[link target=*關閉下拉菜單 exp="f.參數.method='turn'"]翻頁（turn）[endlink][r]
[link target=*關閉下拉菜單 exp="f.參數.method='wave'"]波紋（wave）[endlink][r]
[link target=*關閉下拉菜單 exp="f.參數.method='ripple'"]水面（ripple）[endlink][r]
[link target=*關閉下拉菜單 exp="f.參數.method='scroll'"]捲動（scroll）[endlink][r]
[link target=*關閉下拉菜單 exp="f.參數.method='mosaic'"]馬賽克（mosaic）[endlink][r]
[link target=*關閉下拉菜單 exp="f.參數.method='rotateswap'"]旋轉切換（rotateswap）[endlink][r]
[link target=*關閉下拉菜單 exp="f.參數.method='rotatezoom'"]旋轉縮放（rotatezoom）[endlink][r]
[link target=*關閉下拉菜單 exp="f.參數.method='rotatevanish'"]旋轉消失（rotatevanish）[endlink]
[endmacro]

[macro name=list_from]
[commit]
[list x=%x y=%y line=4 layer="message6"]
[link target=*關閉下拉菜單 exp="f.參數.from='left'"]自左[endlink][r]
[link target=*關閉下拉菜單 exp="f.參數.from='right'"]自右[endlink][r]
[link target=*關閉下拉菜單 exp="f.參數.from='top'"]自上[endlink][r]
[link target=*關閉下拉菜單 exp="f.參數.from='bottom'"]自下[endlink]
[endmacro]

[macro name=list_stay]
[commit]
[list x=%x y=%y line=3 layer="message6"]
[link target=*關閉下拉菜單 exp="f.參數.stay='nostay'"]不停留[endlink][r]
[link target=*關閉下拉菜單 exp="f.參數.stay='stayback'"]移走原圖[endlink][r]
[link target=*關閉下拉菜單 exp="f.參數.stay='stayfore'"]遮蓋原圖[endlink]
[endmacro]

;---------------------------------------------------------------
[return]
