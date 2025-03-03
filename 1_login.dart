Login/Signup

import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home:AuthScreen(),
    theme:ThemeData(primarySwatch: Colors.blueGrey),
  )
  );
}

class AuthScreen extends StatefulWidget{
  @override
  _AuthScreenState createState()=>_AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>{
  final _formKey= GlobalKey<FormState>();
  bool _isLogin=true;
  bool _obscurepwd=true;
  String _email='';
  String _password='';
  final Map<String,String> _userDb={};

  void toggle(){
    setState(() {
      _isLogin=!_isLogin;
    });
}
  void submitForm(){
    if (_formKey.currentState!.validate()){
      _formKey.currentState!.save();
    }
    if (_isLogin){
      if (_userDb.containsKey(_email) &&
          _userDb[_email]==_password){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content:Text('Login')));

      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content:Text('Login invalid')));
      }
    }
    else{
      if (_userDb.containsKey(_email)){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content:Text('User exists. Login.')));
      }
      else{
        _userDb[_email]=_password;
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content:Text('acc created. login')));
      }
      toggle();
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body:Center(
        key:_formKey,
        child:Column(
          children:[
            Text(
            _isLogin ? 'Login':'SignUp',
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText:'Email'
              ),
              validator: (value){
                if (value==null||!value.contains('@')){
                  return 'Enter valid email';
                }
                return null;
              },
            ),
            SizedBox(height:15),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'password'
              ),
              obscureText: _obscurepwd,
              validator:(value){
                if (value==null||value.length<6){
                  return 'password must be 6 chars';
                }
                return null;
              },
            ),
            SizedBox(height:20),
            ElevatedButton(
              onPressed: submitForm,
              child: Text(_isLogin?'Login':'Sign Up')
            ),

            TextButton(
              onPressed: toggle,
              child:Text(_isLogin?'Dont have an account? Sign Up':'Already have an account?Login'),
            ),
          ],
        ),

      ),
    );
  }

}