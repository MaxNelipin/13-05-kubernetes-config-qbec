[

  {
    "apiVersion": "v1",
    "kind": "Endpoints",
    "metadata": {
      "name": "twogisgeo"
    },
      "subsets": [
        {
          "addresses": [

            {
                "ip": "91.236.49.5"
            }

          ],
          "ports": [
                {
                    "name": "web",
                    "port": 443,
                },
            ],
        }
      ]
  },

  {
    "apiVersion": "v1",
    "kind": "Service",
    "metadata": {
      "name": "twogisgeo",
      "labels": {
         "name": "twogisgeo"
      }
    },
    "spec": {
    "selector": {
        "name": "twogisgeo"
      },
      "ports": [
        {
          "name": "web",
          "protocol": "TCP",
          "port": 443,
          "targetPort": 443
        }
      ]
    }
  },


]
