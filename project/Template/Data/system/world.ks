@if exp="typeof(global.world_object) == 'undefined'"
@iscript

KAGLoadScript('world.tjs');

kag.addPlugin(global.world_object = new KAGWorldPlugin(kag));
if (kag.debugLevel >= tkdlSimple) {
    dm("環境設定完了");
}

@endscript
@endif

@return
