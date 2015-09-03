
# 更新记录

![NVLLOGO][1]

本工具为使用吉里吉里2/KAGEX开发的免费开源软件。
下载最新版本、疑问、讨论、添加自制游戏、推荐素材等，请访问[THE NVL Maker][2]官网。

##3.85 stable
###（一）编辑器：

####1、新功能
+ 添加**通关标题**界面编辑窗口
+ 添加**询问窗口**界面编辑，可以自定义询问窗口（保存、读取、退出游戏、返回标题）的样式了


####2、修正错误与优化
+ 导出成BKE脚本的功能配合BKE的指令更新进行了更新
+ 地图、养成面板的控件标题将只显示5个字，避免因为名字过长导致无法打开细节编辑窗口的问题

###（二）模板工程：

####1、新功能
+ 支持通关后（二周目）改变标题画面的效果，当执行到结局收集指令之后，视为游戏通关，接下来将调用**通关标题**面板的效果来代替**默认标题**面板。
+ 逐帧动画播放插件AnimPlayer追加了少量新指令

####2、修正错误与优化
+ 添加**video**、**voice**空文件夹，避免因为缺少这两个文件夹导致的报错
+ 返回标题时将清理按键HOOK，避免在右键隐藏对话框情况下直接返回标题导致的报错

##3.81 stable

###（一）编辑器：

####1、新功能
+ 添加**结局收集**、**BGM鉴赏**模式的界面编辑器（兼容没有END、BGMMODE的版本，当不存在对应界面时不显示）
+ 对应追加addend**登陆结局**指令相关的界面
+ 添加了导出界面配置到**JSON**的功能，并调整导出路径
+ 配合**NVLMaker跨平台版**，添加了从`.ks`剧情脚本一键转换至`.bkscr`脚本的功能

####2、修正错误与优化
+ 调整指令界面排版、修正缺少部分**指令窗口**导致报错的问题
+ **头像、SL画面**等几个控件添加可以通过侧边栏调整坐标的设置窗口，避免出现控件拖出框导致无法使用的问题
+ 修正**历史记录**滚动条修改后没有刷新的问题
+ **简约科幻**模板添加缺失的CG收集画面背景文件
+ 修改部分用词，如统一前后翻页按钮用语为“前一页”、“后一页”，添加解释和注释

###（二）模板工程：

####1、新功能
+ **结局收集**、**BGM鉴赏**模式进行了重写，并整合到模板工程中


####2、修正错误与优化
+ 修正切换透明框时没有重置消息层图片的问题，对应的部分风格模板也进行了修改
+ 对语音播放的代码进行了调整，只在自动模式下，点击才会中断语音
+ 修正auto/skip按钮在非安定状态下无法使用的问题
+ 修正选项按钮每行字数为固定值的问题，为多行时，将可以自己修改字数

##3.70 beta

###（一）编辑器：

####1、新功能
+ **地图**、**养成面板**上的按钮添加了鼠标移入/移出（`onenter`/`onleave`）属性（请参考下方模板工程部分的说明）
+ **系统设定**画面添加了语音音量设置、恢复默认设置功能，基于新模板建立的工程将带有此功能，旧工程可正常打开但无法设置这两项
+ **游戏打包**调用的`krkrrel.exe`现在可以自动指定对应的Data目录，无需自己手动选择了
+ 追加了用于**制作多语言版游戏**的**导出文本**、**回写文本**功能：
>+ 该功能**不会覆盖**原`scenario`文件夹下的任何`.ks`文件，请放心使用~
+ 将会遍历**脚本列表**，即`macro/scenario.txt`内列出的文件，导出以下内容：对话与描述（不含人名）、可存档标签的章节名、选项
+ 导出文本将保存到工程`savedata\dialogue.txt`内，带有文本编号
+ 抽出文本，只余编号的脚本也将会被输出到`savedata\orin`
+ 可修改`dialogue.txt`，例如翻译成其他语言
+ 点击“回写”按钮，会根据当前的`dialogue.txt`以及`savedata\orin`的内容，生成翻译脚本，输出到`savedata\tran`
+ **人名翻译：**使用**姓名编辑**功能，不改变“简称”的情况下，翻译“姓名”并重新生成宏，无需修改脚本即可在游戏中显示翻译后的名

