import 'package:flutter/material.dart';

class AddDeliverAddress extends StatefulWidget {
  const AddDeliverAddress({Key? key}) : super(key: key);

  @override
  _AddDeliverAddressState createState() => _AddDeliverAddressState();
}

class _AddDeliverAddressState extends State<AddDeliverAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Delivery Address",
          style: TextStyle(fontSize: 18),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        height: 48,
        child: MaterialButton(
          onPressed: () {},
          child: const Text(
            "Add Address",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          color: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              30,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: ListView(
          children: const [
            TextField(
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              // controller: _textController,
              decoration: InputDecoration(
                hintText: 'First Name',
              ),
            ),
            TextField(
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              // controller: _textController,
              decoration: InputDecoration(
                hintText: 'Last Name',
              ),
            ),
            TextField(
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              // controller: _textController,
              decoration: InputDecoration(
                hintText: 'Mobile No',
              ),
            ),
            TextField(
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              // controller: _textController,
              decoration: InputDecoration(
                hintText: 'Alternate Mobile No',
              ),
            ),
            TextField(
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              // controller: _textController,
              decoration: InputDecoration(
                hintText: 'Society Name',
              ),
            ),
            TextField(
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              // controller: _textController,
              decoration: InputDecoration(
                hintText: 'Street Name',
              ),
            ),
            TextField(
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              // controller: _textController,
              decoration: InputDecoration(
                hintText: 'Landmark',
              ),
            ),
            TextField(
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              // controller: _textController,
              decoration: InputDecoration(
                hintText: 'City Name',
              ),
            ),
            TextField(
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              // controller: _textController,
              decoration: InputDecoration(
                hintText: 'Area Name',
              ),
            ),
            TextField(
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              // controller: _textController,
              decoration: InputDecoration(
                hintText: 'Pincode',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
