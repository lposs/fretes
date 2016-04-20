//local tenants = [ "bar", "foo" ];

local tstring = std.extVar("tenants");
local tenants = std.split(tstring," ");

// Defines a single ingress that sets up multiple host name based backends
{
   apiVersion: "extensions/v1beta1",
   kind: "Ingress",
   metadata: { name: "idm" },
   spec: {
     rules: [
           {  host: tenant + ".example.com",
               http: {
                  paths: [
                     { backend:  { serviceName: "openidm-" + tenant, servicePort: 80 }}
                  ]
               }
          } for tenant in tenants
     ]
   }
}