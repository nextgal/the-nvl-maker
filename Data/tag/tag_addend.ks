;-------------------------------------------------------------------------------------------
*window
[window_middle width=400 height=300 title="登录结局"]
[line title="文件" name="f.参数.storage" x=30 y=60 type="script"]
[s]

*确认
[commit]

[eval exp="commitLine(f.参数)"]
[jump storage="tag_direct.ks" target=*擦除窗口]

*关闭选单
[jump storage="tag_direct.ks" target=*关闭选单]
;-----------------------------------------------------------------
*选择文件
[call storage="window_file.ks"]
[iscript]
//切掉扩展名
f.参数.storage=Storages.chopStorageExt(f.参数.storage);
[endscript]
[jump target=*window]
