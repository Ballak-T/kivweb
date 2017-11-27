/**
 * Created by ballin on 15.6.17.
 */
function printElement(Element) {
    console.log("Element: "+Element);
}
function toggle(Element_id) {
    element = document.getElementById(Element_id);
    if(element.style.transform == "scale3d(1, 1, 1)")
        minimize(element);
    else
        maximize(element);
}
function show(Element) {
    Element.style.display = "block";
}
function hide(Element) {
    Element.style.display = "none";
}
function minimize(Element) {
    Element.style.transform = "scale3d(0,0,0)";
}
function maximize(Element) {
    Element.style.transform = "scale3d(1,1,1)";
}

function validatePassword(Main_id, Confirm_id){
    var main = document.getElementById(Main_id);
    var confirm = document.getElementById(Confirm_id);
    if(main.value != confirm.value) {
        confirm.setCustomValidity("Hesla se neshodují");
    } else {
        confirm.setCustomValidity('');
    }
}
function back() {
    window.history.back();
}