// 🎯 Dart imports:
// ignore_for_file: depend_on_referenced_packages

// 🎯 Dart imports:
import 'dart:collection';
import 'dart:convert';
import 'dart:io';

// 🐦 Flutter imports:
/* import 'package:flutter/material.dart'; */

// 📦 Package imports:
import 'package:crypto/crypto.dart' show md5;
import 'package:http/http.dart' as http;

// 🌎 Project imports:
import 'package:floatingbubble/network_exceptions.dart';

//  Package imports:

// A class wrapper to house url, body and headers under one name
class RequestWrapper {
  final String url;
  final Map body, headers;

  RequestWrapper({
    @required this.url,
    @required this.body,
    @required this.headers,
  });
}

class HttpRequestUtil {
  /// Given a [request] object, generate a unique [md5] hash for it
  static String hashRequest(RequestWrapper request) {
    final urlHash = generateHash(request.url);
    final headerHash = generateHash(sortMap(request.headers ?? {}).toString());
    final bodyHash = generateHash(sortMap(request.body ?? {}).toString());
    final requestHash = generateHash(urlHash + headerHash + bodyHash);
    debugPrint("Requesthash - $requestHash");
    return requestHash;
  }

  /// Given a [map], sorts the keys in the alphabetical order
  static SplayTreeMap sortMap(Map map) {
    return SplayTreeMap.from(map, (a, b) => a.compareTo(b) as int);
  }

  /// Given a [String], generates the [md5] hash for it
  static String generateHash(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  /// Sends a ***HTTP GET*** request to the specified url with the given headers
  ///
  /// [token]  passed as [String] is injected into the header.
  static Future<Map> getRequest(
    String url, {
    Map<String, dynamic> body,
    Map<String, String> headers,
    String token,
    // bool shouldCache = false,
  }) async {
    debugPrint('GET Request called on :- $url');
    if (token != null) {
      headers ??= {};
      headers['Token'] = token;
    }

    final request = RequestWrapper(url: url, body: body, headers: headers);

    try {
      if (headers != null) {
        debugPrint('Headers for GET Request :- $headers');
      }

      final http.Response response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
      final responseMap = jsonDecode(response.body);

      return responseMap;
    } on FormatException {
      debugPrint('GET Request $url Foramt Exception');

      throw 'Server Error. API not deployed [ E_API01 ]';
    } on SocketException {
      debugPrint('GET Request $url Socket Exception');

      return _handleSocketException(request);
    } catch (e, stackTrace) {
      debugPrint('GET Request $url exception $e with StackTrace $stackTrace');

      throw NetworkException(
        message: 'Unknown Exception while GETting',
        statusCode: -2,
      );
    }
  }

  /// Sends a ***HTTP POST*** request to the specified url with the given headers
  /// the specified request body
  ///
  /// The body is `jsonEncoded` by default and the header is set to
  ///
  ///
  /// ```content-type: application/x-www-form-urlencoded```
  ///
  /// Token passed as [String] is injected into the header.
  static Future<Map> postRequest(
    String url, {
    Map<String, dynamic> body,
    Map<String, String> headers,
    String token,
    bool ignoreErrors = false,
    bool shouldCache = false,
  }) async {
    headers ??= {};
    if (token != null) headers['Token'] = token;
    headers['content-type'] = 'application/json';
    final String jsonBody = jsonEncode(body);
    final request = RequestWrapper(
      url: url,
      body: body,
      headers: headers,
    );
    debugPrint('POST Request JSON body :- $jsonBody');
    debugPrint('Posting :- $url');

    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        body: jsonBody,
        headers: headers,
      );
      final responseMap = jsonDecode(response.body);

      debugPrint('Response for POST Request $url :- $responseMap');

      return responseMap;
    } on FormatException {
      debugPrint('POST Request $url Foramt Exception');

      throw NetworkException(
        message: 'API Error',
        statusCode: 1,
      );
    } on SocketException {
      debugPrint('POST Request $url Socket Exception');

      return _handleSocketException(request);
    } catch (e, stackTrace) {
      debugPrint('POST Request $url exception $e with StackTrace $stackTrace');

      throw NetworkException(
        message: 'Unknown exception while POSTing',
        statusCode: -2,
      );
    }
  }

  /// Handle [SocketException]. Try and retrieve cached responses
  /// if [shouldCache] is set to true
  static Future<Map<String, dynamic>> _handleSocketException(
    RequestWrapper request,
  ) async {
    throw NetworkException(
      message: 'Please check your network connection',
      statusCode: 0,
    );
  }
}
