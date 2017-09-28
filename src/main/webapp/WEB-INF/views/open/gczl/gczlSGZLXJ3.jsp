<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <title>施工质量巡检页面</title>
    <link rel="stylesheet" href="${staticPath}/static/open/css/weui.min.css"/>
    <link rel="stylesheet" href="${staticPath}/static/open/css/main.css"/>

</head>
<body ontouchstart>
    <div class="weui-toptips weui-toptips_warn js_tooltips">错误提示</div>

    <div class="container" id="container">
        <div class="page input js_show">

            <div class="page__bd">

                <div class="weui-gallery" id="gallery">
                    <span class="weui-gallery__img" id="galleryImg"></span>
                    <div class="weui-gallery__opr">
                        <a href="javascript:" class="weui-gallery__del">
                            <i class="weui-icon-delete weui-icon_gallery-delete"></i>
                        </a>
                    </div>
                </div>

                <!-- 提交表单 -->
                <form id="form" method="post" action="${staticPath}/open/gczl/gczlSGZLXJAddDo" enctype="multipart/form-data">
                
                    <div class="weui-cells__title">所属工程</div>
                    <div class="weui-cells weui-cells_form">
                        <div class="weui-cell">
                            <div class="weui-cell__hd"><label class="weui-label" style="width: 8em;">所属工程：</label></div>
                            <div class="weui-cell__bd">
                               ${pro.name}
                            	<input name="gcBh" type="hidden" value="${pro.id}"/>
                            </div>
                        </div>
                        <div class="weui-cell weui-cell_select weui-cell_select-after">
                            <div class="weui-cell__hd">
                                <label for="" class="weui-label" style="width: 8em;">区间名称：</label>
                            </div>
                            <div class="weui-cell__bd">
                                <select class="weui-select" name="qjBh" id='section'>
                                   <c:forEach items="${pro.proSecs}" var="sec">
										<option value="${sec.id}" >${sec.name}</option>
									</c:forEach>
                   
                                   <!--  <option value="1">曾钟</option>
                                    <option value="2">象钟</option> -->
                                </select>
                            </div>
                        </div>
                        <div class="weui-cell weui-cell_select weui-cell_select-after">
                            <div class="weui-cell__hd">
                                <label for="" class="weui-label" style="width: 8em;">线路名称：</label>
                            </div>
                            <div class="weui-cell__bd">
                                <select class="weui-select" name="xlBh" id="line">
                                   <c:forEach items="${pro.proSecs}" var="sec">
										<c:forEach items="${sec.secLines}" var="line">
											<option value="${line.id}" class="${sec.id}">${line.name}</option>
										</c:forEach>
									</c:forEach>
                                   
                                    <!-- <option value="1">左线</option>
                                    <option value="2">右线</option> -->
                                </select>
                            </div>
                        </div>
                        <div class="weui-cell weui-cell_select weui-cell_select-after">
                            <div class="weui-cell__hd">
                                <label for="" class="weui-label" style="width: 8em;">分部工程：</label>
                            </div>
                            <div class="weui-cell__bd">
                                <select class="weui-select" name="fbGcbh" id="fbGcbh">
                                	<c:forEach items="${fbgc.sections}" var="sec">
										<c:forEach items="${sec.fbgcs}" var="fbgc">
											<option value="${fbgc.id}" class="${sec.id}">${fbgc.name}</option>
										</c:forEach>
									</c:forEach>
                                   <!--  <option value="1">分部工程1</option>
                                    <option value="2">分部工程2</option> -->
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="weui-cells__title">施工情况</div>
                    <div class="weui-cells weui-cells_form">
                        <div class="weui-cell">
                            <div class="weui-cell__hd"><label for="" class="weui-label" style="width: 8em;">巡检时间：</label></div>
                            <div class="weui-cell__bd">
                                <input name="xjTime" class="weui-input" type="datetime-local" placeholder="请输入巡检时间" required/>
                            </div>
                        </div>
                        <div class="weui-cell weui-cell_select weui-cell_select-after">
                            <div class="weui-cell__hd">
                                <label for="" class="weui-label" style="width: 8em;">施工内容：</label>
                            </div>
                            <div class="weui-cell__bd">
                                <select id="sgNr" name="sgNr" class="weui-select" onChange="javascript:onChange('mune_x'+this.value)">
                          			<c:forEach items="${dic}" var="dic">
											<option value="${dic.name}" >${dic.name}</option>
									</c:forEach>
                                   
                                   <!--  <option value="1">施工内容1</option>
                                    <option value="2">施工内容2</option> -->
                                </select>
                            </div>
                        </div>

                        <div class="weui-cell weui-cell_select weui-cell_select-after">
                            <div class="weui-cell__hd">
                                <label for="" class="weui-label" style="width: 8em;">具体位置：</label>
                            </div>
                            <div class="weui-cell__bd">
                                <select id="jtWz" name="jtWz" class="weui-select" onChange="javascript:onChange('mune_x'+this.value)">
                                   <c:forEach items="${dic}" var="dic">
										<c:forEach items="${dic.sgzlJtwzinfos}" var="jtwz">
											<option value="${jtwz.name}" class="${dic.name}">${jtwz.name}</option>
										</c:forEach>
									</c:forEach>
                                   
                                   <!--  <option value="1">具体位置1</option>
                                    <option value="2">具体位置2</option> -->
                                </select>
                            </div>
                        </div>


                        <div class="weui-cell weui-cell_select weui-cell_select-after">
                            <div class="weui-cell__hd">
                                <label for="" class="weui-label" style="width: 8em;">质量缺陷：</label>
                            </div>
                            <div class="weui-cell__bd">
                                <select id="zlQx" name="zlQx" class="weui-select" onChange="javascript:onChange('mune_x'+this.value)">
                                     <c:forEach items="${dic}" var="dic">
										<c:forEach items="${dic.sgzlZlqxinfos}" var="zlqx">
											<option value="${zlqx.name}" class="${dic.name}">${zlqx.name}</option>
										</c:forEach>
									</c:forEach>
                                    <!-- <option value="1">质量缺陷1</option>
                                    <option value="2">质量缺陷2</option> -->
                                </select>
                            </div>
                        </div>
                        <div class="weui-cell">
                            <div class="weui-cell__hd"><label for="" class="weui-label" style="width: 8em;">施工工段：</label></div>
                            <div class="weui-cell__bd">
                                <input name="sgd" class="weui-input" type="text" value="" placeholder="请输入施工工段" required/>
                            </div>
                        </div>
                    </div>
                    
                    <div class="weui-cells__title">其他内容</div>
                    <div class="weui-cells weui-cells_form">
                    	<div class="weui-cell">
							<div class="weui-cell__bd">
								<textarea name="remarks" class="weui-textarea" placeholder="请输入其他内容"
									rows="3"></textarea>
								<div class="weui-textarea-counter">
									<span>0</span>/200
								</div>
							</div>
						</div>
                    </div>

                    <div class="weui-cells__title">相关图片</div>
                    <div class="weui-cells weui-cells_form">
                        <div class="weui-cell">
                            <div class="weui-cell__bd">
                                <div class="weui-uploader">
                                    <div class="weui-uploader__hd">
                                        <p class="weui-uploader__title">图片上传</p>
                                        <div class="weui-uploader__info">0/1</div>
                                    </div>
                                    <div class="weui-uploader__bd">
                                        <ul class="weui-uploader__files" id="uploaderFiles">
                                            
                                        </ul>
                                        <div class="weui-uploader__input-box">
                                            <input id="uploaderInput" class="weui-uploader__input" name="file" type="file" accept="image/*" multiple />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>

                </form>
                
                <div class="weui-btn-area">
                    <a class="weui-btn weui-btn_primary" href="javascript:" id="formSubmitBtn">确定</a>
                </div>
            </div>

            <div class="page__ft">
                <a href="#"></a>
            </div>
        
        </div>
    </div>
	<div id="dialogs">
        <!--BEGIN dialogTip-->
        <div class="js_dialog" id="dialogTip" style="opacity: 0; display: none;">
            <div class="weui-mask"></div>
            <div class="weui-dialog">
                <div id="dialogTip_content" class="weui-dialog__bd"></div>
                <div class="weui-dialog__ft">
                    <a href="javascript:;" class="weui-dialog__btn weui-dialog__btn_primary">确定</a>
                </div>
            </div>
        </div>
        <!--END dialogTip-->
        <!--BEGIN dialogSuccess-->
        <div class="js_dialog" id="dialogSuccess" style="opacity: 0; display: none;">
            <div class="weui-mask"></div>
            <div class="weui-dialog weui-skin_android">
                <div class="weui-dialog__hd"><strong class="weui-dialog__title">操作成功</strong></div>
                <div id="dialogSuccess_content" class="weui-dialog__bd"></div>
                <div class="weui-dialog__ft">
                    <a href="javascript:closeCurrentWindow();" class="weui-dialog__btn weui-dialog__btn_default">返回</a>
                    <a href="javascript:;" class="weui-dialog__btn weui-dialog__btn_primary">取消</a>
                </div>
            </div>
        </div>
        <!--END dialogSuccess-->
    </div>
    <script src="${staticPath}/static/open/js/zepto.min.js"></script>
    <script src="${staticPath}/static/open/js/selector.js"></script>
    <script src="${staticPath}/static/open/js/jquery.chained.js"></script>
    <script src="${staticPath}/static/open/js/weui.min.js"></script>
    <script src="${staticPath}/static/open/js/ext.js"></script>
    <script type="text/javascript">
        $(function(){
            var tmpl = '<li class="weui-uploader__file" style="background-image:url(#url#)"></li>',
                $gallery = $("#gallery"), $galleryImg = $("#galleryImg"),
                $uploaderInput = $("#uploaderInput"),
                $uploaderFiles = $("#uploaderFiles")
                ;

            $uploaderInput.on("change", function(e){
                var src, url = window.URL || window.webkitURL || window.mozURL, files = e.target.files;
                for (var i = 0, len = files.length; i < len; ++i) {
                    var file = files[i];

                    if (url) {
                        src = url.createObjectURL(file);
                    } else {
                        src = e.target.result;
                    }

                    $uploaderFiles.append($(tmpl.replace('#url#', src)));
                }
            });
            $uploaderFiles.on("click", "li", function(){
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
            });
            $gallery.on("click", function(){
                $gallery.fadeOut(100);
            });
            
            var $tooltips = $('.js_tooltips');

            $('#showTooltips').on('click', function(){
                if ($tooltips.css('display') != 'none') return;

                // toptips的fixed, 如果有`animation`, `position: fixed`不生效
                $('.page.cell').removeClass('slideIn');

                $tooltips.css('display', 'block');
                setTimeout(function () {
                    $tooltips.css('display', 'none');
                }, 2000);
            });
            
            var $dialogTip = $('#dialogTip');
            var $dialogSuccess = $('#dialogSuccess');

	        $('#dialogs').on('click', '.weui-dialog__btn', function(){
	            $(this).parents('.js_dialog').fadeOut(200);
	        });
	        
			<c:choose>
			   <c:when test="${isDo}">
			   		<c:choose>
			   			<c:when test="${data.success}">
				   			$('#dialogSuccess_content').empty();
					    	$('#dialogSuccess_content').append('${data.msg}');
					   		$dialogSuccess.fadeIn(200);
			   			</c:when>
					    <c:otherwise>
					    	$('#dialogTip_content').empty();
					    	$('#dialogTip_content').append('${data.msg}');
					   		$dialogTip.fadeIn(200);
					    </c:otherwise>
			   		</c:choose>
			   </c:when>
			   <c:otherwise> 
			   </c:otherwise>
			</c:choose>
			
			var success = '${data.success}';
			
	        var $form = $("#form");
	      	
	        // 表单校验
	        $("#formSubmitBtn").on("click", function(){
	            $form.validate(function(error){
	                if(error){
	                	$('#dialogTip_content').empty();
				    	$('#dialogTip_content').append("请完善输入框");
				   		$dialogTip.fadeIn(200);
	                }else{
	                	$form.submit();
	                }
	            });

	        });
            
        });
        
        var closeCurrentWindow = function(){
        	Android.closeCurrentWindow();
        }
        
        $("#line").chained("#section");
        $("#fbGcbh").chained("#section");
        
        $("#jtWz").chained("#sgNr");
        $("#zlQx").chained("#sgNr");
    </script>
</body>
</html>