####2、修正错误与优化
+ 修正了**脚本编辑器**解读包含**宏定义**的脚本时，会出现错误的问题。（`TagExtractor.dll`与编辑器本体均有更新）
+ 将**对话界面**的头像修改为默认不显示，避免一部分新手迷惑，但在功能上没有任何影响
+ 微调了界面，统一界面字体，添加了更多说明，并隐藏了一部分不必要的参数
+ 修改代码，可以通过简单修改编辑器窗口大小，制作**大分辨率游戏**（需下载开源编辑器之后改写编辑器的Config.tjs里的对应参数）

###（二）模板工程：

####1、新功能
+ **地图**、**养成面板**上的按钮添加了鼠标移入/移出（`onenter`/`onleave`）功能。
>配合新加在`macro_map.ks`里的TJS函数，可以制作出类似**鼠标移动到按钮上，则在其他位置显示悬停图片**的功能
**注：**使用方式为在对应参数里填入内容：
鼠标移入：`mapshow('图片名',x,y)`
鼠标移出：`maphide()`
+ **系统设定画面**添加了**语音音量设置**、**恢复默认**设置功能
+ 修改**CG系统**的**缩略图**缩放功能，并添加了自动查找小缩略图的功能。对CG系统自动抓图缩放会导致画面锯齿化不满的童鞋们可以安心了~
>+ 对缩放原图的方法进行了修改，让默认效果变得更平滑了
>+ 假如依然不满意默认效果，可使用`xxx_thum.png`的小图作为对应xxx的缩略图(注意必须是`png`)

+ 添加了**截图功能**，按下F5或小键盘星号键时，将会把当前画面自动保存到`screenshot`文件夹下

####2、使用范例
+ 范例脚本里添加了**显示并登陆CG差分**的演示，第一张CG图现在有两个差分了
+ 添加了使用**养成面板**制作的查看主角资料（姓名）界面，具体代码在`other.ks`，原来的other.ks改名叫`other_sample.ks`
+ 添加了**EXTRA系统**，使用地图+脚本制作，不想要这个功能的直接把title_other.ks改成自己的内容即可
+ 可以从标题进入在`title_other.ks`里写的EXTRA系统，默认有**CG收集**、**音乐欣赏**、**结局收集**三个选项：
>+ **EXTRA系统**的选单本身是**地图**，直接打开地图编辑器修改即可
>+ **音乐鉴赏**模式为纯脚本，不过可以修改坐标、图片的地方都有中文注释，对系统功能个性化没有特殊需求的使用者，直接替换素材略加修改即可
>+ **结局收集**选单同样使用**地图**制作，直接照着原有的范例（结局A、结局B）修改地图和追加新的结局脚本即可

####3、图层调整
+ 将显示CG用的默认图层改为`layer16`，这样想修改系统的可以用上下其他图层（`layer15`、`layer17`）干点别的
+ 将地图画面和养成面板使用的图层顺序统一调整了一下，避免和其他如选择按钮共用图层
>+ 背景从`event`移动到了`layer11`
>+ 地图和养成按钮从`message1`移动到了`message3`
>+ 养成面板的数值、图形显示从`layer9`移动到了`layer12`
>+ 新增的悬停图片功能显示在`layer13`上

+ 为配合新增的EXTRA系统，CG模式和BGM模式的背景图层改为和地图、养成面板背景同一层（`layer11`层）

