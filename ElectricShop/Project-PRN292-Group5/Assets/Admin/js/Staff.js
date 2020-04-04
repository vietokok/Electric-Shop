function checkInput() {

    var name = document.getElementById('cus-name').value;

    var gender = document.getElementById('cus-gender').value;
    var adress = document.getElementById('cus-adress').value;
    var note = document.getElementById('cus-note').value;
    if (name.length < 1 || name == null) {
        alert('Cần điền tên nhân viên');
    }
    else if (gender.length < 1 || gender == null) {
        alert('Cần điền giới tính');
    }
    else if (adress.length < 1 || adress == null) {
        alert('Cần điền địa chỉ');
    } else {
        if (note.length < 1 || note == null) {
            document.getElementById('cus-note').value = 'none';
        }
        document.getElementById('frm-addStaff').submit();
    }


}
function checkInput1(x) {

    var name = document.getElementById('name' + x).value;
    var gender = document.getElementById('gender' + x).value;
    var adress = document.getElementById('adress' + x).value;
    var note = document.getElementById('note' + x).value;
    //var id = document.getElementById('ID' + x).value;
    var editID = document.getElementById('edit-id' + x).value;
    // alert(x);
    if (name.length < 1 || name == null) {
        alert('Cần điền tên nhân viên');
    }
    else if (gender.length < 1 || gender == null) {
        alert('Cần điền giới tính');
    }
    else if (adress.length < 1 || adress == null) {
        alert('Cần điền địa chỉ');
    } else {
        if (note.length < 1 || note == null) {
            document.getElementById('note' + x).value = '';

        }

        document.getElementById('frm-editStaff' + x).submit();
        //  alert(x + "========");
    }


}
function checkInput2() {

    var name = document.getElementById('cus-name').value;
    var adress = document.getElementById('cus-adress').value;
    var phone = document.getElementById('cus-phone').value;
    var note = document.getElementById('cus-note').value;
    if (name.length < 1 || name == null) {
        alert('Cần điền tên khách hàng');
    }
    else if (adress.length < 1 || adress == null) {
        alert('Cần điền địa chỉ');

    }
    else if (phone.length < 1 || phone == null) {
        alert('Cần điền số điện thoại');
    } else {
        if (note.length < 1 || note == null) {
            document.getElementById('cus-note').value = 'none';
        }
        document.getElementById('frm-addCus').submit();
    }


}