# Marvelous
This is an application for Marvel lovers, for all those who find the Marvel world MARVELOUS

#### SwiftLint Plugin
- Needs to install SwiftLint
    - brew install swiftlint
- It's possible to have a worning about the path of `swiftlint` command, you can fix that using this:
    ```
    if test -d "/opt/homebrew/bin/"; then
        PATH="/opt/homebrew/bin/:${PATH}"
    fi

    export PATH

    if which swiftlint >/dev/null; then
        swiftlint
    else
        echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
    fi
    ```
- the `.swiftlint.yml` has some simple rules for this test project:

```
    opt_in_rules:
    - empty_count
    - empty_string

    excluded:
    - Carthage
    - Pods

    line_length:
        warning: 150
        error: 200
        ignores_function_declarations: true
        ignores_comments: true
        ignores_urls: true
        
    function_body_length:
        warning: 300
        error: 500
        
    type_body_length:
        warning: 300
        error: 500
        
    file_length:
        warning: 1000
        error: 1500
        ignore_comment_only_lines: true
        
    cyclomatic_complexity:
        warning: 15
        error: 25

    reporter: "xcode"
```

#### The Composable Architecture (TCA)
- This project contains, as a dependency, the TCA package
- This package is used to define the architecture of this project.


##### Aknowledgement
pointfreeco -> https://github.com/pointfreeco/swift-composable-architecture?tab=readme-ov-file#installation