*start|序章
@bgm storage="wakaba_rond-musicbox"

;一開始就擁有的物品設定
@additem num="5" name="啃過一口的蘋果"
@additem num="1" name="羊毛"
@additem num="1" name="汞"
@additem num="1" name="黃金"
@additem num="1" name="秘銀"
@additem num="1" name="第五元素"

@bg storage="library01_a"
@dia
@history output="true"
@face storage="M102A11"
@eval exp="f.姓='米勒'"
@eval exp="f.名='維金斯'"
你好，初次見面，我是[edit name=f.名]……[r]
@history output="false"
@nowait
@link target="*輸入完畢" hint="點這裡繼續~"
確定用這個名字了[endlink]
@history output="true"
@endnowait
@s

*輸入完畢
[commit]
[主角 face="M102A31"]
嗯，名字是[emb exp=f.名]，姓氏是[emb exp=f.姓]。[lr]職業是磨坊主的兒子。[w]

[主角 face="M102A32"]
這次要做的就是介紹一下道具系統啦。[lr]
首先請點下對話框上的item按鈕，看看道具系統的樣子。[w]
[主角 face="M102A11"]
現在道具界面裡，已經擁有的物品都是在prelogue.ks的開頭加上的。[lr]
接下來我們就來看看怎麼通過TAG指令操作物品。[w]

*tags
[nowait]
[link target=*add]·添加物品：additem[endlink][r]
[link target=*sub]·減少物品：subitem[endlink][r]
[link target=*count]·物品數量：itemcount[endlink][r]
[link target=*continue]·繼續講解[endlink]
[endnowait]
[s]

*add
[主角 face="M102A11"]
添加物品的指令是additem，參數有兩個，一個是物品名稱，另外一個是物品數量。[w]
[主角 face="M102A31"]
寫成[font color="0xFF0000"][ch text="@"]additem num="1" name="秘銀"[resetfont]
這樣的形式，就可以增加一個[font color="0xFF0000"]秘銀[resetfont]。[w]
[主角 face="M102A32"]
假如是本來就擁有的物品，那麼數值會增加。[lr]
假如是沒有的物品，那麼擁有的物品列表就會增加一條。[w]
[主角 face="M102A11"]
例如……
@additem name="羊毛" num=2
增加了兩個羊毛。[w]
[jump target=*tags]

*sub
[主角 face="M102A11"]
減少物品的指令是subitem，參數有兩個，一個是物品名稱，另外一個是物品數量。[w]
[主角 face="M102A31"]
寫成[font color="0xFF0000"][ch text="@"]subitem num="2" name="啃過一口的蘋果"[resetfont]
這樣的形式，就可以減少二個[font color="0xFF0000"]啃過的蘋果[resetfont]。[w]
[主角 face="M102A32"]
當然，減少的物品超過你當前擁有的物品數量以後，物品就會變為零，從擁有的物品列表裡消失了。[w]
[主角 face="M102A11"]
例如……
@subitem name="羊毛" num=2
減少了兩個羊毛。[w]
[主角 face="M102A12"]
……到底為什麼這麼執著於羊毛呢？[w]
[jump target=*tags]

*count
[主角 face="M102A11"]
itemcount指令，參數是物品名稱。[lr]
這是用來取得當前擁有的物品數量的。[w]
[主角 face="M102A31"]
寫成[font color="0xFF0000"][ch text="@"]itemcount name="黃金"[resetfont]就可以在對話裡顯示擁有的物品數量。[w]
[主角 face="M102A32"]
例如……
現在擁有
@itemcount name="黃金"
個[font color="0xFF0000"]黃金[resetfont]和
@itemcount name="羊毛"
個[font color="0xFF0000"]羊毛[resetfont]
哦。[w]
[jump target=*tags]

