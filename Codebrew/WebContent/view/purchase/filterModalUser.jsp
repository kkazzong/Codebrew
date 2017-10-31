<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
    
    	<div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">필터</h4>
	      </div>
	      
	      <div class="modal-body">
			<!-- 
		      <select class="form-control">
									<option value="" selected="selected">필터</option>
									<optgroup label="가격">
										<option value="1">가격▲</option>
										<option value="2">가격▼</option>
									</optgroup>
									<optgroup label="아이디">
										<option value="3">아이디▲</option>
										<option value="4">아이디▼</option>
									</optgroup>
									<optgroup label="구매날짜">
										<option value="5">구매날짜▲</option>
										<option value="6">구매날짜▼</option>
									</optgroup>
				</select>
			-->
			<!-- <div class="row">
				<div class="col-md-12">
					<div class="page-header text-center">
						<h4 class="text-info">필터</h4>
					</div>
				</div>
			</div> -->
			
			<!-- 기간 -->
			<div class="row">
				<div class="col-md-12 text-center">
					<form class="form form-inline" id="dateSearchForm" name="dateSearchForm">
					<div class="form-group">
						<input type="hidden" id="currentPageDate" name="currentPage" value=""/>
						<input type="hidden" id="searchCondition" name="searchCondition" value="6">
						<input class="col-md-7 form-control form-inline input-lg" type="text" id="startDate" name="startDate" value="${!empty search.startDate ? search.startDate : ''}" placeholder="조회 기간 선택" readonly>
						<input class="col-md-7 form-control form-inline input-lg" type="text" id="endDate" name="endDate" value="${!empty search.endDate ? search.endDate : ''}" placeholder="조회 기간 선택" readonly>
						<span class="input-group-btn">	
							<button id="dateRange" class="btn btn-default btn-lg btn-block" type="button">
								<span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
							</button>
						</span>
					</div>
				</form>
				</div>
			</div>
			
			<hr>
			
			<div class="row">
				<div class="col-md-12 text-center">
						<button class="btn btn-default btn-lg" type="button" value="1">축제티켓</button>
				</div>
			</div>
			
			<div class="row">
				<div class="col-md-12 text-center">
						<button class="btn btn-default btn-lg" type="button" value="2">파티티켓</button>
				</div>
			</div>
		</div>
		
		<div class="modal-footer">
	        <button type="button" class="btn btn-default btn-lg" data-dismiss="modal">닫기</button>
      	</div>
    </div>
  </div>
</div>