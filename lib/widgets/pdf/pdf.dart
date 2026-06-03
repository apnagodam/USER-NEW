import 'dart:io';

import 'package:background_downloader/background_downloader.dart';
import 'package:file_saver/file_saver.dart';
import 'package:file_support/file_support.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:one_context/one_context.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pdf.g.dart';

@riverpod
Future<File?> downloadFile(DownloadFileRef ref,
    {required String? fileName, required String? url}) async {
  var filePath = '';
  if (Platform.isAndroid) {
    filePath = '/storage/emulated/0/Download/';
  } else {
    Directory documents = await getApplicationDocumentsDirectory();
    filePath = documents.path;
  }

  return await FileSupport()
      .downloadCustomLocation(
    url: url,
    path: filePath,
    filename: fileName.toString().toLowerCase().replaceAll(' ', '_'),
    extension: ".pdf",
    progress: (progress) async {
      debugPrint(progress);
    },
  )
      .then((video) async {
    return video;
  }).onError((error, stackTrace) {
    return null;
  });
}

Future<File?> downloadFileBG(
    {required String? fileName, required String? url}) async {
  OneContext().showOverlay();
  File? file;

  var filePath = '';
  Directory documents = Directory('/storage/emulated/0/Download');

  filePath = documents.path;

  FileDownloader()
      .configureNotification(
          running: TaskNotification('Downloading', 'file: $fileName'),
          complete: TaskNotification('Download finished', 'file: $fileName'),
          progressBar: true,
          tapOpensFile: true)
      .download(
          DownloadTask(
            // headers: {
            //   'Authorization':
            //       "Bearer ${ref.watch(sharedUtilityProvider).getToken()}"
            // },
            url: url ?? "",

            filename: "$fileName.pdf",
            updates: Updates.statusAndProgress,
            // request status and progress updates
            requiresWiFi: false,
            retries: 5,
            baseDirectory: BaseDirectory.applicationSupport,
            allowPause: true,
          ),
          onProgress: (progress) => print('Progress: ${progress * 100}%'),
          onStatus: (status) => print('Status: $status'))
      .then((value) async {
    switch (value.status) {
      case TaskStatus.enqueued:
      case TaskStatus.running:
      case TaskStatus.complete:
        var filePath = await value.task.filePath();
        await FileSaver.instance
            .saveAs(
                name: fileName ?? 'downloaded_file',
                file: file,
                mimeType: MimeType.pdf,
                ext: '.pdf')
            .then((value) {
          Fluttertoast.showToast(
              msg: 'File saved successfully $filePath',
              toastLength: Toast.LENGTH_LONG);
        });

      // successToast(OneContext().context!, 'File Downloaded successfully');
      // file =
      //     await File("/data/user/0/com.swfl.swfl/app_flutter/${fileName}.pdf")
      //         .copy('/storage/emulated/0/Download/${fileName}.pdf');

      case TaskStatus.notFound:
      case TaskStatus.failed:
      case TaskStatus.canceled:
      case TaskStatus.waitingToRetry:
      case TaskStatus.paused:
    }
  });
  OneContext().hideOverlay();

  return file;
}
