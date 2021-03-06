;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;-------------------------------------------------------------------
;指令按钮选择窗口
;-------------------------------------------------------------------
*window
[locklink]
[rclick enabled=true jump=true call="false" target=*关闭选单]
;描绘窗体底板
[eval exp="drawWin(kag.fore.layers[3],kag.fore.messages[3],'指令选择',640,480)"]
;描绘关闭按钮
[current layer="message3"]
[er]
[nowait]
[locate x=&"640-23" y=6]
[button normal=close-square-outline target=*关闭选单]
;[eval exp="drawButtonCaption('×')"]

[iscript]
drawFrame("图象",5,15,40,kag.fore.layers[3],140);

drawFrame("对话",5,170,40,kag.fore.layers[3],140);

drawFrame("音声",5,325,40,kag.fore.layers[3],140);

drawFrame("选项",5,480,40,kag.fore.layers[3],140);

[endscript]
;图像
[button_tag x=35 y=65 name="显示背景" exp="f.参数.tagname='bg'"]
[button_tag x=35 y=95 name="显示人物" exp="f.参数.tagname='fg'"]
[button_tag x=35 y=125 name="显示头像" exp="f.参数.tagname='face'"]
[button_tag x=35 y=155 name="消除背景" exp="f.参数.tagname='clbg'"]
[button_tag x=35 y=185 name="消除人物" exp="f.参数.tagname='clfg'"]
;对话
[button_tag x=190 y=65 name="话框样式" exp="f.参数.tagname='dia'"]
[button_tag x=190 y=95 name="显示对话" exp="f.参数.tagname='_talk'"]
[button_tag x=190 y=125 name="等待时间" exp="f.参数.tagname='wait'"]
[button_tag x=190 y=155 name="事件跳转" exp="f.参数.tagname='jump'"]
[button_tag x=190 y=185 name="插入标签" exp="f.参数.tagname='_label'"]
;音声
[button_tag x=345 y=65 name="播放音乐" exp="f.参数.tagname='bgm'"]
[button_tag x=345 y=95 name="播放音效" exp="f.参数.tagname='se'"]
[button_tag x=345 y=125 name="等待音效" exp="f.参数.tagname='ws'"]
[button_tag x=345 y=155 name="停止音乐" exp="f.参数.tagname='fadeoutbgm'"]
[button_tag x=345 y=185 name="停止音效" exp="f.参数.tagname='stopse'"]

;选项
;[button_tag x=500 y=65 name="添加选择" exp="f.参数.tagname='seladd'"]
;[button_tag x=500 y=95 name="等待选择" exp="f.参数.tagname='select'"]
;[button_tag x=500 y=125 name="选项结束" exp="f.参数.tagname='seldone'"]
;[button_tag x=500 y=95 name="按钮位置" exp="f.参数.tagname='locate'"]

[button_tag x=500 y=65 name="准备选项" exp="f.参数.tagname='selstart'"]
[button_tag x=500 y=95 name="按钮位置" exp="f.参数.tagname='locate'"]
[button_tag x=500 y=125 name="选项按钮" exp="f.参数.tagname='selbutton'"]
[button_tag x=500 y=155 name="等待选项" exp="f.参数.tagname='selend'"]
[button_tag x=500 y=185 name="消除选项" exp="f.参数.tagname='clsel'"]

[locate x=15 y=230]
[button normal="edit_button_page" exp="tf.指令页面=void" target=*window]
[eval exp="drawButtonCaption('图形动画')"]
[locate x=85 y=230]
[button normal="edit_button_page" exp="tf.指令页面=1" target=*window]
[eval exp="drawButtonCaption('变数系统')"]

;--------------------------------------------------------------------------------------
[if exp="tf.指令页面==void"]

[iscript]
//描绘栏框
drawTagBoard();
[endscript]
;杂项
[button_tag x=35 y=295 name="画面震动" exp="f.参数.tagname='quake'"]
[button_tag x=35 y=325 name="等待震动" exp="f.参数.tagname='wq'"]

[button_tag x=35 y=385 name="图片位移" exp="f.参数.tagname='movepos'"]
[button_tag x=35 y=415 name="天气效果" exp="f.参数.tagname='raininit'"]

;动态
[button_tag x=190 y=295 name="动态效果" exp="f.参数.tagname='action'"]
[button_tag x=190 y=325 name="等待动态" exp="f.参数.tagname='wact'"]
[button_tag x=190 y=355 name="停止动态" exp="f.参数.tagname='stopaction'"]
[button_tag x=190 y=385 name="播放视频" exp="f.参数.tagname='mv'"]
[button_tag x=190 y=415 name="播放语音" exp="f.参数.tagname='vo'"]

