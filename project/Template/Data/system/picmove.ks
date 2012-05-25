;------------------------------------------------
;picmover-背景循環移動插件
;by karryngai
;http://kcddp.keyfc.net/bbs/viewthread.php?tid=331&extra=page%3D1
;------------------------------------------------

;這個東西是用來實現背景循環地移動的，可以向不同的角度移動
;主要是在角色步行時或進入緊張氛圍時使用
;背景最後設置成頭尾可相接的循環，當分辨率是800*600時，圖片最好設在1000*1000以上，當分辯率是640*480時，圖片最好設在800*800以上，也就是矩形的對角線長度，主要是因為角度的問題
;
;@picmover layer=1 storage=picmover angle=120 speed=30 accel=12 time=10000 canstop=false
;layer                所在層，注意不能設成是base的，否則會出錯誤，因為base層不能移動
;                如果不設置，就會自動創建一個新層，這時會加添一個index的參數，可以改變其層次，默認是1
;storage                圖片名
;angle                圖片轉了的角度，正數時逆時針旋轉，默認是0，移動方向朝上
;speed                圖片每秒移動的速度，單位是px/s，默認是100
;accel                加速度，可以設置成負數，速度變成負數後就會倒退回來，默認是0
;time                圖片運行的時間，時間一到，圖片就會停止，如果不設置，圖片就會無限運動下去，默認是void
;canstop                canstop=true時，如果你設置的加速度為負數，當速度變為0時，圖片就會停止，默認是false
;還有picmover有記憶能力，前面設置過參數了，參數就會保留下來，下次調用時可以不設置，除非你要去覆蓋它
;
;@stoppicmover
;停止運動的圖片
;
;@resumepicmover
;讓停止運動的圖片重新運動，運動時會恢復圖片停止前的狀態
;
;@clearpicmover
;清除圖片，如果圖片所在層是新層，必須要用此語句才能清除空間
;
;上面的語句同時和下面的語句運作
;@image layer=1 storage=loli visible=true left=300 top=200
;@action layer=1 module=LayerJumpActionModule vibration=30 cycle=3000
;便能實現背景移動，人物在走動的畫面

@if exp="typeof(global.picmover_object)=='undefined'"
@iscript

class PicMover{
        var window;
        var angle;
        var storage;
        var speed,accel,stopaccel;
        var templayer,targetlayer;
        var tw,th;
        var time;
        var thistime,lasttime,last,starttime;
        var l;
        var canstop;
        var newlayer;
        var stoppingtime;

        function PicMover(window){
                this.window=window;
        }

        function setOption(elm){
                l=0;

                angle=elm.angle!==void?+elm.angle:(angle!==void?angle:0);
                storage=elm.storage if elm.storage!==void;

                speed=elm.speed!==void?+elm.speed:(speed!==void?speed:100);
                accel=elm.accel!==void?+elm.accel:(accel!==void?accel:0);
                stopaccel=elm.stopaccel!==void?+elm.stopaccel:(stopaccel!==void?stopaccel:0);

                time=elm.time!==void?+elm.time:(time!==void?time:void);

                canstop=elm.canstop!==void?elm.canstop:(canstop!==void?canstop:false);

                newlayer=false;
                if(elm.layer!==void){
                        targetlayer=window.getLayerFromElm(elm);
                        newlayer=true;
                }
                else if(targetlayer==void)
                        targetlayer=new AffineLayer(window,window.primaryLayer);
        }

        function initMove(){
                if(templayer==void)
                        templayer=new Layer(window,window.primaryLayer);

                templayer.loadImages(storage);

                tw=templayer.imageWidth;
                th=templayer.imageHeight;
                
                var pw=window.primaryLayer.width,ph=window.primaryLayer.height;
                targetlayer.setPos((pw-tw)/2,(ph-th)/2,tw,th);
                targetlayer.visible=true;
        }

        function startMove(elm){
                setOption(elm);
                initMove();
                
                starttime=last=System.getTickCount();
                System.addContinuousHandler(handler);
        }

        function handler(tick){
                thistime=(tick-starttime)/1000.0;
                lasttime=(last-starttime)/1000.0;
                last=tick;
                setAppearance();
        }

        function setAppearance(){
                l+=speed*(thistime-lasttime)+accel*(Math.pow(thistime,2)/2.0-Math.pow(lasttime,2)/2.0);
                l=l-(l\th)*th*1.0;
                if(l>=0){
                        targetlayer.copyRect(0,0,templayer,0,l,tw,th-l);
                        targetlayer.copyRect(0,th-l,templayer,0,0,tw,l);
                        targetlayer.rotate=angle;
                        targetlayer.update();
                }
                else{
                        targetlayer.copyRect(0,0,templayer,0,th+l,tw,-l);
                        targetlayer.copyRect(0,-l,templayer,0,0,tw,th+l);
                        targetlayer.rotate=angle;
                        targetlayer.update();
                }

                if(canstop && l<0) System.removeContinuousHandler(handler);

                if(time)
                        stopMove() if thistime>time/1000.0;
        }

        function stopMove(){
                stoppingtime=System.getTickCount();
                System.removeContinuousHandler(handler);
        }

        function resumeMove(){
                if(stoppingtime!==void){
                        var now=System.getTickCount();
                        starttime+=now-stoppingtime;
                        last+=now-stoppingtime;
                }
                System.addContinuousHandler(handler);
        }

        function clearMove(){
                System.removeContinuousHandler(handler);
                if(newlayer && targetlayer!==void) invalidate targetlayer;
                invalidate templayer if templayer!==void;
                targetlayer=templayer=void;
        }

        function finalize(){
                System.removeContinuousHandler(handler);
                if(newlayer && targetlayer!==void) invalidate targetlayer;
                invalidate templayer if templayer!==void;
                targetlayer=templayer=void;
        }
}
kag.addPlugin(global.picmover_object=new PicMover(kag));
@endscript
@endif

@macro name=picmover
@eval exp="global.picmover_object.startMove(mp)"
@endmacro

@macro name=stoppicmover
@eval exp="global.picmover_object.stopMove(mp)"
@endmacro

@macro name=resumepicmover
@eval exp="global.picmover_object.resumeMove(mp)"
@endmacro

@macro name=clearpicmover
@eval exp="global.picmover_object.clearMove(mp)"
@endmacro

@return
                                        
                
