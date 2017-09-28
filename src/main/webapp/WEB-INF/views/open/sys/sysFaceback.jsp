<%@page import="com.crfeb.tbmpt.commons.utils.WebUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8" />
	<meta name="viewport"
		content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
	<title>问题反馈</title>
	<link rel="stylesheet" type="text/css" href="${staticPath}/static/open/css/main.css" />
	<link rel="stylesheet" type="text/css" href="${staticPath}/static/open/css/weui.min.css" />
    <%
    	String type = WebUtil.checkDeviceType(request);
	%>
</head>

<body>
	<div class="weui-toptips weui-toptips_warn js_tooltips">错误提示</div>
	<div class="container" id="container">
		<div class="page input js_show">
			<p class="page__desc">
				<a class="link" href="#gallery"></a>
			</p>
			<div class="page__bd">
				<form>
					<div class="weui-cells__title">问题和意见</div>
					<div class="weui-cells weui-cells_form">
						<div class="weui-cell">
							<div class="weui-cell__bd">
								<textarea class="weui-textarea" placeholder="请输入问题和意见" rows="3"></textarea>
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
										<div class="weui-uploader__info">0/2</div>
									</div>
									<div class="weui-uploader__bd">
										<ul class="weui-uploader__files" id="uploaderFiles">

										</ul>
										<div class="weui-uploader__input-box">
											<input id="uploaderInput" class="weui-uploader__input"
												type="file" accept="image/*" multiple />
										</div>
									</div>
								</div>
							</div>
						</div>

					</div>

				</form>
				<div class="weui-btn-area">
					<a class="weui-btn weui-btn_primary" href="javascript:"
						id="formSubmitBtn">确定</a>
				</div>
			</div>
		</div>
	</div>

	<script src="${staticPath}/static/open/js/zepto.min.js"></script>
	<script src="${staticPath}/static/open/js/weui.min.js"></script>
	<script type="text/javascript" class="uploader js_show">
			$(function() {
				var tmpl = '<li class="weui-uploader__file" style="background-image:url(#url#)"></li>',
					$gallery = $("#gallery"),
					$galleryImg = $("#galleryImg"),
					$uploaderInput = $("#uploaderInput"),
					$uploaderFiles = $("#uploaderFiles");

				$uploaderInput.on("change", function(e) {
					var src, url = window.URL || window.webkitURL || window.mozURL,
						files = e.target.files;
					for(var i = 0, len = files.length; i < len; ++i) {
						var file = files[i];

						if(url) {
							src = url.createObjectURL(file);
						} else {
							src = e.target.result;
						}

						$uploaderFiles.append($(tmpl.replace('#url#', src)));
					}
				});
				$uploaderFiles.on("click", "li", function() {
					$galleryImg.attr("style", this.getAttribute("style"));
					$gallery.fadeIn(100);
				});
				$gallery.on("click", function() {
					$gallery.fadeOut(100);
				});
			});
		</script>
</body>

</html>
