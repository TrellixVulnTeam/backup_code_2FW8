function fetchLike(post_id) {
  return fetch(`/api/like/${post_id}`, {
    method: 'post',
    credentials: "include",
  })
  .then(res => res.json())
  .then(r => {
    return {
      ...r,
      error: false
    }
  }).catch(e => {
    return {
      error: true,
    }
  })
}