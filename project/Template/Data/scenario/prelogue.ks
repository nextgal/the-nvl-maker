;------------------------------------------------------------
;点下“开始游戏”以后执行的内容，你可以把下面替换成自己的剧本
;------------------------------------------------------------
*start|序章
@bgm storage="BGM074.ogg"
@bg storage="rouya00"
@fg pos="center" storage="fg_sample"
@dia
@history output="true"
@主角
欢迎来到THE NVL Maker的世界……（喂）[w]
@eval exp="f.姓='abc'"
@eval exp="f.名='def'"
@fg pos="left" storage="fg_sample"
@face storage="face_setting_sample"
@主角
主角的姓氏是[emb exp=f.姓]，名字是[emb exp=f.名]。[w]
@fg pos="right" layer="1" storage="fg_sample"
@npc id="路人甲"
接下来，测试一下选择吧。[w]
;----------
@selstart hidemes="0" hidesysbutton="0"
@locate y="200" x="0"
@selbutton target="*选择A" text="我要选择A"
@locate y="300" x="0"
@selbutton target="*选择B" text="我要选择B"
@selend
;----------
*选择A
@clsel
@npc id="路人甲"
你选择了A。[w]
@jump target="*合并"
;----------
*选择B
@clsel
@npc id="路人甲"
你选择了B。[w]
@jump target="*合并"
;----------
*合并
@npc id="路人甲"
不管选择了A还是B，最后你都会看到这句话。[w]
@scr
试试另外一个样式的对话框……[w]
你也可以切换文字的颜色。[l][font color=0x3366FF]比如这样……[font color=0xFFFFFF][lr][r]
改变[font size=30]大[font size=15]小[font size=20]也没有问题哟。[w]
@dia
@npc id="路人甲"
现在换回来了……[w]
@npc id="路人甲"
地图测试。[w]
@clfg layer="all"
@map storage="sample.map"
;----------
*地图01|
@clmap
@bg storage="planet_Unknown000_00"
@主角
来到了第一个地方。[w]
@jump target="*地图合并"
;----------
*地图02|
@clmap
@bg storage="earth000A_01"
@主角
来到了第二个地方。[w]
@jump target="*地图合并"
;----------
*地图合并|
功能演示完毕。[lr]
准备好就返回标题了哦。[w]
@gotostart ask="false"
