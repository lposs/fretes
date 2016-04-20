// OpenIDM template

local tenant = std.extVar("tenant");
{
apiVersion: "extensions/v1beta1",
kind: "Deployment",
metadata: { name: "openidm-" + tenant },
spec: {
  replicas: 1,
  template: {
    metadata: {
      labels: {
        name: "openidm",
        tenant: tenant
      }
    },
    spec: {
      containers: [
      {
        name: "openidm",
        image: "forgerock/openidm:nightly",
        ports: [{ containerPort: 8080 }],
        command: [ "/opt/openidm/startup.sh", "-p", "custom/stack-config/openidm"],
        // Note: Docker does not allow mounting on /
        volumeMounts: [{  name: "idmconf", mountPath: "/opt/openidm/custom" }]
      }],
      volumes: [
         { name: "idmconf",
            gitRepo: {
               repository: "https://github.com/ForgeRock/stack-config.git",
               revision: "3002b75422488b2be9a007305bf1d881c4ad0749"
            }
         }
      ]

    }
   }
  }
}