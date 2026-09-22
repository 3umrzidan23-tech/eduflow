import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..loadProfile(),
      child: const ProfileView(),
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoggedOut) {
          context.go('/login');
        } else if (state is ProfileFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Profile',
            style: TextStyle(color: Color(0xFF1E293B), fontWeight: FontWeight.bold),
          ),
          centerTitle: false,
        ),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading || state is ProfileInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileLoaded) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue.withValues(alpha: 0.1),
                              border: Border.all(color: Colors.white, width: 4),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Icon(Icons.person, size: 60, color: Colors.blueAccent),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Color(0xFF1E293B),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.edit, color: Colors.white, size: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      state.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.email,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 48),
                    _buildProfileItem(
                      icon: Icons.settings_outlined,
                      title: 'Settings',
                      onTap: () {},
                    ),
                    _buildProfileItem(
                      icon: Icons.notifications_none_outlined,
                      title: 'Notifications',
                      onTap: () {},
                    ),
                    _buildProfileItem(
                      icon: Icons.help_outline,
                      title: 'Help & Support',
                      onTap: () {},
                    ),
                    _buildProfileItem(
                      icon: Icons.logout,
                      title: 'Logout',
                      textColor: Colors.red,
                      iconColor: Colors.red,
                      onTap: () {
                        _showLogoutDialog(context);
                      },
                    ),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildProfileItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? textColor,
    Color? iconColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: (iconColor ?? const Color(0xFF1E293B)).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: iconColor ?? const Color(0xFF1E293B), size: 24),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor ?? const Color(0xFF1E293B),
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<ProfileCubit>().logout();
            },
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
