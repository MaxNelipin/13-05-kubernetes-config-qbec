
// this file returns the params for the current qbec environment
// you need to add an entry here every time you add a new environment.

local env = std.extVar('qbec.io/env');
local base = import './environments/base.libsonnet';
//local default = import './environments/default.libsonnet';
//local prod = default;
//prod.components.hello.indexData = 'hello prod from params';
local prod = base {
  components +: {
    frontend +: {
      indexData: 'frontend prod from params\n',
      replicas: 3,

    },
     backend +: {
      indexData: 'backend prod from params\n',
      replicas: 3,

    },
    twogisgeo +: {
      indexData: 'twogisgeo prod from params\n',

    },
  }
};

local stage = base {
  components +: {
    frontend +: {
      indexData: 'frontend stage from params\n',
      replicas: 1,

    },
     backend +: {
      indexData: 'backend stage from params\n',
      replicas: 1,

    },
  }
};

local paramsMap = {
  _: base,
  stage: stage,
  prod: prod,
};

if std.objectHas(paramsMap, env) then paramsMap[env] else error 'environment ' + env + ' not defined in ' + std.thisFile

