Feature: Resolve conflicts when adding labels
    In order to effectively use labels in my development workflow
    As a repository owner
    I should be able to resolve conflicts that may occur when I try to add a list of labels to a repository


    Scenario: Recolor a conflicting label
        Given there is a repository
        And the following labels are already added to the repository:
            | name        | color  |
            | bug         | FC2929 |
            | enhancement | 84B6EB |
            | question    | CC317C |
        And I defined the following conflict resolution rules:
            | name    | action  | target |
            | bug     | RECOLOR |        |
        When I add the following labels:
            | name    | color  |
            | support | 41B2DB |
            | bug     | FC2828 |
        Then the labels should be added to the repository


    Scenario: Recolor a conflicting alternative label without renaming
        Given there is a repository
        And the following labels are already added to the repository:
            | name        | color  |
            | bug         | FC2929 |
            | enhancement | 84B6EB |
            | question    | CC317C |
        And I defined the following conflict resolution rules:
            | name    | action  | target   |
            | support | RECOLOR | question |
        When I add the following labels:
            | name              | color  |
            | support[question] | 41B2DB |
            | tech-debt         | D93F0B |
        Then the labels should be added to the repository


    Scenario: Recolor a conflicting label when both a matching and an alternative are present
        Given there is a repository
        And the following labels are already added to the repository:
            | name        | color  |
            | bug         | FC2929 |
            | enhancement | 84B6EB |
            | question    | CC317C |
            | support     | CC317C |
        And I defined the following conflict resolution rules:
            | name    | action  | target |
            | support | RECOLOR |        |
        When I add the following labels:
            | name              | color  |
            | support[question] | 41B2DB |
            | tech-debt         | D93F0B |
        Then the labels should be added to the repository


    Scenario: Rename an alternative label without recoloring
        Given there is a repository
        And the following labels are already added to the repository:
            | name        | color  |
            | bug         | FC2929 |
            | enhancement | 84B6EB |
            | question    | CC317C |
        And I defined the following conflict resolution rules:
            | name    | action | target   |
            | support | RENAME | question |
        When I add the following labels:
            | name              | color  |
            | support[question] | 41B2DB |
            | tech-debt         | D93F0B |
        Then the labels should be added to the repository


    Scenario: Rename an alternative label without recoloring when multiple alternatives are available
        Given there is a repository
        And the following labels are already added to the repository:
            | name        | color  |
            | bug         | FC2929 |
            | enhancement | 84B6EB |
            | question    | CC317C |
            | qa          | CC317C |
        And I defined the following conflict resolution rules:
            | name    | action | target   |
            | support | RENAME | question |
        When I add the following labels:
            | name                 | color  |
            | support[question,qa] | 41B2DB |
            | tech-debt            | D93F0B |
        Then the labels should be added to the repository
        And the following original labels should be intact:
            | name |
            | qa   |


    Scenario: Overwrite a conflicting alternative label
        Given there is a repository
        And the following labels are already added to the repository:
            | name        | color  |
            | bug         | FC2929 |
            | enhancement | 84B6EB |
            | question    | CC317C |
        And I defined the following conflict resolution rules:
            | name    | action    | target   |
            | support | OVERWRITE | question |
        When I add the following labels:
            | name              | color  |
            | support[question] | 41B2DB |
            | tech-debt         | D93F0B |
        Then the labels should be added to the repository


    Scenario: Add a label when an alternative is already present
        Given there is a repository
        And the following labels are already added to the repository:
            | name        | color  |
            | bug         | FC2929 |
            | enhancement | 84B6EB |
            | question    | CC317C |
        And I defined the following conflict resolution rules:
            | name    | action | target |
            | support | ADD    |        |
        When I add the following labels:
            | name              | color  |
            | support[question] | 41B2DB |
            | tech-debt         | D93F0B |
        Then the labels should be added to the repository
        And the original labels should be intact


    Scenario: Skip labels
        Given there is a repository
        And the following labels are already added to the repository:
            | name        | color  |
            | bug         | FC2929 |
            | enhancement | 84B6EB |
            | question    | CC317C |
        And I defined the following conflict resolution rules:
            | name    | action | target |
            | bug     | SKIP   |        |
            | feature | SKIP   |        |
            | support | SKIP   |        |
        When I add the following labels:
            | name                 | color  |
            | bug                  | FC2928 |
            | feature[enhancement] | 84B6EB |
            | support              | 41B2DB |
            | tech-debt            | D93F0B |
        Then with the exception of the following:
            | name    |
            | bug     |
            | feature |
            | support |
        But the labels should be added to the repository
