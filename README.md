# TheTool
Common tools 

### UIViewController extension

1) Add child view controller

```swift 
func add(child viewController: UIViewController)
```


### UIColor extension

1) Initialize from the GRB int values

```swift 
convenience init(red: Int, green: Int, blue: Int)
```

2)  Initialize from the String presenting a color in the Hexadecimal format

```swift
convenience init(hexString: String)
```


### UITableViewCell

1) Reusable identifier as an extension for protocol `ReusableIdentifier` 
