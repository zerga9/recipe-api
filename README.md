# Recipe Api

- Please make sure you have PostgreSQL installed

After cloning the repository,

```bash
bundle install
bundle exec rails db:create
bundle exec rails db:migrate
```
Run specs with

```bash
bundle exec rspec
```

## Requirements

- [x] as a User, I can add, edit, list, show and delete Recipes
- [x] as a User, I can see a description, Ingredients and an Author of a Recipe
- [x] as a User, I can choose to see imperial or metric measurements for Ingredients
- [x] as a User, I can Rate a Recipe
- [x] as a User, I can see who Rated a Recipe

## Main Endpoints

POST `/signup` ==> User signup
body:
```bash
{
    "user": {
        "username": "UserName",
        "password": "Password",
        "password_confirmation": "Password"
    }
}
```

POST `/login`   ==> User login
body:
```bash
{
    "user": {
        "username": "UserName",
        "password": "Password"
    }
}
```

DELETE `/logout`   ==> User logout

GET `/api/v1/recipes/` ==> Recipe Collection

POST `/api/v1/recipes/` ==> Create Recipe
```bash
{
    "recipe": {
        "title": "Easy title",
        "description": "Good Descriptionn",
        "process": "Process recipe",
        "ingredients_attributes": [
            {
                "name": "Name Ingredient",
                "metric": {
                    "unit": "metric unit",
                    "amount": metric amount
                },
                "imperial": {
                    "unit": "imperial unit",
                    "amount": imperial amount
                }
            }
        ]
    }
}
```
PUT `/api/v1/recipes/{recipe_id}` ==> Update Recipe
```bash
{
    "recipe": {
        "title": "Better Title",
        "description": "Good Descriptionn",
        "process": "Process recipe"
    }
}
```
DELETE `/api/v1/recipes/{recipe_id}` ==> Destroy Recipe

GET `api/v1/recipes/{recipe_id}/ingredients` ==> Get all ingredients Recipe

GET `api/v1/recipes/{recipe_id}/ingredients?unit=metric` ==> Get all ingredients with metric measurements Recipe

GET `api/v1/recipes/{recipe_id}/ingredients?unit=imperial` ==> Get all ingredients with imperial measurements Recipe

POST `/api/v1/recipes/{recipe_id}/ratings` ==> Add Rating to Recipe
```bash
{
    "rating": {
        "rating": 5

    }
}
```

GET `/api/v1/recipes/{recipe_id}/ratings` ==> Get all Ratings to Recipe
