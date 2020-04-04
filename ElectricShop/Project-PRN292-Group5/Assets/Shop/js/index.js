function checkInput() {
    var name = document.getElementById('cus-name').value;
    var address = document.getElementById('cus-address').value;
    var note = document.getElementById('cus-note').value;
    var phone = document.getElementById('cus-phone').value;
    if (name.length < 1 || name == null) {
        alert('Cần điền tên khách hàng');
    }
    else if (address.length < 1 || address == null) {
        alert('Cần điền địa chỉ');
    }
    else if (phone.length < 1 || phone == null) {
        alert('Cần nhập số điện thoại');
    }
    else {
        if (note.length < 1 || note == null) {
            document.getElementById('cus-note').value = 'none';
        }
        document.getElementById('frm-addCus').submit();
    }
}
function checkOut() {
    var cusname = document.getElementById('select-cusname').value;
    var countOrder = document.getElementById('count-order').value;
    var note = document.getElementById('note').value;
    if (cusname == '-1') {
        alert('Bạn cần chọn người mua');
    }
    else if (countOrder < 1) {
        alert('Bạn cần chọn sản phẩm vào giỏ hàng');
    }
    else {
        if (note == null || note.length < 1) {
            note = "None";
        }
        document.getElementById('cusname').value = cusname;
        document.getElementById('note-order').value = note;
        document.getElementById('frm-checkout').submit();
        alert('Thành công');
    }
}function checkInput() {
    var name = document.getElementById('cus-name').value;
    var address = document.getElementById('cus-address').value;
    var note = document.getElementById('cus-note').value;
    var phone = document.getElementById('cus-phone').value;
    if (name.length < 1 || name == null) {
        alert('Cần điền tên khách hàng');
    }
    else if (address.length < 1 || address == null) {
        alert('Cần điền địa chỉ');
    }
    else if (phone.length < 1 || phone == null) {
        alert('Cần nhập số điện thoại');
    }
    else {
        if (note.length < 1 || note == null) {
            document.getElementById('cus-note').value = 'none';
        }
        document.getElementById('frm-addCus').submit();
    }
}
function checkOut() {
    var cusname = document.getElementById('select-cusname').value;
    var countOrder = document.getElementById('count-order').value;
    var note = document.getElementById('note').value;
    if (cusname == '-1') {
        alert('Bạn cần chọn người mua');
    }
    else if (countOrder < 1) {
        alert('Bạn cần chọn sản phẩm vào giỏ hàng');
    }
    else {
        if (note == null || note.length < 1) {
            note = "None";
        }
        document.getElementById('cusname').value = cusname;
        document.getElementById('note-order').value = note;
        document.getElementById('frm-checkout').submit();
        alert('Thành công');
    }
}