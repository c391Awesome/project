day: <%= request.getParameter("day") %>
year: <%= request.getParameter("year") %>
month: <%= request.getParameter("month") %>

<ul>
<li>
<a href="analysis.jsp?year=2013">2013</a> / <a href="analysis.jsp?month=3">03</a>/ <a href="analysis.jsp?day=12">12</a>
</li>

<li>
<a href="analysis.jsp?year=2014">2014</a> / <a href="analysis.jsp?month=5">05</a>/ <a href="analysis.jsp?day=10">10</a>
</li>
</ul>
