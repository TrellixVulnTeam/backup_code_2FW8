function onLoad() {
  const tweets = document.querySelector("#tweets").querySelectorAll("tr");
  tweets.forEach(function (tweet) {
    const id = tweet.dataset.tweetid;
    const btn = tweet.querySelector("button")
    btn.addEventListener('click', function (e) {
      fetch(`/delete-tweet/${id}`, {
        method: 'post',
      }).then(res => res.json()).then(r => {
        tweet.parentElement.removeChild(tweet)
        notify("Delete Success")
      }).catch(e => {
        notify("Delete Error")
      })
    })
  })
}