####4、修正错误与优化
+ 修正因为拼写错误导致**历史记录**播放**语音**使用的是`se[0]`而不是`se[1]`的错误
+ 修正当使用code文件夹下追加的透明询问窗口`MyYesNoDialog.tjs`代码时可能会导致的窗口弹出后立刻自动消失的问题
+ 优化了一些代码，主要是`macro_ui.ks`等的部分，更多地用TJS去代替KAG宏（总的来说代码行数减少了很多，修改起来也更方便了，但对新手来说结果可能只是更加看不懂）
+ **系统按钮**的有效化/无效化改用了正直的写法（意思是原来用的方法很猥琐，不要学）
+ 代码做了少量修改，可以同时支持krkr原版和krkrz两种exe，不过这个基本没什么意义……
+ 追加了一些注释并删除了一些多余的代码

---
##3.55 stable

###编辑器：
 - 新增台词抽取功能，可以将已经完成的脚本中的对话和描述内容抽出，方便制作配音版和统计最终剧本字数
 - 修改部分界面图片，添加退出按钮
 - 在界面上添加使用规约
 - 修正淡出音乐的时间默认值设定没有条件判断，导致输入的淡出时间被重置为默认值的问题
 - 为如何修改单页档案个数添加文字提示
 - 调整界面文字大小
 - 当选中universal模式时，会自动添加rule参数的默认值了，避免因没有指定遮片图而导致的游戏执行出错
 - 原“等待时间”指令按钮更名为“等待操作”，并追加“等待点击”功能在“等待操作”指令下
 - 图片选择窗口的“查看原图”功能，改为双击缩略图后打开（原来为选中缩略图即打开）
 - 调整margin设置（对话框页边距）白框的文字位置，使其更接近实际文字显示位置
 - 打开最近工程时，将判断工程文件是否存在了（避免删除当前编辑中的工程后，编辑器因找不到工程而导致的出错）
 - 为脚本编辑器的NPC姓名指令增加头像、角色图和编号参数，其实本来就该有的功能为什么没有做呢_(:з」∠)_

###分支：
 - 新增小分辨率版本编辑器Editor_lite.exe，可用于在笔记本屏幕上编辑800x600大小的游戏画面

###模板工程：
 - 修正雾气效果插件显示顺位过于靠前的问题，以及保存后读取可能无法正常还原效果的问题（fog.ks）
 - 调整空白模板的按钮图形，使按钮在黑背景下也能看清
 - 增加scenario.txt（抽取台词用的设定文档）
 - 选项按钮支持多行效果，超过20字会自动换行（虽然应该几乎不会有人用到吧……）
 - 修改模板工程的范例文字，避免打开编辑prelogue.ks时，因为显示文字内有@并被系统识别为指令而出现错误

###其他：
 - 官网地址修改为新域名：http://www.nvlmaker.net/并进行了改版
 - 使用手册重写，新增大量内容，并改为HTML形式，可从编辑器直接打开浏览器查看
 - Wizard.exe和KAGConfigEX2.exe进行了重新编译并修正了一些隐藏问题
 - 修正第一个图片窗口代码的Override.tjs里缺少nvl文件夹搜索导致直接覆盖运行会出错的问题

---
##3.52 stable

###编辑器：
 - 加入了显示器分辨率不满足条件时，编辑器显示滚动条的功能（全屏外的另一选择）
 - 统一部分用语

###模板工程：

 - 添加了空白宏文件macro_self.ks，可填写自制宏内容 ·添加了关于使用规约的简单说明 ·范例使用到的图片进行了更新
 - 修复游戏界面字体默认显示为“用户选择字体”而非Config.tjs里设定的默认字体的问题
 - 新增文件夹nvl，放置不会被编辑器改动的系统文件、TJS插件等 ·修正当文件名中有非扩展名的“.”，导致的选项分支显示出错
 - 修正少量界面指令使其名称和功能对应，并添加注释
 - 默认标题画面的“自定按钮”和主菜单或对话框上的“自定按钮”将分别连接到title_other.ks和other.ks上
 - 对自定按钮连接到的脚本内容进行了更新，加入了如何添加自定内容的说明

