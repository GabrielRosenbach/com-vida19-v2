function fazGet(url){
    let request = new XMLHttpRequest()
    request.open("Get",url,false)
    request.send()
    return request.responseText
}