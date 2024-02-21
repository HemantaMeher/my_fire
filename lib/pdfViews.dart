import 'package:flutter/material.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
 class PdfViews extends StatefulWidget {
   String url;
   PdfViews({Key? key, required this.url}) : super(key: key);

   @override
   State<PdfViews> createState() => _PdfViewsState();
 }

 class _PdfViewsState extends State<PdfViews> {
  late PDFDocument document;
   bool _isLoading = true;
   loadDocument() async{
     document = await PDFDocument.fromURL(widget.url);
     setState(() {
       _isLoading = false;
     });
   }
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadDocument();
  }
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(title: Text('PDF Viewer'),),
       body: Center(
         child: _isLoading? Center(child: CircularProgressIndicator(),)
             : PDFViewer(
             document: document,
           backgroundColor: Colors.cyan,
           scrollDirection: Axis.vertical,
           enableSwipeNavigation: true,
           indicatorBackground: Colors.pink,
           // showIndicator: false,
           pickerButtonColor: Colors.purpleAccent,
           // showPicker: false,
           showNavigation: false,

         )
       ),
     );
   }
 }
