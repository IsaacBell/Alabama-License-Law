<?
$lawid = $_POST['rule'];


$con=mysqli_connect("localhost","unexactl_billy","seinfeld33","unexactl_arec");
// Check connection
if (mysqli_connect_errno())
  {
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
  }

$result = mysqli_query($con,"SELECT * FROM law_files WHERE id='$lawid'");


while($row = mysqli_fetch_array($result))   {

?>
  

  <html>
<head>
	<script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-2.0.0.min.js"></script>
	<link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'>
	<style>
		body {
			font-family: 'Open Sans', sans-serif;
			font-size: 16px;
			line-height: 1.5em;
			background-color: white;
		}
		ol {
			list-style: none;
			list-style-position: inside;
		}

		ol:first-of-type {
			padding-left:0px;
		}
		
		li {
			padding: 8px;
			border: 1px solid #C7C7C7;
		}
		
		#menu {
			width: 100%;
			position: fixed;
			top: 0px;
			right: 8px;
			height: 60px;
			background-color: #2c291b;
			margin-left: 0;
			min-width: 328px;
		}
		#space {
			width: 110%;
			height: 60px;
		}
		h4 {
			text-align: center;
			font-size: 36px;
			color:  #2c291b;
			margin: 24px;

		}
		#btn1 {
			float:left;
			padding-left:9px;
			padding-top:9px;
		}
		#btn2 {
			float:right;
			padding: 9px 0 0 9px;
		}
		footer {
			font-size: 13px;
		}
		.li-head {
			font-weight: bold;
		}

		h6 {
			text-align: center;
			font-size: 1.2em;
			margin: 0;
			color: #5C5438;
		}

	</style>
	<script>
	$(document).ready(function () {
		var letters = 'abcdefghijklmnopqrstuvwxyz';
		$('li').each(function (i, ele) {
		    $('<span />', {html : (function() {
		        return $(ele).parents('li').addBack().map(function (_, a) {
		                 return isNaN( $(a).parent('ol').attr('type') ) ? 
		                        letters[$(a).index()] :
		                        $(a).index() + 1;
		                }).get().join('.') + ')&nbsp;';
		     }()), class:"li-head"}).prependTo(ele);
		});
		$('p:contains("Statutory Authority:"),p:contains("History:"),p:contains("(Acts "),p:contains("(Act "),p:contains("Cross references"),p:contains("Cross References"),p:contains("See RULE"),p:contains("Author: Alabama Real Estate")').wrapAll("<footer>");
		$("<hr>").prependTo("footer");
		$('li:odd').css("background-color", "#FFF");
		$('li:even').css("background-color", "#EEEDED");
	});
	</script>
</head>
<body>
	<div id='menu'>
		<img src='btn1.png' id='btn1'><img src='btn1.png' id='btn1'>
		<img src='home.png' id='btn2'><img src='home.png' id='btn2'>
	</div>
	<div id='space'></div>
<h4><? echo $row['id']; ?> </h4>
<h6><? echo $row['title']; ?></h6>

<hr>


<? echo $row['content']; ?>

  
</body>
</html>




<?

}
mysqli_close($con);

?>