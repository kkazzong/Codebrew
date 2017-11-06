<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html lang="ko">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>판매목록</title>

<style rel="stylesheet">
body {
  font-family: "Helvetica Neue", Helvetica, Arial;
  font-size: 14px;
  line-height: 20px;
  font-weight: 400;
  color: #3b3b3b;
  padding-top : 70px;
  -webkit-font-smoothing: antialiased;
  font-smoothing: antialiased;
  background-color: #f2f4f6;
}

.wrapper {
  margin: 0 auto;
  padding: 40px;
  max-width: 800px;
}

.table {
  margin: 0 0 40px 0;
  width: 100%;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.2);
  display: table;
}
@media screen and (max-width: 580px) {
  .table {
    display: block;
  }
}

.row {
  display: table-row;
  background: #f6f6f6;
}
.row:nth-of-type(odd) {
  background: #e9e9e9;
}
.row.header {
  font-weight: 900;
  color: #ffffff;
  background: #ea6153;
}
.row.green {
  background: #27ae60;
}
.row.blue {
  background: #2980b9;
}
@media screen and (max-width: 580px) {
  .row {
    padding: 8px 0;
    display: block;
  }
}

.cell {
  padding: 6px 12px;
  display: table-cell;
}
@media screen and (max-width: 580px) {
  .cell {
    padding: 2px 12px;
    display: block;
  }
}

</style>
</head>
<body>

<div class="wrapper">
  
  <div class="table">
    
    <div class="row header">
      <div class="cell">
        NO
      </div>
      <div class="cell">
        구매번호
      </div>
      <div class="cell">
        아이디
      </div>
      <div class="cell">
        분류
      </div>
      <div class="cell">
        티켓명
      </div>
      <div class="cell">
        구매날짜
      </div>
      <div class="cell">
        수량
      </div>
      <div class="cell">
        결제금액
      </div>
      <div class="cell">
        상태
      </div>
    </div>
    
    <c:forEach var="purchase" items="${list}">
							<c:set var="i" value="${i+1}"></c:set>
					<div class="row">
								<div class="cell">${i}</div>
								<div class="cell">${purchase.purchaseNo}</div>
								<div class="cell">${purchase.user.userId}</div>
								<div class="cell">
									<c:choose>
										<c:when test="${purchase.purchaseFlag == 1}">
											<span class="badge badge-pill badge-info"># 축제</span>
										</c:when>
										<c:when test="${purchase.purchaseFlag == 2}">
											<span class="badge badge-pill badge-warning"># 파티</span>
										</c:when>
									</c:choose>
								</div>
								<div class="cell">${purchase.itemName}</div>
								<div class="cell">${purchase.purchaseDate}</div>
								<div class="cell">${purchase.purchaseCount}장</div>
								<div class="cell"><%-- ${purchase.purchasePrice} --%>${purchase.price}원</div>
								<div class="cell">
								<c:if test="${purchase.tranCode == 1}">
									결제완료
								</c:if>
								<c:if test="${purchase.tranCode == 2}">
									<span class="text-danger">결제취소</span>
								</c:if>
								</div>
						</div>
						</c:forEach>
    
   
  </div>
  
  
  
</div>

</body>
</html>
