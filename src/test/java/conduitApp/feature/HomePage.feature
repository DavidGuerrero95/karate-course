Feature: Test for the home page

    Background: Define URL
        Given url apiUrl

    Scenario: Get all tags
        Given path 'tags'
        When method Get
        Then status 200
        And match response.tags == '#array'
        And match each response.tags == '#string'
    
    Scenario: Get 10 articles from the page
        * def timeValidator = read('classpath:helpers/timeValidator.js')
        Given params {limit: 10, offset: 0}
        Given path 'articles'
        When method Get
        Then status 200
        And match response == {"articles":"#array","articlesCount": 168}
        And match each response.articles == 
        """
        {
            "slug": "#string",
            "title": "#string",
            "description": "#string",
            "body": "#string",
            "tagList": "#array",
            "createdAt": "#? timeValidator(_)",
            "updatedAt": "#? timeValidator(_)",
            "favorited": "#boolean",
            "favoritesCount": "#number",
            "author": {
                "username": "#string",
                "bio": "##string",
                "image": "#string",
                "following": "#boolean"
            }
        }
        """
