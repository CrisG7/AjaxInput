<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>AjaxDemo</title>
<style type="text/css">
	#mydiv{
		position: absolute;
		left: 45%;
		top: 40%;
		margin-left: -200px;
		margin-top: -50px;
	}
	
	.mouseOver{
		background: #708090;
		color: #FFFAFA
	}
	.mouseOut{
		background: #FFFAFA;
		color: #000000;
	}
	input{
                border: 1px solid #ccc;
                padding: 7px 0px;
                border-radius: 3px;
                padding-left:5px;
                -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
                box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
                -webkit-transition: border-color ease-in-out .15s,-webkit-box-shadow ease-in-out .15s;
                -o-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
                transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s
            }
    input:focus{
                    border-color: #66afe9;
                    outline: 0;
                    -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075),0 0 8px rgba(102,175,233,.6);
                    box-shadow: inset 0 1px 1px rgba(0,0,0,.075),0 0 8px rgba(102,175,233,.6)
            }
</style>
<script type="text/javascript">
	var xmlHttp;
	function getMoreContents(){
		var content = document.getElementById("keyword");
		if(content.value==""){
			clearContent();
			return;
		}
		//使用ajax异步传输
		xmlHttp=createXMLHttp();
		var url = "search?keyword="+escape(content.value);		
		//xmlHttp绑定回调函数，回来每次xmlHttp状态改变时被调用0-4.只关心4状态
		xmlHttp.onreadystatechange=function(){
			if(xmlHttp.readyState==4&&xmlHttp.status==200){
				//接受服务器响应的数据,是文本数据，JSON也是文本数据
				var result=xmlHttp.responseText;
				//解析数据
				var json=eval("("+result+")");
				setContent(json)
			}
		}
		xmlHttp.open("GET",url,true);
		xmlHttp.send();
		
	}
	function createXMLHttp(){
		var xmlHttp;
		if(window.XMLHttpRequest){
			xmlHttp=new XMLHttpRequest();
		}
		if(window.ActiveXObject){
			xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
			if(!xmlHttp){
				xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
			}
		}
		return xmlHttp;
	}
	//关联数据的展示函数
	function setContent(content){
		clearContent();
		setLocation();
		var size = content.length;
		for(var i=0;i<size;i++){
			var nextNode=content[i];
			var tr=document.createElement("tr");
			var td=document.createElement("td");
			td.setAttribute("border", 0);
			td.setAttribute("bgcolor", "#FFFAFA");
			td.onmouseover=function(){
				this.className="mouseOver";
			};
			td.onmouseout=function(){
				this.className="mouseOut";
			};
			td.onmousedown = function(){
				console.log("onmousedown");
		        document.getElementById("keyword").value = this.innerText;
		    };
			td.onclick=function(){
				console.log(this.innerText);
				document.getElementById("keyword").value=this.innerText;
			}
			var text = document.createTextNode(nextNode);
			td.appendChild(text);
			tr.appendChild(td);
			document.getElementById("content_table_body").appendChild(tr);
		}
	}
	//清空数据函数
	function clearContent(){
		var contentBody = document.getElementById("content_table_body");
		var size = contentBody.childNodes.length;
		for(var i=size-1;i>=0;i--){
			contentBody.removeChild(contentBody.childNodes[i]);
		}
		document.getElementById("popdiv").style.border="none";
	}
	function keywordbour(){
		console.log("keywordbour");
		clearContent();
	}
	function setLocation(){
		var content = document.getElementById("keyword");
		var width=content.offsetWidth;
		var left=content["offsetLeft"];//距离左边框距离
		var top=content["offsetTop"]+content.offsetHeight;
		//获得显示数据的div
		var popdiv=document.getElementById("popdiv");
		popdiv.style.border="black 1px solid";
		popdiv.style.left=left+"px";
		popdiv.style.top=top+"px";
		popdiv.style.width=width+"px";
		document.getElementById("content_table").style.width=width+"px";
	}
</script>
</head>
<body>
          
	<div id="mydiv">
	    <h2>Ajax+Servlet实现输入框智能提示</h2>
		<input id="keyword" type="text" size="50" onkeyup="getMoreContents()" onblur="keywordbour()" onfocus="getMoreContents()">
		<div id="popdiv">
			<table id="content_table" bgcolor="#FFFAFA" border="0" cellpadding="0" cellspacing="0">
				<!-- 数据显示区域 -->
				<tbody id="content_table_body">
				
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>