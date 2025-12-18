import 'package:flutter/material.dart';
import '../utils/theme.dart';
import '../utils/role_manager.dart';

class RoleSelectionDropdown extends StatefulWidget {
  final Function(String)? onRoleChanged;
  const RoleSelectionDropdown({super.key, this.onRoleChanged});

  @override
  State<RoleSelectionDropdown> createState() => _RoleSelectionDropdownState();
}

class _RoleSelectionDropdownState extends State<RoleSelectionDropdown> {
  String currentRole = RoleManager.getCurrentRole();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: continuoBlue.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: currentRole,
          icon: const Icon(Icons.arrow_drop_down, color: continuoBlue),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: continuoBlue,
                fontWeight: FontWeight.w500,
              ),
          items: RoleManager.availableRoles.map((String role) {
            return DropdownMenuItem<String>(
              value: role,
              child: Text(
                role,
                style: const TextStyle(
                  fontSize: 14,
                  color: continuoBlue,
                ),
              ),
            );
          }).toList(),
          onChanged: (String? newRole) async {
            if (newRole != null && newRole != currentRole) {
              setState(() {
                currentRole = newRole;
              });
              await RoleManager.setUserRole(newRole);
              widget.onRoleChanged?.call(newRole);
            }
          },
        ),
      ),
    );
  }
}

class RoleFilterHeader extends StatelessWidget {
  final Function(String)? onRoleChanged;
  const RoleFilterHeader({super.key, this.onRoleChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Filter by Role: ',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: continuoBlue,
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(width: 8),
        RoleSelectionDropdown(onRoleChanged: onRoleChanged),
      ],
    );
  }
}
