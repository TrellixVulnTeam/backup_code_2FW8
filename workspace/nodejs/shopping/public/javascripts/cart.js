const market = document.querySelector("#add-to-market")


market.addEventListener('click', function() {
  console.log(market.dataset.pid);
  
  fetch('/cart/add', {
    method: 'post',
    body: JSON.stringify({
      product_id: market.dataset.pid,
    }),
    headers: new Headers({
      'Content-Type': 'application/json'
    })
  }).then((d) => {
    return d.json()
  }).then(({msg, color}) => {
    toast(msg, color)
  })
  
})