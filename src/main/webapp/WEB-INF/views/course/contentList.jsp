<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../common/config.jsp"%>
<link href="${resPath}/css/courseTitle.css" rel="stylesheet">
<title>수강과목-강의 목차</title>
<style>
  .contentsListLi {
  	background-color: #eff4ff;
  	border-radius: 18px;
  }
  .nav {
  	border-bottom: 1px solid #ccc;
  }
</style>
</head>
<body>
<div class="w-25">
	<%@ include file="../common/leftbar.jsp"%>
</div>
	<div class="mainview container mt-5 ms-5 me-5 position-absolute min-vh-100 w-50">
		<%@ include file="../common/courseTitle.jsp" %>
		<%@ include file="../common/courseBar.jsp" %>
		<div>
			<h3 class="blue600 info">강의 목차</h3>
		</div>
		<div>
			 <div>
	          <ul class="list-unstyled">
				<c:forEach var="content" items="${contents}">
		            <li class="contentsListLi mb-2">
		              <a class="ms-3 d-flex flex-column flex-lg-row gap-3 align-items-start align-items-lg-center py-3 link-body-emphasis text-decoration-none border-top" 
		              		href="${context}course/${courseInfo.courseId }/contents/${content.contentId}">
		                <img alt="강의목차 컨텐츠 썸네일" src="${courseInfo.thumbnail}" width="450" height="200">
		                <div class="col-lg-8">
		                	<input class="btn bg-primary text-white " type="button" value="${courseInfo.sort}" style="border-radius: 12px" >
		               	  <h3 class="my-3">${content.contentName} </h3>
		                  <!-- <small class="text-body-secondary">January 15, 2023</small> -->
		                </div>
		              </a>
		            </li>
	            </c:forEach>
	          </ul>
	        </div>
		</div>
		<%@ include file="../common/footer.jsp" %>
	</div>
	<div class="w-25">
		<%@ include file="../common/rightbar.jsp"%>
	</div>
</body>
<script src="${resPath}/js/courseBar.js"></script>
</html>