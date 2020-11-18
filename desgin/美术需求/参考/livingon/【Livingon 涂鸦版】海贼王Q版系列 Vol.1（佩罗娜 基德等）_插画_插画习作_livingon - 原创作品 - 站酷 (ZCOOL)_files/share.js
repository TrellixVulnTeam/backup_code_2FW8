
ralateuid_tsina = "1733083617";
appkey_tsina = "163310332";
appkey_tqq = "100332598";
url = (typeof shareZ !== "undefined" && shareZ.url) ? shareZ.url : location.href;
title = (typeof shareZ !== "undefined" && shareZ.title) ? shareZ.title : "";
pic = (typeof shareZ !== "undefined" && shareZ.pic) ? shareZ.pic : ""
summary = (typeof shareZ !== "undefined" && shareZ.summary) ? shareZ.summary : ""

var link = '';
link += 'http://service.weibo.com/share/share.php?';
link += 'url=' + encodeURIComponent(url);
link += '&title=' + encodeURIComponent(title);
link += '&ralateUid=' + encodeURIComponent(ralateuid_tsina);
link += '&appkey=' + encodeURIComponent(appkey_tsina);
link += '&pic=' + encodeURIComponent(pic);

var weiboShare = document.getElementById('weiboShare')
if(weiboShare)
weiboShare.href = link;


var link = '';
link += 'https://connect.qq.com/widget/shareqq/index.html?';
link += 'url=' + encodeURIComponent(url);
link += '&title=' + encodeURIComponent(title);
link += '&pics=' + encodeURIComponent(pic);
link += '&desc=';
link += '&summary=' + encodeURIComponent(summary.substr(0,100));
link += '&site=' + encodeURIComponent('站酷网');

var qqShare = document.getElementById('qqShare')
if(qqShare)
qqShare.href = link;


var link = '';
link += 'https://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?';
link += 'url=' + encodeURIComponent(url);
link += '&title=' + encodeURIComponent(title);
link += '&pics=' + encodeURIComponent(pic);
link += '&summary=' + encodeURIComponent(summary);
link += '&desc=';
link += '&site=' + encodeURIComponent('站酷网');

var qzoneShare = document.getElementById('qzoneShare')
if(qzoneShare)
qzoneShare.href = link;