*start|序章
@bgm storage="wakaba_rond-musicbox"

;一开始就拥有的物品设定
@additem num="5" name="啃过一口的苹果"
@additem num="1" name="羊毛"
@additem num="1" name="汞"
@additem num="1" name="黄金"
@additem num="1" name="秘银"
@additem num="1" name="第五元素"

@bg storage="library01_a"
@dia
@history output="true"
@face storage="M102A11"
@eval exp="f.姓='米勒'"
@eval exp="f.名='维金斯'"
你好，初次见面，我是[edit name=f.名]……[r]
@history output="false"
@nowait
@link target="*输入完毕" hint="点这里继续~"
确定用这个名字了[endlink]
@history output="true"
@endnowait
@s

*输入完毕
[commit]
[主角 face="M102A31"]
嗯，名字是[emb exp=f.名]，姓氏是[emb exp=f.姓]。[lr]职业是磨坊主的儿子。[w]

[主角 face="M102A32"]
这次要做的就是介绍一下道具系统啦。[lr]
首先请点下对话框上的item按钮，看看道具系统的样子。[w]
[主角 face="M102A11"]
现在道具界面里，已经拥有的物品都是在prelogue.ks的开头加上的。[lr]
接下来我们就来看看怎么通过TAG指令操作物品。[w]

*tags
[nowait]
[link target=*add]·添加物品：additem[endlink][r]
[link target=*sub]·减少物品：subitem[endlink][r]
[link target=*count]·物品数量：itemcount[endlink][r]
[link target=*continue]·继续讲解[endlink]
[endnowait]
[s]

*add
[主角 face="M102A11"]
添加物品的指令是additem，参数有两个，一个是物品名称，另外一个是物品数量。[w]
[主角 face="M102A31"]
写成[font color="0xFF0000"][ch text="@"]additem num="1" name="秘银"[resetfont]
这样的形式，就可以增加一个[font color="0xFF0000"]秘银[resetfont]。[w]
[主角 face="M102A32"]
假如是本来就拥有的物品，那么数值会增加。[lr]
假如是没有的物品，那么拥有的物品列表就会增加一条。[w]
[主角 face="M102A11"]
例如……
@additem name="羊毛" num=2
增加了两个羊毛。[w]
[jump target=*tags]

*sub
[主角 face="M102A11"]
减少物品的指令是subitem，参数有两个，一个是物品名称，另外一个是物品数量。[w]
[主角 face="M102A31"]
写成[font color="0xFF0000"][ch text="@"]subitem num="2" name="啃过一口的苹果"[resetfont]
这样的形式，就可以减少二个[font color="0xFF0000"]啃过的苹果[resetfont]。[w]
[主角 face="M102A32"]
当然，减少的物品超过你当前拥有的物品数量以后，物品就会变为零，从拥有的物品列表里消失了。[w]
[主角 face="M102A11"]
例如……
@subitem name="羊毛" num=2
减少了两个羊毛。[w]
[主角 face="M102A12"]
……到底为什么这么执着于羊毛呢？[w]
[jump target=*tags]

*count
[主角 face="M102A11"]
itemcount指令，参数是物品名称。[lr]
这是用来取得当前拥有的物品数量的。[w]
[主角 face="M102A31"]
写成[font color="0xFF0000"][ch text="@"]itemcount name="黄金"[resetfont]就可以在对话里显示拥有的物品数量。[w]
[主角 face="M102A32"]
例如……
现在拥有
@itemcount name="黄金"
个[font color="0xFF0000"]黄金[resetfont]和
@itemcount name="羊毛"
个[font color="0xFF0000"]羊毛[resetfont]
哦。[w]
[jump target=*tags]

