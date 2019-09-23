mkdir "/home/wwwroot/www.fegan.xyz/view/js" && cd "/home/wwwroot/www.fegan.xyz/view/js"
wget "https://github.com/Dador/JavascriptSubtitlesOctopus/blob/master/dist/subtitles-octopus-worker.data"
wget "https://raw.githubusercontent.com/Dador/JavascriptSubtitlesOctopus/master/dist/subtitles-octopus-worker.js"
wget "https://github.com/Dador/JavascriptSubtitlesOctopus/blob/master/dist/subtitles-octopus-worker.wasm"
wget "https://raw.githubusercontent.com/Dador/JavascriptSubtitlesOctopus/master/dist/subtitles-octopus.js"

cd /home/wwwroot/www.fegan.xyz/view/nexmoe/show
echo '' > video5.php
echo "<?php view::layout('layout')?>
 
<?php 
//仅支持教育版和企业版
if(strpos($item['downloadUrl'],"sharepoint.com") == false){
	header('Location: '.$item['downloadUrl']);exit();
}
$item['thumb'] = onedrive::thumbnail($item['path']);
$mpd =  str_replace("thumbnail","videomanifest",$item['thumb'])."&part=index&format=dash&useScf=True&pretranscode=0&transcodeahead=0";
?>
 
<?php view::begin('content');?>
<link class="dplayer-css" rel="stylesheet" href="https://cdn.jsdelivr.net/npm/dplayer/dist/DPlayer.min.css">
<script src="https://cdn.jsdelivr.net/npm/dashjs/dist/dash.all.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/dplayer/dist/DPlayer.min.js"></script>
<script src="/home/wwwroot/www.fegan.xyz/view/js/subtitles-octopus.js"></script>
<div class="mdui-container-fluid">
	<div class="nexmoe-item">
		<div class="mdui-center" id="dplayer"></div>
	<!-- 固定标签 -->
	<div class="mdui-textfield">
	  <label class="mdui-textfield-label">下载地址</label>
	  <input class="mdui-textfield-input" type="text" value="<?php e($url);?>"/>
	</div>
	<div class="mdui-textfield">
	  <label class="mdui-textfield-label">引用地址</label>
	  <textarea class="mdui-textfield-input"><video><source src="<?php e($url);?>" type="video/mp4"></video></textarea>
	</div>
</div>
<script>
const dp = new DPlayer({
	container: document.getElementById('dplayer'),
	lang:'zh-cn',
	video: {
	    url: '<?php e($item['downloadUrl']);?>',
	    pic: '<?php @e($item['thumb']);?>',
	    type: 'auto'
	},
      subtitle: {
        url: '<?php $urlparts = pathinfo($url); e($urlparts['dirname'].'/'.$urlparts['filename'].'.vtt');?>',
        type: 'webvtt',
        fontSize: '15px',
        bottom: '5%',
        color: '#ffffff'
    }
});
dp.on('canplay',
function() {
fetch('', {
redirect: 'follow'
}).then(function(response) {
return response.text();
}).then(function(text) {
var video = document.getElementsByTagName('video')[0];
window.SubtitlesOctopusOnLoad = function() {
var options = {
video: video,
// subUrl: '',
subContent: text,
fonts: ["//gapis.geekzu.org/g-fonts/ea/notosanssc/v1/NotoSansSC-Regular.otf", "//gapis.geekzu.org/g-fonts/ea/notosanstc/v1/NotoSansTC-Regular.otf", "//gapis.geekzu.org/g-fonts/ea/notosansjapanese/v6/NotoSansJP-Regular.otf"],
workerUrl: '/home/wwwroot/www.fegan.xyz/view/js/subtitles-octopus-worker.js'
};
window.octopusInstance = new SubtitlesOctopus(options);
};
if (SubtitlesOctopus) {
SubtitlesOctopusOnLoad();
}
})
})
</script>
<a href="<?php e($url);?>" class="mdui-fab mdui-fab-fixed mdui-ripple mdui-color-theme-accent"><i class="mdui-icon material-icons">file_download</i></a>
<?php view::end('content');?>" > /home/wwwroot/www.fegan.xyz/view/nexmoe/show/video5.php