
local tenant = std.extVar("tenant");

{
   apiVersion:  "v1",
   kind: "Namespace",
   metadata:  {  name: tenant }
}