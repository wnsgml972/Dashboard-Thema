function play(){
	alert("1");
}
function pause(){
    alert('2');
}
function stop(){
	alert("3");
}

function httpGetAsync(theUrl, callback)
{
    var xmlHttp = new XMLHttpRequest();
    xmlHttp.onreadystatechange = function() { 
        if (xmlHttp.readyState == 4 && xmlHttp.status == 200){
        	 callback(xmlHttp.responseText);
        }           
    }
    xmlHttp.open("GET", theUrl, true); // true for asynchronous 
    xmlHttp.send(null);
}
function myCallBack(response){
	alert(response);
}