;trans
[button_tag x=345 y=295 name="准备切换" exp="f.参数.tagname='backlay'"]
[button_tag x=345 y=325 name="载入图片" exp="f.参数.tagname='image'"]
[button_tag x=345 y=355 name="卸载图片" exp="f.参数.tagname='freeimage'"]
[button_tag x=345 y=385 name="执行切换" exp="f.参数.tagname='trans'"]
[button_tag x=345 y=415 name="等待切换" exp="f.参数.tagname='wt'"]

;map/other
[button_tag x=500 y=295 name="调用地图" exp="f.参数.tagname='map'"]
[button_tag x=500 y=325 name="消除地图" exp="f.参数.tagname='clmap'"]

[button_tag x=500 y=385 name="调用面板" exp="f.参数.tagname='edu'"]
[button_tag x=500 y=415 name="消除面板" exp="f.参数.tagname='cledu'"]

;--------------------------------------------------------------------------------------
[else]
[iscript]
//描绘栏框
drawTagBoard(70);
[endscript]
;变数
[button_tag x=35 y=295 name="操作变数" exp="f.参数.tagname='eval'"]
[button_tag x=35 y=325 name="显示变数" exp="f.参数.tagname='emb'"]

[button_tag x=35 y=355 name="创建分歧" exp="f.参数.tagname='newif'"]
[button_tag x=35 y=385 name="条件分歧" exp="f.参数.tagname='if'"]
[button_tag x=35 y=415 name="分歧结束" exp="f.参数.tagname='endif'"]

[button_tag x=190 y=295 name="对话速度" exp="f.参数.tagname='nowait'"]
[button_tag x=190 y=325 name="段落样式" exp="f.参数.tagname='style'"]
[button_tag x=190 y=355 name="消除对话" exp="f.参数.tagname='er'"]
[button_tag x=190 y=385 name="登录CG" exp="f.参数.tagname='addcg'"]
[button_tag x=190 y=415 name="登录结局" exp="f.参数.tagname='addend'"]

;系统/流程
[button_tag x=345 y=295 name="离开游戏" exp="f.参数.tagname='close'"]
[button_tag x=345 y=325 name="历史记录" exp="f.参数.tagname='history'"]

[button_tag x=345 y=385 name="呼叫事件" exp="f.参数.tagname='call'"]
[button_tag x=345 y=415 name="呼叫返回" exp="f.参数.tagname='return'"]

;文本/指令
[button_tag x=500 y=295 name="编辑文本" exp="f.参数.tagname='_msg'"]
[button_tag x=500 y=325 name="直接输入" exp="f.参数.tagname='_blank'"]

[button_tag x=500 y=385 name="TJS段落" exp="f.参数.tagname='iscript'"]
[button_tag x=500 y=415 name="插入注释" exp="f.参数.tagname='_remark'"]

[endif]
;--------------------------------------------------------------------------------------

;[button_tag x=345 y=415 name="*系统选单" exp="f.参数.tagname='system'"]
;[button_tag x=35 y=385 name="*播放影片" exp="f.参数.tagname='movie'"]
;[button_tag x=35 y=415 name="*图层设定" exp="f.参数.tagname='layopt'"]
;[button_tag x=500 y=415 name="*登陆CG" exp="f.参数.tagname='getcg'"]

;;按钮/输入
;[button_tag x=345 y=295 name="*普通按钮" exp="f.参数.tagname='button'"]
;[button_tag x=345 y=325 name="*文字连接" exp="f.参数.tagname='links'"]
;[button_tag x=345 y=355 name="*输入框" exp="f.参数.tagname='edit'"]
;[button_tag x=345 y=385 name="*等待输入" exp="f.参数.tagname='s'"]
;[button_tag x=345 y=415 name="*确认输入" exp="f.参数.tagname='commit'"]

;[button_tag x=35 y=415 name="*播放影片" exp="f.参数.tagname='movie'"]
;[button_tag x=190 y=415 name="消除文字" exp="f.参数.tagname='er'"]
[s]

;------------------------------------------------------
;给tagname设好默认值后打开对应窗口
;------------------------------------------------------
*打开指令窗口
[if exp="f.target[f.参数.tagname]!=void"]
[call storage="&('tag_'+f.target[f.参数.tagname]+'.ks')"]
[else]
[call storage="tag_direct.ks"]
[endif]

[jump storage="window_tag.ks"]

*关闭选单
[iscript]
//假如是为最后一行加入的空白行,直接删除
if (f.script[f.当前脚本行].tagname=="_blank" && f.script[f.当前脚本行+1].tagname=="_end")
{
     deleteLine();
}
[endscript]
[rclick enabled="false"]
[freeimage layer="3"]
[freeimage layer="4"]
[current layer="message3"]
[er]
[layopt layer="message3" visible="false"]
[jump storage="gui_script.ks" target=*window]
