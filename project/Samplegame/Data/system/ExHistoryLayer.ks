;// ExHistoryLayer.ks ( 2004/07/04 ) releaced 1.01
;// 履歷擴張 by  / 改變配布自由自在
;//
;// 注意約束。
;// 自己責任下使用。
;// 右內操作、履歷垂流。
;//
;// 使方。
;// 適當場所 [ call storage="" ] 
;// [ history ] 擴張 type 屬性追加。
;// [ history type = scroll  ] 操作形式
;// [ history type = default ] 吉裡吉裡標準形式
;// 任意切替可能、切替時既存履歷失點注意。
;//
;// 縱書橫書表示位置變關係上、
;// controlHeight值 0 固定設定。
;// 下文字隱、場合
;// Config.tjs => HistoryLayer_config() 內追加設定
;// ;marginT = 上端
;// ;marginB = 下端
;// ;marginL = 左端
;// ;marginR = 右端
;// 其值設定狀態是正。
;//
;// 1.00 -> 1.01
;// 名變更：RButtonLayer -> RapidFireButton
;// 標準添付 kag3plugin  rclick_tjs.ks 重複為變更。
;//
[if exp=" 'undefined' == typeof global.HistoryLayerExtended" ]
[iscript]
// 的仕組 HistoryLayer.tjs => LButtonLayer.class 同。
// 押 parent 送信 100ms 週期行。
//
class RapidFireButton extends ButtonLayer
{
	var timer;
	function RapidFireButton(window, parent)
	{
		super.ButtonLayer(window, parent);
		focusable = false;
		timer = new Timer( this , "repeat" );
		timer.interval = 100;
	}
	function onMouseDown(x, y, button, shift)
	{
		super.onMouseDown(...);
		if( Butt_mouseDown )
		{
			parent.onButtonClick(this);
			timer.enabled = true;
		}
	}
	function repeat()
	{
		if( Butt_mouseDown ) parent.onButtonClick(this);
		else timer.enabled = false;
	}
	function finalize()
	{
		super.finalize(...);
		invalidate timer;
	}
}
// 變更加場合變更加。
// ( width / height ) 適時變更點留意。
//
class Slider extends ButtonLayer
{
	var dragging;
	function Slider( win , par )
	{
		super.ButtonLayer( win , par );
	}
	function onMouseDown( x , y , button , shift )
	{
		super.onMouseDown(...);
		dragging = ( enabled && button == mbLeft );
	}
	function onMouseUp( x , y , button , shift )
	{
		super.onMouseUp(...);
		dragging = false;
	}
	function onMouseMove( x , y , shift )
	{
		super.onMouseMove(...);
		if( dragging ) parent.onSliderDragged( x , y );
	}
}
/*
interface Scrollbar.Target // 下記備關連付可能。
{
	function nextPage(); // nextPage/prevPage/nextLine/prevLine
	function prevPage(); // 各呼出、以外要因
	function nextLine(); // 表示位置 ( position ) 變化場合、
	function prevLine(); // Scrollbar.target  Scrollbar.updateState 呼出必要。
	function isHead();
	function isTail();
	property pageCount;  // setter實裝不要
	property lineCount;  // setter實裝不要
	property position;   // setter實裝不要 返值範圍 1.0（末尾） ～ 0.0（先頭） 實裝。
	property pagebypage; // setter實裝不要 返值 true 固定場合 nextLine/prevLine/lineCount 實裝不要。
}
*/
// 縱橫方向性持抽像。
// 縱方向/橫方向共通操作實裝。
//
class AbstractScrollbar extends Layer
{
	var target,timer;
	var prev,next;
	function AbstractScrollbar( win , par , tar )
	{
		super.Layer( win , par );
		target = tar;
		prev = new RapidFireButton( win , this );
		next = new RapidFireButton( win , this );
		prev.color   = 0x808080;
		next.color   = 0x808080;
		prev.visible = true;
		next.visible = true;
		hitType      = htMask;
		hitThreshold = 0;
	}
	function initState()
	{
		face = dfBoth;
		fillRect( 0 , 0 , width , height , 0xFF404040 );
	}
	function updateState()
	{
		prev.captionColor = ( prev.enabled = !target.isHead() ) ? 0xCCCCCC : 0x808080;
		next.captionColor = ( next.enabled = !target.isTail() ) ? 0xCCCCCC : 0x808080;
	}
	function onButtonClick( src )
	{
		if( src == prev ) target.prevPage(); else
		if( src == next ) target.nextPage();
	}
	function finalize()
	{
		invalidate prev if prev !== void;;
		invalidate next if next !== void;;
	}
}
// 縱方向。
//
class VerticalScrollbar extends AbstractScrollbar
{
	var slider;
	function VerticalScrollbar( win , par , tar )
	{
		super.AbstractScrollbar( win , par , tar );
		prev.caption = "▲";
		next.caption = "▼";
		slider = new Slider( win , this );
		slider.color = 0x808080;
		slider.visible = true;
	}
	// 矢印畫像讀迂場合↑↓變更。
	function initState()
	{
		super.initState(...);
		next.height = prev.height = width;
		prev.width  = next.width  = width;
		prev.left   = next.left   = 0;
		prev.top    = 0;
		next.top    = height - width;
		
		var btnlen    = ( ( height - next.height - prev.height ) / target.pageCount ) \ 1;
		slider.height = ( btnlen > 1 ) ? btnlen : 1;
		slider.width  = width;
		slider.left   = 0;
		slider.top    = prev.height + ( ( height - slider.height - next.height - prev.height ) * target.position ) \ 1;
	}
	function updateState()
	{
		super.updateState(...);
		slider.enabled = !( target.isHead() && target.isTail() );
		slider.top     = prev.height + ( ( height - slider.height - next.height - prev.height ) * target.position ) \ 1;
	}
	function onSliderDragged( x , y )
	{
		if( target.pagebypage )
		{
			var len = slider.height;
			if( y <             0 ){ for( var i = 0; i > ( ( y +             0 ) / len ) ; i-- ) target.prevPage(); } else
			if( y > slider.height ){ for( var i = 0; i < ( ( y - slider.height ) / len ) ; i++ ) target.nextPage(); }
		}
		else
		{
			var len = ( height - next.height - prev.height ) / target.lineCount;
			if( y <             0 ){ for( var i = 0; i > ( ( y +             0 ) / len ) ; i-- ) target.prevLine(); } else
			if( y > slider.height ){ for( var i = 0; i < ( ( y - slider.height ) / len ) ; i++ ) target.nextLine(); }
		}
	}
	// 上押際、 prev/next 押同等動作為仕組。
	var tmr; ( tmr = new Timer( this , "repeat" ) ).interval = 100;
	var dst;
	function scrollTo( value )
	{
		dst = value;
		tmr.enabled = true;
	}
	function repeat()
	{
		if( dst < slider.top                 ) ( target.pagebypage ) ? target.prevPage() : target.prevLine(); else
		if( dst > slider.top + slider.height ) ( target.pagebypage ) ? target.nextPage() : target.nextLine(); else
		tmr.enabled = false;
	}
	function onMouseDown( x , y , button , shift  )
	{
		super.onMouseDown(...);
		if( y < slider.top                 ){ ( target.pagebypage ) ? target.prevPage() : target.prevLine(); scrollTo( y ); } else
		if( y > slider.top + slider.height ){ ( target.pagebypage ) ? target.nextPage() : target.nextLine(); scrollTo( y ); }
	}
	function onMouseMove( x , y , shift )
	{
		if( tmr.enabled ) dst = y;
	}
	function onMouseUp( x , y , button , shift  )
	{
		tmr.enabled = false;
	}
	function finalize()
	{
		super.finalize(...);
		invalidate slider if slider !== void;
		invalidate tmr    if tmr    !== void;
	}
}
// 橫方向。
//
class HorizontalScrollbar extends AbstractScrollbar
{
	var prev,next,slider;
	var target;
	function HorizontalScrollbar( win , par , tar )
	{
		super.AbstractScrollbar( win , par , tar );
		prev.caption = "》";
		next.caption = "《";
		slider = new Slider( win , this );
		slider.color = 0x808080;
		slider.visible = true;
	}
	// 矢印畫像讀迂場合↑↓變更。
	function initState()
	{
		super.initState(...);
		next.height = prev.height = height;
		prev.width  = next.width  = height;
		prev.top    = next.top    = 0;
		prev.left   = width - height;
		next.left   = 0;
		
		var btnlen    = ( ( width - next.width - prev.width ) / target.pageCount ) \ 1;
		slider.height = height;
		slider.width  = ( btnlen > 1 ) ? btnlen : 1;
		slider.left   = next.width + ( ( width - slider.width - next.width - prev.width ) * ( 1 - target.position ) ) \ 1;
		slider.top    = 0;
	}
	function updateState()
	{
		super.updateState(...);
		slider.enabled = !( target.isHead() && target.isTail() );
		slider.left    = next.width + ( ( width - slider.width - next.width - prev.width ) * ( 1 - target.position ) ) \ 1;
	}
	function onSliderDragged( x , y )
	{
		if( target.pagebypage )
		{
			var len = slider.width;
			if( x <            0 ){ for( var i = 0; i > ( ( x +            0 ) / len ) ; i-- ) target.nextPage(); } else
			if( x > slider.width ){ for( var i = 0; i < ( ( x - slider.width ) / len ) ; i++ ) target.prevPage(); }
		}
		else
		{
			var len = ( width - next.width - prev.width ) / target.lineCount;
			if( x <            0 ){ for( var i = 0; i > ( ( x +            0 ) / len ) ; i-- ) target.nextLine(); } else
			if( x > slider.width ){ for( var i = 0; i < ( ( x - slider.width ) / len ) ; i++ ) target.prevLine(); }
		}
	}
	// 上押際、 prev/next 押同等動作為仕組。
	var tmr; ( tmr = new Timer( this , "repeat" ) ).interval = 100;
	var dst;
	function scrollTo( value )
	{
		dst = value;
		tmr.enabled = true;
	}
	function repeat()
	{
		if( dst < slider.left                ) ( target.pagebypage ) ? target.nextPage() : target.nextLine(); else
		if( dst > slider.left + slider.width ) ( target.pagebypage ) ? target.prevPage() : target.prevLine(); else
		tmr.enabled = false;
	}
	function onMouseDown( x , y , button , shift  )
	{
		super.onMouseDown(...);
		if( x < slider.left                ){ ( target.pagebypage ) ? target.nextPage() : target.nextLine(); scrollTo( x ); } else
		if( x > slider.left + slider.width ){ ( target.pagebypage ) ? target.prevPage() : target.prevLine(); scrollTo( x ); }
	}
	function onMouseMove( x , y , shift )
	{
		if( tmr.enabled ) dst = x;
	}
	function onMouseUp( x , y , button , shift  )
	{
		tmr.enabled = false;
	}
	function finalize()
	{
		super.finalize(...);
		invalidate slider if slider !== void;
		invalidate tmr    if tmr    !== void;
	}
}
class HistoryLayerExtended extends HistoryLayer
{
	var scrollbar;
	function HistoryLayerExtended( win , par , direction )
	{
		super.HistoryLayer( win , par );
		controlHeight = 0;
	}
	function finalize()
	{
		super.finalize(...);
		invalidate scrollbar if scrollbar !== void;
	}
	function makeButtons() // overrides HistoryLayer.makeButtons()
	{
		if( scrollbar === void )
		{
			closeButton = new LButtonLayer( window , this );
			closeButton.top    = 0;
			closeButton.left   = width - 15;
			closeButton.width  = 15;
			closeButton.height = 15;
			closeButton.hint         = "履歷閉";
			closeButton.captionColor = 0xffffff;
			closeButton.color        = 0x808080;
			closeButton.caption      = "×";
			closeButton.visible      = true;
			
			// 縱書時上端 15 pixel 張。
			if( verticalView )
			{
				scrollbar = new HorizontalScrollbar( window , this , this );
				scrollbar.width  = width - closeButton.width;
				scrollbar.height = 15;
				scrollbar.setPos( 0 , 0 );
				scrollbar.visible = true;
			}
			// 橫書時右端 15 pixel 張。
			else
			{
				scrollbar = new VerticalScrollbar( window , this , this );
				scrollbar.width  = 15;
				scrollbar.height = height - closeButton.height;
				scrollbar.setPos( width - scrollbar.width , closeButton.height );
				scrollbar.visible = true;
			}
		}
		scrollbar.initState();
	}
	function updateButtonState(){ scrollbar.updateState(); } // overrides HistoryLayer.updateButtonState()
	
// HEAD :Scrollbar.Target interface實裝部分
//
	//function nextPage() HistoryLayer實裝濟
	//function prevPage() HistoryLayer實裝濟
	function nextLine() { scrollUp();   }
	function prevLine() { scrollDown(); }
	function isHead()
	{
		return !( dispStart > 0 );
	}
	function isTail()
	{ 
		if( everypage ) return !( dispStart < dataPages -         1 );
		else            return !( dispStart < dataLines - dispLines );
	}
	property pagebypage { getter() { return everypage; } }
	property lineCount  { getter() { return dataLines; } }
	property pageCount
	{
		getter()
		{
			var res = ( everypage ) ? dataPages : dataLines / repageLine;
			return ( res > 1 ) ? res : 1;
		}
	}
	property position
	{
		getter()
		{
			if( everypage )
			{
				if( pageCount > 1 ) return dispStart / ( pageCount - 1 );
				else return 1;
			}
			else
			{
				if( dataLines > dispLines ) return dispStart / ( dataLines - dispLines );
				else return 0;
			}
		}
	}
//
// TAIL :Scrollbar.Target interface實裝部分
//
// 。
// 履歷表示時 dispInit 呼出。
// 非表示時 dispUninit 呼出。
//
	function dispInit()
	{
		super.dispInit(...);
	}
	function dispUninit()
	{
		super.dispUninit(...);
	}
}
// [history]屬性追加
//
// type屬性 ：default 從來型履歷
// type屬性 ：scroll  形式履歷

kag.tagHandlers.history = function( elm )
{
	if( elm.type == "scroll" )
	{
		if( historyLayer instanceof "HistoryLayer" )
		{
			remove( historyLayer );
			invalidate historyLayer if historyLayer !== void;
			historyLayer = new HistoryLayerExtended( this , fore.base );
			add( historyLayer );
		}
	}
	else
	if( elm.type == "default" )
	{
		if( historyLayer instanceof "HistoryLayerExtended" )
		{
			remove( historyLayer );
			invalidate historyLayer if historyLayer !== void;
			historyLayer = new HistoryLayer( this , fore.base );
			add( historyLayer );
		}
	}
	setHistoryOptions( elm );
	return 0;
} incontextof kag;
[endscript]
[endif]
[return]
