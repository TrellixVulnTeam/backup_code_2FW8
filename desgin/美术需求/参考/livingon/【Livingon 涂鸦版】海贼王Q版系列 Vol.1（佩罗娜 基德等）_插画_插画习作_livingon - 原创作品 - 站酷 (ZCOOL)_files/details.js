


var ObjId = $('#dataInput').attr('data-objid');
var ObjType = $('#dataInput').attr('data-objtype');
var idstr = location.pathname.substring(location.pathname.lastIndexOf('/')+1,location.pathname.lastIndexOf('.'));
$.ajax({
 type: "get",
 url: serverApi + "/wxshare/getQrcode?id=" + ObjId + "&objectType=" + ObjType,
 dataType: "json",
 contentType: 'application/json',
 success: function(data) {
    $('#app-code').append('<image src="' + data.data + '" />')
 }
})

$('#share').on('click', function () {
    showGlobalMaskLayer();
    $('#pop-share').removeClass('hide');
})
$('#pop-share .pop-close').on('click', function () {
    $(this).parents('#pop-share').addClass('hide');
    hideGlobalMaskLayer();
})

$('.radio label').on('click', function (e) {
    console.log(e.target.nodeName)
    $("input[name=radio]").parent().removeClass().addClass('radio-1');
    $("input[name=radio]:checked").parent().removeClass().addClass('radio-0');
})

// 详情页作者信息吸顶效果
function infoFixedJudgment() {
    var sT = $('.details-userinfo-wrap').offset().top - $('.normal-userinfo-box').height() - parseInt($('.details-userinfo-wrap').css('margin-top')); //底部限制
    var top = $('.details-userinfo-wrap').get(0).offsetTop - $('.normal-userinfo-box').height() - parseInt($('.details-userinfo-wrap').css('margin-top'));
    var Heig = document.documentElement.clientHeight;
    var scrollLeft = $(document).scrollLeft();
    if (top > Heig) {
        if ($(document).scrollTop() > Heig) {
            $('.normal-userinfo-box').addClass('fixed-card').css({
                'left': $('.details-right-wrap').offset().left - scrollLeft
            });
            if ($(document).scrollTop() >= (sT)) {
                $('.normal-userinfo-box').addClass('absolute-card').removeClass('fixed-card').css({
                    'top': top,
                    'left': 0
                })
            } else {
                $('.normal-userinfo-box').removeClass('absolute-card').addClass('fixed-card').css({
                    'top': 10,
                    'left': $('.details-right-wrap').offset().left - scrollLeft
                })
                
            }
            $('.right-fixed-wrap').hide();
        } else {
            $('.normal-userinfo-box').removeClass('fixed-card');
            $('.right-fixed-wrap').show();
            $('.normal-userinfo-box').removeClass('absolute-card')
        }
    }
}

function informationScroll() {

    $(window).on('scroll resize', function () {
        $('.the-album-wrap').css('margin-top', $('.details-userinfo-wrap').get(0).offsetTop + 'px').show()

            infoFixedJudgment()
    })
}

// **************

function selectShow() {
    $('.rightbar-titlebox .rightnew-arrows').on('click', function () {
        if ($(this).hasClass('rightnew-arrowstop')) {
            $(this).removeClass('rightnew-arrowstop');
        } else {
            $(this).addClass('rightnew-arrowstop');
        }
        $(this).parents('.infomation-work').find('.info-list').toggle();
    })
}

function cricleMore() {
    $('.indexcricle').hover(function () {
        $('.indexcricle li').addClass('hover')
    }, function () {
        $('.indexcricle li').removeClass('hover')
    })
}

// 获取用户信息
function getUserPro(userId, FOLLOW_STATUS) {
    var _getUserProSuccessCallback = getUserProSuccessCallback
    $.ajax({
        type: "GET",
        xhrFields: {
            withCredentials: true
        },
        crossDomain: true,
        headers: {
            "X-Requested-With": "XMLHttpRequest"
        },
        url: proMainZDomain + "/member/card/" + userId + ".json",
        dataType: "json",
        success: function (data) {
            // 成功回掉函数
            _getUserProSuccessCallback(data, FOLLOW_STATUS)
        }

    })
}

function getUserProSuccessCallback(data, FOLLOW_STATUS) {
    data.contentType = $('input[name=creator]').attr('value');
    var authorCardHtml = template('author-cards', data);
    $('.author-card').html(authorCardHtml);
    // *********文章详情页左内容区的作者信息渲染：
    if($('#author-info').length > 0){
        var authorCardHtmlSmall = template('author-info', data)
        $('.left-author-card').html(authorCardHtmlSmall)
    }
    // *********
    $('.author-card .js-project-focus-btn,.left-author-card .js-project-focus-btn').append(zcoolFocusLoadingTpl);
   

    var data = data.data;
    guanZhuStatus = data["guanzhuStatus"];
    var userUrl = data["userUrl"];
    var memberHonors = data["memberHonors"];
    var authorCardId = data["id"];
    $('.indexcricle').attr('title', data.username);
    // 超出三个作者身份icon
    if (memberHonors.length > 3) {
        $('.card-media .zcool-treetop').css({'width': '40px'})
        $('.card-media .more-leaveout').css('display', 'inline-block');
        $('.card-media .more-leaveout').find('.leaveout-tips').css({
            'width': memberHonors.length * 21 + 32 + 'px',
            'margin-left': -(memberHonors.length * 21 + 32) / 2 + 'px'
        })
    }

    if (guanZhuStatus == FOLLOW_STATUS.NO_FOLLOW || guanZhuStatus == FOLLOW_STATUS.FOLLOWED) {
        $('.attention').removeClass('btn-default-secondary').addClass('btn-default-main').addClass('notfollow')
            .removeClass('following')
        $('.attention').val(messagesWeb.common_follow)
        $('.attention').attr('title', messagesWeb.common_follow_title)

    } else if (guanZhuStatus == FOLLOW_STATUS.FOLLOW) {
        $('.attention').addClass('btn-default-secondary').addClass('following').removeClass('notfollow')
            .removeClass('btn-default-main')
        $('.attention').val(messagesWeb.common_followed)
        $('.attention').attr('title', messagesWeb.common_followed_title)
    } else {
        $('.attention').addClass('btn-default-secondary').removeClass('following').removeClass('notfollow')
            .removeClass('btn-default-main')
        $('.attention').val(messagesWeb.common_mutual_concern)
        $('.attention').attr('title', messagesWeb.common_mutual_concern_title)
    }
}

