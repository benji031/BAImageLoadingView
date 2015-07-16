# BAImageLoadingView

**BAImageLoadingView** is easy loader for UIImageView when image is downloaded or need long loading.

## Requirements

- iOS 7.0+

Written in Swift

For use IBDesignable in storyboard, you need iOS 8.0+

## Instalation

Copy the BAImageLoadingView class files into your project.

## How to Use

You can use **BAImageLoadingView** in storyboard by put custom class of UIImageView in `Identity Inspector`, you can set the attribute of ImageLoaingView in the `Attributes Inspector`.

Availaible attributes :

- `cornerRadius`: Set the corner radius of the UIImage
- `maskOpacity` : Set the opacity of the background mask
- `progressColor` : Set the color of the progress bar
- `progressWidth` : Set the width of the progress bar
- `radius` : Set the distance between the progress bar and the border (in percent)

## Start loading

```
imageLoadingView.startLoading()
```

## Stop loading

When your new image is downloaded, you can set your new image by

```
imageView.setLoadedImage(UIImage(named: "mynewImage"))
```

Or just stop loading

```
imageView.stopLoading()
```
