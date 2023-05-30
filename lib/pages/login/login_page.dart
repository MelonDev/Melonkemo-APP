import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    _provider = LoginProvider();
    //_model = createModel(context, () => Login09Model());

    //_model.emailAddressFieldController ??= TextEditingController();
    //_model.passwordFieldController ??= TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    //_model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _provider,
      builder: (BuildContext ct,Widget? widget){
        return GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              key: scaffoldKey,
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
                          margin: EdgeInsets.only(top: 30, bottom: 30,left: MediaQuery.of(context).size.width > 1100 ? 0 :20),
                          padding: const EdgeInsets.only(left: 20),
                          height: MediaQuery.of(context).size.height * 1,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                              fit: MediaQuery.of(context).size.width < 1100 ? BoxFit.fitWidth : BoxFit.fitHeight,
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
                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
                                child: Container(
                                  constraints: BoxConstraints(
                                    maxWidth: 320,
                                  ),
                                  decoration: BoxDecoration(
                                  ),
                                  child: Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        ..._titleArea(ct),
                                        _formArea(),
                                        _forgetPasswordArea(),

                                        _loginButton(),
                                        // Padding(
                                        //   padding: EdgeInsetsDirectional.fromSTEB(
                                        //       0, 24, 0, 0),
                                        //   child: FFButtonWidget(
                                        //     onPressed: () async {
                                        //       // if (_model.formKey.currentState ==
                                        //       //     null ||
                                        //       //     !_model.formKey.currentState!
                                        //       //         .validate()) {
                                        //       //   return;
                                        //       // }
                                        //     },
                                        //     text: 'Log in',
                                        //     options: FFButtonOptions(
                                        //       width: double.infinity,
                                        //       height: 44,
                                        //       padding: EdgeInsetsDirectional.fromSTEB(
                                        //           0, 0, 0, 0),
                                        //       iconPadding:
                                        //       EdgeInsetsDirectional.fromSTEB(
                                        //           0, 0, 0, 0),
                                        //       // color: FlutterFlowTheme.of(context)
                                        //       //     .primary,
                                        //       // textStyle: FlutterFlowTheme.of(context)
                                        //       //     .titleSmall
                                        //       //     .override(
                                        //       //   fontFamily: 'Inter',
                                        //       //   color: Colors.white,
                                        //       // ),
                                        //       elevation: 0,
                                        //       borderSide: BorderSide(
                                        //         color: Colors.transparent,
                                        //         width: 1,
                                        //       ),
                                        //       borderRadius: BorderRadius.circular(12),
                                        //     ),
                                        //   ),
                                        // ),
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
    );
  }

  List<Widget> _titleArea(BuildContext context) {
    return [
      SelectionArea(
          child: Text(
        'ยินดีต้อนรับกลับ ${context.watch<LoginProvider>().index}',
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
          constraints: BoxConstraints(
            maxWidth: 320,
          ),
          decoration: BoxDecoration(
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
                'อีเมล',
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
        cursorColor: Colors.grey,
        obscureText: false,
        decoration: InputDecoration(
          labelStyle: TextStyle(
              color: Colors.black.withOpacity(0.9),
              fontSize: 16,
              fontFamily: 'Itim',
              fontWeight: FontWeight.w500),
          hintText: 'ป้อนอีเมลของคุณ',
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
      padding: EdgeInsetsDirectional.fromSTEB(0, 6, 0, 0),
      child: TextFormField(
        // controller: _model
        //     .passwordFieldController,
        // obscureText: !_model
        //     .passwordFieldVisibility,
        cursorColor: Colors.grey,

        obscureText: isObscure,
        decoration: InputDecoration(
          labelStyle: TextStyle(
              color: Colors.black.withOpacity(0.9),
              fontSize: 16,
              fontFamily: 'Itim',
              fontWeight: FontWeight.w500),
          hintText: isObscure ? '••••••••' : 'ป้อนรหัสผ่านของคุณ',
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
                  : Icons.visibility_outlined,
              color: Colors.black.withOpacity(0.7),
              size: 16,
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

  Widget _loginButton() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
      child: SizedBox(
        width: double.infinity, // <-- Your width
        height: 44, // <-- Your height
        child: ElevatedButton(
          onPressed: () {
            _provider.test();
          },
          child: Text('ล็อกอิน',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Itim',
                  fontWeight: FontWeight.w600)),
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Colors.blueAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }

  Widget _forgetPasswordArea() {
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
              child: Text(
            'ไม่มีบัญชีผู้ใช้? ',
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.7),
                      fontSize: 16,
                      fontFamily: 'Itim',
                      fontWeight: FontWeight.w300)
          )),
          SelectionArea(
              child: Text(
            'ลงทะเบียน',
                  style: TextStyle(
                      color: Colors.blueAccent.withOpacity(0.9),
                      fontSize: 16,
                      fontFamily: 'Itim',
                      fontWeight: FontWeight.w600)
          )),
        ],
      ),
    );
  }
}
