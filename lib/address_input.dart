import 'package:flutter/material.dart';

import 'localizations.dart';
import 'voting_profile.dart';

class AddressInputPage extends StatefulWidget {
  @override
  _AddressInputPageState createState() => _AddressInputPageState();
}

class _AddressInputPageState extends State<AddressInputPage> {
  final _formKey = GlobalKey<FormState>();
  String _address;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final addressController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(BallotLocalizations.of(context).addressInputTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: addressController,
                  onSaved: (val) => _address = val,
                  decoration: InputDecoration(
                      labelText:
                          BallotLocalizations.of(context).votingAddressLabel),
                  validator: (val) {
                    return val.isEmpty
                        ? BallotLocalizations.of(context).required
                        : null;
                  },
                ),
              ),
              Row(
                children: <Widget>[
                  Text('Examples:'),
                  _createAddressExampleButton(
                      BallotLocalizations.of(context).california,
                      '1456 Edgewood Dr, Palo Alto, CA 94301',
                      theme,
                      addressController),
                  _createAddressExampleButton(
                      BallotLocalizations.of(context).colorado,
                      '5101 E Montview Blvd, Denver, CO 80207',
                      theme,
                      addressController),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text(BallotLocalizations.of(context).lookup),
                  onPressed: () {
                    final form = _formKey.currentState;
                    if (form.validate()) {
                      form.save();
                      var route = MaterialPageRoute(
                        builder: (context) => VotingProfile(address: _address),
                      );
                      Navigator.of(context).push(route);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createAddressExampleButton(text, address, theme, addressController) {
    return FlatButton(
      child: Text(text,
          style: TextStyle(
              color: theme.accentColor, decoration: TextDecoration.underline)),
      onPressed: () {
        addressController.text = address;
      },
    );
  }
}
