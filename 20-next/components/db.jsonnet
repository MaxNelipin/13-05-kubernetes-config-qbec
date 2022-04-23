local p = import '../params.libsonnet';
local params = p.components.db;
local component  = 'db';


[
  {
    "kind": "StatefulSet",
    "apiVersion": "apps/v1",
    "metadata": {
      "name": "db"
    },
    "spec": {
      "serviceName": "db",
      "selector": {
        "matchLabels": {
          "component": "db"
        }
      },
      "template": {
        "metadata": {
          "labels": {
            "component": "db"
          }
        },
        "spec": {
          "containers": [
            {
              "name": "db",
              "image": params.repository + ":" + params.tag,
              "env": [
                {
                "name": "POSTGRES_USER",
                "value": "postgres"
                },
                 {
                "name": "POSTGRES_PASSWORD",
                "value": "postgres"
                },
                 {
                "name": "POSTGRES_DB",
                "value": "news"
                },
              ],
              "ports": [
                {
                  "containerPort":5432
                }
              ]
            }
          ]
        }
      }
    }
  },
  {
    "apiVersion": "v1",
    "kind": "Service",
    "metadata": {
      "name": "db"
    },
    "spec": {
      "selector": {
        "component": "db"
      },
      "ports": [
        {
          "name": "db",
          "targetPort": 5432,
          "port": 5432
        }
      ]
    }
  }
]
