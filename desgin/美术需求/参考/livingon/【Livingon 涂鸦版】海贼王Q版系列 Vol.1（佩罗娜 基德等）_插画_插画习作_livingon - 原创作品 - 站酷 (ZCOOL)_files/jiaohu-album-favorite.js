


$(function () {
    var colListSmallLoadding = '<img src="' + proStaticZDomain + '/z/images/common/page_loading.gif" width="20" style="vertical-align:middle;" />';
    var objId = $('#dataInput').attr('data-objid');
    var objType = $('#dataInput').attr('data-objtype');
    var uid = getUid();
    var flag = true;
    var ZcFav = {
        domConfig: {
            folderListId: 'js-al-folder-covers',
        },
        favStatus: function () {
            if (getUid() > 0) {
                $.ajax({
                    type: "GET",
                    url: proMyZDomain + "/collection/getFavoriteStatus",
                    data: {
                        objId: objId,
                        objType: objType
                    },
                    xhrFields: {
                        withCredentials: true
                    },
                    crossDomain: true,
                    headers: {
                        "X-Requested-With": "XMLHttpRequest"
                    },
                    dataType: "json",
                    success: function (data) {
                        if (data.code == 0) {
                            if (data.data == false) {
                                // 没有收藏
                                $('.js-project-fav').addClass('js-not-fav')
                                $('.js-project-fav').attr('title', messagesWeb.fav_title_fav).val(messagesWeb.fav_title_fav)
                            } else {
                                // 已经收藏
                                $('.js-project-fav').removeClass('js-not-fav')
                                $('.js-project-fav').attr('title', messagesWeb.fav_title_collected).val(messagesWeb.fav_title_collected)
                            }
                        }
                    }
                })
            }

        },
        favAdd: function (thisDom) {
            // var successTipEle = thisDom.parents('.js-al-folder').find('.ablum-req-prompt');
            var collectionIds = thisDom.attr('collectionIds');
            
            // successTipEle.html(colListSmallLoadding);
            btnGifLoaddingShow(thisDom)
            if (thisDom.attr('data-collect') == 1) {
                // 取消收藏
                albumCelCollect(objType, objId, collectionIds, albumCelSuccess,albumCelError)
                function albumCelSuccess() {
                    // successTipEle.html('');
                    btnGifLoaddingHide(thisDom)
                    thisDom.val(messagesWeb.fav_title_fav).removeClass('btn-default-secondary').addClass('btn-default-main').attr('data-collect', '0');
                    
                    flag = true;
                }
                function albumCelError(data){
                    if(data){
                     pageToastFail(data.msg)
                    }
                    btnGifLoaddingHide(thisDom)
                    // successTipEle.html('');
                    flag = true;
                }
            } else {
                // 添加收藏
                albumAddCollect(objType, objId, collectionIds, albumAddSuccess,albumAddError)
                function albumAddSuccess(data) {
                    // successTipEle.fadeIn('fast',function(){
                    //     successTipEle.html(messagesWeb.fav_collection_success)
                    //     // 收藏成功
                    // });
                    // setTimeout(function(){
                    //     successTipEle.fadeOut('fast',function(){
                    //         successTipEle.html('')
                    //     });
                    // },2000)
                    btnGifLoaddingHide(thisDom)
                     thisDom.val(messagesWeb.fav_title_collected).addClass('btn-default-secondary').removeClass('btn-default-main').attr('data-collect', '1');
                    flag = true;
                }
                function albumAddError(data){
                    if(data){
                     pageToastFail(data.msg)
                    }
                    btnGifLoaddingHide(thisDom)
                    // successTipEle.html('');
                    flag = true;
                }

            }

        },
        favAddListen: function () {

            $('body').on('click', '.js-p-fav-btn', function () {
                if(flag){
                    ZcFav.favAdd($(this));
                    flag = false;
                }
            })
            $('#album-fav-pop .pop-close').on('click',function(){
                $('.js-al-folder-list input').each(function(i,v){
                    if($(v).attr('data-collect') == 1){
                        $('.js-project-fav').attr('title', messagesWeb.fav_title_collected).val(messagesWeb.fav_title_collected)
                        return false;
                    }else{
                        $('.js-project-fav').attr('title', messagesWeb.fav_title_fav).val(messagesWeb.fav_title_fav)
                        
                    }
                })
            })
        },
        favFolderList: function (_id) {
            $("." + ZcFav.domConfig.folderListId).html("");
            $("." + ZcFav.domConfig.folderListId).append('<div class="fav-loadding"><img src="' + proStaticZDomain + '/z/images/common/page_loading.gif"></div>')
            $.ajax({
                type: "GET",
                url: proMyZDomain + "/collections/allAndStatus?objectType=" + objType + "&objectId=" + objId,
                xhrFields: {
                    withCredentials: true
                },
                crossDomain: true,
                headers: {
                    "X-Requested-With": "XMLHttpRequest"
                },
                dataType: "json",
                success: function (data) {
                    if (data.code == 0) {
                        var alFolderHtml = template('al-folder-list-tpl', data);
                        $(".js-al-folder-covers").append(alFolderHtml);
                        $('#album-fav-pop').css({
                            'margin-top':-($('#album-fav-pop').height() /2)
                        })
                        // 放置loaddingDom
                        loaddingDomAdd('#album-fav-pop .js-c-loading-cover')
                        //  $('#album-fav-pop .js-c-loading-cover').append(zcoolFocusLoadingTpl)
                        $(".js-project-al-scroll .album-popup-con").mCustomScrollbar({
                            theme: "dark", //主题颜色
                            scrollButtons: {
                                scrollSpeed: 100,
                                enable: true //是否使用上下滚动按钮
                            },
                            autoHideScrollbar: true, //是否自动隐藏滚动条
                            scrollInertia: 100, //滚动延迟
                            horizontalScroll: false, //水平滚动条
                            autoDraggerLength: true,
                            callbacks: {
                                onScrollStart: function () {
                                    $('.mCS-autoHide .mCustomScrollBox .mCSB_scrollTools').css({ "opacity": '1', '-webkit-animation': 'none' })
                                },
                                whileScrolling: function () {
                                    $('.mCS-autoHide .mCustomScrollBox .mCSB_scrollTools').css({ "opacity": '1', '-webkit-animation': 'none' })
                                },
                                onScroll: function () {
                                    //滚动完成后触发事件
                                    $('.mCS-autoHide .mCustomScrollBox .mCSB_scrollTools').removeAttr('style')
                                }
                            }
                        });
                        $("." + ZcFav.domConfig.folderListId + ' .fav-loadding').remove();
                    }
                }
            })
        },
        favFolderAddExpandListen: function () {
            // 
            // zCharCount_withExceedCount($("#al-name"), {
            //     allowed: 50
            // });
            // zCharCount_withExceedCount($("#album-dis-textarea"), {
            //     allowed: 200
            // });

            $("." + ZcFav.domConfig.folderListId).on('click', '.js-add-al-folder', function () {
                
                // createAlbumShowAndFn 创建专辑的弹窗 在jiaohu-album.js里
                // showRemindBindLayer 用户未绑定手机号提示用户绑定layer 在login-window.js中定义 
                showRemindBindLayer(createFavFolderUnbindPhoneCb)
                function createFavFolderUnbindPhoneCb(){
                    createAlbumShowAndFn(createAlSuccuess,createAlError)
                    $('#album-fav-pop').hide();
                }
            })
            
            function createAlSuccuess(data) {
                var collectionIds = data.data.id;
                $('#album-fav-pop').show();
                $('#create-album-pop').hide();
                flag = false;
                var alFolderHtml = '<li class="js-al-folder temporary-al-folder">' +
                    '<div class="album-name-cover">' +
                    '<span class="p-album-name">' + data.data.name + '</span>';
                    if(data.data.open == 0){
                        alFolderHtml += '<i class="alfolder-icon-privacy" title="' + messagesWeb.albumFolder.a_private_favorites + '"></i>';
                    }
                    alFolderHtml += '</div>' + '<div class="ablum-list-right">' +
                    '<div class="js-c-loading-cover fav-loading-cover">' +
                    '<input type="button" value="' + messagesWeb.fav_title_collected + '" data-collect="1" collectionIds="' + data.data.id + '" class="btn-default-secondary fav-btn-size js-p-fav-btn">' +
                    '</div>' +
                    '</div>' +
                    '</li>'
                $('.js-al-folder-covers .js-al-folder-list > li:first').after(alFolderHtml);

                loaddingDomAdd('.js-al-folder-covers .js-al-folder-list > .temporary-al-folder:first .js-c-loading-cover')
                // 添加收藏
                albumAddCollect(objType, objId, collectionIds, albumAddSuccess,albumAddError)
                function albumAddSuccess(data) {
                    // $('.temporary-al-folder:first .ablum-req-prompt').fadeIn('fast',function(){
                    //     $('.temporary-al-folder:first .ablum-req-prompt').html(messagesWeb.fav_collection_success);
                    // });
                    $('.temporary-al-folder:first .js-p-fav-btn').val(messagesWeb.fav_title_collected).addClass('btn-default-secondary').removeClass('btn-default-main').attr('data-collect', '1');
                    // $('.temporary-al-folder:first .js-p-fav-btn').removeClass('check-c').addClass('check-cd').attr('data-collect', '1');
                    // setTimeout(function(){
                    //     $('.temporary-al-folder:first .ablum-req-prompt').fadeOut('fast',function(){
                    //         $('.temporary-al-folder:first .ablum-req-prompt').html('');
                    //     });
                    // },2000)
                    flag = true;
                }
                function albumAddError(data){
                    if(data){
                        pageToastFail(data.msg)
                    }
                    flag = true;
                }
                cancelLoaddingBtnDis($('.js-creat-al-confirm'));
                
            }
            function createAlError(data) {
                pageToastFail(data.msg)
                cancelLoaddingBtnDis($('.js-creat-al-confirm'))
            }
            // 取消添加专辑的分类类别
            $('#create-album-pop .pop-close,#create-album-pop .pop-cancel').on('click', function () {
                $('#album-fav-pop').show();
                showGlobalMaskLayer();
            })
            

        },
        favFolderIsExist: function () {

        },
        favPop: function () {
            if (getUid() > 0) {
                // if ($('.js-project-fav').hasClass('js-not-fav')) {
                    $('#album-fav-pop').show();
                    showGlobalMaskLayer();
                    // 加载专辑列表
                    ZcFav.favFolderList();
                // } else {
                //     pageToastFail('你已经收藏过了');
                // }

            } else {
                var successCallback = [];
                successCallback.push(function () {
                    ZcFav.favPop();
                });
                openLoginWindow(successCallback);
            }
        },
        favPopListen: function () {
            $('.js-project-fav').on('click', function () {
                ZcFav.favPop();
            });
        }
    };
    ZcFav.favStatus();

    ZcFav.favAddListen();
    ZcFav.favPopListen();
    ZcFav.favFolderAddExpandListen();
})
