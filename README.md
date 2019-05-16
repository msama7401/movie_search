New Changes:
# Created a function moviesearch that uses getapidata function to get the data from api call and the readconfig to maintain the configurations (here used the secret)
# We can set path to the secret in /etc for users with no read access.


 
# Search for movie rating
# Clone the repo from github

$ git clone https://github.com/msama7401/movie_search.git

# Build the docker Image: Used Ubuntu 

$ docker build movie_search/ -t movie-search:latest

# Run the Docker Image (You will see a bunch of downloads as you know ubuntu base image does not have gridsite-client (for urlencode), curl and python); sorry, will find an alpine when working for client :P

$ docker run -it movie-search

# The container connect you to the image to the shell scipt location; Run the following:

$ source search_movie.sh
$ moviesearch <movieName> 
