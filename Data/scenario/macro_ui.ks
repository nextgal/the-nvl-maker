;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
[macro name="draw_basic_menu"]
[current layer="message0"]
[er]
;---------------------------------------------------------------
;创建按钮
[locate x=15 y=10]
[button normal=edit_button_insert hint="新建工程：打开新建工程向导" storage="first.ks" target=*新建工程]
;[eval exp="drawButtonCaption('新建')"]
[locate x=65 y=10]
[button normal=edit_button_open storage="first.ks" target=*打开工程 hint="打开工程：打开project文件夹下的游戏工程"]
;[eval exp="drawButtonCaption('打开')"]
[locate x=315 y=10]
[button normal=edit_button_help hint="使用说明：查看帮助文件" exp="System.shellExecute( 'http://www.nvlmaker.net/manual/index.html' )" hint="访问教程"]
;[eval exp="drawButtonCaption('教程')"]

[locate x=425 y=10]
[button normal=edit_button_close hint="关闭程序" exp="kag.close()"]
;[eval exp="drawButtonCaption('退出')"]

;组标志
[locate x=&"kag.scWidth-420" y=5]
[button normal="weibo" exp="System.shellExecute( 'http://weibo.com/nvlmaker' )" hint="官方微博"]
[locate x=&"kag.scWidth-210" y=5]
[button normal="banner_nvlmaker" exp="System.shellExecute( 'http://www.nvlmaker.net' )" hint="访问官网"]
;-------------------------------------------------
;当有工程时才显示
;-------------------------------------------------
[if exp="sf.project!=void"]
[title name=&"'THE NVL Maker-'+f.setting.title"]
[locate x=115 y=10]
[button normal=edit_button_reload storage="first.ks" target=*载入工程 hint="重载工程：将重载工程相关的设定及素材图片，所有未保存的设定将丢失" exp="f.window=''"]
;[eval exp="drawButtonCaption('重载')"]
[locate x=190 y=10]
[button normal=edit_button_option hint="素材管理：打开游戏工程的素材文件夹，假如添加了新素材，请记得『重载工程』" exp="System.shellExecute(Storages.getLocalName(System.exePath+'/') + '/project/'+sf.project+'/Data')"]
;[eval exp="drawButtonCaption('素材')"]
[locate x=240 y=10]
[button normal=edit_button_test storage="first.ks" target=*全篇测试 hint="全篇测试：将从指定的标题文件开始执行游戏"]
;[eval exp="drawButtonCaption('测试')"]
[locate x=370 y=10]
[button normal=edit_button_package storage="first.ks" target=*游戏打包 hint="游戏打包：将打开krkrrel.exe"]
;[eval exp="drawButtonCaption('打包')"]
;-------------------------------------------------
;分页按钮
[locate x=10 y=60]
[if exp="sf.main!='project_main.ks'"]
[button normal=edit_button_page over=edit_button_page_over storage="project_main.ks" exp="f.window='',sf.main='project_main.ks'"]
[else]
[button normal=edit_button_page_over over=edit_button_page_over]
[endif]
[eval exp="drawButtonCaption('工程设定',0x0088aa)"]

[locate x=110 y=60]
[if exp="sf.main!='gui_main.ks'"]
[button normal=edit_button_page over=edit_button_page_over storage="gui_main.ks" exp="f.window='',sf.main='gui_main.ks'"]
[else]
[button normal=edit_button_page_over over=edit_button_page_over]
[endif]
[eval exp="drawButtonCaption('界面设定',0x0088aa)"]

[locate x=210 y=60]
[if exp="sf.main!='script_main.ks'"]
[button normal=edit_button_page over=edit_button_page_over storage="script_main.ks" exp="f.window='',sf.main='script_main.ks'"]
[else]
[button normal=edit_button_page_over over=edit_button_page_over]
[endif]
[eval exp="drawButtonCaption('脚本编辑',0x0088aa)"]

[locate x=310 y=60]
[if exp="sf.main!='chara_main.ks'"]
[button normal=edit_button_page over=edit_button_page_over storage="chara_main.ks" exp="f.window='',sf.main='chara_main.ks'"]
[else]
[button normal=edit_button_page_over over=edit_button_page_over]
[endif]
[eval exp="drawButtonCaption('姓名编辑',0x0088aa)"]

[locate x=410 y=60]
[if exp="sf.main!='map_main.ks'"]
[button normal=edit_button_page over=edit_button_page_over storage="map_main.ks" exp="f.window='',sf.main='map_main.ks'"]
[else]
[button normal=edit_button_page_over over=edit_button_page_over]
[endif]
[eval exp="drawButtonCaption('游戏系统',0x0088aa)"]
[endmacro]
;------------------------------------------------------------------------------------------------
;常用控件组
;------------------------------------------------------------------------------------------------
[macro name="licence"]
[frame title="使用规约" x=&"kag.scWidth-355" y=15 line=20]
[nowait]
[locate x=&"kag.scWidth-350" y=30]
[indent]
本工具为免费软件，但拥有附加使用条件。[r]
假如自认无法遵守以下约定，请停止使用[r]
并删除本软件。[r]

违反使用规定的行为视同抄袭代码，软件[r]
作者将采取一切手段维权。
[r][r]
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
[endnowait]
[endmacro]
;---------------------------------------------------------------
;指令按钮
;---------------------------------------------------------------
[macro name=button_tag]
[locate x=%x y=%y]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target="*打开指令窗口" exp=%exp]
[eval exp="drawButtonCaption(mp.name)"]
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
[eval exp="drawButtonCaption('×')"]

[if exp="mp.height>=800"]
[eval exp="mp.height=710"]
[endif]

[locate x=&"mp.width-140" y=&"mp.height-80"]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*确认]
[eval exp="drawButtonCaption('确认')"]
[locate x=&"mp.width-140" y=&"mp.height-50"]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*关闭选单]
[eval exp="drawButtonCaption('取消')"]
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
[eval exp="drawButtonCaption('×')"]

[locate x=&"mp.width-140" y=&"mp.height-80"]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*确认]
[eval exp="drawButtonCaption('确认')"]
[locate x=&"mp.width-140" y=&"mp.height-50"]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*关闭选单]
[eval exp="drawButtonCaption('取消')"]
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
[eval exp="drawButtonCaption('×')"]

[locate x=&"mp.width-140" y=&"mp.height-80"]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*确认]
[eval exp="drawButtonCaption('确认')"]
[locate x=&"mp.width-140" y=&"mp.height-50"]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*关闭选单]
[eval exp="drawButtonCaption('取消')"]
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
[eval exp="drawButtonCaption('×')"]
[locate x=93 y=40]
点三角形切换素材文件夹
[locate x=320 y=40]
提示：新加入的素材在预览图中找不到的情况，请“重载工程”后再试
[locate x=&"mp.width-260" y=40]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*确认]
[eval exp="drawButtonCaption('确认')"]
[locate x=&"mp.width-140" y=40]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*关闭选单]
[eval exp="drawButtonCaption('取消')"]
[endmacro]
;---------------------------------------------------------------
;标题框
;---------------------------------------------------------------
[macro name=frame]
[eval exp="drawFrame(mp.title,(int)mp.line,(int)mp.x,(int)mp.y)"]
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
[position layer="%layer|message4" width=%width|225 height=&"mp.line*23" frame="" color="0xFFFFFF" opacity=255]
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
