*start|序章
@bg storage="white"
@dia
@history output="true"
@主角
歡迎來到THE NVL Maker的世界……（喂）[w]
@eval exp="f.姓='abc'"
@eval exp="f.名='def'"
@face storage="face_setting_sample"
@主角
主角的姓氏是[emb exp=f.姓]，名字是[emb exp=f.名]。[w]
@npc id="路人甲"
接下來，測試一下選擇吧。[w]
;----------
@selstart hidemes="0" hidesysbutton="0"
@locate y="200" x="0"
@selbutton target="*選擇A" text="我要選擇A"
@locate y="300" x="0"
@selbutton target="*選擇B" text="我要選擇B"
@selend
;----------
*選擇A
@clsel
@npc id="路人甲"
你選擇了A。[w]
@jump target="*合併"
;----------
*選擇B
@clsel
@npc id="路人甲"
你選擇了B。[w]
@jump target="*合併"
;----------
*合併
@npc id="路人甲"
不管選擇了A還是B，最後你都會看到這句話。[w]
@scr
試試另外一個樣式的對話框……[lr]
你也可以切換文字的顏色。[l][font color=0x3366FF]比如這樣……[font color=0xFFFFFF][lr][r]
改變[font size=30]大[font size=15]小[font size=20]也沒有問題喲。[w]
@dia
@npc id="路人甲"
現在換回來了……[lr]
準備好就返回標題了哦。[w]
@gotostart ask="false"
