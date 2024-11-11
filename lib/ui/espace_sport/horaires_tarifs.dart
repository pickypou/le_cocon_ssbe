import 'package:flutter/material.dart';
import 'package:le_cocon_ssbe/ui/theme.dart';

class HorairesTarifs extends StatelessWidget {
  const HorairesTarifs({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Center(
      child:Padding(
          padding: EdgeInsets.symmetric(horizontal: 35),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Les horaires', style: titleStyleSmall(context).copyWith(fontSize: size.width / 20),),
          Text('Yoga : lundi de 14h à 15h30 et le vendredi de 19h30 à 20h30.' ,style: textStyleText(context).copyWith(fontSize: size.width / 42),),
          Text('Yoga  parent/enfant:  mercredi de 9h30 à 10h30.' ,style: textStyleText(context).copyWith(fontSize: size.width / 42),),
          Text('Gym douce :  mercredi de 14h à 15h.' ,style: textStyleText(context).copyWith(fontSize: size.width / 42),),
          Text('Stretching : mercredi de 19h à 20h.' ,style: textStyleText(context).copyWith(fontSize: size.width / 42),),
          Text('Taïso : mardi de 19h à 20h30 et samedi de 10h à 11h30.' ,style: textStyleText(context).copyWith(fontSize: size.width / 42),),
          Text('Coaching individuel : Uniquement sur rendez-vous. Possibilité d\'intervention à domocile.' ,style: textStyleText(context).copyWith(fontSize: size.width / 42),),
          Text('Bon à savoir : ' ,style: textStyleText(context).copyWith(fontSize: size.width / 42),),
          Text('La saison débute le 15 août et se termine le 14 juillet.' ,style: textStyleText(context).copyWith(fontSize: size.width / 42),),
          Text('Les séances ont lieu toute l\'année, même durant la période de vacances scolaires, sauf les jours fériés. Possibilité de changer de séance en cas d\'indisponibilité ponctuelle.' ,style: textStyleText(context).copyWith(fontSize: size.width / 42),),
          Text('1ère séance d\'essais gratuite.' ,style: textStyleText(context).copyWith(fontSize: size.width / 42),),
          const SizedBox(height: 25,),
          Text('Les Tarifs', style: titleStyleSmall(context).copyWith(fontSize: size.width / 20),),
          Text('La séance 7€.' ,style: textStyleText(context).copyWith(fontSize: size.width / 42),),
          Text('Le trimestre' ,style: titleStyleSmall(context).copyWith(fontSize: size.width / 20),),
          Text('1 séance semaine 60€ ; 12 séances soit 5€ la séance.' ,style: textStyleText(context).copyWith(fontSize: size.width / 42),),
          Text('2 séances semaine 80€ ; 24 séances soit 2.50€ la séance.' ,style: textStyleText(context).copyWith(fontSize: size.width / 42),),
          Text('L \'année' ,style: titleStyleSmall(context).copyWith(fontSize: size.width / 20),),
          Text('1 séance semaine 200€ ; 47 séances/année soit 4.25€ la séance.' ,style: textStyleText(context).copyWith(fontSize: size.width / 42),),
          Text('2 séances semaine 300€ ; 92 séances/année soit 3.26 la séance.' ,style: textStyleText(context).copyWith(fontSize: size.width / 42),),
          Text('3 séances semaine 350€ ; 139 séances/année soit 0.39€ la séance.' ,style: textStyleText(context).copyWith(fontSize: size.width / 42),),
          Text('Coaching individuel au Cocon SSBE ; 40€ la séance.' ,style: textStyleText(context).copyWith(fontSize: size.width / 42),),
          Text('Coaching individuel à domicile (20 KMS) 50€ la séance.' ,style: textStyleText(context).copyWith(fontSize: size.width / 42),),
          Text('(Possibilité de réduction de 50% en crédit d\'impôt sur la déclaration fiscale service à la personne).' ,style: textStyleText(context).copyWith(fontSize: size.width / 42),),
          Text('Réduction de 10% pour les provinois (la première année).' ,style: textStyleText(context).copyWith(fontSize: size.width / 42),),

        ],
      ),
      )
     
    );
  }
}
