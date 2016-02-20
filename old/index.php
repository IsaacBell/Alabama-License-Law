<?


$con=mysqli_connect("localhost","unexactl_billy","seinfeld33","unexactl_arec");
// Check connection
if (mysqli_connect_errno())
  {
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
  }

$result = mysqli_query($con,"SELECT * FROM law_files");


?>

<html>
<head>
	<link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'>
<style>
 body { font-family: 'Open Sans', sans-serif; text-align: center;}
 select { 
width: 300px;
height: 30px;
font-family: 'Open Sans';
font-size: 18px;}
 </style>
</head>
<body>
<h2>Select Law</h2>
<form action='getLaw.php' method='post'>
<select id='rule' name='rule'>
	<? while($row = mysqli_fetch_array($result))   { 
		echo "<option value='".$row['id']."'>".$row['id']."</option>";
	}
	?>
</select> 
<br>
<br>
<input type='submit' value='Submit'>
</form>
</body>
</html>