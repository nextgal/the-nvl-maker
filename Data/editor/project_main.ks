;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;---------------------------------------------------------------
;游戏工程设定
;---------------------------------------------------------------
*start
[iscript]
//每次切换到此画面时，重载
f.setting=getConfig();
[endscript]

*window
[eval exp="drawPageBoard()"]
;---------------------------------------------------------------
[unlocklink]
[current layer="message1"]
[er]
[nowait]
;---------------------------------------------------------------
;自定义
;---------------------------------------------------------------
[frame title="系统设定" line=3 x=15 y=15]
[line title="标题" name="f.setting.title" x=30 y=35]
[line title="启动画面" name="f.setting.startfrom" type="script" x=30 y=65]
[line title="预览字体" name="f.setting.fontface" type="font" x=30 y=95]

;[iscript]
;
;if (f.setting.defaultfont==void)
;{
;	f.setting.defaultfont=%[];
;	f.setting.defaultfont.height=24;
;	f.setting.defaultfont.color="0xFFFFFF";
;}
;
;[endscript]
;[frame title="预览样式" x=345 y=15 line=5]
;[line title="字号" name="f.setting.defaultfont.height" x=360 y=35]
;[line title="颜色" name="f.setting.defaultfont.color" type="color" x=360 y=65]
;[line title="预渲染" name="f.setting.defaultfont.tft" x=360 y=95]

;---------------------------------------------------------------
;保存与重载按钮
;---------------------------------------------------------------
[frame title="记录" line=1 x=15 y=274]
[locate x=50 y=300]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*保存设定]
[eval exp="drawButtonCaption('保存设定',16)"]
[locate x=190 y=300]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*放弃修改]
[eval exp="drawButtonCaption('放弃修改',16)"]
[s]

*选择音声
[call storage="window_bgm.ks"]
[jump target=*window]

*选择文件
[call storage="window_file.ks"]
[jump target=*window]

*选择图片
[call storage="window_picture.ks"]
[jump target=*window]

*选择颜色
[call storage="window_color.ks"]
[jump target=*window]

*选择字体
[call storage="window_font.ks"]
[jump target=*window]

*关闭下拉菜单
[rclick enabled="false"]
[current layer="message4"]
[er]
[layopt layer="message4" visible="false"]
[jump target=*window]

*保存设定
[commit]
[iscript]
//保存自定义内容
//保存字典
SaveDic(f.setting,"setting.tjs");

//保存config.tjs内容
saveConfig();

 //重写start.ks.从新标题启动
 rewriteStart(f.setting.startfrom);

[endscript]
[jump target=*window]

*放弃修改
[iscript]
//重载
f.setting=getConfig();
[endscript]
[jump target=*window]
