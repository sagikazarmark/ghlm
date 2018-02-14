Feature: Add labels
    In order to effectively use labels in my development workflow
    As a repository owner
    I should be able to add a list of labels to a repository


    Scenario: Add a list of labels
        Given there is a repository
        When I add the following labels:
            | name        | color  |
            | bug         | FC2929 |
            | enhancement | 84B6EB |
            | question    | CC317C |
        Then the labels should be added to the repository


    Scenario: Add a list of labels containing conflicting elements
        Given there is a repository
        And the following labels are already added to the repository:
            | name        | color  |
            | bug         | FC2929 |
            | enhancement | 84B6EB |
            | question    | CC317C |
        When I add the following labels:
            | name    | color  |
            | support | 41B2DB |
            | bug     | FC2828 |
        Then the labels should not be added to the repository


    Scenario: Add a list of labels containing matching elements
        Given there is a repository
        And the following labels are already added to the repository:
            | name        | color  |
            | bug         | FC2929 |
            | enhancement | 84B6EB |
            | question    | CC317C |
        When I add the following labels:
            | name    | color  |
            | support | 41B2DB |
            | bug     | FC2929 |
        Then the labels should be added to the repository
