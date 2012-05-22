;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------------------
;通用的文本文件的选择,载入,保存,重写
;------------------------------------------------------------------------------------------------
;------------------------------------------------------------------
;重写启动脚本
;------------------------------------------------------------------
[iscript]
function rewriteStart(storage)
{
//自动生成宏
var arr=[];
arr[0]=";--------------------------------------------";
arr[1]=";由编辑器自动改写以方便测试的跳转脚本";
arr[2]=";--------------------------------------------";
arr[3]="[jump storage=\""+storage+"\"]";

//进行保存
arr.save(sf.path+"macro/start.ks");
}
[endscript]

;------------------------------------------------------------------
;读入文本文件
;------------------------------------------------------------------
[iscript]
function loadScript(file)
{
var script=[];
script.load(file);
return script;
}
[endscript]
;------------------------------------------------------------------
;保存文本文件
;------------------------------------------------------------------
[iscript]
function saveScript(filename,script)
{
  Plugins.link("win32ole.dll");
  var objFileSystem = new WIN32OLE("Scripting.FileSystemObject");
  var objTextFile = objFileSystem.OpenTextFile(filename , 2 ,true ,-1);
  //参数:文件名,(只读1/只写2/续写8),不存在是否新建(true/false),(默认-2/UNICODE-1/ASCII0)
  for (var i=0;i<script.count;i++)
   {
       objTextFile.WriteLine(script[i]);
    }
objTextFile.Close();
}
[endscript]
;------------------------------------------------------------------
;保存设定文件
;------------------------------------------------------------------
[iscript]
function saveConfig()
{
//读入模板设定
var cont;
cont=loadScript(sf.path+"Config.tjs");

//按行改写部分内容
for (var i=0;i<cont.count;i++)
{
	//标题
	if (cont[i].indexOf(";System.title")!=-1) cont[i]=";System.title =\""+f.setting.title+"\";";
	//分辨率
	if (cont[i].indexOf(";scWidth")!=-1) cont[i]=";scWidth ="+f.setting.width+";";
	if (cont[i].indexOf(";scHeight")!=-1) cont[i]=";scHeight ="+f.setting.height+";";
	//根据分辨率修改立绘对齐线
	if (cont[i].indexOf(";scPositionX.left_center")!=-1) {cont[i]=";scPositionX.left_center = "+(f.setting.width*3/8)+";";}
	else if (cont[i].indexOf(";scPositionX.left")!=-1) {cont[i]=";scPositionX.left = "+f.setting.width/4+";";}
	if (cont[i].indexOf(";scPositionX.center")!=-1) cont[i]=";scPositionX.center = "+f.setting.width/2+";";
	if (cont[i].indexOf(";scPositionX.right_center")!=-1) {cont[i]=";scPositionX.right_center = "+(f.setting.width*5/8)+";";}
	else if (cont[i].indexOf(";scPositionX.right")!=-1) {cont[i]=";scPositionX.right =  "+(f.setting.width*3/4)+";";}
	//根据分辨率修改对话框大小
	if (cont[i].indexOf(";mw")!=-1) cont[i]=";mw = "+f.setting.width+";";
	if (cont[i].indexOf(";mh")!=-1) cont[i]=";mh ="+f.setting.height+";";
}

//----------------------------------------------------------
//保存设定文件
//----------------------------------------------------------
saveScript(Storages.getLocalName(sf.path+"Config.tjs"),cont);
}
[endscript]
;------------------------------------------------------------------
[return]