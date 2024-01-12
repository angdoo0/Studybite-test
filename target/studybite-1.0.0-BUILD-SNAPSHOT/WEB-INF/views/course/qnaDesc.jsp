<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<%@ include file="../common/config.jsp"%>
<title>수강과목-질의 응답 상세</title>
</head>

<body>
	<div class="w-25">
		<%@ include file="../common/leftbar.jsp"%>
	</div>
	<div id="container" class="mainview container mt-5 min-vh-100 w-50">
		<%@ include file="../common/courseTitle.jsp"%>
		<%@ include file="../common/courseBar.jsp"%>
		<div class="my-1 text-left">
			<h4 class="blue600 info" id="smallTitle">
				<button class="btn border-0" type="submit" onclick="location.href='/studybite/course/${courseInfo.courseId}/qna'" style="background-color: white">
					<img src="/studybite/resources/img/back.png" width="30" height="30">
				</button>
				질의 응답 목록
			</h4>
		</div>
		<form:form modelAttribute="qna" method="delete" id="deleteForm">
			<div class="card mb-2 border-0 p-4 " style="background-color: rgba(239, 244, 255, 0.5);">
				<h3 class="text-center my-4">${qna.title}</h3>
				<div class="d-flex mt-2">
					<div>작성자 : ${qna.userName}</div>
					<div class="ms-auto me-3">작성일 : ${qna.date}</div>
					<div>조회수 : ${qna.views}</div>
				</div>
			</div>
			<hr class="m-0">
			<div class="mt-3">
				<div>${qna.description}</div>
			</div>
			<hr class="my-5">
			<c:choose>
				<c:when test="${fileBoard.filetype eq'application/pdf'}">
					<div>${fileBoard.originName}</div>
					<a href="${context}course/qna/${qnaId}/filedown?fileName=${fileBoard.originName}">첨부파일 다운로드</a>
				</c:when>
				<c:when test="${not empty fileBoard}">
					<img alt="첨부파일" src="${resPath}/files/${fileBoard.filename}" class="w-50 h-50">
					<div>
						<a href="${context}course/qna/${qnaId}/filedown?fileName=${fileBoard.originName}">첨부파일 다운로드</a>
					</div>
				</c:when>
			</c:choose>
			<c:if test="${user.userName eq qna.userName}">
				<div class="d-flex justify-content-end mt-1">
					<button type="button" onclick="location.href='${context}course/${courseId}/qna/${qnaId}/editForm'" class="btn btn-primary">수정</button>
					<form:button type="button" class="delete btn btn-primary mx-1" id="${qnaId}">삭제</form:button>
				</div>
			</c:if>
		</form:form>

		<!-- 교육자와 학습자, 답변 존재 여부를 판별해서 질의 답변 기능 동작 -->
		<c:choose>
			<c:when test="${user.role == 3 and not empty qna.answer}">
				<h4 class="blue600 info">답변</h4>
				<div class="card mb-2 border-0 p-3" style="background-color: rgba(239, 244, 255, 0.5)">
					<div>${qna.answer}</div>
				</div>
			</c:when>
			<c:when test="${user.role == 3 and empty qna.answer}">
				<h4 class="blue600 info">답변</h4>
				<div class="card mb-2 border-0 p-3" style="background-color: rgba(239, 244, 255, 0.5)">
					<div>등록된 답변이 없습니다</div>
				</div>
			</c:when>
			<c:when test="${user.role == 2 and not empty qna.answer}">
				<h4 class="blue600 info">답변</h4>
				<div class="card mb-2 border-0 p-3" style="background-color: rgba(239, 244, 255, 0.5)">
					<div>${qna.answer}</div>
				</div>
				<form:form modelAttribute="qna" action="/studybite/course/${courseInfo.courseId}/qna/answer" id="editAnswer" style="display: none">
					<div class="my-3">
						<label for="answer" class="form-label">답변 입력</label>
						<form:textarea path="answer" class="form-control" id="exampleFormControlTextarea1" rows="3" />
						<form:input path="qnaId" type="hidden" />
						<div class="d-flex">
							<form:button type="submit" class="btn btn-primary mt-2 ms-auto">수정 완료</form:button>
						</div>
					</div>
				</form:form>
				<div class="d-flex justify-content-end mt-1">
					<button type="button" class="btn btn-primary" id="editBtn" onclick="editClick()">답변 수정</button>
					<form:form modelAttribute="qna" action="/studybite/course/${courseInfo.courseId}/qna/answer" id="deleteAnswer">
						<form:hidden path="qnaId" value="${qna.qnaId}" />
						<form:button type="button" class="btn btn-primary ms-1" id="deleteBtn" onclick="delClick()">답변 삭제</form:button>
					</form:form>
				</div>
			</c:when>
			<c:when test="${user.role == 2 and empty qna.answer}">
				<form action="/studybite/course/${courseInfo.courseId}/qna/answer" method="post" enctype="multipart/form-data">
					<div class="my-3">
						<label for="answer" class="form-label">답변 입력</label>
						<textarea name="answer" class="form-control" id="exampleFormControlTextarea1" rows="3"></textarea>
						<input type="hidden" id="qnaId" name="qnaId" value="${qna.qnaId}">
						<button type="submit" class="btn btn-primary my-2" style="float: right">답변하기</button>
					</div>
				</form>
			</c:when>
		</c:choose>
		<div>
			<%-- <%@ include file="../common/footer.jsp" %> --%>
		</div>
	</div>
	<div class="w-25">
		<%@ include file="../common/rightbar.jsp"%>
	</div>
	<script src="${resPath}/js/courseBar.js"></script>
	<script type="text/javascript">
		var courseId = '${courseInfo.courseId}';
		console.log("courseId = " + courseId);
		$(".delete").click(
				function() {
					var id = $(this).attr('id');
					// 확인창
					var choice = confirm("질문을 삭제하겠습니까?");
					console.log('choice  ' + choice);
					//확인창에서 확인을 클릭하면,
					if (choice) {
						$('#deleteForm').attr('action',
								'/studybite/course/' + courseId + '/qna/' + id)
								.submit();
					}
				});

		function editClick() {
			$('#editAnswer').show();
			$('#editBtn').hide();
		};

		function delClick() {
			if (confirm("답변을 삭제하겠습니까?")) {
				$('#deleteAnswer').submit();
			}
		}
	</script>
</body>
</html>
