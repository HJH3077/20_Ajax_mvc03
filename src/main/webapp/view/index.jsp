<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
span {
	width: 150px;
	color: tomato;
}

input {
	border: 1px solid red;
	padding: 8px;
}

table {
	width: 70%;
	margin: 0 auto;
	border-collapse: collapse;
}

table, th, td {
	border: 1px solid gray;
	text-align: center;
}

h2 {
	text-align: center;
}
</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		// 리스트 불러오기 
		// 회원가입 성공이나 삭제가 성공되면 다시 DB에 갖다와야 한다.
		function getList() {
			$("#tbody").empty();
			// input type 내용들 지우기 
			$.ajax({
				url : "/MyController",
				method : "post",
				dataType : "xml",
				success : function(data) {
					var tbody = "";
					$(data).find("member").each(
							function() {
								tbody += "<tr>";
								tbody += "<td  style='padding: 8px;' >"
										+ $(this).find("idx").text() + "</td>";
								tbody += "<td>" + $(this).find("id").text()
										+ "</td>";
								tbody += "<td>" + $(this).find("pw").text()
										+ "</td>";
								tbody += "<td>" + $(this).find("name").text()
										+ "</td>";
								tbody += "<td>" + $(this).find("age").text()
										+ "</td>";
								tbody += "<td>" + $(this).find("addr").text()
										+ "</td>";
								tbody += "<td>" + $(this).find("reg").text()
										+ "</td>";
								tbody += "<td><button id='del' idx='"
										+ $(this).find("idx").text()
										+ "'>삭제</button></td>";
								tbody += "</tr>";
							});
					$("#tbody").append(tbody);
				},
				error : function() {
					alert("읽기실패");
				}
			});
		}

		// 아이디 중복검사
		$("#btn1").click(function() {
			if ($("#id").val() == "") {
				alert("중복검사를 확인해야 가입 가능합니다.");
				$("#id").focus();
				return;
			}
			// id값을 파리미터로 넘겨서 DB 검사 해야 된다.
			$.ajax({
				url : "/MyController2",
				method : "post",
				data : "id=" + $("#id").val(),
				dataType : "text",
				success : function(data) {
					if (data.trim() == '1') {
						alert("아이디 중복\n다시 입력하세요 ");
						$("#id").val("");
						$("#id").focus();
						$("#btn2").attr("disabled", true); // 비활성화
					} else {
						alert("아이디 사용 가능");
						$("#btn2").attr("disabled", false); // 활성화
					}
				},
				error : function() {
					alert("읽기실패");
				}
			});

			// 데이터를 직렬로 전송해서 한번에 보내서 회원가입
			$("#btn2").click(function() {
				// serialize: form 안에 있는 모든 파라미터값이 직렬 전달된다. 
				$.ajax({
					url : "/MyController3",
					method : "post",
					data : $("#myForm").serialize(),
					dataType : "text",
					success : function(data) {
						if (data.trim() == '0') {
							alert("회원 가입 실패");
						} else {
							alert("회원 가입 성공");
							getList();
						}
						$("#btn2").attr("disabled", true); // 비활성화
					},
					error : function() {
						alert("읽기실패");
					}
				});
			});
		});

		// 동적바인딩 변수이기 때문에 click를 사용 못함
		// $("셀렉터").on("이벤트","셀렉터", function(){})
		$("table").on("click", "#del", function() {
			$.ajax({
				url : "/MyController4",
				method : "get",
				data : "idx=" + $(this).attr("idx"),
				dataType : "text",
				success : function(data) {
					if (data.trim() == '1') {
						alert("삭제성공");
						getList();
					} else {
						alert("삭제실패");
					}
					$("#btn2").attr("disabled", true); // 비활성화
				},
				error : function() {
					alert("읽기실패");
				}
			});
		});
		// 리스트 함수 호출
		getList();
	});
</script>
<script type="text/javascript"></script>
</head>
<body>
	<h2>회원 정보 입력하기</h2>
	<form method="post" id="myForm">
		<table>
			<thead>
				<tr>
					<th>ID</th>
					<th>PW</th>
					<th>NAME</th>
					<th>AGE</th>
					<th>ADDR</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><input type="text" name="id" id="id" required>
						<button type="button" id="btn1">중복확인</button></td>
					<td><input type="password" name="pw"></td>
					<td><input type="text" name="name"></td>
					<td><input type="number" name="age"></td>
					<td><input type="text" name="addr"></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<!-- 중복하기를 성공해야 가입하기를 활성화 -->
					<td colspan="5"><input type="button" id="btn2" value="가입하기"></td>
				</tr>
			</tfoot>
		</table>
	</form>
	<h2>회원 정보 보기</h2>
	<div>
		<table id="list">
			<thead>
				<tr>
					<th>IDX</th>
					<th>ID</th>
					<th>PW</th>
					<th>NAME</th>
					<th>AGE</th>
					<th>ADDR</th>
					<th>REG</th>
					<th>삭제여부</th>
				</tr>
			</thead>
			<tbody id="tbody"></tbody>
		</table>
	</div>
</body>
</html>