*continue
[主角 face="M102A11"]
前面的这些变化都可以通过道具界面查看。[lr]
这还只是单纯的使用，接下来要讲一下道具系统相关代码的位置。[w]
[主角 face="M102A11"]
首先我们需要加入对应的素材（others文件夹）到你的工程。[w]
[主角 face="M102A11"]
然后是scenario文件夹里这4个脚本文件，也一样要复制过去。[w]
[nowait]
item_data.tjs——物品数据库[r]
macro_item.ks——操作物品数据的函数和宏[r]
macro_item_ui.ks——物品界面宏[r]
other.ks——物品界面
[endnowait]
[w]
[主角 face="M102A11"]
接下来还要在macro文件夹下的macro_self.ks里加入一行：[font color="0xFF0000"][ch text="@"]call storage="macro_item.ks"[resetfont]。[w]
[主角 face="M102A31"]
那么以后你点击系统按钮或者主菜单上的"其他"按钮，或者用其他方式呼叫other.ks脚本，就会看到物品界面了。[w]
[主角 face="M102A32"]
当然最终目标是要学会自己改造甚至制作物品系统，所以请继续听我讲下去。[w]
[主角 face="M102A11"]
item_data.tjs是记录物品数据的地方。游戏里所有可能出现的物品资料都必须要写在这里。[w]
[主角 face="M102A11"]
item_data.tjs可以使用EXE所在目录的"item_data.xlsm"来生成，或者用记事本打开也可以哦。[lr]
每一个[font color="0xFF0000"][ch text=" %["][resetfont]和[font color="0xFF0000"][ch text="],"][resetfont]
之间的内容，就是一个物品的数据。[w]
[主角 face="M102A11"]
包括名称（name），图标（icon），介绍文字（intro），是否可食（eat）四个参数。[w]
[主角 face="M102A31"]
其中是否可食用这个……纯属恶趣味，也不是必须参数，我们可以先无视他。[w]
[主角 face="M102A11"]
只要你按照这样的格式填写物品数据，之后就可以用additem把这些物品增加到拥有的物品列表里了。[w]
[nowait]
[font color="0xFF0000"][ch text=" %["][resetfont]
		[ch text="'name'=>'物品名',"][r]
		[ch text="'icon'=>'图标',"][r]
		[ch text="'intro'=>'文字介绍',"]
[font color="0xFF0000"][ch text="],"][resetfont]
[endnowait]
[w]
[主角 face="M102A11"]
物品名称需要是唯一的，因为系统要通过物品名称来查找其他的资料，例如图标等等并显示在界面上。[w]

*datafunction
[主角 face="M102A11"]
而macro_item.ks所作的事情，就是读入这些物品数据，并且封装了增加减少物品等等的宏。[w]
[主角 face="M102A11"]
这部分是完全不需要修改就可以使用的代码，所以不细讲太多了。请打开macro_item.ks自己看注释吧。[w]

*ui
[主角 face="M102A11"]
重点要讲的是如何修改物品界面让它符合你的游戏。[w]
[主角 face="M102A11"]
首先必须要了解的就是macro_item_ui.ks里定义了所有物品界面相关的宏，而other.ks则负责调用这些宏，把界面显示出来。[w]
[主角 face="M102A11"]
在充分理解了这一点之后，再继续下去。[w]
[主角 face="M102A11"]
通常需要修改的地方就是“翻页按钮，返回按钮”的外观和坐标，还有“当前翻到第几页”的文字。[w]
[主角 face="M102A11"]
再来就是“每页显示多少个物品”，“显示的位置”，“物品按钮之间的间距”。[w]
[主角 face="M102A11"]
最后是“物品按钮本身的外观”“当鼠标移动到物品上时，会显示的详细信息”。[w]

*changeui
[nowait]
[link target=*page]·翻页按钮，页数显示[endlink][r]
[link target=*item]·物品列表的外观[endlink][r]
[link target=*data]·物品按钮和移动上去显示的效果[endlink][r]
[link target=*final]·继续讲解[endlink]
[endnowait]
[s]

*page
[主角 face="M102A11"]
翻页按钮，页数显示的宏在macro_item_ui.ks的第228行，名叫[font color="0xFF0000"]item_page[resetfont]的宏。[w]
[主角 face="M102A11"]
通过修改button的normal和over属性的图片，可以改变翻页按钮的外形。[lr]
通过修改locate的x和y属性的数值，可以改变坐标。[w]
[主角 face="M102A11"]
至于页数显示，则是通过ptext这一行来进行的。[lr]
ptext的作用是在图片层上显示文字。[w]
[主角 face="M102A11"]
可以通过修改ptext的x，y来改变坐标，color，size来改变颜色和文字大小，text来改变文字的内容。[w]
[主角 face="M102A11"]
现在里面包含了两个变数，
[font color="0xFF0000"]f.当前物品页[resetfont]
代表当前翻到的页数，
[font color="0xFF0000"]f.物品总页数[resetfont]
代表现在拥有的物品列表一共有几页。[w]
[主角 face="M102A11"]
除了变数以外的文字，用''（单引号）括起来即可。[w]
[主角 face="M102A11"]
例如你也可以写成[r]
[ch text="[ptext text=&('第'+f.当前物品页+'页')]"][lr]
这样的话，就会显示“第N页”的字样。[w]
[jump target=*changeui]

