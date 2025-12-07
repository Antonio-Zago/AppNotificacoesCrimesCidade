import 'package:flutter/material.dart';
import 'package:notifica_crimes_frontend/config/colors_constants.dart';

class DrawerDefault extends StatefulWidget {
  const DrawerDefault({super.key, required this.estaLogado});

  final bool estaLogado;

  @override
  State<DrawerDefault> createState() => _DrawerDefaultState();
}

class _DrawerDefaultState extends State<DrawerDefault> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/background.png',
            ), // Path to your image
            fit: BoxFit.cover, // How the image should fit within the container
          ),
        ),
        child: ListView(
          children: [
            if(widget.estaLogado)
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Color(ColorsConstants.azulPadraoApp),
                ),
                accountName: Text(
                  "Nome usuário",
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                ),
                accountEmail: Text("Email usuário"),
                currentAccountPicture: CircleAvatar(radius: 30.0,
                backgroundImage: AssetImage("assets/images/perfil_exemplo.png"),),
              ),
            ListTile(
              title: Text(
                "Início",
                style: TextStyle(
                  color: Colors.black, 
                  fontSize: 17,
                  fontWeight: FontWeight.bold
                ),
              ),
              leading: Icon(
                Icons.home_outlined, 
                color: Colors.black,
                size: 35,
              ),
              
              onTap: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/', (_) => false);
              },
            ),
            if(widget.estaLogado) ...[
              ListTile(
                title: Text(
                  "Nova ocorrência",
                  style: TextStyle(
                    color: Colors.black, 
                    fontSize: 17,
                    fontWeight: FontWeight.bold
                  ),
                ),
                leading: Icon(
                  Icons.shield_outlined, 
                  color: Colors.black,
                  size: 35,
                ),
                
                onTap: () {
                  Navigator.pushNamed(context, '/ocorrencia');
                },
              ),
              ListTile(
                title: Text(
                  "Locais salvos",
                  style: TextStyle(
                    color: Colors.black, 
                    fontSize: 17,
                    fontWeight: FontWeight.bold
                  ),
                ),
                leading: Icon(
                  Icons.add_location_outlined, 
                  color: Colors.black,
                  size: 35,
                ),
                
                onTap: () {
                  
                },
              ),
              ListTile(
                title: Text(
                  "Configuração",
                  style: TextStyle(
                    color: Colors.black, 
                    fontSize: 17,
                    fontWeight: FontWeight.bold
                  ),
                ),
                leading: Icon(
                  Icons.settings_outlined, 
                  color: Colors.black,
                  size: 35,
                ),
                
                onTap: () {
                  
                },
              ),
            ],
            widget.estaLogado?
              ListTile(
                title: Text(
                  "Sair",
                  style: TextStyle(
                    color: Colors.black, 
                    fontSize: 17,
                    fontWeight: FontWeight.bold
                  ),
                ),
                leading: Icon(
                  Icons.logout_outlined, 
                  color: Colors.black,
                  size: 35,
                ),
                
                onTap: () {
                  
                },
              ) :
              ListTile(
                title: Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.black, 
                    fontSize: 17,
                    fontWeight: FontWeight.bold
                  ),
                ),
                leading: Icon(
                  Icons.logout_outlined, 
                  color: Colors.black,
                  size: 35,
                ),
                
                onTap: () {
                  Navigator.of(context)
                    .pushNamedAndRemoveUntil('/login', (_) => false);
                },
              ),
          ],
        ),
      ),
    );
  }
}
