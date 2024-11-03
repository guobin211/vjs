const fetchJson = async () => {
    return fetch('http://jsonplaceholder.typicode.com/posts/1')
        .then((response) => response.json())
        .then((json) => json)
        .catch((error) => error)
}

;(async () => {
    const start = performance.now()
    await Promise.all([fetchJson(), fetchJson(), fetchJson()])
    const end = performance.now()
    console.log(`Time: ${end - start} ms`)
})()