// 其他作品
function getUserOthPro(ObjType, ObjId) {
    var _getUserOthProSuccessCallback = getUserOthProSuccessCallback
    $.ajax({
        type: "GET",
        xhrFields: {
            withCredentials: true
        },
        crossDomain: true,
        headers: {
            "X-Requested-With": "XMLHttpRequest"
        },
        dataType: "json",
        url: proMainZDomain + "/content/other.json?objectType=" + ObjType + "&objectId=" + ObjId,
        success: function (data) {
            _getUserOthProSuccessCallback(data)
        }
    })
}

 function getTeamInfo(){
    $('.js-a-team-info').html('<div class="c-loadding" style="text-align:center;"><img src="' + proStaticZDomain + '/z/images/common/page_loading.gif" style="vertical-align:middle;"></div>')
    $.ajax({
        type: "GET",
        xhrFields: {
            withCredentials: true
        },
        crossDomain: true,
        headers: {
            "X-Requested-With": "XMLHttpRequest"
        },
        dataType: "json",
        url: proMainZDomain + "/zteamForDetail?id=" + $('.js-a-team-info').attr('data-zteamid'),
        success: function (data) {
            if(data.code == 0){
                if(data.result){
                    var html = template('details-team-info-tpl',data)
                    $('.js-a-team-info').html(html);
                }else{
                        $('.js-a-team-info').html('');
                }
            }
        }
    })
}

getTeamInfo()

//lazy load image
function lazyLoadImage(num) {
  var num = num || 0;
  var deferreds = [];
  var i = 0;
  var batchNum = 0;
  var loadNumPerTime = 3;
  var headNumUncontrol = 3;
  var initScreenWidth = $(window).width() > 1600 ? 1280 : 1130;

  $('.lazy-img-class').each(function(index, ele) {
    var $this = this;
    
    // init blur image screen width
    if ($($this).data('width') > initScreenWidth) {
      $('.reveal-work-wrap').eq(index + headNumUncontrol).find('img').width(initScreenWidth);
    } else {
      $('.reveal-work-wrap').eq(index + headNumUncontrol).find('img').width($($this).data('width'));
    }
    
    batchNum = Math.floor(index / loadNumPerTime);

    if (batchNum === num) {
      deferreds.push(new $.Deferred());
      var img = new Image();
      img.src = $($this).data('src');
      img.onload = function() {
        $($this).attr('src', $($this).data('src'));
      };
      img.onerror = function() {
        $($this).attr('src', $($this).data('src'));
      };
    }

    // When image is loaded, resolve the next deferred
    $($this).load(function() {
      if (!deferreds[i]) return;
      deferreds[i].resolve();
      i++;
    }).error(function() {
      if (!deferreds[i]) return;
      deferreds[i].reject();
      i++;
    });
  });

  // When all deferreds are done (all images loaded) do some stuff
  $.when.apply(null, deferreds).done(function() {
    if (num < batchNum) lazyLoadImage(num + 1);
  });
}

// 作品详情页 加载内容图片时
lazyLoadImage();

$(function () {
    
    var FOLLOW_STATUS = {
        NO_FOLLOW: 0,
        FOLLOW: 1,
        MUTUAL_FOLLOW: 2,
        FOLLOWED: 3
    };

    $('.copy-con .copy-icon').hover(function () {
        $(this).find("i").show().css({
            'margin-left': -$(this).find("i").width() / 2 - 18 + 'px'
        })
        if($(this).find("i").width()/2 > $(this).position().left){
            $(this).find("i").show().css({
                'margin-left': -$(this).find("i").width()/2 - 18 + ($(this).find("i").width()/2 - $(this).position().left) + 18 + 'px'
            })
        }
    }, function () {
        $(this).find("i").hide()
    })
    cricleMore()
    selectShow()
    // 初始关注
    var userId = $("input[name='creator']").val();
    var contentId = $("input[name='contentId']").val();
    getUserPro(userId, FOLLOW_STATUS);
    // 用户其他作品
    getUserOthPro(ObjType, ObjId);

    // $(window).on('scroll',function(){
    //      ? $('.details-fixed-wrap').addClass('details-fixed-show') : $('.details-fixed-wrap').removeClass('details-fixed-show') ;
    // })
    
})

$(document).bind("contextmenu", ".no-right-key", function(e) {
    if (e.target.className.indexOf('no-right-key') > -1) {
        return false;
    }
})
