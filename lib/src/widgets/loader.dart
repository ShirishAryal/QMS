import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// class QmsLoader {
//   OverlayEntry? _overlayEntry;
//   OverlayState? _overlayState;

//   show(BuildContext context) async {
//     _overlayState = Overlay.of(context);
//     _overlayEntry = OverlayEntry(
//       builder: (context) =>
//           WillPopScope(onWillPop: () async => false, child: LoaderComponent()),
//     );
//     _overlayState!.insert(_overlayEntry!);
//   }

//   hide() {
//     try {
//       _overlayEntry?.remove();
//     } catch (e) {
//       print(e);
//     }
//   }
// }

class QmsLoader {
  BuildContext _context;
  void hide() {
    Navigator.of(_context).pop();
  }

  void show() {
    showDialog(
        context: _context,
        barrierDismissible: false,
        builder: (ctx) => const LoaderComponent());
  }

  Future<T> during<T>(Future<T> future) {
    show();
    return future.whenComplete(() => hide());
  }

  QmsLoader._create(this._context);
  factory QmsLoader.of(BuildContext context) {
    return QmsLoader._create(context);
  }
}

class LoaderComponent extends StatelessWidget {
  const LoaderComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return WillPopScope(
      onWillPop: () async => true,
      child: Container(
        color: const Color(0xFF212121).withOpacity(0.5),
        child: Padding(
          padding: EdgeInsets.only(top: statusBarHeight),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AlertDialog(
                insetPadding: const EdgeInsets.symmetric(horizontal: 25),
                backgroundColor: Colors.grey[200],
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SpinKitSpinningLines(
                      lineWidth: 1,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Flexible(
                      child: Text(
                        "Loading..",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoadingIndicator {
  static Future<void> showProgress(BuildContext ctx, [String? message]) async {
    return showDialog<void>(
        context: ctx,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: SimpleDialog(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(20),
                    width: 300,
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SpinKitThreeBounce(
                            color: Theme.of(context).primaryColor),
                        Expanded(
                            child:
                                Text(message ?? "Processing Your Request..."))
                      ],
                    ),
                  ),
                ]),
          );
        });
  }
}
