import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:xml/xml.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'util/toast_util.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Process? process;
  TextEditingController cmdController = TextEditingController();
  List<String> messages = [];

  //apk文件的绝对路径
  String path = "";

  //反编译后的文件路径去掉后缀名
  String fileName = "";

  //工作路径
  String workPath = "";

  //包的配置信息
  String apkInfo = "";

  //Androidmanifest文件
  String androidmanifest = "";

  //包名
  String packageName = "";
  String appName = "";
  String stringInfo = "";
  String appNameReplace = "";
  final xType = XTypeGroup(label: '安装包', extensions: ['apk']);
  final xSignType = XTypeGroup(label: "签名密钥", extensions: ["keystore", "jks"]);
  final xExcelType = XTypeGroup(label: "表格", extensions: ["xlsx"]);
  String signPath = "";

  void selectFile() async {
    final XFile? file = await openFile(acceptedTypeGroups: [xType]);
    if (file != null) {
      fileName = file!.name.replaceAll(".apk", "");
      path = file!.path;
      setState(() {});
    }
  }

  void selectWorkPath() async {
    String? rootPath = await getDirectoryPath();
    if (rootPath != null) {
      workPath = rootPath!;
      String root = workPath.substring(0, 1);
      setCmd("${root}:");
      setCmd("cd ${workPath}");
      File file = File("${workPath}\\${fileName}");
      if (await file.exists()) {
        ToastUtils.show("${file.path}已存在");
      } else {
        setCmd("apktool d ${path}");
      }
      setState(() {});
    }
  }

  void getApkInfo() async {
    File file = File("${workPath}\\${fileName}\\assets\\client.properties");
    apkInfo = (await file.readAsString()).toString();
    _controller.text = apkInfo;
    File packname = File("${workPath}\\${fileName}\\AndroidManifest.xml");
    androidmanifest = await packname.readAsString();
    var datas = await packname.readAsLines();
    var index = datas[0].split(" ");
    for (var item in index) {
      if (item.startsWith("package=")) {
        packageName = item.substring(9, item.length - 1);
        _packageController.text = packageName;
        break;
      }
    }

    File appname = File("${workPath}\\${fileName}\\res\\values\\strings.xml");
    stringInfo = appname.readAsStringSync();
    final document = XmlDocument.parse(stringInfo);
    XmlElement texx = document.findElements("resources").first.findElements("string").where((element) => element.getAttribute("name") == "app_name").first;
    appNameReplace = texx.text;
    appName = texx.firstChild!.text;
    _appNameController.text = appName;
    setState(() {});
  }

  void editAndSaveConf() async {
    final Uint8List fileData = const Utf8Encoder().convert(_controller.text);
    final String? path = await getSavePath(
      acceptedTypeGroups: [
        XTypeGroup(label: '文本', extensions: ['properties']),
      ],
      initialDirectory: "${workPath}\\${fileName}\\assets\\",
      suggestedName: "client.properties",
    );
    debugPrint('存储路径：$path');
    if (path != null) {
      const String fileMimeType = 'text/plain';
      final XFile xFile = XFile.fromData(
        fileData,
        mimeType: fileMimeType,
      );
      await xFile.saveTo(path);
    } else {
      ToastUtils.show('给你个眼神自己体会😑');
    }
  }

  void editAndSavePackage() async {
    String newManifest = androidmanifest.replaceFirst("package=\"${packageName}\"", "package=\"${_packageController.text}\"");
    final Uint8List fileData = const Utf8Encoder().convert(newManifest);
    final String? path = await getSavePath(
      acceptedTypeGroups: [
        XTypeGroup(label: '文本', extensions: ['xml']),
      ],
      initialDirectory: " ${workPath}\\${fileName}\\",
      suggestedName: "strings.xml",
    );
    debugPrint('存储路径：$path');
    if (path != null) {
      const String fileMimeType = 'text/plain';
      final XFile xFile = XFile.fromData(
        fileData,
        mimeType: fileMimeType,
      );
      await xFile.saveTo(path);
    } else {
      ToastUtils.show('给你个眼神自己体会😑');
    }
  }

  void editAndSaveAppName() async {
    String newManifest = stringInfo.replaceFirst("${appNameReplace}", "${appNameReplace.replaceFirst("${appName}", _appNameController.text)}");
    final Uint8List fileData = const Utf8Encoder().convert(newManifest);
    final String? path = await getSavePath(
      acceptedTypeGroups: [
        XTypeGroup(label: '文本', extensions: ['xml']),
      ],
      initialDirectory: "${workPath}\\${fileName}\\res\\values\\",
      suggestedName: "strings.xml",
    );
    debugPrint('存储路径：$path');
    if (path != null) {
      const String fileMimeType = 'text/plain';
      final XFile xFile = XFile.fromData(
        fileData,
        mimeType: fileMimeType,
      );
      await xFile.saveTo(path);
    } else {
      ToastUtils.show('给你个眼神自己体会😑');
    }
  }

  void rebuildApk() async {
    setCmd("apktool b ${workPath}\\${fileName}");
  }

  void signApk() async {
    final XFile? file = await openFile(acceptedTypeGroups: [xSignType]);
    if (file != null) {
      //签名文件路径不能包含中文
      signPath = file.path;
      debugPrint('存储路径：$path');
    }
    String originFileName = "${workPath}\\${fileName}\\dist\\${fileName}.apk";
    String newFileName = "${workPath}\\${fileName}_signed.apk";
    String cmdStr =
        "jarsigner -digestalg SHA1 -sigalg MD5withRSA -keystore ${signPath} -storepass ${_signPasswordController.text} -signedjar ${newFileName} ${originFileName} ${_signNameController.text}";
    setCmd(cmdStr);
    setState(() {});
  }

  late TextEditingController _controller;
  late TextEditingController _packageController;
  late TextEditingController _appNameController;
  late TextEditingController _signPasswordController;
  late TextEditingController _signNameController;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _packageController = TextEditingController();
    _appNameController = TextEditingController();
    _signPasswordController = TextEditingController();
    _signNameController = TextEditingController();
    Process.start('cmd.exe', []).then((value) {
      process = value;
      process?.stdout.listen(onMessage);
      setState(() {
        messages.add('cmd ok');
      });
    });
  }

  @override
  dispose() {
    process?.kill();
    process = null;
    _controller.dispose();
    _packageController.dispose();
    _appNameController.dispose();
    _signPasswordController.dispose();
    _signNameController.dispose();
    super.dispose();
  }

  setCmd(String cmd) {
    if (cmd == 'clear') {
      messages.clear();
    }
    if (process != null) {
      process?.stdin.writeln(cmd);
    }
  }

  onMessage(List<int> event) {
    String lines = String.fromCharCodes(event).trim();
    setState(() {
      messages += lines.split('\n');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "apk工具箱",
          style: TextStyle(color: Colors.black54),
        ),
      ),
      body: WillPopScope(
        onWillPop: () {
          if (process != null) process?.kill();
          return Future.value(true);
        },
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ElevatedButton(onPressed: selectFile, child: Text('选取安装包')),
                      SizedBox(
                        width: 20,
                      ),
                      Text("${path} ----- ${fileName}"),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      ElevatedButton(onPressed: selectWorkPath, child: Text('选取工作目录（命令下显示编译完成后才可进行下一步操作）')),
                      SizedBox(
                        width: 20,
                      ),
                      Text("${workPath}"),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      ElevatedButton(onPressed: getApkInfo, child: Text('获取apk信息')),
                      SizedBox(
                        width: 20,
                      ),
                      Text("包名:"),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        width: 180,
                        color: Colors.blueGrey,
                        child: TextField(
                          controller: _packageController,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(onPressed: editAndSavePackage, child: Text('修改保存包名')),
                      SizedBox(
                        width: 10,
                      ),
                      Text("游戏名:"),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        width: 180,
                        color: Colors.blueGrey,
                        child: TextField(
                          controller: _appNameController,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(onPressed: editAndSaveAppName, child: Text('修改保存游戏名')),
                    ],
                  ),
                  Text("配置文件信息"),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    height: 250,
                    child: SingleChildScrollView(
                      child: TextField(
                        decoration: InputDecoration(border: InputBorder.none),
                        maxLines: null,
                        controller: _controller,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      ElevatedButton(onPressed: editAndSaveConf, child: Text('修改保存配置文件')),
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(onPressed: rebuildApk, child: Text('重新生成apk包')),
                      SizedBox(
                        width: 10,
                      ),
                      /*ElevatedButton(
                          onPressed: readExcel, child: Text('读取excel文件')),*/
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        width: 180,
                        color: Colors.blueGrey,
                        child: TextField(
                          controller: _signNameController,
                          decoration: InputDecoration(
                            hintText: "请输入密钥别名",
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        width: 180,
                        color: Colors.blueGrey,
                        child: TextField(
                          controller: _signPasswordController,
                          decoration: InputDecoration(
                            hintText: "请输入密钥密码",
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(onPressed: signApk, child: Text('选取密钥并签名apk包(密钥路径不能有中文)')),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Cmd:',
                  ),
                  SizedBox(
                    width: 150,
                    child: TextField(
                      controller: cmdController,
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        setCmd(cmdController.text);
                        cmdController.text = '';
                      },
                      child: Text('Send')),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        setCmd('clear');
                      },
                      child: Text('Clear')),
                ],
              ),
              Expanded(
                child: ListView(
                  children: messages.map<Widget>((item) => Text(item)).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
