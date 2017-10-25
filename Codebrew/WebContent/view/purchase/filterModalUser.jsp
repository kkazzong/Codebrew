<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
  <div class="modal-dialog modal-sm" role="document">
    <div class="modal-content">
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
		<div class="row">
			<div class="col-md-12">
				<div class="page-header text-center">
					<h4 class="text-info">필터</h4>
				</div>
			</div>
		</div>
		<!-- 기간 -->
		<!-- <div class="row">
			<div class="col-md-12">
				<form class="form form-inline">
					<div class="input-group">
						<input id="dailySelect" class="form-control" type="text" name="statDate" placeholder="조회 기간 선택">
						<span class="input-group-btn">	
							<button class="btn btn-primary btn-block" type="button">
								<span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
							</button>
						</span>
					</div>
				</form>
			</div>
		</div> -->
		<div class="row">
			<div class="col-md-12 text-center">
				<div class="btn-group-vertical" role="group">
					<label class="control-label" for="priceSort">티켓티켓</label>
					<button class="btn btn-default" type="button" value="1">축제티켓</button>
					<button class="btn btn-default" type="button" value="2">파티티켓</button>
				</div>
			</div>
		</div>
    </div>
  </div>
</div>