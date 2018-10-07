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



<img width="386" alt="screen shot 2018-10-08 at 12 49 15 am" src="https://user-images.githubusercontent.com/13132554/46585946-1f5e1f00-ca95-11e8-8748-30c0010c823f.png">


<img width="399" alt="screen shot 2018-10-08 at 12 49 31 am" src="https://user-images.githubusercontent.com/13132554/46585963-59c7bc00-ca95-11e8-8c42-0280d76033f7.png">


<img width="764" alt="screen shot 2018-10-08 at 1 00 42 am" src="https://user-images.githubusercontent.com/13132554/46585987-af03cd80-ca95-11e8-8838-e6f459d0220c.png">