*item
[主角 face="M102A11"]
“每页显示多少个物品”，“显示的位置”，“物品按钮之间的间距”，这几个是通过函数设定的。[w]
[主角 face="M102A11"]
第18行，名叫[font color="0xFF0000"]draw_item()[resetfont]的函数。[lr]
具体的作用是通过循环，批量地显示一整页的物品。[w]
[主角 face="M102A31"]
【修改排版的位置】已经用注释标记出来了，修改这里的数值就能改变物品界面的排版。[w]
[jump target=*changeui]

*data
[主角 face="M102A11"]
最后是“物品按钮本身的外观”“当鼠标移动到物品上时，会显示的详细信息”。[w]
[主角 face="M102A11"]
其中物品按钮的外观，是通过第72行，[r]
名叫[font color="0xFF0000"]draw_item_button()[resetfont]的函数设定的。[w]
[主角 face="M102A11"]
它同时还负责设定点下按钮后跳转到的标签等等。[w]
[主角 face="M102A11"]
修改物品按钮外观的是第78行和79行。[w]
[主角 face="M102A11"]
物品按钮上显示的“物品名称”和“物品数量”，是由98行的函数[font color="0xFF0000"]draw_item_name()[resetfont]负责的。[w]
其中每个[font color="0xFF0000"]mybutton.drawText()[resetfont]里面的
[font color="0xD1BEA0"]0xD1BEA0[resetfont]代表按钮不同状态下的文字颜色，可以随意修改成自己喜欢的颜色。[w]
[主角 face="M102A11"]
至于鼠标移动上去的效果，则是128行以后的悬停函数负责。[w]
[主角 face="M102A11"]
[font color="0xFF0000"]draw_item_icon()[r]
draw_item_elm()[r]
draw_item_exp()[resetfont][w]

[主角 face="M102A32"]
以上三个，可以通过修改里面的坐标等来达到改变界面布局的目的。[w]
[主角 face="M102A11"]
图标的位置在140和141行，解释的排版则在189到193行修改。[w]
[主角 face="M102A11"]
对不需要显示的内容，可以通过在这一行前面加上//来把它注释掉。[w]
[主角 face="M102A11"]
例如注释掉148行，那么就不会显示是否可食用字样。[w]
[主角 face="M102A11"]
注释137-142行，不显示图标。注释151行，不显示物品解释。[w]
[jump target=*changeui]

*final
[主角 face="M102A11"]
最后，other.ks的第13行可以修改道具系统的背景图片~这个应该没问题了吧。[w]

[主角 face="M102A31"]
每当点下一个物品按钮以后，变数[font color="0xFF0000"]f.选择物品编号[resetfont]的值会被带入物品的编号。[w]
[主角 face="M102A11"]
这个编号是指在[font color="0xFF0000"]f.item[resetfont]，也就是你当前拥有的物品数组里，这个物品的排列位置。[w]
[主角 face="M102A11"]
可以通过[font color="0xFF0000"][ch text="f.item[f.选择物品编号]"][resetfont]来取得这个物品的具体数据。[w]
[主角 face="M102A11"]
[font color="0xFF0000"][ch text="f.item[f.选择物品编号].name"][resetfont]代表物品名称，[r]
[font color="0xFF0000"][ch text="f.item[f.选择物品编号].num"][resetfont]代表物品数量，[r]
[font color="0xFF0000"][ch text="f.item[f.选择物品编号].intro"][resetfont]代表物品介绍。[w]

[主角 face="M102A11"]
接着会跳转到other.ks的[font color="0xFF0000"]*使用物品[resetfont]标签。[w]
[主角 face="M102A11"]
可以通过取得的值，做一些条件分歧，然后对物品进行操作。[w]
[主角 face="M102A31"]
例如对可以吃的物品，每次点下按钮就减少一个。[w]
[主角 face="M102A32"]
或者根据物品名字的不同，使用物品会产生不同的效果（增加、减少HP之类的……）。[w]
[主角 face="M102A31"]
希望以上的讲解可以让你更快地看懂整个道具系统范例。[w]
[主角 face="M102A11"]
不过，如果变数，数组，字典，宏，函数之类的概念不清楚的话……[w]
[主角 face="M102A31"]
那我也没办法啦，请老实地从吉里吉里基础学起吧！[w]
[主角 face="M102A11"]
今天就到这里，拜拜~[w]

;调用配方界面
[call storage="recipe.ks"]


[gotostart ask="false"]
