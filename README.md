# File Storage API


## Deploy

Generate `Config/crypto.json` and `Config/secrets/production.json` files
accordind to its `*.exmaple` templates. Using the copied templates is enough
for *development*.

Build and run:

```bash
vapor build
vapor run
```

## How to use this

### Request
POST https://files.jenkins.mit.ajty.cz
```bash
curl -X POST \
  https://files.jenkins.mit.ajty.cz/ \
  -H 'authorization: token SECRET_TOKEN' \
  -H 'cache-control: no-cache' \
  -H 'content-type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW' \
  -F file=@path_to_file \
  -F extension=extension_of_file
```

### Response 
```js
{
    "url": "https://files.jenkins.mit.ajty.cz/48F5D5BD-343C-4B09-A6BF-E62AA93C9B5B.png"
}
```
