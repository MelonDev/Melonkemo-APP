import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:melonkemo/core/components/bouncing/melon_bouncing_button.dart';
import 'package:melonkemo/core/extensions/bot_toast_extension.dart';
import 'package:provider/provider.dart';
import 'login_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  bool isObscure = true;
  late LoginProvider _provider;

  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _provider = LoginProvider();

    _usernameController = TextEditingController();
    _passwordController = TextEditingController();

    //_model = createModel(context, () => Login09Model());

    //_model.emailAddressFieldController ??= TextEditingController();
    //_model.passwordFieldController ??= TextEditingController();
    //WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    //_model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Title(
      color: Colors.white,
      title: "ลงชื่อเข้าใช้",
      child: ChangeNotifierProvider(
        create: (_) => _provider,
        builder: (BuildContext ct, Widget? widget) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
            child: WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                key: scaffoldKey,
                //resizeToAvoidBottomInset: false,
                backgroundColor: Colors.white,
                body: SafeArea(
                  top: true,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      if (MediaQuery.of(context).size.width > 900)
                        Expanded(
                          child: Container(
                            width: 100,
                            margin: EdgeInsets.only(
                                top: 30,
                                bottom: 30,
                                left: MediaQuery.of(context).size.width > 1100
                                    ? 0
                                    : 50),
                            padding: const EdgeInsets.only(left: 20),
                            height: MediaQuery.of(context).size.height * 1,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              image: DecorationImage(
                                fit: MediaQuery.of(context).size.width < 1100
                                    ? BoxFit.fitWidth
                                    : BoxFit.fitHeight,
                                alignment: Alignment.centerRight,
                                image: Image.network(
                                  //'https://pbs.twimg.com/media/FxQoAeMaEAARLme?format=jpg&name=orig',
                                  'https://firebasestorage.googleapis.com/v0/b/meloncloud-d2fb8.appspot.com/o/MelonCloud%2Fmelonkemo%2Fcover%2FFxQoAeMaEAARLme.jpeg?alt=media&token=5584688c-76cb-4823-bcee-374c2b746a22',
                                ).image,
                              ),
                            ),
                          ),
                        ),
                      Expanded(
                          child: Material(
                            color: Colors.white,
                            elevation: 0,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0),
                                topLeft: Radius.circular(2),
                                topRight: Radius.circular(0),
                              ),
                            ),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 1,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(0),
                                  topLeft: Radius.circular(2),
                                  topRight: Radius.circular(0),
                                ),
                                shape: BoxShape.rectangle,
                              ),
                              child: Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Padding(
                                  padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
                                  child: Container(
                                    constraints: BoxConstraints(
                                      maxWidth: 320,
                                    ),
                                    decoration: BoxDecoration(),
                                    child: Align(
                                      alignment: AlignmentDirectional(0, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          ..._titleArea(ct),
                                          _formArea(),
                                          _forgetPasswordArea(),

                                          _loginButton(context),
                                          _registerArea()
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> _titleArea(BuildContext context) {
    return [
      SelectionArea(
          child: Text(
        'ยินดีต้อนรับกลับ',
        style: TextStyle(
            color: Colors.black.withOpacity(0.9),
            fontSize: 32,
            fontFamily: 'Itim',
            fontWeight: FontWeight.w600),
      )),
      Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
        child: SelectionArea(
            child: Text(
          'กรอกรายละเอียดของคุณด้านล่างได้เลย!',
          style: TextStyle(
              color: Colors.black.withOpacity(0.6),
              fontSize: 16,
              fontFamily: 'Itim',
              fontWeight: FontWeight.normal),
        )),
      ),
    ];
  }

  Widget _formArea() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 32, 0, 0),
      child: Form(
        //key: _model.formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 320,
          ),
          decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [_emailArea(), _passwordArea()],
          ),
        ),
      ),
    );
  }

  Widget _emailArea() {
    return Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              SelectionArea(
                  child: Text(
                'ชื่อผู้ใช้',
                style: TextStyle(
                    color: Colors.black.withOpacity(0.9),
                    fontSize: 16,
                    fontFamily: 'Itim',
                    fontWeight: FontWeight.w500),
              )),
            ],
          ),
          _emailTextField(),
        ]);
  }

  Widget _emailTextField() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 6, 0, 0),
      child: TextFormField(
        // controller: _model
        //     .emailAddressFieldController,
        controller: _usernameController,

        cursorColor: Colors.grey,
        obscureText: false,
        decoration: InputDecoration(
          labelStyle: TextStyle(
              color: Colors.black.withOpacity(0.9),
              fontSize: 16,
              fontFamily: 'Itim',
              fontWeight: FontWeight.w500),
          hintText: 'ป้อนชื่อผู้ใช้',
          hintStyle: TextStyle(
              color: Colors.black.withOpacity(0.5),
              fontSize: 16,
              fontFamily: 'Itim',
              fontWeight: FontWeight.w500),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black.withOpacity(0.2),
              width: 1.2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black.withOpacity(0.2),
              width: 1.2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFFDA29B),
              width: 1.2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFFDA29B),
              width: 1.2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsetsDirectional.fromSTEB(14, 10, 14, 10),
        ),
        style: TextStyle(
            color: Colors.black.withOpacity(0.8),
            fontSize: 16,
            fontFamily: 'Itim',
            fontWeight: FontWeight.w500),
        keyboardType: TextInputType.emailAddress,
        // validator: _model
        //     .emailAddressFieldControllerValidator
        //     .asValidator(context),
      ),
    );
  }

  Widget _passwordTextField() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 6, 0, 0),
      child: TextFormField(
        // controller: _model
        //     .passwordFieldController,
        // obscureText: !_model
        //     .passwordFieldVisibility,
        cursorColor: Colors.grey,

        obscureText: isObscure,
        controller: _passwordController,
        decoration: InputDecoration(
          labelStyle: TextStyle(
              color: Colors.black.withOpacity(0.9),
              fontSize: 16,
              fontFamily: 'Itim',
              fontWeight: FontWeight.w500),
          hintText: 'ป้อนรหัสผ่าน',
          hintStyle: TextStyle(
              color: Colors.black.withOpacity(0.5),
              fontSize: 16,
              fontFamily: 'Itim',
              fontWeight: FontWeight.w500),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black.withOpacity(0.2),
              width: 1.2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black.withOpacity(0.2),
              width: 1.2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xFFFDA29B),
              width: 1.2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xFFFDA29B),
              width: 1.2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsetsDirectional.fromSTEB(14, 10, 14, 10),
          suffixIcon: InkWell(
            onTap: () {
              setState(() {
                isObscure = !isObscure;
              });
            },
            focusNode: FocusNode(skipTraversal: true),
            child: Icon(
              isObscure
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_rounded,
              color:
                  isObscure ? Colors.black.withOpacity(0.5) : Colors.blueAccent,
              size: 20,
            ),
          ),
        ),
        // validator: _model
        //     .passwordFieldControllerValidator
        //     .asValidator(context),
      ),
    );
  }

  Widget _passwordArea() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
      child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectionArea(
                child: Text(
              'รหัสผ่าน',
              style: TextStyle(
                  color: Colors.black.withOpacity(0.9),
                  fontSize: 16,
                  fontFamily: 'Itim',
                  fontWeight: FontWeight.w500),
            )),
            _passwordTextField(),
          ]),
    );
  }

  Widget _loginButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
      child: MelonBouncingButton.text(
          enabledHover: true,
          callback:(){
            if (_usernameController.text.isNotEmpty &&
                _passwordController.text.isNotEmpty) {
              _provider.login(
                username: _usernameController.text,
                password: _passwordController.text,
              );
            } else {
              //BotToast().component.test("กรุณากรอกข้อมูลให้ครบถ้วน");
              BotToast().component.error("กรุณากรอกข้อมูลให้ครบถ้วน");
            }
          },
          text: "ล็อกอิน",
          textColor: Colors.white,
          fontSize: 18,
          height: 44,
          color: Colors.blueAccent),
    );
  }

  Widget _forgetPasswordArea() {
    return Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
        child:
        MelonBouncingButton.text(
            enabledHover: true,
            callback:(){
              BotToast().component.dialog("ฟังก์ชันไม่พร้อมใช้งาน",color: Colors.redAccent);
            },
            text: "ลืมรหัสผ่าน?",
            textColor: Colors.blueAccent,
            fontSize: 16,
            height: 26,
            color: Colors.transparent)
    );
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
      child: SelectionArea(
          child: Text('ลืมรหัสผ่าน?',
              style: TextStyle(
                  color: Colors.blueAccent.withOpacity(0.9),
                  fontSize: 16,
                  fontFamily: 'Itim',
                  fontWeight: FontWeight.w600))),
    );
  }

  Widget _registerArea() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SelectionArea(
              child: Text('ไม่มีบัญชีผู้ใช้? ',
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.7),
                      fontSize: 16,
                      fontFamily: 'Itim',
                      fontWeight: FontWeight.w300))),
          SelectionArea(
              child: Text('ลงทะเบียน',
                  style: TextStyle(
                      color: Colors.blueAccent.withOpacity(0.9),
                      fontSize: 16,
                      fontFamily: 'Itim',
                      fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }
}
