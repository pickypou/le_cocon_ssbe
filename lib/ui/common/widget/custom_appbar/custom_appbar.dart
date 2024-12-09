import 'package:flutter/material.dart';
import '../../../theme.dart';



class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final void Function(String)? onNavigate;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.onNavigate,
  });

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  Widget? _getLeading(BuildContext context) {
    if (MediaQuery.of(context).size.width > 750) {
      return null; // No menu button on large screens
    } else {
      return IconButton(
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        icon: Icon(Icons.menu, color: theme.colorScheme.onPrimary),
      );
    }
  }

  void _scrollToSection(BuildContext context, String sectionId) {
    if (onNavigate != null) {
      onNavigate!(sectionId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: theme.colorScheme.onSurface,
      title: Text(
        title,
        textAlign: TextAlign.center,
      ),
      leading: _getLeading(context),
      actions: [
        if (MediaQuery.of(context).size.width > 750) // For large screens
          ...[
            _buildNavItem(context, 'Espace Bien-être', 'espace_bien_etre'),
            _buildNavItem(context, 'Espace Sport', 'espace_sport'),
            _buildNavItem(context, 'Commentaires', 'commenters'),
            _buildNavItem(context, 'Événements', 'evenement'),
            _buildNavItem(context, 'Contact', 'contact'),
          ],
      ],
    );
  }

  Widget _buildNavItem(BuildContext context, String label, String sectionId) {
    return GestureDetector(
      onTap: () => _scrollToSection(context, sectionId),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Text(
            label,
            style: TextStyle(fontSize: 16.0, color: theme.colorScheme.onPrimary),
          ),
        ),
      ),
    );
  }
}
class CustomDrawer extends StatelessWidget {
  final GlobalKey espaceBienEtre;
  final GlobalKey espaceSport;
  final GlobalKey commenters;
  final GlobalKey evenement;
  final GlobalKey contact;

  const CustomDrawer({
    super.key,
    required this.espaceBienEtre,
    required this.espaceSport,
    required this .commenters,
    required this.evenement,
    required this.contact,
  });

  void _scrollToSection(GlobalKey sectionKey) {
    if (sectionKey.currentContext != null) {
      Scrollable.ensureVisible(
        sectionKey.currentContext!,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: theme.colorScheme.onSurface,
      elevation: 0,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          ListTile(
            title: Text('Espace Bien-être', style: TextStyle(color: theme.colorScheme.onPrimary)),
            onTap: () {
              _scrollToSection(espaceBienEtre);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Espace Sport', style: TextStyle(color: theme.colorScheme.onPrimary)),
            onTap: () {
              _scrollToSection(espaceSport);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Commentaires', style: TextStyle(color: theme.colorScheme.onPrimary)),
            onTap: () {
              _scrollToSection(commenters);
              Navigator.pop(context);
            },
          ),

          ListTile(
            title: Text('Événement', style: TextStyle(color: theme.colorScheme.onPrimary)),
            onTap: () {
              _scrollToSection(evenement);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Contact', style: TextStyle(color: theme.colorScheme.onPrimary)),
            onTap: () {
              _scrollToSection(contact);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

