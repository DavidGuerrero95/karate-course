Feature: Sign Up new user

    Background: Preconditions
        * def dataGenerator = Java.type('helpers.DataGenerator')
        * url apiUrl

    @debug
    Scenario: New user Sign Up
        * def randomEmail = dataGenerator.gerRandomEmail();
        * def randomUsername = dataGenerator.getRandomUsername();

        * def jsFunction = 
        """
            function () {
                var DataGenerator = Java.type('helpers.DataGenerator')
                var generator = new DataGenerator()
                return generator.getRandomUsername2()
            }
        """

        * def randomUsername2 = call jsFunction

        Given path 'users'
        And request 
        """
        {
            "user": {
                "email": #(randomEmail),
                "password": "1234567890",
                "username": #(randomUsername2)
            }
        }
        """
        When method Post
        Then status 200
        And match response ==
        """
            {
                "user": {
                    "email": #(randomEmail),
                    "username": #(randomUsername2),
                    "bio": null,
                    "image": "#string",
                    "token": "#string"
                }
            }
        """

    Scenario Outline: Validate Sign Up error messages
        * def randomEmail = dataGenerator.gerRandomEmail();
        * def randomUsername = dataGenerator.getRandomUsername();

        * def jsFunction = 
        """
            function () {
                var DataGenerator = Java.type('helpers.DataGenerator')
                var generator = new DataGenerator()
                return generator.getRandomUsername2()
            }
        """

        * def randomUsername2 = call jsFunction

        Given path 'users'
        And request 
        """
        {
            "user": {
                "email": "<email>",
                "password": "<password>",
                "username": "<username>"
            }
        }
        """
        When method Post
        Then status 422
        And match response == <errorResponse>

        Examples:
            | email                    | password   | username                  | errorResponse                                                                      |
            | #(randomEmail)           | 1234567890 | 1234567890                | {"errors":{"username":["has already been taken"]}}                                 |
            | 12345678901@gmail.com    | 1234567890 | #(randomUsername)         | {"errors":{"email":["has already been taken"]}}                                    |

   