###其他：
 - 教程进行了对应更新
 - 3.51-3.52，依然请采取拷贝配置文件和剧情脚本，覆盖到新建空白工程的方法
 - 要复制的TJS配置文件列表：
  >cglist.txt
  macro_name.ks
  namelist.tjs
  setting.tjs
  uicgmode.tjs
  uidia.tjs
  uihistory.tjs
  uiload.tjs
  uimenu.tjs
  uioption.tjs
  uisave.tjs
  uislpos.tjs
  uititle.tjs
  
 - 今后进行系统等更新时，如无特别说明，仅需备份并将macro和scenario覆盖到新建空白工程
 - 当然，最好还是不用更新了……

---
##3.51 beta

编辑器：
·为对话框加入了文字范围边界显示和文字样式示例
·当改变对话框图片时，页边距会自动设定为0，避免因为忘记调整页边距导致文字无法显示的情况
·修复了字体的阴影和边缘效果在编辑器部分界面不显示的问题
·修正了地图按钮无法记录执行TJS式的问题（EXP参数）
·对非4:3的游戏，截图演示的长度和宽度进行了修正，能够正确显示截图大小了
·修复路径中有空格会导致KAGCONFIG.EXE无法打开的问题
·地图和养成部分按钮增加了音效输入

模板工程：
·修复没有加载插件，无法播放MP3和OGG的问题
·修复没有加载特效插件，可能导致部分切换效果无法使用的问题
·修复游戏部分字体与Config.tjs设定不同的问题
·修复分页[w]之后，文字依然存在的问题
·修复auto\skip系统按钮在非安定状态无法点击的问题
·修复Slider的实际位置和编辑器显示不同的问题
·修复历史记录的按钮在编辑器中可以设置音效，但在游戏中没有实际音效的问题
·修复option画面下，跳过全部和只跳已读按钮不根据状态显示，而是都显示的问题
·删除无用的函数并加入更详细的注释
·配合编辑器，地图和养成部分按钮增加了音效播放功能
·prelogue.ks增加了输入姓名、显示立绘、范例地图的演示
·MySaveLoadFuntion.tjs里增加了退出和返回标题的询问文字，可以自行修改了

其他：
·加入了新的界面模板：flower dream，作者QR
·加入了新的界面模板：darkness，作者xdeadgodx
·加入了新的图形退出询问窗口代码，并更新使用说明
·Tool文件夹下添加krkr.exe，使游戏可以打包成单个exe格式
·同捆的GPL协议修正为与吉里吉里SDK相同的GPLv2
·教程针对3.5版做了一些修正，更换了部分截图
·为节约空间，道具系统范例放入官网Document页提供独立下载

---
##3.5 alpha

编辑器：
·对应模板工程，去掉多余的设置项
·工程设定界面重做，不再强制修改config.tjs的其他内容
·可以直接使用KAGConfigEX2来编辑详细设定了（点击界面设定config.tjs）
·历史记录界面重做
·2.32版EXE恢复使用（编辑器启动时左上角仍有黑色方块，属于正常现象，游戏工程不会有）

模板工程：
·更换全system文件夹为KAGEX1原版（2.32版EXE下，启动时左上角也不会有黑色方块了）
·改写部分macro脚本，添加MySaveLoadFunction.tjs等
·更换历史记录系统的写法

其他：
·SKIN对应修改
·询问窗口对应修改

从3.1X到3.5版工程更新方法：
由于系统进行了大幅度更新（包括macro和system），
因此建议不要将新系统直接覆盖到旧工程里，
最好建立新工程，之后将自己的文件复制到新工程的办法。

·在3.5下新建工程
·将原工程的素材与macro文件夹下的TJS配置文件覆盖到新工程对应文件夹下
·要复制的TJS配置文件列表：
  macro_name.ks
  namelist.tjs
  setting.tjs
  uicgmode.tjs
  uidia.tjs
  uihistory.tjs
  uiload.tjs
  uimenu.tjs
  uioption.tjs
  uisave.tjs
  uislpos.tjs
  uititle.tjs
