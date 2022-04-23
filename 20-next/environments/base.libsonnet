
// this file has the baseline default parameters
{
  components: { // required
    frontend: {
      indexData: 'frontend baseline\n',
      replicas: 1,
      repository: "maxnelipin/13-frontend",
      tag: "latest",
    },
    backend: {
      indexData: 'backend baseline\n',
      replicas: 1,
      repository: "maxnelipin/13-backend",
      tag: "latest",
    },
    db: {
      indexData: 'db baseline\n',
      replicas: 1,
      repository: "postgres",
      tag: "13-alpine"
    },
    twogisgeo: {

    },
  },
}
