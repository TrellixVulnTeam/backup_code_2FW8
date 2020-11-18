import React from 'react';

function loadJson(json) {
  return {}
}

export default function(WrapperComponent, json) {
  const data = loadJson(json);
  return <WrapperComponent {...data} />
}