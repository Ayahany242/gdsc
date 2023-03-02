import 'package:flutter/material.dart';

class AnimatedListScreen extends StatefulWidget {
  const AnimatedListScreen({super.key});

  @override
  State<AnimatedListScreen> createState() => _AnimatedListScreenState();
}

class _AnimatedListScreenState extends State<AnimatedListScreen> {
  final List<String> items = [];

  final GlobalKey<AnimatedListState> key =
      GlobalKey(); // to handel state in animated

  final ScrollController scrollController =
      ScrollController(); //  بتحكم في الاسكرول بتاعي

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Animated List'),
        elevation: 0.0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              insertItem();
            },
            icon: Icon(
              Icons.add,
              size: size.height / 20,
              color: Colors.deepPurple,
            ),
          ),
          Expanded(
            child: AnimatedList(
              key: key,
              controller: scrollController,
              initialItemCount: items.length,
              itemBuilder: (context, index, animation) => SizeTransition(
                sizeFactor: animation,
                child: itemBuilder(
                  // height: size.height / 10,
                  // width: size.width * .9,
                  text: items[index],
                  onPressed: () {
                    deleteItem(index);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void insertItem() {
    var index = items.length;
    print(index);
    items.add('Item ${index + 1}');
    key.currentState!.insertItem(index);
    // scroll to last item has added
    Future.delayed(
      const Duration(milliseconds: 300),
      () => scrollController.animateTo(
          scrollController.position.maxScrollExtent /* اخر مكان للسكرول*/,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn),
    );
  }

  void deleteItem(int index) {
    var removedItem = items.removeAt(index);

    key.currentState!.removeItem(
      index,
      (context, animation) => SizeTransition(
        sizeFactor: animation,
        child: itemBuilder(
          text: 'Deleted',
          onPressed: () {},
          color: Colors.red,
        ),
      ),
    );
  }
}

Widget itemBuilder(
        {
        // required double height,
        // required double width,
        required String text,
        required VoidCallback onPressed,
        Color? color}) =>
    Container(
      // height: height, //size.height / 10,
      // width: width, //size.width * .9,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      /*  decoration: BoxDecoration(
          //color: const Color.fromARGB(255, 148, 117, 202),
          //borderRadius: BorderRadius.circular(10),
          /*    boxShadow: [
          BoxShadow(
            //  color: Colors.grey.withOpacity(.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ], */
          ), */
      child: Card(
        color: color ?? const Color.fromARGB(255, 148, 117, 202),
        elevation: 3,
        child: Center(
          child: ListTile(
            title: Text(
              text,
              style: const TextStyle(color: Colors.white),
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
              onPressed: onPressed,
            ),
          ),
        ),
      ),
    );