*continue
[主角 face="M102A11"]
前面的這些變化都可以通過道具界面查看。[lr]
這還只是單純的使用，接下來要講一下道具系統相關代碼的位置。[w]
[主角 face="M102A11"]
首先我們需要加入對應的素材（others文件夾）到你的工程。[w]
[主角 face="M102A11"]
然後是scenario文件夾裡這4個腳本文件，也一樣要複製過去。[w]
[nowait]
item_data.tjs——物品數據庫[r]
macro_item.ks——操作物品數據的函數和宏[r]
macro_item_ui.ks——物品界面宏[r]
other.ks——物品界面
[endnowait]
[w]
[主角 face="M102A11"]
接下來還要在macro.ks裡加入一行：[font color="0xFF0000"][ch text="@"]call storage="macro_item.ks"[resetfont]。[w]
[主角 face="M102A31"]
那麼以後你打開對話框，系統按鈕或者主菜單上的"其他"按鈕，或者用其他方式呼叫other.ks腳本，就會看到物品界面了。[w]
[主角 face="M102A32"]
當然最終目標是要學會自己改造甚至製作物品系統，所以請繼續聽我講下去。[w]
[主角 face="M102A11"]
item_data.tjs是記錄物品數據的地方。遊戲裡所有可能出現的物品資料都必須要寫在這裡。[w]
[主角 face="M102A11"]
item_data.tjs可以用記事本打開。[lr]
每一個[font color="0xFF0000"][ch text=" %["][resetfont]和[font color="0xFF0000"][ch text="],"][resetfont]
之間的內容，就是一個物品的數據。[w]
[主角 face="M102A11"]
包括名稱（name），圖標（icon），介紹文字（intro），是否可食（eat）四個參數。[w]
[主角 face="M102A31"]
其中是否可食用這個……純屬惡趣味，也不是必須參數，我們可以先無視他。[w]
[主角 face="M102A11"]
只要你按照這樣的格式填寫物品數據，之後就可以用additem把這些物品增加到擁有的物品列表裡了。[w]
[nowait]
[font color="0xFF0000"][ch text=" %["][resetfont]
		[ch text="'name'=>'物品名',"][r]
		[ch text="'icon'=>'圖標',"][r]
		[ch text="'intro'=>'文字介紹',"]
[font color="0xFF0000"][ch text="],"][resetfont]
[endnowait]
[w]
[主角 face="M102A11"]
物品名稱需要是唯一的，因為系統要通過物品名稱來查找其他的資料，例如圖標等等並顯示在界面上。[w]

*datafunction
[主角 face="M102A11"]
而macro_item.ks所作的事情，就是讀入這些物品數據，並且封裝了增加減少物品等等的宏。[w]
[主角 face="M102A11"]
這部分是完全不需要修改就可以使用的代碼，所以不細講太多了。請打開macro_item.ks自己看註釋吧。[w]

*ui
[主角 face="M102A11"]
重點要講的是如何修改物品界面讓它符合你的遊戲。[w]
[主角 face="M102A11"]
首先必須要瞭解的就是macro_item_ui.ks裡定義了所有物品界面相關的宏，而other.ks則負責調用這些宏，把界面顯示出來。[w]
[主角 face="M102A11"]
在充分理解了這一點之後，再繼續下去。[w]
[主角 face="M102A11"]
通常需要修改的地方就是「翻頁按鈕，返回按鈕」的外觀和坐標，還有「當前翻到第幾頁」的文字。[w]
[主角 face="M102A11"]
再來就是「每頁顯示多少個物品」，「顯示的位置」，「物品按鈕之間的間距」。[w]
[主角 face="M102A11"]
最後是「物品按鈕本身的外觀」「當鼠標移動到物品上時，會顯示的詳細信息」。[w]

*changeui
[nowait]
[link target=*page]·翻頁按鈕，頁數顯示[endlink][r]
[link target=*item]·物品列表的外觀[endlink][r]
[link target=*data]·物品按鈕和移動上去顯示的效果[endlink][r]
[link target=*final]·繼續講解[endlink]
[endnowait]
[s]

*page
[主角 face="M102A11"]
翻頁按鈕，頁數顯示的宏在macro_item_ui.ks的第228行，名叫[font color="0xFF0000"]item_page[resetfont]的宏。[w]
[主角 face="M102A11"]
通過修改button的normal和over屬性的圖片，可以改變翻頁按鈕的外形。[lr]
通過修改locate的x和y屬性的數值，可以改變坐標。[w]
[主角 face="M102A11"]
至於頁數顯示，則是通過ptext這一行來進行的。[lr]
ptext的作用是在圖片層上顯示文字。[w]
[主角 face="M102A11"]
可以通過修改ptext的x，y來改變坐標，color，size來改變顏色和文字大小，text來改變文字的內容。[w]
[主角 face="M102A11"]
現在裡面包含了兩個變數，
[font color="0xFF0000"]f.當前物品頁[resetfont]
代表當前翻到的頁數，
[font color="0xFF0000"]f.物品總頁數[resetfont]
代表現在擁有的物品列表一共有幾頁。[w]
[主角 face="M102A11"]
除了變數以外的文字，用''（單引號）括起來即可。[w]
[主角 face="M102A11"]
例如你也可以寫成[r]
[ch text="[ptext text=&('第'+f.當前物品頁+'頁')]"][lr]
這樣的話，就會顯示「第N頁」的字樣。[w]
[jump target=*changeui]

