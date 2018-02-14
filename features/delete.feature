Feature: Delete labels
    In order to change the way I use labels in my development workflow
    As a repository owner
    I should be able to delete labels from a repository


    Scenario: Delete a list of labels
        Given there is a repository
        And the following labels are already added to the repository:
            | name        | color  |
            | bug         | FC2929 |
            | enhancement | 84B6EB |
            | question    | CC317C |
        When I delete the following labels:
            | name        |
            | bug         |
            | enhancement |
        Then the labels should be deleted from the repository


    Scenario: Delete all labels
        Given there is a repository
        And the following labels are already added to the repository:
            | name        | color  |
            | bug         | FC2929 |
            | enhancement | 84B6EB |
            | question    | CC317C |
        When I delete all labels
        Then the repository should not have any labels