·将原工程里已经制作的剧情脚本复制到新工程scenario文件夹下（不包括first.ks/title.ks，这两个请使用新版）
·打开历史记录界面编辑器，调整滚动条的长和宽、更换滚动条按钮（滚动条底图现在可以直接做到历史记录底图上）

---
##3.14 beta

编辑器：
·为脚本编辑器加入直接打开KS文件功能与全局测试功能
·修正checkbox无法辨别字符串形式"false"的问题
·微调界面显示位置，使对分辨率的需求降低
·将历史记录宽度的判断从800改成画面宽度

模板工程：
·HistoryLayerCustomConfig.tjs的margin统一设为0

其他：
·工具KAGConfigEX2更新
·繁体版SKIN说明更新

3.13 正式版

编辑器：
·更新Editor.exe设置，使其在全屏下可以正常缩放以显示全部内容。
·为保证版本统一，分辨率修改回1440x900。
·界面排列顺序进行了一些调整。

模板工程：
·微调macro_ui.ks内实现系统按钮隐藏对话框的代码，避免可能导致的跳转错误BUG。

文档&其他：
·附录添加CG系统相关变数记录。

---
##3.12 beta版

编辑器、模板工程、范例：
·将所有EXE版本改为2.28，以修复游戏启动时左上角出现黑色方框的问题
·因此删除2.30的繁体中文内核，将日文内核更换成2.28版。

从3.11版本到3.12的升级方式[手动醒目]：
（1）替换Editor.exe和所有游戏工程的krkr.exe
（2）删除所有的savedata文件夹，包括编辑器本身的和游戏工程（含Template）的
（3）所有游戏工程（含Template）的macro文件夹下的tjs配置文件需要进行手动修改：
     ·使用文本编辑器打开macro文件夹下的所有tjs文件
     ·使用全部替换功能，将所有(const)替换为空

同样原理，对所有使用3.11或之前版本制作的游戏，想要去掉启动时左上角黑色方块的办法：
（1）将krkr.exe替换成2.28版本
（2）删除savedata文件夹
（3）将所有tjs配置文件里的(const)删除
（4）有自建map/edu文件的情况，用同样方法打开，删除(const)即可被正常读取。

---
##3.11 正式版

编辑器：
·修复因为部分脚本文件没有UNICODE化造成的日文系统下无法正常开启编辑器问题
·增加由久遠.悠（https://sites.google.com/site/hiyuadv/） 翻译的繁体中文内核krkrcht.exe
·如日文系统无法开启Editor.exe，请使用同目录下的krkrcht.exe打开

其他：
·Wizard.exe更新，BUG修复，添加改变既有工程分辨率的功能
·加入代码（Code）文件夹，提供一些可以直接使用的追加功能，
·修复3.10时，图片询问窗口代码包内没有返回值，导致记录最新档功能失效的问题
·加入范例游戏（project/Samplegame）
·修复3.10时，范例游戏姓名输入因缺少[commit]导致输入的名字无法正常被记录的问题

模板工程：
·修复地图按钮最后一个无法显示的问题
·修复Template/Data/system/HistoryLayerCustomConfig.tjs没有UNICODE化造成的日文系统下无法正常开启游戏的问题
·增加对应版本的日文EXE和由 久遠.悠（https://sites.google.com/site/hiyuadv/）翻译的繁体中文版EXE
·如日文系统无法开启krkr.exe，请使用krkrcht.exe/krkrjpn.exe打开

---
##3.10 正式版

编辑器：
·增加了新建工程功能
·一些窗口的排版调整
·统一将“TJS”与“执行”“EXP”栏名称改为“表达式”,修改部分说明文字
·添加了“创建分歧”的窗口，可以一次性创建@if~@elsif~@else~@endif的分歧框架
·TJS条件生成器写法更新
·分歧结束指令窗口增加了else和endif的选择

工具：
·增加了新建工程向导Wizard.exe（源代码地址：http://code.google.com/p/nvlmaker-wizard/）
·KAGConfigEx2.exe更新（源代码地址：http://kcddp.keyfc.net/bbs/viewthread.php?tid=1374&extra=page%3D1）
·增加了放置界面模板的skin文件夹

