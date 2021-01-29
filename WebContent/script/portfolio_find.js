function inputCheck1(){
	if(document.findform.name.value ==""){
		alert("이름을 입력해주세요");
		document.findform.name.focus();
		return;	
	}
	if(document.findform.email.value ==""){
		alert("이메일을 입력해주세요");
		document.findform.email.focus();
		return;	
	}
	document.findform.submit();
}


function inputCheck2(){
	if(document.findform.name.value ==""){
		alert("이름을 입력해주세요");
		document.findform.name.focus();
		return;	
	}
	if(document.findform.email.value ==""){
		alert("이메일를 입력해주세요");
		document.findform.email.focus();
		return;	
	}
	if(document.findform.id.value ==""){
		alert("아이디를 입력해주세요");
		document.findform.id.focus();
		return;	
	}
	document.findform.submit();
}
