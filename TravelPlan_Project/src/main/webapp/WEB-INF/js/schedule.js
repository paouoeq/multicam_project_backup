// 추가버튼
$(document).on("click", ".addBtn", function(){
	// 해당 버튼의 data-idx값 불러오기
//	console.log(this.dataset.idx);
	var idx = this.dataset.idx
	
	// index에 맞는 장소 이름, 주소 불러오기
	var title = $("#place_name"+idx).text();
	var addr1 = $("#address_name"+idx).text();
	var addr2 = $("#road_address_name"+idx).text();
//	console.log('click클릭이벤트 '+title+addr1+addr2);
//		console.log($(this).prev().prev().text());
	
	$.ajax({
        // 요청코드
        type:"get", // scheduleList으로 doget방식으로 url넘겨줌
        url:"scheduleList", // 버튼 눌렀을 때 이동할 곳 정하기
        data:{ // scheduleList 으로 넘겨줄 값
        	title:title,
        	addr1:addr1
        },

        // 응답코드
        success:function(data, satatus, xhr) { 
        	$.each(data, function(index, value) {
//        		console.log(index);
//        		console.log(value.title); 
//        		console.log(value.addr1); 
//        		console.log(value.addr2);
        		getScheduleList(title, addr1);
        	});
        	
        },
        error:function(xhr, status, error) {
            console.log("에러발생");
        }
    }); 

});

// 리스트 추가
function getScheduleList(title, addr1) {

	var inHtml ='<div class="list-group-item list-group-item-action py-3 lh-sm" aria-current="true">'+
					'<div class="d-flex w-100 align-items-center justify-content-between">' +
					'  <strong class="mb-1">'+title+'</strong>' + 
					'  <input type="text" class="time_text small" style="width: 45px;" placeholder="12:00">' +
					'</div>' +
					'<div class="col-10 mb-1 small">'+addr1+'</div>'+
					'<button class="removeBtn btn btn-danger" style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;">삭제</button>' +
				'</div>';

	$('.scheduleList').append(inHtml);
}

// 삭제버튼
$(document).on("click", ".removeBtn", function(){
	this.parentNode.remove(); // 해당 버튼의 부모 찾아서 삭제
});
