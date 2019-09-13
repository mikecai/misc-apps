<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Session Cached Counter</title>
</head>
<body>




	<p>
		<b>Hazelcast Session ID = ${hc_sess_id}</b>
	</p>
	<p>
		<b>JSession ID = ${j_sess_id}</b>
	</p>
	<p>
		<b>Pod Name = ${pod_name}</b>
	</p>
	<p>
		<b>Current counter = ${counter}</b>
	</p>
	<p>
		<b>Current count = ${counter.getCount()}</b>
	</p>

	<form action="CounterServlet" method="POST">
		<input type="submit" name="increment" value="Increment Counter">
		<input type="submit" name="decrement" value="Decrement Counter">
		<input type="submit" name="reset" value="Reset Counter"> <input
			type="submit" name="invalidate" value="Invalide Servlet Session">
		<input type="hidden" name="counter" value="${counter}"> <input
			type="hidden" name="j_sess_id" value="${j_sess_id}"> <input
			type="hidden" name="hc_sess_id" value="${hc_sess_id}">
	</form>
</body>
</html>