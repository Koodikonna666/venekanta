<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="scripts/main.js"></script>
<link rel="stylesheet" type="text/css" href="css/styles.css">
<title>Muuta venettä</title>
</head>
<body onkeydown="tutkiKey(event)">
<div class="keskitys">
	<div class="taulukko">
<form id="tiedot">
			<h1 style="text-align:center">Muuta venettä</h1>

						<div class="varoitus">
							<span id="ilmo"></span>
						</div>
						<div  class="lisays-info">
							<span id="info"></span>
						</div>
					
						<label>Nimi</label>
						<input type="text" name="nimi" id="nimi" placeholder="Sylvia">
						<label>Merkki / Malli</label>
						<input type="text" name="merkkimalli" id="merkkimalli" placeholder="Grandezza 28 DC">
						<label>Pituus (m)</label>
						<input type="number" name="pituus" id="pituus" step=".01" placeholder="5,52">
						<label>Leveys (m)</label>
						<input type="number" name="leveys" id="leveys" step=".01" placeholder="2,11">
						<label>Hinta (€)</label>
						<input type="number" name="hinta" id="hinta" placeholder="50 000">
						<div class="painikkeet">
						<a class="peruuta" href="listaaveneet.jsp" id="takaisin">Takaisin</a>
						<input class ="lisaa" type="button" id="tallenna" value="Muuta" onclick="vieTiedot()">
						</div>
				
		
	<input type="hidden" name="tunnus" id="tunnus">	
</form>
</div>
</div>
</body>
<script>

function tutkiKey(event){
	if(event.keyCode==13){
		lisaaTiedot();
	}
	
}

document.getElementById("nimi").focus();


var tunnus = requestURLParam("tunnus"); 
fetch("veneet/haeyksi/" + tunnus,{
      method: 'GET'	     
    })
.then( function (response) {
	return response.json()
})
.then( function (responseJson) {
	console.log(responseJson)
	document.getElementById("tunnus").value = responseJson.tunnus;	
	document.getElementById("nimi").value = responseJson.nimi;	
	document.getElementById("merkkimalli").value = responseJson.merkkimalli;	
	document.getElementById("pituus").value = responseJson.pituus;	
	document.getElementById("leveys").value = responseJson.leveys;	
	document.getElementById("hinta").value = responseJson.hinta;	
});	


function vieTiedot(){	
	var ilmo="";
	if(document.getElementById("nimi").value.length<1){
		ilmo="Antamasi nimi on liian lyhyt";
	}else if(document.getElementById("merkkimalli").value.length<2){
		ilmo="Antamasi merkki / malli on liian lyhyt";
	}else if(document.getElementById("pituus").value.length<1){
		ilmo="Antamasi pituus on liian lyhyt";
	}else if(document.getElementById("pituus").value*1!=document.getElementById("pituus").value){
		ilmo="Antamasi pituus ei ole numeraalinen";
	}else if(document.getElementById("leveys").value.length<0.5){
		ilmo="Antamasi leveys on liian kapea";
	}else if(document.getElementById("leveys").value*1!=document.getElementById("leveys").value){
		ilmo="Antamasi leveys ei ole numeraalinen";
	}else if(document.getElementById("hinta").value*1!=document.getElementById("hinta").value){
		ilmo="Syöttämäsi hinta numeraalinen";
}
	if(ilmo!=""){
		document.getElementById("ilmo").innerHTML=ilmo;
		setTimeout(function(){ document.getElementById("ilmo").innerHTML=""; }, 3000);
		return;
	}
	
	var formJsonStr=formDataToJSON(document.getElementById("tiedot")); 
	
	fetch("veneet",{
	      method: 'PUT',
	      body:formJsonStr
	    })
	.then( function (response) {	
		return response.json()
	})
	.then( function (responseJson) {
		var vastaus = responseJson.response;
		if(vastaus==0){
			document.getElementById("ilmo").innerHTML= "Veneen päivittäminen epäonnistui";
    	}else if(vastaus==1){	        	
    		document.getElementById("info").innerHTML= "Veneen päivittäminen onnistui";			      	
		}
		setTimeout(function(){ document.getElementById("ilmo").innerHTML=""; }, 5000);
	});	
	document.getElementById("tiedot").reset(); 
}
</script>
</html>