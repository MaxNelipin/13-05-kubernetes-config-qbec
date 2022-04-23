local p = import '../params.libsonnet';
local params = p.components.frontend;
local component  = 'frontend';

[
  {
    apiVersion: 'v1',
    kind: 'ConfigMap',
    metadata: {
      name: component,
    },
    data: {
      'index.html': params.indexData,
    },
  },
  {
    apiVersion: 'apps/v1',
    kind: 'Deployment',
    metadata: {
      name: component,
      labels: {
        app: component,
      },
    },
    spec: {
      replicas: params.replicas,
      selector: {
        matchLabels: {
          app: component,
        },
      },
      template: {
        metadata: {
          labels: {
            app: component,
          },
        },
        spec: {
          containers: [
            {
              name: component,
              image: params.repository + ":" + params.tag,
              imagePullPolicy: 'IfNotPresent',
               "ports": [
                {
                  "containerPort":80
                }
              ],
              "env": [
                {
                "name": "BASE_URL",
                "value": "http://backend:9000"
                }
              ],
            },
          ],
        },
      },
    },
  },

  {
    "apiVersion": "v1",
    "kind": "Service",
    "metadata": {
      "name": "frontend"
    },
    "spec": {
      "selector": {
        "app": "frontend"
      },
      "ports": [
        {
          "name": "frontend",
          "targetPort": 80,
          "port": 8000
        }
      ]
    }
  }
]
