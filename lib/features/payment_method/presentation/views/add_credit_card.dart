import 'package:flutter/material.dart';

import '../../../../core/components/button/button_controller.dart';
import '../../../../core/components/button/button_widget.dart';
import '../../../../core/components/formatters/credit_card_formatter.dart';
import '../../../../core/components/formatters/date_formatter.dart';
import '../../../../core/components/search_input/search_input.dart';
import '../../../../core/constants/app_colors.dart';
import '../widgets/credit_card.dart';

class AddCreditCard extends StatefulWidget {
  const AddCreditCard({super.key});

  @override
  State<AddCreditCard> createState() => _AddCreditCardState();
}

class _AddCreditCardState extends State<AddCreditCard>
    with TickerProviderStateMixin {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  final FocusNode _expiryDateFocusNode = FocusNode();
  final FocusNode _cvvFocusNode = FocusNode();

  final ValueNotifier<bool> _isExpiryFocused = ValueNotifier(false);
  final ValueNotifier<bool> _isCvvFocused = ValueNotifier(false);

  late final AnimationController _flipController;
  bool _isFlipped = false;

  ButtonStateEnum _statusButton = ButtonStateEnum.disabled;

  @override
  void initState() {
    super.initState();

    _flipController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    // Listeners para os FocusNodes
    _expiryDateFocusNode.addListener(() {
      _isExpiryFocused.value = _expiryDateFocusNode.hasFocus;
    });

    _cvvFocusNode.addListener(() {
      _isCvvFocused.value = _cvvFocusNode.hasFocus;
    });

    // Monitora os focus nodes para flip do cartão
    _isExpiryFocused.addListener(_handleFocusChange);
    _isCvvFocused.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _flipController.dispose();
    _expiryDateFocusNode.dispose();
    _cvvFocusNode.dispose();
    _isExpiryFocused.dispose();
    _isCvvFocused.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    if (_isExpiryFocused.value || _isCvvFocused.value) {
      if (!_isFlipped) {
        _flipController.forward();
        _isFlipped = true;
      }
    } else if (_isFlipped) {
      _flipController.reverse();
      _isFlipped = false;
    }
  }

  void _onFieldChanged(String value) {
    setState(() {});

    if (_cardNumberController.text.length == 19 &&
        _expiryDateController.text.length == 5 &&
        _cvvController.text.length == 3) {
      _statusButton = ButtonStateEnum.enabled;
    } else {
      _statusButton = ButtonStateEnum.disabled;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        surfaceTintColor: AppColors.background,
        foregroundColor: Colors.white,
        title: const Text('Adicionar cartão de crédito'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 24,
            left: 16,
            right: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Agora, digite os detalhes do seu cartão de crédito.',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),

              // Animação do cartão de crédito
              Center(
                child: GestureDetector(
                  onTap: _handleFocusChange,
                  child: CreditCard(
                    cardNumber: _cardNumberController.text,
                    dateNumber: _expiryDateController.text,
                    cvv: _cvvController.text,
                    flipAnimation: _flipController,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Campo de número do cartão
              const Text(
                'Número do cartão',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              SearchInput(
                controller: _cardNumberController,
                hintText: '0000 0000 0000 0000',
                onChanged: _onFieldChanged,
                keyboardType: TextInputType.number,
                inputFormatters: [CreditCardFormatter()],
              ),
              const SizedBox(height: 16),

              // Campo de data de validade
              const Text(
                'Data de validade',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              SearchInput(
                controller: _expiryDateController,
                hintText: 'MM/AA',
                onChanged: _onFieldChanged,
                keyboardType: TextInputType.number,
                focusNode: _expiryDateFocusNode,
                inputFormatters: [DateFormatter()],
              ),
              const SizedBox(height: 16),

              // Campo de CVC
              const Text(
                'CVV',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              SearchInput(
                keyboardType: TextInputType.number,
                controller: _cvvController,
                hintText: 'Digite seu CVV',
                onChanged: _onFieldChanged,
                focusNode: _cvvFocusNode,
                maxLength: 3,
              ),

              const SizedBox(height: 16),

              // Botão de adicionar cartão
              ButtonWidget(
                onPressed: () {},
                textButton: 'Adicionar cartão',
                buttonState: _statusButton,
                backgroundColor: AppColors.primary,
              ),

              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}