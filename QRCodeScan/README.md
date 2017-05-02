How to use this utility tool:
----------------------------

1. Import ImageScan.h/m to the project or Drag and Drop in the xcode project
2. Call class method decodeQRFromUIImage directly with valid QR image.


decodeQRFromUIImage method will return string if image is valid QRscan image otherwise it will return empty string.

Example:
-------

UIImage *workingImage = [info valueForKey:UIImagePickerControllerOriginalImage];

NSString *textFromQRImage = [ImageScan decodeQRFromUIImage:workingImage];

textFromQRImage contains actual string from QR image if image is valid.

