local p = import '../params.libsonnet';
local params = p.components.backend;
local component  = 'backend';

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
                  "containerPort":9000
                }
              ],
              "env": [
                {
                "name": "DATABASE_URL",
                "value": "postgres://postgres:postgres@db:5432/news"
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
      "name": "backend"
    },
    "spec": {
      "selector": {
        "app": "backend"
      },
      "ports": [
        {
          "name": "backend",
          "targetPort": 9000,
          "port": 9000
        }
      ]
    }
  }
]
