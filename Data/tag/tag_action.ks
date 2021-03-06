;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
*window
[window_middle width=400 height=480 title="动态效果"]
[eval exp="drawFrame('基本信息',3,15,40,kag.fore.layers[5],314)"]
[line title="编号" name="f.参数.layer" x=30 y=60 type=list target="*选择图层"]
[line title="时间" name="f.参数.time" x=30 y=90]
[line title="延迟" name="f.参数.delay" x=30 y=120]

[eval exp="drawFrame('效果设定',5,15,175,kag.fore.layers[5],314)"]
[line title="效果" name="f.参数.module" x=30 y=190 type=list target="*选择效果"]
;----------------------------------------------------------------------------------------------
;移动动作组
[if exp="f.参数.module=='LayerNormalMoveModule' || f.参数.module=='LayerAccelMoveModule' || f.参数.module=='LayerDecelMoveModule'"]
[line title="目标坐标" x=30 y=220]
[pos valuex="f.参数.x" valuey="f.参数.y" x=45 y=250]
[endif]
[if exp="f.参数.module=='LayerParabolaMoveModule'"]
[line title="顶点坐标" x=30 y=220]
[pos valuex="f.参数.x" valuey="f.参数.y" x=45 y=250]
[line title="顶点时间" name="f.参数.toptime" x=30 y=310]
[endif]
;----------------------------------------------------------------------------------------------
;往返运动动作组
[if exp="f.参数.module=='LayerVibrateActionModule'"]
[line title="振动设定" x=30 y=220]
[line title="振幅" name="f.参数.vibration" x=30 y=250]
[line title="间隔时间" name="f.参数.waittime" x=30 y=280]
[endif]

[if exp="f.参数.module=='LayerFallActionModule'"]
[line title="落下设定" x=30 y=220]
[line title="距离" name="f.参数.distance" x=30 y=250]
[line title="时间" name="f.参数.falltime" x=30 y=280]
[endif]

[if exp="f.参数.module=='LayerJumpActionModule' || f.参数.module=='LayerJumpOnceActionModule' || f.参数.module=='LayerWaveActionModule' || f.参数.module=='LayerWaveOnceActionModule'"]
[line title="振动设定" x=30 y=220]
[line title="振幅" name="f.参数.vibration" x=30 y=250]
[line title="周期时间" name="f.参数.cycle" x=30 y=280]
[endif]
;----------------------------------------------------------------------------------------------
;放大，缩小动作组
[if exp="f.参数.module=='LayerNormalZoomModule' || f.参数.module=='LayerHeartBeatZoomModule'"]
[line title="缩放设定" x=30 y=220]
[line title="放大率" name="f.参数.zoom" x=30 y=250]
[endif]

[if exp="f.参数.module=='LayerVRotateZoomModule' || f.参数.module=='LayerHRotateZoomModule'"]
[line title="3D变形设定" x=30 y=220]
[line title="角速度" name="f.参数.angvel" x=30 y=250]
[endif]

[if exp="f.参数.module=='LayerVibrateZoomModule'"]
[line title="缩放振动设定" x=30 y=220]
[line title="振幅" name="f.参数.vibration" x=30 y=250]
[line title="间隔时间" name="f.参数.waittime" x=30 y=280]
[endif]
;----------------------------------------------------------------------------------------------
;旋转动作组
[if exp="f.参数.module=='LayerNormalRotateModule'"]
[line title="旋转设定" x=30 y=220]
[line title="角速度" name="f.参数.angvel" x=30 y=250]
[endif]

[if exp="f.参数.module=='LayerVibrateRotateModule'"]
[line title="振动旋转设定" x=30 y=220]
[line title="振幅" name="f.参数.vibration" x=30 y=250]
[line title="周期时间" name="f.参数.cycle" x=30 y=280]
[endif]

[if exp="f.参数.module=='LayerFalldownRotateModule' || f.参数.module=='LayerToRotateModule'"]
[line title="指定角度" x=30 y=220]
[line title="角度" name="f.参数.angle" x=30 y=250]
[endif]
;----------------------------------------------------------------------------------------------
;渐变动作组
[if exp="f.参数.module=='LayerBlinkModeModule'"]
[line title="闪烁设定" x=30 y=220]
[line title="显示时间" name="f.参数.showtime" x=30 y=250]
[line title="消失时间" name="f.参数.hidetime" x=30 y=280]
[endif]

[if exp="f.参数.module=='LayerFadeModeModule'"]
[line title="渐变设定" x=30 y=220]
[line title="渐入时间" name="f.参数.intime" x=30 y=250]
[line title="渐出时间" name="f.参数.outtime" x=30 y=280]
[endif]

