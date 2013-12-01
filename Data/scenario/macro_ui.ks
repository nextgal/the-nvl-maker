;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------------------
;常用控件组
;------------------------------------------------------------------------------------------------
[macro name="licence"]
[frame title="使用规约" x=&"kag.scWidth-355" y=15 line=18]
[nowait]
[locate x=&"kag.scWidth-330" y=30]
[indent]
[font size=14]
本工具为免费软件，但拥有附加使用条件。[r]
假如自认无法遵守以下约定，请停止使用[r]
并删除本软件。[r]
[r]
（1）署名：[r]
游戏发布时，请在游戏内或者readme文件内[r]
明确标记使用了本工具。[r][r]
（2）引用素材注明来源：[r]
请将使用到的共享素材作者、出处等清楚写[r]
明，以便其他制作者寻找素材。[r][r]
（3）禁止盗用素材等侵权行为：[r]
无论免费、收费游戏，请不要误将有版权问[r]
题的内容当做素材使用。[r]
所谓版权问题是指来源、作者不明，或未获[r]
得作者允许使用的图片、音乐、音效、字体[r]
等，如解包其他游戏、截图、百度搜索收集[r]
到的图片、音乐、明星照片等，均属于此类。[r]
不做商业用途就没有版权问题是完全错误的[r]
观点。[r][r]
（4）使用责任自负：[r]
工具作者不会为你的文件损坏或其他损失负[r]
责，所以多做备份和多存档，或者使用版本[r]
控制软件，都是好习惯。
[resetfont]
[endnowait]
[endmacro]
;---------------------------------------------------------------
;指令按钮
;---------------------------------------------------------------
[macro name=button_tag]
[locate x=%x y=%y]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target="*打开指令窗口" exp=%exp]
[eval exp="drawButtonCaption(mp.name,14)"]
[endmacro]

;---------------------------------------------------------------
;滚动条/翻页按钮
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
;下层窗口背景
;---------------------------------------------------------------
[macro name=window_down]
[locklink]
[rclick enabled=true jump=true call="false" target=*关闭选单]
;描绘窗体底板
[eval exp="drawWin(kag.fore.layers[3],kag.fore.messages[3],mp.title,mp.width,mp.height)"]
;描绘关闭按钮
[current layer="message3"]
[er]
[nowait]
[locate x=&"mp.width-23" y=6]
[button normal=edit_slider_button target=*关闭选单]
[eval exp="drawButtonCaption('×',14)"]
[if exp="mp.height>=800"]
[eval exp="mp.height=710"]
[endif]
[locate x=&"mp.width-140" y=&"mp.height-80"]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*确认]
[eval exp="drawButtonCaption('确认',14)"]
[locate x=&"mp.width-140" y=&"mp.height-50"]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*关闭选单]
[eval exp="drawButtonCaption('取消',14)"]
[endmacro]
;---------------------------------------------------------------
;下层窗口背景[养成面板用]
;---------------------------------------------------------------
[macro name=window_down_edu]
[locklink]
[rclick enabled=true jump=true call="false" target=*关闭选单]
;描绘窗体底板
[eval exp="drawWin(kag.fore.layers[3],kag.fore.messages[3],mp.title,mp.width,mp.height)"]
;描绘关闭按钮
[current layer="message3"]
[er]
[nowait]
[locate x=&"mp.width-23" y=6]
[button normal=edit_slider_button target=*关闭选单]
[eval exp="drawButtonCaption('×',14)"]
[if exp="mp.height>=800"]
[eval exp="mp.height=710"]
[endif]
[locate x=&"mp.width-180" y=&"mp.height-80"]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*确认]
[eval exp="drawButtonCaption('确认',14)"]
[locate x=&"mp.width-180" y=&"mp.height-50"]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*关闭选单]
[eval exp="drawButtonCaption('取消',14)"]
[endmacro]
;---------------------------------------------------------------
;中层窗口背景
;---------------------------------------------------------------
[macro name=window_middle]
[locklink]
[rclick enabled=true jump=true call="false" target=*关闭选单]
;描绘窗体底板
[eval exp="drawWin(kag.fore.layers[5],kag.fore.messages[5],mp.title,mp.width,mp.height)"]
;描绘关闭按钮
[current layer="message5"]
[er]
[nowait]
[locate x=&"mp.width-23" y=6]
[button normal=edit_slider_button target=*关闭选单]
[eval exp="drawButtonCaption('×',14)"]