*item
[主角 face="M102A11"]
「每頁顯示多少個物品」，「顯示的位置」，「物品按鈕之間的間距」，這幾個是通過函數設定的。[w]
[主角 face="M102A11"]
第18行，名叫[font color="0xFF0000"]draw_item()[resetfont]的函數。[lr]
具體的作用是通過循環，批量地顯示一整頁的物品。[w]
[主角 face="M102A31"]
【修改排版的位置】已經用註釋標記出來了，修改這裡的數值就能改變物品界面的排版。[w]
[jump target=*changeui]

*data
[主角 face="M102A11"]
最後是「物品按鈕本身的外觀」「當鼠標移動到物品上時，會顯示的詳細信息」。[w]
[主角 face="M102A11"]
其中物品按鈕的外觀，是通過第72行，[r]
名叫[font color="0xFF0000"]draw_item_button()[resetfont]的函數設定的。[w]
[主角 face="M102A11"]
它同時還負責設定點下按鈕後跳轉到的標籤等等。[w]
[主角 face="M102A11"]
修改物品按鈕外觀的是第78行和79行。[w]
[主角 face="M102A11"]
物品按鈕上顯示的「物品名稱」和「物品數量」，是由98行的函數[font color="0xFF0000"]draw_item_name()[resetfont]負責的。[w]
其中每個[font color="0xFF0000"]mybutton.drawText()[resetfont]裡面的
[font color="0xD1BEA0"]0xD1BEA0[resetfont]代表按鈕不同狀態下的文字顏色，可以隨意修改成自己喜歡的顏色。[w]
[主角 face="M102A11"]
至於鼠標移動上去的效果，則是128行以後的懸停函數負責。[w]
[主角 face="M102A11"]
[font color="0xFF0000"]draw_item_icon()[r]
draw_item_elm()[r]
draw_item_exp()[resetfont][w]

[主角 face="M102A32"]
以上三個，可以通過修改裡面的坐標等來達到改變界面佈局的目的。[w]
[主角 face="M102A11"]
圖標的位置在140和141行，解釋的排版則在189到193行修改。[w]
[主角 face="M102A11"]
對不需要顯示的內容，可以通過在這一行前面加上//來把它註釋掉。[w]
[主角 face="M102A11"]
例如註釋掉148行，那麼就不會顯示是否可食用字樣。[w]
[主角 face="M102A11"]
註釋137-142行，不顯示圖標。註釋151行，不顯示物品解釋。[w]
[jump target=*changeui]

*final
[主角 face="M102A11"]
最後，other.ks的第13行可以修改道具系統的背景圖片~這個應該沒問題了吧。[w]

[主角 face="M102A31"]
每當點下一個物品按鈕以後，變數[font color="0xFF0000"]f.選擇物品編號[resetfont]的值會被帶入物品的編號。[w]
[主角 face="M102A11"]
這個編號是指在[font color="0xFF0000"]f.item[resetfont]，也就是你當前擁有的物品數組裡，這個物品的排列位置。[w]
[主角 face="M102A11"]
可以通過[font color="0xFF0000"][ch text="f.item[f.選擇物品編號]"][resetfont]來取得這個物品的具體數據。[w]
[主角 face="M102A11"]
[font color="0xFF0000"][ch text="f.item[f.選擇物品編號].name"][resetfont]代表物品名稱，[r]
[font color="0xFF0000"][ch text="f.item[f.選擇物品編號].num"][resetfont]代表物品數量，[r]
[font color="0xFF0000"][ch text="f.item[f.選擇物品編號].intro"][resetfont]代表物品介紹。[w]

[主角 face="M102A11"]
接著會跳轉到other.ks的[font color="0xFF0000"]*使用物品[resetfont]標籤。[w]
[主角 face="M102A11"]
可以通過取得的值，做一些條件分歧，然後對物品進行操作。[w]
[主角 face="M102A31"]
例如對可以吃的物品，每次點下按鈕就減少一個。[w]
[主角 face="M102A32"]
或者根據物品名字的不同，使用物品會產生不同的效果（增加、減少HP之類的……）。[w]
[主角 face="M102A31"]
希望以上的講解可以讓你更快地看懂整個道具系統範例。[w]
[主角 face="M102A11"]
不過，如果變數，數組，字典，宏，函數之類的概念不清楚的話……[w]
[主角 face="M102A31"]
那我也沒辦法啦，請老實地從吉裡吉裡基礎學起吧！[w]
[主角 face="M102A11"]
今天就到這裡，拜拜~[w]

[gotostart ask="false"]
