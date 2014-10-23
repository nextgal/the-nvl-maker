;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
[iscript]
class uiListLayer extends uiLayer
{
	//文字
	var bold;
	var italic;
	var shadow;
	var shadowcolor;
	var edge;
	var edgecolor;
	var name;
	var size;
	var color;

	var x;
	var y;

	//按钮
	var normal;
	var over;
	var on;
	
	//排版
	var num;
	var line;
	var disy;
	var disx;
	var temp;

	//---------------------------------------------------创建---------------------------------------------------
	function uiListLayer(elm)
	{
		super.Layer(kag, parent);

		visible=true;
		
		hitType = htMask;
		hitThreshold =0;
		focusable=true;

		//读取参数
		Reset(elm);
		//描绘外观
		drawSelect();
	}
	//输入数值
	function Reset(elm)
	{
		//将该层的位置输出，供字典保存用
		left=elm.left;
		top=elm.top;
		//按钮
		normal=elm.normal;
		over=elm.over;
		on=elm.on;
		//排版
		line=elm.line;
		disx=elm.disx;
		disy=elm.disy;
		num=elm.num;
		//文字
		x=elm.x;
		y=elm.y;
		bold=elm.bold;
		italic=elm.italic;
		shadow=elm.shadow;
		shadowcolor=elm.shadowcolor;
		edge=elm.edge;
		edgecolor=elm.edgecolor;
		name=elm.name;
		size=elm.size;
		color=(string)elm.color;
	}

	//在规定位置描绘按钮
	function drawButton()
	{
		if (line=="single")
		{
			for (var i=0;i<num;i++)
			{
				drawOneButton(0,(temp.height+(int)disy)*i);
			}
		}
		else
		{
			for (var i=0;i<num;i++)
			{
				drawOneButton((temp.width+(int)disx)*(i%2),(temp.height+(int)disy)*(i\2));
			}
		}
	}

	//描绘单个按钮
	function drawOneButton(butx,buty)
	{
		//复制到背景上
		this.piledCopy(butx, buty, temp, 0, 0, temp.width, temp.height);

		//描绘文字
		this.font.height=size;
		this.font.bold=bold;
		this.font.italic=italic;

		if (shadow)
		{
			this.drawText(butx+(int)x,buty+(int)y,"元素文字样式",color,255,true,255,shadowcolor,0,2,2);
		}
		else if (edge)
		{
			this.drawText(butx+(int)x,buty+(int)y,"元素文字样式",color,255,true,255,edgecolor,1,0,0);
		}
		else
		{
			this.drawText(butx+(int)x,buty+(int)y,"元素文字样式",color);
		}
	}
	//---------------------------------------------------描绘---------------------------------------------------
	function drawSelect()
	{
		//加载临时图片
        temp=new global.Layer(kag, parent);
		temp.loadImages(normal);
		temp.setSizeToImageSize();
		
		if (line=="single")
		{
			this.width=temp.width;
			this.height=temp.height*num+(int)disy*(num-1);
		}
		else
		{
			this.width=temp.width*2+(int)disx;
			var count=num\2;
			if (num%2!=0) count++;
			this.height=temp.height*count+(int)disy*(count-1);
		}

		setSize(width,height);
		fillRect(0,0,width,height,0x00FFFFFF);
		
		//假如选中,带边框
		if (select)
		{
			fillRect(0,0,width,1,0xCCFF0000);
			fillRect(0,0,1,height,0xCCFF0000);
			fillRect(0,height-1,width,1,0xCCFF0000);
			fillRect(width-1,0,1,height,0xCCFF0000);
		}

		//描绘按钮
		drawButton();
	
	}

   //---------------------------------------------------输出---------------------------------------------------
   function LayerElm()
   {
      var dic=new Dictionary();

		//将该层的位置输出，供字典保存用
		dic.left=this.left;
		dic.top=this.top;
		//按钮
		dic.normal=this.normal;
		dic.over=this.over;
		dic.on=this.on;
		//排版
		dic.line=this.line;
		dic.disx=this.disx;
		dic.disy=this.disy;
		dic.num=this.num;
		//文字
		dic.x=this.x;
		dic.y=this.y;
		dic.bold=this.bold;
		dic.italic=this.italic;
		dic.shadow=this.shadow;
		dic.shadowcolor=this.shadowcolor;
		dic.edge=this.edge;
		dic.edgecolor=this.edgecolor;
		dic.name=this.name;
		dic.size=this.size;
		dic.color=(string)this.color;
	
      	return dic;
   }

}

[endscript]
[return]