[locate x=&"mp.width-140" y=&"mp.height-80"]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*确认]
[eval exp="drawButtonCaption('确认',14)"]
[locate x=&"mp.width-140" y=&"mp.height-50"]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*关闭选单]
[eval exp="drawButtonCaption('取消',14)"]
[endmacro]
;---------------------------------------------------------------
;最上层窗口背景
;---------------------------------------------------------------
[macro name=window_up]
[locklink]
[rclick enabled=true jump=true call="false" target=*关闭选单]
;描绘窗体底板
[eval exp="drawWin(kag.fore.layers[7],kag.fore.messages[7],mp.title,mp.width,mp.height)"]
;描绘关闭按钮
[current layer="message7"]
[er]
[nowait]
[locate x=&"mp.width-23" y=6]
[button normal=edit_slider_button target=*关闭选单]
[eval exp="drawButtonCaption('×',14)"]

[locate x=&"mp.width-140" y=&"mp.height-80"]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*确认]
[eval exp="drawButtonCaption('确认',14)"]
[locate x=&"mp.width-140" y=&"mp.height-50"]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*关闭选单]
[eval exp="drawButtonCaption('取消',14)"]
[endmacro]
;---------------------------------------------------------------
;特别设定（图片窗口专用）
;---------------------------------------------------------------
[macro name=window_up_sp]
[locklink]
[rclick enabled=true jump=true call="false" target=*关闭选单]
;描绘窗体底板
[eval exp="drawWin(kag.fore.layers[7],kag.fore.messages[7],mp.title,mp.width,mp.height)"]
;描绘关闭按钮
[current layer="message7"]
[er]
[nowait]
[locate x=&"mp.width-23" y=6]
[button normal=edit_slider_button target=*关闭选单]
[eval exp="drawButtonCaption('×',14)"]
[locate x=93 y=35]
点三角形切换素材文件夹
[locate x=320 y=35]
提示：新增素材后，请“重载工程”
[locate x=&"mp.width-140" y=&"mp.height-80"]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*确认]
[eval exp="drawButtonCaption('确认',14)"]
[locate x=&"mp.width-140" y=&"mp.height-50"]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*关闭选单]
[eval exp="drawButtonCaption('取消',14)"]
[endmacro]
;---------------------------------------------------------------
;标题框
;---------------------------------------------------------------
[macro name=frame]
[eval exp="drawFrame(mp.title,(int)mp.line,(int)mp.x,(int)mp.y,mp.layer,mp.width)"]
[endmacro]
;---------------------------------------------------------------
;行[type=color/font/music/sound/script/cursor/cond][type=pic附带path/dw/dh]
;---------------------------------------------------------------
[macro name=line]
[eval exp="drawEdit(mp.title,mp.name,(int)mp.x,(int)mp.y,mp.length,mp.true)"]
;附加框1
[if exp="mp.type!=void && mp.type!='pic' && mp.type!='list'"]
[eval exp="drawLink_Win(mp.name,mp.type)"]
[endif]
;图片附加框
[if exp="mp.type=='pic'"]
[eval exp="drawLink_Picwin(mp.name,mp.path,mp.dw,mp.dh)"]
[endif]
;下拉附加框
[if exp="mp.type=='list'"]
[eval exp="drawLink_List(mp.target)"]
[endif]
;附加框2
[if exp="mp.copyfrom!=void"]
 [link target=*window exp=&"mp.name+'=copy(\''+mp.copyfrom+'\')'" hint="点此复制上一栏内容"]
〇
[endlink]
[endif]
[endmacro]
;---------------------------------------------------------------
;单选框
;---------------------------------------------------------------
[macro name=check]
[eval exp="drawCheck(mp.title,mp.name,(int)mp.x,(int)mp.y)"]
[endmacro]
;---------------------------------------------------------------
;互斥选框
;---------------------------------------------------------------
[macro name=option]
[eval exp="drawOption(mp.title,mp.name,(int)mp.x,(int)mp.y,mp.false)"]
[endmacro]
;---------------------------------------------------------------
;互斥选框组
;---------------------------------------------------------------
[macro name=group]
[eval exp="drawGroup(mp.title,mp.name,(int)mp.x,(int)mp.y,mp.comp)"]
[endmacro]
;---------------------------------------------------------------
;位置联动框(值xy,位置xy,条件,当作范例的图)
;---------------------------------------------------------------
[macro name=pos]
[eval exp="drawPos(mp.valuex,mp.valuey,(int)mp.x,(int)mp.y,mp.true,mp.sample)"]
[endmacro]

;---------------------------------------------------------------
;method相关参数输入
;---------------------------------------------------------------
[macro name=frame_trans]

[line title="时间" name="f.参数.time" x=%x y=%y]
[line title="方式" name="f.参数.method" x=%x y=&"(int)mp.y+30" type="list" target="*切换方式"]

;使用rule
[if exp="f.参数.method=='universal'"]
[eval exp="f.参数.rule='00'" cond="f.参数.rule==void"]
[line title="遮片" name="f.参数.rule" x=%x y=&"(int)mp.y+60" type="pic" path="rule"]

