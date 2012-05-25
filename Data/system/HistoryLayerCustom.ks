;// HistoryLayerCustom.ks - 支持一定程度的外觀定制的HistoryLayer擴展模塊
;// 作者：希德船長 修改、發佈自由
;// 適用於KAG3 3.28

[if exp=" 'undefined' == typeof global.HistoryLayerCustom" ]
[iscript]

class HistoryLayerCustom extends HistoryLayerExtended
{
	var historyLayerType = "scroll"; // 默認顯示模式為scroll模式(即HistoryLayerExtended的模式)
	
	function HistoryLayerCustom(win, par, direction, type)
	{
		super.HistoryLayerExtended(win, par, direction);
		
		if(type !== void)
			historyLayerType = type;

		if(historyLayerType == "default")
			controlHeight = 20;
	}
	
	function finalize()
	{
		super.finalize(...);
	}
	
	function setOptions(elm)
	{
		super.setOptions(elm);
		
		if(elm.type !== void)
			historyLayerType = elm.type;
	}
	
	function makeButtons()
	{
		if(historyLayerType == "default")
		{
			(global.HistoryLayer.makeButtons incontextof this)();
		}
		else
		{
			super.makeButtons();
		}
	}
	
	function updateButtonState()
	{
		if(historyLayerType == "default")
		{
			(global.HistoryLayer.updateButtonState incontextof this)();
		}
		else
		{
			super.updateButtonState();
		}
	}
}

kag.tagHandlers.history = function(elm)
{
	if(!(historyLayer instanceof "HistoryLayerCustom"))
	{
		remove(historyLayer);
		invalidate historyLayer if historyLayer !== void;
		historyLayer = new HistoryLayerCustom(this, fore.base, elm.direction, elm.type);
		add(historyLayer);
	}

	setHistoryOptions(elm);
	return 0;
} incontextof kag;

[endscript]
[endif]
[return]