import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoned/data/model/FeedModel.dart';
import 'package:zoned/ui/main/main_viewmodel.dart';

class ItemView extends StatelessWidget {
  const ItemView({Key? key, required this.model}) : super(key: key);
  final FeedModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              InkWell(
                child: const Icon(Icons.account_circle_rounded),
                onTap: () {},
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(model.username),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      model.location,
                      style:
                          const TextStyle(fontSize: 12, color: Colors.black87),
                    )
                  ],
                ),
              ),
              InkWell(
                child: const Icon(Icons.directions),
                onTap: () {
                  context.read<MainViewModel>().onItemTapped(1);
                },
              )
            ],
          ),
        ),
        Image.network(
          model.imgPosting,
          width: double.infinity,
          fit: BoxFit.cover,
          height: 200,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Apakah informasi ini benar?'),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                child: const Icon(Icons.thumb_up),
                onTap: () {},
              ),
              const SizedBox(
                width: 5,
              ),
              Text(model.voteUp),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                child: const Icon(Icons.thumb_down),
                onTap: () {},
              ),
              const SizedBox(
                width: 5,
              ),
              Text(model.voteDown),
            ],
          ),
        ),
        Container(
          padding:
              const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 16),
          child: Row(
            children: [
              Expanded(
                child: Text(model.description),
              )
            ],
          ),
        )
      ],
    );
  }
}