;使用滚动
[elsif exp="f.参数.method=='scroll'"]
[line title="方向" name="f.参数.from" x=%x y=&"(int)mp.y+60" type="list" target="*卷动方向"]
[line title="背景" name="f.参数.stay" x=%x y=&"(int)mp.y+90" type="list" target="*背景停留"]
[endif]

[check title="可略过" name="f.参数.canskip" x=%x y=&"(int)mp.y+125"]

[endmacro]
;---------------------------------------------------------------
;下拉菜单
;---------------------------------------------------------------
[macro name=list]
[locklink]
[rclick enabled=true jump=true target="%target|*关闭下拉菜单"]
[position layer="%layer|message4" left=&"(int)kag.current.left+(int)mp.x+40" top=&"(int)kag.current.top+(int)mp.y+24"]
[position layer="%layer|message4" width=%width|200 height=&"mp.line*22" frame="" color="0xFFFFFF" opacity=255]
[layopt layer="%layer|message4" visible="true"]
[current layer="%layer|message4"]
[er]
[nowait]
[style align="center"]
[endmacro]

;---------------------------------------------------------------
;层选择下拉菜单
;---------------------------------------------------------------
[macro name=list_fglayer]
[commit]
[list x=%x y=%y line=9 layer="message6"]
[link target=*关闭下拉菜单 exp="f.参数.layer='0'"]前景层No.0[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.layer='1'"]前景层No.1[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.layer='2'"]前景层No.2[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.layer='3'"]前景层No.3[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.layer='4'"]前景层No.4[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.layer='5'"]前景层No.5[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.layer='6'"]前景层No.6[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.layer='7'"]前景层No.7[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.layer='8'"]头像层No.8[endlink]
[endmacro]

[macro name=list_glayer]
[commit]
[list x=%x y=%y line=10 layer="message6"]
[link target=*关闭下拉菜单 exp="f.参数.layer='all'"]全部前景[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.layer='0'"]前景层No.0[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.layer='1'"]前景层No.1[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.layer='2'"]前景层No.2[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.layer='3'"]前景层No.3[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.layer='4'"]前景层No.4[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.layer='5'"]前景层No.5[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.layer='6'"]前景层No.6[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.layer='7'"]前景层No.7[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.layer='8'"]头像层No.8[endlink]
[endmacro]

[macro name=list_layer]
[commit]
[list x=%x y=%y line=11 layer="message6"]
[link target=*关闭下拉菜单 exp="f.参数.layer='stage'"]背景层[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.layer='0'"]前景层No.0[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.layer='1'"]前景层No.1[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.layer='2'"]前景层No.2[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.layer='3'"]前景层No.3[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.layer='4'"]前景层No.4[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.layer='5'"]前景层No.5[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.layer='6'"]前景层No.6[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.layer='7'"]前景层No.7[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.layer='8'"]头像层No.8[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.layer='event'"]特效层[endlink]
[endmacro]

[macro name=list_page]
[commit]
[list x=%x y=%y line=2 layer="message6"]
[link target=*关闭下拉菜单 exp="f.参数.page='fore'"]表页[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.page='back'"]里页[endlink]
[endmacro]
;---------------------------------------------------------------
;method相关效果下拉菜单
;---------------------------------------------------------------
[macro name=list_method]
[commit]
[list x=%x y=%y line=10 layer="message6"]
[link target=*关闭下拉菜单 exp="f.参数.method='crossfade'"]淡入（crossfade）[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.method='universal'"]遮片（universal）[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.method='turn'"]翻页（turn）[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.method='wave'"]波纹（wave）[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.method='ripple'"]水面（ripple）[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.method='scroll'"]卷动（scroll）[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.method='mosaic'"]马赛克（mosaic）[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.method='rotateswap'"]旋转切换（rotateswap）[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.method='rotatezoom'"]旋转缩放（rotatezoom）[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.method='rotatevanish'"]旋转消失（rotatevanish）[endlink]
[endmacro]

[macro name=list_from]
[commit]
[list x=%x y=%y line=4 layer="message6"]
[link target=*关闭下拉菜单 exp="f.参数.from='left'"]自左[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.from='right'"]自右[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.from='top'"]自上[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.from='bottom'"]自下[endlink]
[endmacro]

[macro name=list_stay]
[commit]
[list x=%x y=%y line=3 layer="message6"]
[link target=*关闭下拉菜单 exp="f.参数.stay='nostay'"]不停留[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.stay='stayback'"]移走原图[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.stay='stayfore'"]遮盖原图[endlink]
[endmacro]

;---------------------------------------------------------------
[return]
