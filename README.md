# MoviesDataBaseApplication
Movie Database App

Based on data provided in the movies.json file, implement the following features:

List out the below options to show related movies:
Year
Genre
Directors
Actors
All Movies

On tapping of each option, list out the values linked to it on the same screen (expand/collapse) effect. 
- In case of "Year/Genre/Directors/Actors", only one field is required to show in each value cell
- In case of "All Movies", thumbnail, movie title, language and year fields required to show in each value cell
- ![Screenshot 2023-10-28 at 12 57 54 PM](https://github.com/shubhransh-gupta/MoviesDataBaseApplication/assets/54713516/eda65f7b-590b-4caf-9e0a-2428f45c8eea)
![Screenshot 2023-10-28 at 12 57 37 PM](https://github.com/shubhransh-gupta/MoviesDataBaseApplication/assets/54713516/3af9356b-674c-4372-a7e9-e8bff67cba27)
![Screenshot 2023-10-28 at 12 59 12 PM](https://github.com/shubhransh-gupta/MoviesDataBaseApplication/assets/54713516/9bca0baa-19c0-476f-a914-4245f7194b45)
![Screenshot 2023-10-28 at 12 58 08 PM](https://github.com/shubhransh-gupta/MoviesDataBaseApplication/assets/54713516/dcb126db-ba81-416e-b0b8-10374bd44b29)

For example, if Genre contains Comedy, Action, Sport then show them as separate values. On clicking each value, display a list of movies associated with that value. This example is applicable to all options listed above.
Search: User can search for movies by title/genre/actor/director. For example, if user searches for “comedy”, then display all movies which contains “comedy” in title/genre/actor/director. 
On search, UI will show a list of movies that are matched and on clearing search UI will show list of options mentioned above. (year/genre/directors/actors). Each movie index cell should display poster, title, language, year.

On tapping the movie, show the details:

1. Poster, title, plot, cast & crew, released date, genre and rating

2. User should be able to select a rating source (IMDB, Rotten Tomatoes, Metacritic) to see the rating value. 

3. Create a custom UI control to show rating value.
