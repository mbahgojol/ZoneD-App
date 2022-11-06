import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoned/ui/feeds/create_feeds_viewmodel.dart';
import 'package:zoned/ui/feeds/widget/dropdown_typeincident.dart';

import '../camera/camera_page.dart';

late final GlobalKey<FormFieldState> keyKu = GlobalKey<FormFieldState>();

class CreateFeedsPage extends StatefulWidget {
  const CreateFeedsPage({Key? key}) : super(key: key);

  @override
  State<CreateFeedsPage> createState() => _CreateFeedsPageState();
}

class _CreateFeedsPageState extends State<CreateFeedsPage> {
  final _controllerTitle = TextEditingController();
  final _controllerDes = TextEditingController();

  Future<void> _showLoadingDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            width: 100,
            height: 100,
            child: Center(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                CircularProgressIndicator(),
                SizedBox(
                  height: 16,
                ),
                Text('Loading Posting Feeds...')
              ],
            )),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        InkWell(
          onTap: () async {
            await availableCameras().then((value) async {
              XFile result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => CameraPage(cameras: value)));
              context.read<CreateFeedsViewModel>().setPath(result.path);
            });
          },
          child: Consumer<CreateFeedsViewModel>(
            builder: (context, viewModel, _) {
              if (viewModel.path == null) {
                return Image.asset(
                  'assets/images/add_image.png',
                  width: double.infinity,
                  height: 300,
                );
              } else {
                return Image.file(
                  File(viewModel.path ?? ""),
                  width: double.infinity,
                  fit: BoxFit.cover,
                  height: 300,
                );
              }
            },
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Consumer<CreateFeedsViewModel>(
          builder: (context, viewModel, _) {
            return editText('Title', controller: _controllerTitle,
                onChange: (value) {
              viewModel.title = value;
            });
          },
        ),
        const SizedBox(
          height: 16,
        ),
        Consumer<CreateFeedsViewModel>(
          builder: (context, viewModel, _) {
            return editText('Description', controller: _controllerDes,
                onChange: (value) {
              viewModel.description = value;
            });
          },
        ),
        const SizedBox(
          height: 16,
        ),
        DropdownTypeIncident(
          onChanged: (position) {
            context.read<CreateFeedsViewModel>().incident = position;
          },
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
            onPressed: () {
              context.read<CreateFeedsViewModel>().postingFeed(() {
                _showLoadingDialog();
              }, () {
                Navigator.of(context).pop();
                _controllerTitle.clear();
                _controllerDes.clear();
                keyKu.currentState?.reset();
              });
            },
            child: const Text('Submit'))
      ],
    );
  }

  Widget editText(String hint,
          {required TextEditingController controller,
          required Function(String) onChange}) =>
      TextFormField(
        controller: controller,
        keyboardType: TextInputType.text,
        onChanged: onChange,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: hint,
        ),
      );
}
