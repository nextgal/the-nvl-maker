;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
[iscript]
if (f.參數.left!=void || f.參數.top!=void)
{
   f.參數.locate=true;
}
if (f.參數.rceil==0 && f.參數.gceil==0 && f.參數.bceil==0 && f.參數.rfloor==255 && f.參數.gfloor==255 &&  f.參數.gfloor==255)
{
   f.參數.convert=true;
}
if (f.參數.visible==void)
{
   f.參數.visible=true;
}
if (f.參數.layer==void)
{
   f.參數.layer="stage";
}
if (f.參數.storage==void)
{
   f.參數.storage="empty";
}
[endscript]

*window
[window_middle width=690 height=430 title="載入圖片"]
[eval exp="drawFrame('基本信息',3,15,40,kag.fore.layers[5],314)"]
[line title="圖片" name="f.參數.storage" x=30 y=60 type="pic" path="bgimage"]
[line title="編號" name="f.參數.layer" x=30 y=90 type=list target="*選擇圖層"]
[line title="載入" name="f.參數.page" x=30 y=120 type=list target="*選擇頁"]

[eval exp="drawFrame('位置設定',6,15,175,kag.fore.layers[5],314)"]
[group title="居中" name="f.參數.pos" x=30 y=190 comp="center"]
[group title="居左" name="f.參數.pos" x=120 y=190 comp="left"]
[group title="居右" name="f.參數.pos" x=210 y=190 comp="right"]
[check title="直接指定" name="f.參數.locate" x=30 y=220]
[pos valuex="f.參數.left" valuey="f.參數.top" x=30 y=250 true="f.參數.locate"]

[check title="圖層可見" name="f.參數.visible" x=30 y=345]

[eval exp="drawFrame('特殊效果',3,345,40,kag.fore.layers[5],314)"]
[check title="黑白" name="f.參數.grayscale" x=360 y=60]
[check title="反色" name="f.參數.convert" x=500 y=60]
[line title="蒙板色" name="f.參數.mcolor" x=360 y=90 type="color"]
[line title="蒙板透明度" name="f.參數.mopacity" x=360 y=120]

[eval exp="drawFrame('其他參數',3,345,175,kag.fore.layers[5],314)"]
[line title="模式" name="f.參數.mode" x=360 y=190 type=list target="*顯示模式"]
[line title="透明" name="f.參數.opacity" x=360 y=220]
[check title="上下反轉" name="f.參數.flipud" x=360 y=255]
[check title="左右反轉" name="f.參數.fliplr" x=500 y=255]
[s]

*確認
[commit]
[iscript]
if (f.參數.locate==false)
{
   f.參數.left=void;
   f.參數.top=void;
}
f.參數.locate=void;
//-------------------------------------
if (f.參數.convert==true)
{
   with(f.參數)
   {
      .rceil=0;
      .gceil=0;
      .bceil=0;
      .rfloor=255;
      .bfloor=255;
      .gfloor=255;
      .convert=void;
   }
}
else
{
   with(f.參數)
   {
      .rceil=void;
      .gceil=void;
      .bceil=void;
      .rfloor=void;
      .bfloor=void;
      .gfloor=void;
      .convert=void;
   }
}
//-------------------------------------

[endscript]
[eval exp="commitLine(f.參數)"]
[jump storage="tag_direct.ks" target=*擦除窗口]

*關閉選單
[jump storage="tag_direct.ks" target=*關閉選單]
;-----------------------------------------------------------------
*選擇圖層
[list_layer x=34 y=90]
[s]

*選擇頁
[list_page x=34 y=120]
[s]

*關閉下拉菜單
[rclick enabled="false"]
[current layer="message6"]
[er]
[layopt layer="message6" visible="false"]
[jump target=*window]
;-----------------------------------------------------------------
*選擇圖片
[call storage="window_picture.ks"]
[jump target=*window]

*選擇顏色
[call storage="window_color.ks"]
[jump target=*window]
;-----------------------------------------------------------------
*顯示模式
[commit]
[list x=364 y=190 line=16 layer="message6"]
[link target=*關閉下拉菜單 exp="f.參數.mode='alpha'"]一般透過（默認）[endlink][r]
[link target=*關閉下拉菜單 exp="f.參數.mode='opaque'"]完全不透過[endlink][r]
[link target=*關閉下拉菜單 exp="f.參數.mode='addalpha'"]加算透過[endlink][r]

[link target=*關閉下拉菜單 exp="f.參數.mode='psadd'"]PS加算[endlink][r]
[link target=*關閉下拉菜單 exp="f.參數.mode='pssub'"]PS減算[endlink][r]
[link target=*關閉下拉菜單 exp="f.參數.mode='psmul'"]PS正片疊底[endlink][r]

[link target=*關閉下拉菜單 exp="f.參數.mode='psscreen'"]PS屏幕[endlink][r]
[link target=*關閉下拉菜單 exp="f.參數.mode='psoverlay'"]PS疊加[endlink][r]

[link target=*關閉下拉菜單 exp="f.參數.mode='pshlight'"]PS強光[endlink][r]
[link target=*關閉下拉菜單 exp="f.參數.mode='psslight'"]PS柔光[endlink][r]

[link target=*關閉下拉菜單 exp="f.參數.mode='psdodge'"]PS減淡[endlink][r]
[link target=*關閉下拉菜單 exp="f.參數.mode='psburn'"]PS加深[endlink][r]
[link target=*關閉下拉菜單 exp="f.參數.mode='pslighten'"]PS變亮[endlink][r]
[link target=*關閉下拉菜單 exp="f.參數.mode='psdarken'"]PS變暗[endlink][r]
[link target=*關閉下拉菜單 exp="f.參數.mode='psdiff'"]PS差值[endlink][r]
[link target=*關閉下拉菜單 exp="f.參數.mode='psexcl'"]PS排除[endlink]
[s]
