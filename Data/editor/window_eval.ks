*window
[window_up width=400 height=300 title="常用表达式"]
[group title="生成0~3的随机整数" name="f.参数.exp" x=100 y=50 comp="f.intran=intrandom(0,3)"]
[group title="将数字42转换为汉字" name="f.参数.exp" x=100 y=80 comp="f.num=kansuuji_simple(42)"]
[s]

*确认
[commit]

*关闭选单
[eval exp="f.window=''"]
[rclick enabled="false"]
[freeimage layer="7"]
[current layer="message7"]
[er]
[layopt layer="message7" visible="false"]
[return]
