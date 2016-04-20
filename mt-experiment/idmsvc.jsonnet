local tenant = std.extVar("tenant");

{
   apiVersion: "v1",
       kind: "Service",
       metadata: { name: "openidm-" + tenant },
       spec: {
         selector: { name: "openidm", tenant: tenant },
         type: "NodePort",
         ports: [{  port: 80, targetPort: 8080 }]
       }
}