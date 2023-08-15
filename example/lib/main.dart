import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:bushaicon/bushaicon.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int batchIconNumber = 0;
  final _bushaiconPlugin = Bushaicon();

  String currentIconName = "?";

  bool loading = false;
  bool showAlert = true;

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      Bushaicon.initialize(
        classNames: ['MainActivity', 'DarkTheme', 'LightTheme'],
      );
    } else {
      Bushaicon.getApplicationIconBadgeNumber().then((v) {
        setState(() {
          batchIconNumber = v;
        });
      });

      Bushaicon.getAlternateIconName().then((v) {
        setState(() {
          currentIconName = v ?? "`primary`";
        });
      });
    }
  }

  void switchAppIcon() async {
    await _bushaiconPlugin.switchIconTo(
     classNames: ['DarkTheme', '']
    );
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Dynamic App Icon'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 28),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Current batch number: $batchIconNumber",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            TextField(
              controller: controller,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp("\\d+")),
              ],
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Set Batch Icon Number",
                suffixIcon: loading
                    ? Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(
                            // strokeWidth: 2,
                            ),
                      )
                    : IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () async {
                          setState(() {
                            loading = true;
                          });
                          try {
                            await Bushaicon.setApplicationIconBadgeNumber(
                                int.parse(controller.text));
                            batchIconNumber = await Bushaicon.getApplicationIconBadgeNumber();
                            if (this.mounted) {
                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Successfully changed batch number"),
                              ));
                            }
                          } on PlatformException {
                            if (this.mounted) {
                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Failed to change batch number"),
                              ));
                            }
                          } catch (e) {
                            if (this.mounted) {
                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Failed to change batch number"),
                              ));
                            }
                          }

                          setState(() {
                            loading = false;
                          });
                        },
                      ),
              ),
            ),
            SizedBox(
              height: 28,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Current Icon Name: $currentIconName",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            SwitchListTile(
                title: Text("Show Alert"),
                subtitle:
                    Text("Disable alert at your own risk as it uses a private/undocumented API"),
                value: showAlert,
                onChanged: (value) {
                  setState(() {
                    showAlert = value;
                  });
                }),
            OutlinedButton.icon(
              icon: Icon(Icons.ac_unit),
              label: Text("Team Fortress"),
              onPressed: () async {
                try {
                  print(await Bushaicon.supportsAlternateIcons);
                  if (await Bushaicon.supportsAlternateIcons) {
                    await Bushaicon.setAlternateIconName("teamfortress", showAlert: showAlert);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("App icon change successful"),
                    ));
                    Bushaicon.getAlternateIconName().then((v) {
                      setState(() {
                        currentIconName = v ?? "`primary`";
                      });
                    });
                    return;
                  }
                } on PlatformException {
                } catch (e) {}
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Failed to change app icon"),
                ));
              },
            ),
            OutlinedButton.icon(
              icon: Icon(Icons.ac_unit),
              label: Text("Photos"),
              onPressed: () async {
                try {
                  if (await Bushaicon.supportsAlternateIcons) {
                    await Bushaicon.setAlternateIconName("photos", showAlert: showAlert);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("App icon change successful"),
                    ));
                    Bushaicon.getAlternateIconName().then((v) {
                      setState(() {
                        currentIconName = v ?? "`primary`";
                      });
                    });
                    return;
                  }
                } on PlatformException {
                } catch (e) {}
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Failed to change app icon"),
                ));
              },
            ),
            OutlinedButton.icon(
              icon: Icon(Icons.ac_unit),
              label: Text("Chills"),
              onPressed: () async {
                try {
                  if (await Bushaicon.supportsAlternateIcons) {
                    await Bushaicon.setAlternateIconName("chills", showAlert: showAlert);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("App icon change successful"),
                    ));
                    Bushaicon.getAlternateIconName().then((v) {
                      setState(() {
                        currentIconName = v ?? "`primary`";
                      });
                    });
                    return;
                  }
                } on PlatformException {
                } catch (e) {}
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Failed to change app icon"),
                ));
              },
            ),
            SizedBox(
              height: 28,
            ),
            OutlinedButton.icon(
              icon: Icon(Icons.restore_outlined),
              label: Text("Restore Icon"),
              onPressed: () async {
                try {
                  if (await Bushaicon.supportsAlternateIcons) {
                    await Bushaicon.setAlternateIconName(null, showAlert: showAlert);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("App icon restore successful"),
                    ));
                    Bushaicon.getAlternateIconName().then((v) {
                      setState(() {
                        currentIconName = v ?? "`primary`";
                      });
                    });
                    return;
                  }
                } on PlatformException {
                } catch (e) {}
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Failed to change app icon"),
                ));
              },
            ),
            OutlinedButton.icon(
              icon: Icon(Icons.restore_outlined),
              label: Text("Andriod Icon"),
              onPressed: () async {
                switchAppIcon();
              },
            ),
          ],
        ),
      ),
    );
  }
}
