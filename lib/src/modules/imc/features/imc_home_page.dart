import 'package:flutter/material.dart';
import 'package:superapp_my_bloc/src/core/bloc/components/bloc_consumer.dart';
import 'package:superapp_my_bloc/src/core/bloc/di/dependon.dart';
import 'package:superapp_my_bloc/src/core/components/base_view_component.dart';
import 'package:superapp_my_bloc/src/core/components/button_component.dart';
import 'package:superapp_my_bloc/src/core/components/input_component.dart';
import 'package:superapp_my_bloc/src/core/components/loader_component.dart';
import 'package:superapp_my_bloc/src/core/theme/app_dimension.dart';
import 'package:superapp_my_bloc/src/core/theme/app_extension.dart';
import 'package:superapp_my_bloc/src/core/theme/app_fonts.dart';
import 'package:superapp_my_bloc/src/core/utils/utils.dart';
import 'package:superapp_my_bloc/src/modules/imc/features/bloc/imc_bloc.dart';
import 'package:validatorless/validatorless.dart';

class ImcHomePage extends StatefulWidget {
  const ImcHomePage({Key? key}) : super(key: key);

  @override
  State<ImcHomePage> createState() => _ImcHomePageState();
}

class _ImcHomePageState extends State<ImcHomePage> {
  late final ImcBloc bloc;

  final _formKey = GlobalKey<FormState>();
  final _heightEC = TextEditingController();
  final _weightEC = TextEditingController();

  @override
  void initState() {
    bloc = get();
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    _heightEC.dispose();
    _heightEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = Utils.getColorArgs(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        title: const Text('Calculadora de IMC'),
      ),
      body: SingleChildScrollView(
        child: BaseViewComponent(
          child: Column(
            children: [
              _buildTitle(),
              const SizedBox(
                height: AppDimension.size_5,
              ),
              _buildForm(color),
              const SizedBox(
                height: AppDimension.size_3,
              ),
              _buildResult(color)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResult(Color color) {
    return BlocConsumer<ImcBloc, ImcState>(
      bloc: bloc,
      builder: (context, state) {
        return Visibility(
          visible: state.imc != 0,
          child: Column(
            children: [
              Text(
                'Seu imc é ${state.imc.toStringAsFixed(1)}',
                style: AppFonts.bodyLarge(),
              ),
              const SizedBox(
                height: AppDimension.size_1,
              ),
              Text(
                state.result,
                style: AppFonts.titleLarge(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildForm(Color color) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          InputComponent(
            label: 'Altura',
            controller: _heightEC,
            validator: Validatorless.required('Campo obrigatório'),
          ),
          const SizedBox(
            height: AppDimension.size_2,
          ),
          InputComponent(
            label: 'Peso',
            controller: _weightEC,
            validator: Validatorless.required('Campo obrigatório'),
          ),
          const SizedBox(
            height: AppDimension.size_4,
          ),
          BlocConsumer<ImcBloc, ImcState>(
            bloc: bloc,
            builder: (context, state) {
              return LoaderComponent(
                color: color,
                loading: state is ImcLoading,
                child: ButtonComponent(
                  color: color,
                  child: const Text('Calcular'),
                  func: () {
                    if (_formKey.currentState!.validate()) {
                      bloc.imcCalculate(
                        double.parse(_heightEC.text.replaceAll(',', '.')),
                        double.parse(_weightEC.text.replaceAll(',', '.')),
                      );

                      FocusManager.instance.primaryFocus?.unfocus();
                    }
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Calculadora de IMC',
          style: AppFonts.titleLarge(),
        ),
        const SizedBox(
          height: AppDimension.size_0,
        ),
        Text(
          'Calcule seu IMC e descubra sua composição corporal!',
          style: AppFonts.bodyLarge(
            color: AppExtension.textLightColor,
          ),
        ),
      ],
    );
  }
}