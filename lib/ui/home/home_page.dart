import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoned/ui/home/home_viewmodel.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, _) {
        return viewModel.service.getFeedsRealtime();
      },
    );
  }
}