模板工程：
·mapbutton增加执行EXP功能（更新macro_map.ks）
·追加逐帧动画播放插件AnimPlayer.ks于system文件夹下（需要手动添加AnimPlayer.ks并更新macro.ks）
·修正显示名字同时有头像显示时，会导致名字字体变化的问题（更新macro_play.ks）
·修正默认标题文件当游戏画面大于1024x768时出现的文字层大小与窗口不对应问题（更新title.ks）

文档：
·使用手册修正、新手教程完成。

---
##3.07 beta版

编辑器：

·多行文本框更新为TJS插件（修复在全屏状态下，输入对话等指令窗口无法正常显示文本框的问题。）
  另外，插入特殊符号功能修改为插入到光标所在位置，依旧支持选中、剪切、复制、粘贴等功能。
 （限制：每次输入的对话字数控制将被在文本框范围之内，需要大批量输入文本时，请打开脚本直接输入。）
  假如认为文本框没有原来的好用，请上论坛反应，这个部分的修改将会回滚。

·修复存取、CG编辑器在改变每页存档按钮或CG按钮数量时，由多->少改变设置可能出现的报错。

·地图和养成面板编辑器，为据点和按钮设定标签跳转时，如果忘记加入*号，编辑器会自动帮忙加上。

·3.06->3.07更新方法：覆盖Data.xp3

游戏工程：

·修复有一定几率在读档之后，系统按钮依然无效化，需要用滚轮打开一次历史记录之类的才能重新有效的BUG。

·3.06->3.07更新方法：覆盖project文件夹下，模板工程或其他游戏工程里Data/macro文件夹下的以下同名文件——
  Data/macro/macro_ui.ks
  Data/macro/main_menu.ks
  Data/macro/save.ks
  Data/macro/load.ks
  Data/macro/history.ks
  Data/macro/option.ks

  PS：拥有吉里吉里知识，并已经大量修改模板系统内容的同学可以不用覆盖，自行修复此BUG，具体修改内容见：
  http://kcddp.keyfc.net/bbs/viewthread.php?tid=1381&extra=page%3D1

---
##3.06 安定版

修改部分数值计算使config.tjs里不至于出现小数（请使用之前版本的同学更新编辑器后重新保存一次工程设定）

修正读入config.tjs的方式，从读入编辑器模板强制覆盖，改成读入当前工程文件夹的Config.tjs。（不推荐手写编辑，假如你需要大量修改，请使用KAGConfig工具）

上方工具栏新增“素材管理”按钮，可直接打开当前编辑中的游戏素材文件夹（Data）

模板工程内添加了支持的素材格式说明文档

加入一些简单的操作说明，例如页边距的设定，鼠标应从左上到右下拖动

为fadeoutbgm加入默认参数时间值，当忘记在编辑器内填写渐变时间时，执行游戏也不会出错了

养成部分功能更新，增加了“等待玩家选择”一项。（需要更新游戏工程内的macro_edu.ks脚本）

    例如当周一输入时，可以设定一张面板A显示养成项目，并勾上“等待玩家选择”。
    而当玩家点击某个养成项目后，使用另一张面板B显示养成数据，不使用“等待玩家选择”。

    循环示例：

    【周一】显示面板A（等待玩家选择）->玩家选择项目“锻炼”
    【周一】->锻炼第一次，体能增加->显示面板B
    【周二】->锻炼第二次，体能增加，显示面板B
    ……
    【周五】->锻炼第五次，体能增加->显示面板B
    【周末】->自由行动

    则做出的效果是周一选择日程，之后一直到周五执行日程。并且每次执行后数值都会更新。
    当然，这个需要一定的变数操作知识。

    另外养成面板的按钮增加了设置“执行（当点下按钮时执行的TJS式）”的功能（对应KAG的button的exp属性）。

【从3.05-3.06的更新方式】

1、编辑器本体

   替换Data.xp3

