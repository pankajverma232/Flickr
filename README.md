# Flickr
demo app for image search using Flickr api




## Description

This App uses the Flickr image search API and shows the results in a collection view. User can serch for images in the Searchbar at the top.

https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=3e7cc266ae2b0e0d78e279ce8e361736&format=json&nojsoncallback=1&safe_search=1&text=kittens

* above api returns Json response
* **Codable** is used for handling Json
* Records are shown in **Collection view** (3 cells in a row in portrait mode)
* Images are cached using **Core data**.
* A detail page is also there if an image is selected for details.