[if exp="f.参数.module=='LayerFadeToModeModule'"]
[line title="透明设定" x=30 y=220]
[line title="透明度" name="f.参数.opacity" x=30 y=250]
[endif]
[s]

*确认
[commit]
[eval exp="commitLine(f.参数)"]
[jump storage="tag_direct.ks" target=*擦除窗口]

*关闭选单
[jump storage="tag_direct.ks" target=*关闭选单]
;-----------------------------------------------------------------
*选择图层
[list_layer x=34 y=50]
[s]

*关闭下拉菜单
[rclick enabled="false"]
[current layer="message6"]
[er]
[layopt layer="message6" visible="false"]
[jump target=*window]
;-----------------------------------------------------------------
*选择效果
[commit]
[list x=34 y=190 line=16 layer="message6"]
[font color="0xFF8080"][emb exp="getTransStr('移动')"][resetfont][r]
[link target=*关闭下拉菜单 exp="f.参数.module='LayerNormalMoveModule'"][emb exp="getTransStr('通常移动')"][endlink] 
[link target=*关闭下拉菜单 exp="f.参数.module='LayerAccelMoveModule'"][emb exp="getTransStr('加速移动')"][endlink]
[r]
[link target=*关闭下拉菜单 exp="f.参数.module='LayerDecelMoveModule'"][emb exp="getTransStr('减速移动')"][endlink] 
[link target=*关闭下拉菜单 exp="f.参数.module='LayerParabolaMoveModule'"][emb exp="getTransStr('抛物线移动')"][endlink]
[r]
[font color="0xFF8080"]往返运动[resetfont][r]
[link target=*关闭下拉菜单 exp="f.参数.module='LayerVibrateActionModule'"][emb exp="getTransStr('振动动作')"][endlink] 
[link target=*关闭下拉菜单 exp="f.参数.module='LayerFallActionModule'"][emb exp="getTransStr('落下动作')"][endlink]
[r]
[link target=*关闭下拉菜单 exp="f.参数.module='LayerJumpActionModule'"][emb exp="getTransStr('上下振动')"][endlink] 
[link target=*关闭下拉菜单 exp="f.参数.module='LayerJumpOnceActionModule'"][emb exp="getTransStr('单次上下振动')"][endlink]
[r]
[link target=*关闭下拉菜单 exp="f.参数.module='LayerWaveActionModule'"][emb exp="getTransStr('左右振动')"][endlink] 
[link target=*关闭下拉菜单 exp="f.参数.module='LayerWaveOnceActionModule'"][emb exp="getTransStr('单次左右振动')"][endlink]
[r]
[font color="0xFF8080"]缩放变形[resetfont][r]
[link target=*关闭下拉菜单 exp="f.参数.module='LayerNormalZoomModule'"][emb exp="getTransStr('单纯缩放')"][endlink] 
[link target=*关闭下拉菜单 exp="f.参数.module='LayerVibrateZoomModule'"][emb exp="getTransStr('缩放振动')"][endlink]
[r]
[link target=*关闭下拉菜单 exp="f.参数.module='LayerVRotateZoomModule'"][emb exp="getTransStr('3D纵轴')"][endlink] 
[link target=*关闭下拉菜单 exp="f.参数.module='LayerHRotateZoomModule'"][emb exp="getTransStr('3D横轴')"][endlink] 
[link target=*关闭下拉菜单 exp="f.参数.module='LayerHeartBeatZoomModule'"][emb exp="getTransStr('心跳')"][endlink]
[r]
[font color="0xFF8080"]旋转[resetfont][r]
[link target=*关闭下拉菜单 exp="f.参数.module='LayerNormalRotateModule'"][emb exp="getTransStr('单纯旋转')"][endlink] 
[link target=*关闭下拉菜单 exp="f.参数.module='LayerVibrateRotateModule'"][emb exp="getTransStr('旋转振动')"][endlink]
[r]
[link target=*关闭下拉菜单 exp="f.参数.module='LayerFalldownRotateModule'"][emb exp="getTransStr('旋转倒下')"][endlink] 
[link target=*关闭下拉菜单 exp="f.参数.module='LayerToRotateModule'"][emb exp="getTransStr('到指定角度')"][endlink]
[r]
[font color="0xFF8080"]渐变[resetfont][r]
[link target=*关闭下拉菜单 exp="f.参数.module='LayerBlinkModeModule'"][emb exp="getTransStr('闪烁效果')"][endlink] 
[link target=*关闭下拉菜单 exp="f.参数.module='LayerFadeModeModule'"][emb exp="getTransStr('渐入渐出')"][endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.module='LayerFadeToModeModule'"][emb exp="getTransStr('改变透明度')"][endlink]
[s]

