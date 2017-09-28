<%@page import="com.crfeb.tbmpt.commons.utils.WebUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>管片质量巡检历史</title>
	<meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <link rel="stylesheet" href="${staticPath}/static/open/css/weui.min.css"/>
    <link rel="stylesheet" href="${staticPath}/static/open/css/weui2.css"/>
    <script src="${staticPath}/static/open/js/zepto.min.js"></script> 
    <script src="${staticPath}/static/open/js/updown.js"></script> 
    <%
    	String type = WebUtil.checkDeviceType(request);
	%>
<script>
$(function(){
    // 每页展示10个
    var num =10;
    var page = 1;
    // dropload
    $('.weui-panel').dropload({
        scrollArea : window,
        autoLoad : true,
        domDown : {//上拉
            domClass   : 'dropload-down',
            domRefresh : '<div class="dropload-refresh f15 "><i class="icon icon-20"></i>上拉加载更多</div>',
            domLoad    : '<div class="dropload-load f15"><span class="weui-loading"></span>正在加载中...</div>',
            domNoData  : '<div class="dropload-noData">没有更多数据了</div>'
        },
        domUp : {//下拉
            domClass   : 'dropload-up',
            domRefresh : '<div class="dropload-refresh"><i class="icon icon-114"></i>上拉加载更多</div>',
            domUpdate  : '<div class="dropload-load f15"><i class="icon icon-20"></i>释放更新...</div>',
            domLoad    : '<div class="dropload-load f15"><span class="weui-loading"></span>正在加载中...</div>'
        },
        loadUpFn : function(me){//刷新
            $.ajax({
                type: 'GET',
                url: '${staticPath}/open/gczl/gczlGPZLLS',
                data:{page:1},
                dataType: 'json',
                success: function(data){
                    var result = '';
                    for(var i = 0; i < data.lists.length; i++){
						var time = data.lists[i].updateTime;
						if(time == null){
							time = data.lists[i].xjtime;
						}
						
                    	result+='<a href="javascript:<%=type%>.onJumpInfo(\'com.crfeb.tbmpt.app.GczlGPZLXJInfoActivity\',\''+data.lists[i].id+'\')'+
							';" class="weui-media-box weui-media-box_appmsg">'+
                            '<div class="weui-media-box__hd">'+
                                '<img class="weui-media-box__thumb" alt="" '+
                                'src="${imageBrowsePath}/'+data.lists[i].xjzpslt+'">'+
                                //'src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAC4AAAAuCAMAAABgZ9sFAAAAVFBMVEXx8fHMzMzr6+vn5+fv7+/t7e3d3d2+vr7W1tbHx8eysrKdnZ3p6enk5OTR0dG7u7u3t7ejo6PY2Njh4eHf39/T09PExMSvr6+goKCqqqqnp6e4uLgcLY/OAAAAnklEQVRIx+3RSRLDIAxE0QYhAbGZPNu5/z0zrXHiqiz5W72FqhqtVuuXAl3iOV7iPV/iSsAqZa9BS7YOmMXnNNX4TWGxRMn3R6SxRNgy0bzXOW8EBO8SAClsPdB3psqlvG+Lw7ONXg/pTld52BjgSSkA3PV2OOemjIDcZQWgVvONw60q7sIpR38EnHPSMDQ4MjDjLPozhAkGrVbr/z0ANjAF4AcbXmYAAAAASUVORK5CYII=">'+

                            '</div>'+
                            '<div class="weui-media-box__bd">'+
                                '<h4 class="weui-media-box__title">'+data.lists[i].typeName+'</h4>'+
                                '<p class="weui-media-box__desc">'+data.lists[i].qkms+'</p>'+
                                '<p class="weui-media-box__desc">处理时间:'+time+'</p>'+
                                '<p class="weui-media-box__desc">当前状态：'+data.lists[i].sbzt+"  "+data.lists[i].shzt+"  "+data.lists[i].zgzt+'</p>'+
                            '</div>'+
                            '<span class="weui-cell__ft"></span>'+
                        '</a>';

                    }
                    
                    $('.weui-panel__bd').html(result);
                    // 每次数据加载完，必须重置
                    me.resetload();

                    if(data.lists.length < 10){
                        // 锁定
                        me.lock();
                        // 无数据
                        me.noData();
                    }else{
                    	// 解锁
                        me.unlock();
                        me.noData(false);
                    }
                    
                    page = 2;
                    /*
                    // 为了测试，延迟1秒加载
                    setTimeout(function(){
                        $('.weui-panel__bd').html(result);
                        // 每次数据加载完，必须重置
                        me.resetload();
                        // 重置索引值，重新拼接more.json数据
                        counter = 0;
                        // 解锁
                        me.unlock();
                        me.noData(false);
                    },1000);
                    */
                },
                error: function(xhr, type){
                    // 即使加载出错，也得重置
                    me.resetload();
                }
            });
        },
        loadDownFn : function(me){//加载更多
            $.ajax({
                type: 'GET',
                url: '${staticPath}/open/gczl/gczlGPZLLS',
                dataType: 'json',
                data:{page:page},
                success: function(data){
                    var result = '';
                    page++;
                    for(var i = 0; i < data.lists.length; i++){
                    	var time = data.lists[i].updateTime;
						if(time == null){
							time = data.lists[i].xjtime;
						}
                        result+='<a href="javascript:<%=type%>.onJumpInfo(\'com.crfeb.tbmpt.app.GczlGPZLXJInfoActivity\',\''+data.lists[i].id+'\')'+
                        	';" class="weui-media-box weui-media-box_appmsg">'+
                            '<div class="weui-media-box__hd">'+
                                '<img class="weui-media-box__thumb" alt="" '+
                                'src="${imageBrowsePath}/'+data.lists[i].xjzpslt+'">'+
                                //'src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAC4AAAAuCAMAAABgZ9sFAAAAVFBMVEXx8fHMzMzr6+vn5+fv7+/t7e3d3d2+vr7W1tbHx8eysrKdnZ3p6enk5OTR0dG7u7u3t7ejo6PY2Njh4eHf39/T09PExMSvr6+goKCqqqqnp6e4uLgcLY/OAAAAnklEQVRIx+3RSRLDIAxE0QYhAbGZPNu5/z0zrXHiqiz5W72FqhqtVuuXAl3iOV7iPV/iSsAqZa9BS7YOmMXnNNX4TWGxRMn3R6SxRNgy0bzXOW8EBO8SAClsPdB3psqlvG+Lw7ONXg/pTld52BjgSSkA3PV2OOemjIDcZQWgVvONw60q7sIpR38EnHPSMDQ4MjDjLPozhAkGrVbr/z0ANjAF4AcbXmYAAAAASUVORK5CYII=">'+
                            '</div>'+
                            '<div class="weui-media-box__bd">'+
                                '<h4 class="weui-media-box__title">'+data.lists[i].typeName+'</h4>'+
                                '<p class="weui-media-box__desc">'+data.lists[i].qkms+'</p>'+
                                '<p class="weui-media-box__desc">处理时间:'+time+'</p>'+
                                '<p class="weui-media-box__desc">当前状态：'+data.lists[i].sbzt+"  "+data.lists[i].shzt+"  "+data.lists[i].zgzt+'</p>'+
                            '</div>'+
                            '<span class="weui-cell__ft"></span>'+
                        '</a>';
                    }
                    if(data.lists.length < 10){
                        // 锁定
                        me.lock();
                        // 无数据
                        me.noData();
                    }
                    $('.weui-panel__bd').append(result);
                    // 每次数据加载完，必须重置
                    me.resetload();
                    
                    
                    
                    /*
                    // 为了测试，延迟1秒加载
                    setTimeout(function(){
                        $('.weui-panel__bd').append(result);
                        // 每次数据加载完，必须重置
                        me.resetload();
                    },1000);
                    */
                },
                error: function(xhr, type){
                    // 即使加载出错，也得重置
                    me.resetload();
                }
            });
        }
    });
});
</script>      
 
</head>
<body ontouchstart>
    <div class="weui-toptips weui-toptips_warn js_tooltips">错误提示</div>

    <div class="container" id="container">
        <div class="page">
            <div class="page__bd">
                <div class="weui-panel weui-panel_access">
                    
                    <div class="weui-panel__bd"></div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

