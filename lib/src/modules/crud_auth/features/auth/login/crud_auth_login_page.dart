import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:superapp_my_bloc/src/core/components/base_view_component.dart';
import 'package:superapp_my_bloc/src/core/components/button_component.dart';
import 'package:superapp_my_bloc/src/core/components/loader_component.dart';
import 'package:superapp_my_bloc/src/core/infra/components/bloc_consumer.dart';
import 'package:superapp_my_bloc/src/core/infra/components/page_widget.dart';
import 'package:superapp_my_bloc/src/core/theme/app_colors.dart';
import 'package:superapp_my_bloc/src/core/theme/app_dimension.dart';
import 'package:superapp_my_bloc/src/core/theme/app_extension.dart';
import 'package:superapp_my_bloc/src/core/theme/app_fonts.dart';
import 'package:superapp_my_bloc/src/core/utils/utils.dart';
import 'package:superapp_my_bloc/src/modules/crud_auth/features/auth/login/bloc/crud_auth_login_bloc.dart';

class CrudAuthLoginPage extends PageWidget<CrudAuthLoginBloc> {
  CrudAuthLoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Utils.getArgs(context);

    return Scaffold(
      body: BaseViewComponent(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTitle(),
              const SizedBox(
                height: AppDimension.size_3,
              ),
              _buildButtons()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Column(
      children: [
        BlocConsumer<CrudAuthLoginBloc, CrudAuthLoginState>(
          bloc: bloc,
          listener: (context, state) {
            if (state is CrudAuthLoginError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          builder: (context, state) {
            return LoaderComponent(
              color: AppColors.red600,
              loading: state is CrudAuthLoginLoading,
              child: ButtonComponent(
                color: AppColors.red600,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(FontAwesomeIcons.google),
                    SizedBox(
                      width: AppDimension.size_1,
                    ),
                    Text('Login com o google'),
                  ],
                ),
                func: () => bloc.signInWithGoogle(),
              ),
            );
          },
        )
      ],
    );
  }

  Widget _buildTitle() {
    return Column(
      children: [
        Text(
          'Login',
          style: AppFonts.titleLarge(),
        ),
        const SizedBox(
          height: AppDimension.size_0,
        ),
        Text(
          'Faça login com google ou se preferir crie sua conta!',
          style: AppFonts.bodyLarge(
            color: AppExtension.textLightColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
