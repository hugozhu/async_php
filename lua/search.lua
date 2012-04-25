local res = ngx.location.capture("/before_dispatch.php");
ngx.print(res.body);

local socket = ngx.socket.tcp();
socket:setkeepalive(1000 * 30,100);
socket:settimeout(1000);
local ok, err = socket:connect("220.181.111.85", 80);
local req = "GET /30ms.php HTTP/1.0\\r\\n\\r\\n";
local bytes, err = socket:send(req);
local line,  err = socket:receive("*a");
ngx.print(line);
socket:close();

res = ngx.location.capture("/after_dispatch.php");
ngx.print(res.body);