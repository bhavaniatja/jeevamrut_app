import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jeevamrut_app/Screens/profile/components/add_delivery_address.dart';
import 'package:jeevamrut_app/Screens/profile/components/single_delivery_address.dart';
import 'package:jeevamrut_app/bloc/address/address_bloc.dart';
import 'package:jeevamrut_app/models/address_response.dart';

// ignore: must_be_immutable
class DeliveryDetails extends StatefulWidget {
  // AddressResponse addressdata;
  DeliveryDetails({Key? key}) : super(key: key);

  @override
  _DeliveryDetailsState createState() => _DeliveryDetailsState();
}

class _DeliveryDetailsState extends State<DeliveryDetails> {
  static const String routeName = '/address';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delivery Details"),
      ),
      bottomNavigationBar: BlocBuilder<AddressBloc, AddressState>(
        builder: (context, state) {
          if (state is AddressLoaded) {
            return Container(
              // width: 160,
              height: 48,
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: MaterialButton(
                child: Text("Add new Address"),
                onPressed: () {
                  BlocProvider.of<AddressBloc>(context).add(AddressEditing());
                  // context.read<AddressBloc>().add(AddressInitial());

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AddDeliverAddress(state.Address),
                    ),
                  );
                },
                color: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    30,
                  ),
                ),
              ),
            );
          } else {
            return SizedBox();
          }
        },
      ),
      body: BlocBuilder<AddressBloc, AddressState>(
        builder: (context, state) {
          if (state is AddressLoaded) {
            return ListView(
              children: [
                ListTile(
                  title: Text("Deliver To"),
                ),
                Divider(
                  height: 1,
                ),
                Column(children: [
                  SingleDeliveryItem(
                      address: '${state.Address.address!.city}',
                      title: '${state.Address.fname}',
                      number: '${state.Address.mobileNumber}',
                      addressType: '${state.Address.address!.type}')
                ]),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
