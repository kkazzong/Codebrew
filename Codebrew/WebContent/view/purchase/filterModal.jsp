<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
    	<div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">필터</h4>
	      </div>
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
		<div class="modal-body">
		<div class="row">
			<div class="col-md-4 text-center">
				<div class="btn-group-vertical" role="group">
					<label class="control-label" for="priceSort">판매금액 정렬</label>
					<button class="btn btn-default btn-lg" type="button" value="1">판매금액▲</button>
					<button class="btn btn-default btn-lg" type="button" value="2">판매금액▼</button>
				</div>
			</div>
		<!-- </div>
		<div class="row"> -->
			<div class="col-md-4 text-center">
				<div class="btn-group-vertical" role="group">
					<label class="control-label" for="countSort">판매수량 정렬</label>
					<button class="btn btn-default btn-lg" type="button" value="3">판매수량▲ </button>
					<button class="btn btn-default btn-lg" type="button" value="4">판매수량▼ </button>
				</div>
			</div>
		<!-- </div>
		<div class="row"> -->
			<div class="col-md-4 text-center">
				<div class="btn-group-vertical" role="group">
					<label class="control-label" for="idSort">회원 아이디 정렬</label>
					<button class="btn btn-default btn-lg" type="button" value="5">아이디▲ </button>
					<button class="btn btn-default btn-lg" type="button" value="6">아이디▼ </button>
				</div>
			</div>
		</div>
		</div>
    </div>
  </div>
</div>