<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="css/styles.css">
<script src="scripts/main.js"></script>
<title>Veneet</title>
</head>
<body onkeydown="tutkiKey(event)">
<div class="keskitys">
	<div class="taulukko">
	
	<h1 style="text-align:center; margin-bottom: 50px">Tervetuloa venekantaan</h1>
	
	<div>
		<div class="flex">
			<div class="ab haku-teksti"><label>Haku:</label></div>
			<input type="text" id="hakusana">
			<div class="ab"><input class="lisaa" type="button" value="hae" id="hakunappi" onclick="haeTiedot()"></div>
			<div class="ab"><a class="lisaa" id="uusiVene" href="lisaavene.jsp">Lisää uusi vene</a></div>
		</div>	
	</div>
		<table id="veneet">
			<thead>	
				<tr>
					<th>Nimi</th>
					<th>Merkki / Malli</th>
					<th>Pituus</th>
					<th>Leveys</th>							
					<th>Hinta</th>							
					<th></th>							
				</tr>
			</thead>
			<tbody id="tbody">
					
			</tbody>
		</table>
	</div>
</div>
<script>
haeTiedot();	

//hakukenttä aktiiviseksi kun sivu latautuu
document.getElementById("hakusana").focus();

//enterin aktivointi
function tutkiKey(event){
	if(event.keyCode==13){
		haeTiedot();
	}		
}

//haetaan veneiden teidot
function haeTiedot(){
	document.getElementById("tbody").innerHTML = "";
	fetch("veneet/"+ document.getElementById("hakusana").value,{
		method: 'GET'
	})
	.then(function (response){
		return response.json()
	})
	.then(function (responseJson) {	
		var veneet = responseJson.veneet;	
		var htmlStr="";
		for(var i=0;i<veneet.length;i++){			
        	htmlStr+="<tr id='rivi_"+veneet[i].tunnus+"'>";
        	htmlStr+="<td>"+veneet[i].nimi+"</td>";
        	htmlStr+="<td>"+veneet[i].merkkimalli+"</td>";
        	htmlStr+="<td>"+veneet[i].pituus+"m</td>";
        	htmlStr+="<td>"+veneet[i].leveys+"m</td>";  
        	htmlStr+="<td>"+veneet[i].hinta+" €</td>";  
        	htmlStr+="<td class='center'><a class='muuta' href='muutavene.jsp?tunnus="+veneet[i].tunnus+"'>Muuta</a>&nbsp;";
        	htmlStr+="<span class='poista' onclick=poista("+veneet[i].tunnus+",'"+veneet[i].nimi.replace(/ /g,'&nbsp')+"','"+veneet[i].merkkimalli.replace(/ /g,'&nbsp')+"')>Poista</span></td>";
        	htmlStr+="</tr>";
		}
		document.getElementById("tbody").innerHTML = htmlStr;		
	})	
}


function poista(tunnus, nimi, merkkimalli){
	document.getElementById('rivi_'+tunnus).style.backgroundColor = "red";
	if (confirm("Poistetaanko " + nimi.replace(/(&nbsp)/g,' ') + " " + merkkimalli.replace(/(&nbsp)/g,' ') + " ?")){
		fetch("veneet/"+ tunnus,{
		      method: 'DELETE'		      	      
		    })
		.then(function (response) {
			return response.json()
		})
		.then(function (responseJson) {
			var vastaus = responseJson.response;		
			if(vastaus==0){
				document.getElementById("ilmo").innerHTML= "Veneen poisto epäonnistui.";
	        }else if(vastaus==1){	        	
				haeTiedot();
				alert("Vene " + nimi + " " + merkkimalli + " on poistettu.")
	        }	
			setTimeout(function(){ document.getElementById("ilmo").innerHTML=""; }, 5000);
		})		
	}	
	document.getElementById('rivi_'+tunnus).style.backgroundColor = "rgba(255, 255, 255, 0)";
}


</script>
</body>
</html>