2、模板工程或其他游戏工程

   修正Config.tjs——更新编辑器后重新保存一次工程设定
   
   直接替换文件：/project/Template/Data/macro/macro_edu.ks

3、Tool文件夹

   因为KAGConfig在WIN 7系统下无法使用，添加了新版的KAGConfigEx2

【从3.04-3.06的更新方式】

1、编辑器本体

   替换Data.xp3

2、模板工程或其他游戏工程
   
   修改（或直接替换）的文件：

   /project/Template/Data/macro/macro_edu.ks（直接替换）

   /project/Template/Data/macro/macro.ks（增加一行，[call storage="macro_cg.ks"]，用于呼叫macro_cg.ks）

   /project/Template/Data/scenario/title.ks（*附加按钮 标签下增加一行，[call storage="cgmode.ks"]，这样点下标题画面里的“自定按钮”后，将跳转到cgmode.ks）

   新增的文件（复制粘贴，大家都会的吧……）：

   /project/Template/Data/image/sample_cgthum.png（用于决定CG缩略图大小的空白PNG图片）

   /project/Template/Data/macro/macro_cg.ks（CG模式的宏指令）

   /project/Template/Data/macro/uicgmode.tjs（CG模式的界面配置表）

   /project/Template/Data/macro/cglist.txt（记录需要显示的CG文件名，每行一个）

   /project/Template/Data/macro/cgmode.ks（CG模式系统的脚本）

---
##3.05

添加了CG系统编辑界面。

修正了从编辑器无法试听MID格式音乐的问题。

使用3.04的各位如果不想覆盖原有工程，请更新以下几个文件，即可更新到3.05版：

1、编辑器本体

   替换Data.xp3

2、模板工程或其他游戏工程
   
   修改（或直接替换）的文件：

   /project/Template/Data/macro/macro.ks（增加一行，[call storage="macro_cg.ks"]，用于呼叫macro_cg.ks）

   /project/Template/Data/scenario/title.ks（*附加按钮 标签下增加一行，[call storage="cgmode.ks"]，这样点下标题画面里的“自定按钮”后，将跳转到cgmode.ks）

   新增的文件（复制粘贴，大家都会的吧……）：

   /project/Template/Data/image/sample_cgthum.png（用于决定CG缩略图大小的空白PNG图片）

   /project/Template/Data/macro/macro_cg.ks（CG模式的宏指令）

   /project/Template/Data/macro/uicgmode.tjs（CG模式的界面配置表）

   /project/Template/Data/macro/cglist.txt（记录需要显示的CG文件名，每行一个）

   /project/Template/Data/macro/cgmode.ks（CG模式系统的脚本）

---
##3.04

使用说明手册进行了少量更新，添加了新手教程关于标签与跳转的部分

模板工程选择按钮的标签名统一为需要加星号，编辑器也做了对应的修改

图片选择窗口每页可显示15张图片，缩略图大小扩大为240x180，并添加独立的图片预览窗口

修正保存角色名字时，主角名和默认名的文字颜色无法直接输入的问题

---
##3.03

模板工程所有系统按钮添加选中、按下时的音效功能，并可以在编辑器里随时试听

修复上次紧急更新去掉的显示新档标记功能

模板工程存储界面，没有任何存档时，不显示新档标记（原来会默认显示在第一个存档位置上）

模板工程存储界面，成功保存游戏后会刷新悬停效果缩略图

修正模板工程默认标题画面设置了前景图片但是不显示的问题

---
##3.02

添加枫叶粒子效果

修复SL界面上的控件无法通过拖动来调整位置的严重BUG

---
##3.01

将脚本编辑器的显示范围扩大，并拉长到35行

切换使用手册路径


为if/elsif增加TJS条件生成器


添加历史记录操作的指令窗口

添加部分防出错功能（标签*号自动添加、去除相关）




  [1]: http://i257.photobucket.com/albums/hh217/countd2005/banner/banner_nvlmaker.png
  [2]: http://www.nvlmaker.net/

> Written with [StackEdit](https://stackedit.io/).