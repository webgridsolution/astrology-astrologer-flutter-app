import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/service_controller.dart';
import '../../models/service_model.dart';
import '../../utils/constants.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_text_field.dart';

class ServiceFormScreen extends StatefulWidget {
  final String? serviceId;
  const ServiceFormScreen({super.key, this.serviceId});

  @override
  State<ServiceFormScreen> createState() => _ServiceFormScreenState();
}

class _ServiceFormScreenState extends State<ServiceFormScreen> {
  late final TextEditingController name;
  late final TextEditingController type;
  late final TextEditingController price;
  late final TextEditingController duration;
  late final TextEditingController desc;
  bool enabled = true;
  bool perMinute = true;

  @override
  void initState() {
    super.initState();
    final existing = widget.serviceId == null
        ? null
        : context.read<ServiceController>().byId(widget.serviceId!);
    name = TextEditingController(text: existing?.name ?? '');
    type = TextEditingController(text: existing?.type ?? 'Chat');
    price = TextEditingController(text: existing?.price.toString() ?? '');
    duration = TextEditingController(text: '${existing?.durationMinutes ?? 30}');
    desc = TextEditingController(text: existing?.description ?? '');
    enabled = existing?.enabled ?? true;
    perMinute = existing?.perMinute ?? true;
  }

  @override
  void dispose() {
    name.dispose();
    type.dispose();
    price.dispose();
    duration.dispose();
    desc.dispose();
    super.dispose();
  }

  void _save() {
    final c = context.read<ServiceController>();
    final model = ServiceModel(
      id: widget.serviceId ?? 's-${DateTime.now().millisecondsSinceEpoch}',
      name: name.text.trim(),
      type: type.text.trim(),
      price: double.tryParse(price.text) ?? 0,
      perMinute: perMinute,
      durationMinutes: int.tryParse(duration.text) ?? 30,
      description: desc.text.trim(),
      enabled: enabled,
      icon: 'chat',
    );
    if (widget.serviceId == null) {
      c.add(model);
    } else {
      c.update(model);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final edit = widget.serviceId != null;
    return Scaffold(
      appBar: AppBar(title: Text(edit ? 'Edit Service' : 'Add Service')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AppTextField(label: 'Service Name', controller: name),
          const SizedBox(height: 12),
          AppTextField(label: 'Service Type', controller: type),
          const SizedBox(height: 12),
          AppTextField(label: 'Price (₹)', controller: price, keyboardType: TextInputType.number),
          const SizedBox(height: 12),
          AppTextField(label: 'Duration (minutes)', controller: duration, keyboardType: TextInputType.number),
          const SizedBox(height: 12),
          AppTextField(label: 'Description', controller: desc, maxLines: 3),
          SwitchListTile(
            title: const Text('Per minute pricing'),
            value: perMinute,
            onChanged: (v) => setState(() => perMinute = v),
          ),
          SwitchListTile(
            title: const Text('Available'),
            value: enabled,
            onChanged: (v) => setState(() => enabled = v),
          ),
          const SizedBox(height: 12),
          AppButton(label: edit ? 'Save Changes' : 'Add Service', onTap: _save),
        ],
      ),
    );
  }
}
