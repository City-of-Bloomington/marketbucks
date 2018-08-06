echo off
set var=bucks
copy .\build\WEB-INF\classes\%var%\*.class .\WEB-INf\classes\%var%\.
:done
