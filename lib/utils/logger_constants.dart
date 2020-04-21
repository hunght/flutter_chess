import 'package:logger/logger.dart';

import 'logger_utils.dart';

LoggerUtil LOG = LoggerUtil(
  printer: PrettyPrinter(
    methodCount: 0,
    lineLength: 150,
    printTime: true,
    printEmojis: false,
  ),
  level: LoggerUtil.logLevel(),
);
